'use strict';
/**
 * qr-gen.js — Self-contained QR Code Generator
 * Generates a Version 3, ECC Level M QR code for the iZinga app download URL.
 * Algorithm: ISO/IEC 18004 — byte mode, single-block RS, all 8 mask patterns evaluated.
 * No external dependencies, no CDN calls.
 */
(function () {

  /* ============================================================
     GF(256) arithmetic — irreducible polynomial 0x11D
     ============================================================ */
  var GF_EXP = new Array(512);
  var GF_LOG = new Array(256);

  (function initGF() {
    var x = 1;
    for (var i = 0; i < 255; i++) {
      GF_EXP[i] = x;
      GF_LOG[x] = i;
      x = (x & 0x80) ? ((x << 1) ^ 0x11D) & 0xFF : (x << 1) & 0xFF;
    }
    for (var i = 0; i < 256; i++) GF_EXP[i + 255] = GF_EXP[i];
    GF_LOG[0] = 0;
  })();

  function gfMul(a, b) {
    return (a === 0 || b === 0) ? 0 : GF_EXP[(GF_LOG[a] + GF_LOG[b]) % 255];
  }

  /* ============================================================
     Reed-Solomon error correction
     Generator polynomial: g(x) = ∏(i=0..nEcc-1)(x + α^i)
     ============================================================ */
  function rsGenPoly(nEcc) {
    var p = [1];
    for (var i = 0; i < nEcc; i++) {
      var c = GF_EXP[i];
      var np = new Array(p.length + 1).fill(0);
      for (var j = 0; j < p.length; j++) {
        np[j]     ^= p[j];
        np[j + 1] ^= gfMul(p[j], c);
      }
      p = np;
    }
    return p;
  }

  function rsEncode(data, nEcc) {
    var gen = rsGenPoly(nEcc);
    var msg = data.concat(new Array(nEcc).fill(0));
    for (var i = 0; i < data.length; i++) {
      var coef = msg[i];
      if (coef !== 0) {
        for (var j = 0; j < gen.length; j++) {
          msg[i + j] ^= gfMul(gen[j], coef);
        }
      }
    }
    return msg.slice(data.length);
  }

  /* ============================================================
     QR Version 3, ECC Level M constants
     ============================================================ */
  var VER    = 3;
  var SIZE   = 17 + 4 * VER; // 29
  var N_DATA = 44;            // data codewords
  var N_ECC  = 26;            // error correction codewords
  var ECC_BITS = 0;           // ECC M = 00 in format info

  /* ============================================================
     Data encoding — byte mode
     ============================================================ */
  function encodeData(text) {
    var bytes = [];
    for (var i = 0; i < text.length; i++) bytes.push(text.charCodeAt(i) & 0xFF);

    var bits = [];
    function addBits(val, n) {
      for (var i = n - 1; i >= 0; i--) bits.push((val >> i) & 1);
    }

    addBits(0x4, 4);          // mode indicator: byte = 0100
    addBits(bytes.length, 8); // character count (8 bits for versions 1-9)
    bytes.forEach(function (b) { addBits(b, 8); });

    // Terminator (up to 4 zero bits)
    var term = Math.min(4, N_DATA * 8 - bits.length);
    for (var i = 0; i < term; i++) bits.push(0);

    // Pad to byte boundary
    while (bits.length % 8) bits.push(0);

    // Pad codewords 0xEC, 0x11...
    var PAD = [0xEC, 0x11];
    var pi  = 0;
    while (bits.length < N_DATA * 8) addBits(PAD[pi++ % 2], 8);

    // Pack into bytes
    var cw = [];
    for (var i = 0; i < N_DATA; i++) {
      var b = 0;
      for (var j = 0; j < 8; j++) b = (b << 1) | bits[i * 8 + j];
      cw.push(b);
    }
    return cw;
  }

  /* ============================================================
     Module matrix helpers
     ============================================================ */
  function makeMatrix() {
    var m = [];
    for (var r = 0; r < SIZE; r++) m.push(new Array(SIZE).fill(null));
    return m;
  }

  function cloneMatrix(m) {
    return m.map(function (row) { return row.slice(); });
  }

  /* 7×7 finder pattern at (startRow, startCol) */
  function placeFinder(mat, sr, sc) {
    for (var r = 0; r < 7; r++) {
      for (var c = 0; c < 7; c++) {
        var onBorder = (r === 0 || r === 6 || c === 0 || c === 6);
        var onInner  = (r >= 2 && r <= 4 && c >= 2 && c <= 4);
        mat[sr + r][sc + c] = (onBorder || onInner) ? 1 : 0;
      }
    }
  }

  function placeSeparators(mat) {
    // Top-left finder separators
    for (var i = 0; i < 8; i++) { mat[i][7] = 0; mat[7][i] = 0; }
    // Top-right finder separators
    for (var i = 0; i < 8; i++) { mat[i][SIZE - 8] = 0; mat[7][SIZE - 8 + i] = 0; }
    // Bottom-left finder separators
    for (var i = 0; i < 8; i++) { mat[SIZE - 8][i] = 0; mat[SIZE - 8 + i][7] = 0; }
  }

  function placeTimingPatterns(mat) {
    for (var i = 8; i < SIZE - 8; i++) {
      mat[6][i] = mat[i][6] = (i % 2 === 0) ? 1 : 0;
    }
  }

  function placeDarkModule(mat) {
    mat[4 * VER + 9][8] = 1;
  }

  /* ============================================================
     Format information
     Format: ECC(2b) + mask(3b) → 5 bits → BCH(15,5) → 15 bits → XOR 0x5412
     Generator: x^10 + x^8 + x^5 + x^4 + x^2 + x + 1 = 0x537
     ============================================================ */
  function computeFormatBits(eccBits, maskPat) {
    var data = (eccBits << 3) | maskPat;
    var gen  = 0x537;
    var rem  = data << 10;
    for (var i = 4; i >= 0; i--) {
      if ((rem >> (i + 10)) & 1) rem ^= (gen << i);
    }
    return ((data << 10) | rem) ^ 0x5412;
  }

  /* Format bit positions — copy 1 (near top-left finder) */
  var FMT_POS_1 = [
    [8,0],[8,1],[8,2],[8,3],[8,4],[8,5],[8,7],
    [8,8],[7,8],[5,8],[4,8],[3,8],[2,8],[1,8],[0,8]
  ];
  /* Format bit positions — copy 2 (top-right + bottom-left) */
  var FMT_POS_2 = [
    [SIZE-1,8],[SIZE-2,8],[SIZE-3,8],[SIZE-4,8],[SIZE-5,8],[SIZE-6,8],[SIZE-7,8],
    [8,SIZE-8],[8,SIZE-7],[8,SIZE-6],[8,SIZE-5],[8,SIZE-4],[8,SIZE-3],[8,SIZE-2],[8,SIZE-1]
  ];

  function placeFormat(mat, fmtBits) {
    for (var i = 0; i < 15; i++) {
      var bit = (fmtBits >> (14 - i)) & 1;
      mat[FMT_POS_1[i][0]][FMT_POS_1[i][1]] = bit;
      mat[FMT_POS_2[i][0]][FMT_POS_2[i][1]] = bit;
    }
  }

  /* Mark function modules as reserved (not available for data) */
  function buildReservedMap(mat) {
    var reserved = mat.map(function (row) {
      return row.map(function (v) { return v !== null; });
    });
    // Mark format positions reserved
    FMT_POS_1.forEach(function (p) { reserved[p[0]][p[1]] = true; });
    FMT_POS_2.forEach(function (p) { reserved[p[0]][p[1]] = true; });
    return reserved;
  }

  /* ============================================================
     Data placement — zigzag from bottom-right
     ============================================================ */
  function placeData(mat, codewords) {
    var bits = [];
    codewords.forEach(function (b) {
      for (var i = 7; i >= 0; i--) bits.push((b >> i) & 1);
    });

    var di  = 0;
    var col = SIZE - 1;
    var dir = -1; // -1 = up, +1 = down

    while (col > 0) {
      if (col === 6) col--; // skip timing column

      for (var r = 0; r < SIZE; r++) {
        var row = (dir === -1) ? (SIZE - 1 - r) : r;
        for (var dc = 0; dc < 2; dc++) {
          var c = col - dc;
          if (c >= 0 && mat[row][c] === null) {
            mat[row][c] = di < bits.length ? bits[di++] : 0;
          }
        }
      }

      col -= 2;
      dir  = -dir;
    }
  }

  /* ============================================================
     Mask patterns + penalty scoring
     ============================================================ */
  function applyMask(mat, reserved, maskPat) {
    var m = cloneMatrix(mat);
    for (var r = 0; r < SIZE; r++) {
      for (var c = 0; c < SIZE; c++) {
        if (reserved[r][c]) continue;
        var flip = false;
        switch (maskPat) {
          case 0: flip = (r + c) % 2 === 0; break;
          case 1: flip = r % 2 === 0; break;
          case 2: flip = c % 3 === 0; break;
          case 3: flip = (r + c) % 3 === 0; break;
          case 4: flip = (Math.floor(r / 2) + Math.floor(c / 3)) % 2 === 0; break;
          case 5: flip = (r * c) % 2 + (r * c) % 3 === 0; break;
          case 6: flip = ((r * c) % 2 + (r * c) % 3) % 2 === 0; break;
          case 7: flip = ((r + c) % 2 + (r * c) % 3) % 2 === 0; break;
        }
        if (flip) m[r][c] ^= 1;
      }
    }
    return m;
  }

  var PAT1 = [1,0,1,1,1,0,1,0,0,0,0];
  var PAT2 = [0,0,0,0,1,0,1,1,1,0,1];

  function penaltyScore(mat) {
    var score = 0;

    // Rule 1: runs of 5+ same-color modules
    for (var r = 0; r < SIZE; r++) {
      for (var s = 0; s < SIZE; ) {
        var v = mat[r][s], e = s + 1;
        while (e < SIZE && mat[r][e] === v) e++;
        if (e - s >= 5) score += 3 + (e - s - 5);
        s = e;
      }
    }
    for (var c = 0; c < SIZE; c++) {
      for (var s = 0; s < SIZE; ) {
        var v = mat[s][c], e = s + 1;
        while (e < SIZE && mat[e][c] === v) e++;
        if (e - s >= 5) score += 3 + (e - s - 5);
        s = e;
      }
    }

    // Rule 2: 2×2 same-color blocks
    for (var r = 0; r < SIZE - 1; r++) {
      for (var c = 0; c < SIZE - 1; c++) {
        var m = mat[r][c];
        if (m === mat[r][c+1] && m === mat[r+1][c] && m === mat[r+1][c+1]) score += 3;
      }
    }

    // Rule 3: finder-like patterns
    for (var r = 0; r < SIZE; r++) {
      for (var c = 0; c < SIZE - 10; c++) {
        var m1 = true, m2 = true;
        for (var k = 0; k < 11; k++) {
          if (mat[r][c+k] !== PAT1[k]) m1 = false;
          if (mat[r][c+k] !== PAT2[k]) m2 = false;
        }
        if (m1 || m2) score += 40;
      }
    }
    for (var c = 0; c < SIZE; c++) {
      for (var r = 0; r < SIZE - 10; r++) {
        var m1 = true, m2 = true;
        for (var k = 0; k < 11; k++) {
          if (mat[r+k][c] !== PAT1[k]) m1 = false;
          if (mat[r+k][c] !== PAT2[k]) m2 = false;
        }
        if (m1 || m2) score += 40;
      }
    }

    // Rule 4: dark module ratio deviation from 50%
    var dark = 0;
    for (var r = 0; r < SIZE; r++) for (var c = 0; c < SIZE; c++) if (mat[r][c]) dark++;
    score += Math.floor(Math.abs(dark * 100 / (SIZE * SIZE) - 50) / 5) * 20;

    return score;
  }

  /* ============================================================
     Main generator
     ============================================================ */
  function generateQR(text) {
    var dataWords = encodeData(text);
    var eccWords  = rsEncode(dataWords, N_ECC);
    var allWords  = dataWords.concat(eccWords);

    // Build structural (functional) matrix
    var mat = makeMatrix();
    placeFinder(mat, 0, 0);
    placeFinder(mat, 0, SIZE - 7);
    placeFinder(mat, SIZE - 7, 0);
    placeSeparators(mat);
    placeTimingPatterns(mat);
    placeDarkModule(mat);

    var reserved = buildReservedMap(mat);

    // Reserve format areas in the structural matrix (will be overwritten by actual bits)
    FMT_POS_1.forEach(function (p) { if (mat[p[0]][p[1]] === null) mat[p[0]][p[1]] = 0; });
    FMT_POS_2.forEach(function (p) { if (mat[p[0]][p[1]] === null) mat[p[0]][p[1]] = 0; });

    // Place encoded data
    placeData(mat, allWords);

    // Evaluate all 8 masks, pick lowest penalty
    var bestMask  = 0;
    var bestScore = Infinity;
    var bestMat   = null;

    for (var m = 0; m < 8; m++) {
      var candidate = applyMask(mat, reserved, m);
      var fmtBits   = computeFormatBits(ECC_BITS, m);
      placeFormat(candidate, fmtBits);
      var s = penaltyScore(candidate);
      if (s < bestScore) { bestScore = s; bestMask = m; bestMat = candidate; }
    }

    return bestMat;
  }

  /* ============================================================
     SVG renderer
     ============================================================ */
  function renderSVG(matrix, pxSize) {
    pxSize = pxSize || 80;
    var cell = pxSize / SIZE;
    var parts = [
      '<svg xmlns="http://www.w3.org/2000/svg"',
      ' viewBox="0 0 ' + pxSize + ' ' + pxSize + '"',
      ' width="' + pxSize + '" height="' + pxSize + '"',
      ' role="img" aria-label="QR code: scan to download the iZinga app">',
      '<rect width="' + pxSize + '" height="' + pxSize + '" fill="#fff"/>'
    ];
    for (var r = 0; r < SIZE; r++) {
      for (var c = 0; c < SIZE; c++) {
        if (matrix[r][c]) {
          parts.push(
            '<rect x="' + (c * cell).toFixed(3) + '"' +
            ' y="' + (r * cell).toFixed(3) + '"' +
            ' width="' + cell.toFixed(3) + '"' +
            ' height="' + cell.toFixed(3) + '" fill="#212121"/>'
          );
        }
      }
    }
    parts.push('</svg>');
    return parts.join('');
  }

  /* ============================================================
     Inject into .qr-frame on DOMContentLoaded
     ============================================================ */
  function inject() {
    var frame = document.querySelector('.qr-frame');
    if (!frame) return;
    try {
      var matrix = generateQR('https://download.izinga.co.za/app');
      frame.innerHTML = renderSVG(matrix, 80);
    } catch (e) {
      // Keep the existing placeholder if generation fails
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', inject);
  } else {
    inject();
  }

})();
