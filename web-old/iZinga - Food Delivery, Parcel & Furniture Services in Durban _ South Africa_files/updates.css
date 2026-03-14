<!DOCTYPE html>
<html lang="en" class="js cssanimations">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="iZinga - Leading digital platform for food delivery, parcel services, and furniture moving in Durban and across South Africa. Fast, reliable delivery with secure payment solutions.">
	<meta name="keywords" content="iZinga, food delivery Durban, parcel delivery Durban, furniture moving Durban, Durban delivery service, mobile payments, digital wallet, iZinga Pay, KwaZulu-Natal delivery, on-demand services South Africa">
	<meta name="author" content="iZinga">
	<meta name="robots" content="index, follow">
	<link rel="canonical" href="https://izinga.co.za" />
	
	<!-- Open Graph / Facebook -->
	<meta property="og:type" content="website">
	<meta property="og:url" content="https://izinga.co.za">
	<meta property="og:title" content="iZinga - Complete Digital Solution Platform for South Africa">
	<meta property="og:description" content="Order food, send parcels, move furniture, and accept payments in Durban and across South Africa. iZinga delivers fast, reliable services to your doorstep.">
	<meta property="og:image" content="https://izinga.co.za/images/izinga-social-preview.png">
	<meta property="og:image:width" content="1200">
	<meta property="og:image:height" content="630">
	<meta property="og:site_name" content="iZinga">
	<meta property="og:locale" content="en_ZA">
	
	<!-- Twitter -->
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:url" content="https://izinga.co.za">
	<meta name="twitter:title" content="iZinga - Complete Digital Solution Platform">
	<meta name="twitter:description" content="Order food, send parcels, move furniture in Durban & South Africa. Fast delivery & secure payments - Download iZinga today!">
	<meta name="twitter:image" content="https://izinga.co.za/images/izinga-social-preview.png">
	<meta name="twitter:creator" content="@iZingaApp">
	
	<!-- PWA Meta Tags -->
	<meta name="theme-color" content="#d66247">
	<meta name="msapplication-navbutton-color" content="#d66247">
	<meta name="apple-mobile-web-app-status-bar-style" content="default">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes">
	
	<!-- PWA Manifest -->
	<link rel="manifest" href="./manifest.json">
	
	<!-- Favicons and Icons -->
	<link rel="icon" type="image/png" sizes="32x32" href="./images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./images/favicon-16x16.png">
	<link rel="apple-touch-icon" sizes="180x180" href="./images/apple-touch-icon.png">
	<link rel="mask-icon" href="./images/safari-pinned-tab.svg" color="#d66247">
	
	<title>iZinga - Food Delivery, Parcel & Furniture Services in Durban | South Africa</title>

	<!-- Favicon
	<link rel="shortcut icon" href="http://designwp.com/spacey/images/favicon.ico">  -->

	<!-- Stylesheets -->
	<link rel="stylesheet" href="./bootstrap.min_files/bootstrap.css">
	<link rel="stylesheet" href="./bootstrap.min_files/style.css">
	<link rel="stylesheet" href="./bootstrap.min_files/mobile.css">
	<link rel="stylesheet" href="./bootstrap.min_files/all.min.css">
	<link rel="stylesheet" href="./bootstrap.min_files/updates.css">

	<!-- Floating Action Button Styles -->
	<style>

		.heading-button {
			z-index: 2000 !important;
		}
		
		.btn {
			z-index: 2000 !important;
		}

		.fab-container {
			position: fixed;
			bottom: 30px;
			right: 30px;
			z-index: 1000;
			display: flex;
			flex-direction: column;
			align-items: flex-end;
		}

		.fab-main {
			width: 60px;
			height: 60px;
			border-radius: 50%;
			background: linear-gradient(135deg, #d66247, #ff6b35);
			border: none;
			box-shadow: 0 4px 20px rgba(214, 98, 71, 0.4);
			cursor: pointer;
			transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
			display: flex;
			align-items: center;
			justify-content: center;
			position: relative;
		}

		.fab-main:hover {
			transform: scale(1.1);
			box-shadow: 0 6px 25px rgba(214, 98, 71, 0.6);
		}

		.fab-main.active {
			transform: rotate(45deg);
		}

		.fab-icon {
			color: white;
			font-size: 24px;
			transition: transform 0.3s ease;
		}

		.fab-menu {
			display: flex;
			flex-direction: column;
			gap: 15px;
			margin-bottom: 20px;
			opacity: 0;
			transform: translateY(20px);
			transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
			pointer-events: none;
		}

		.fab-menu.active {
			opacity: 1;
			transform: translateY(0);
			pointer-events: all;
		}

		.fab-option {
			display: flex;
			align-items: center;
			gap: 12px;
			padding: 12px 20px 12px 12px;
			background: white;
			border-radius: 30px;
			box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
			cursor: pointer;
			transition: all 0.3s ease;
			white-space: nowrap;
			transform: scale(0.8);
			opacity: 0;
		}

		.fab-menu.active .fab-option {
			transform: scale(1);
			opacity: 1;
		}

		.fab-menu.active .fab-option:nth-child(1) {
			transition-delay: 0.1s;
		}

		.fab-menu.active .fab-option:nth-child(2) {
			transition-delay: 0.15s;
		}

		.fab-menu.active .fab-option:nth-child(3) {
			transition-delay: 0.2s;
		}

		.fab-option:hover {
			transform: scale(1.05) translateX(-5px);
			box-shadow: 0 4px 25px rgba(0, 0, 0, 0.15);
		}

		.fab-option i {
			width: 36px;
			height: 36px;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
			color: white;
			font-size: 16px;
		}

		.fab-option:nth-child(1) i {
			background: #ff6b35;
		}

		.fab-option:nth-child(2) i {
			background: #4caf50;
		}

		.fab-option:nth-child(3) i {
			background: #2196f3;
		}

		.fab-label {
			font-weight: 500;
			color: #333;
			font-size: 14px;
		}


		
		#particles-js, #particles-js2, #particles-js3 {
			position: fixed;
			top: 0;
			left: 0;
			width: 100vw;
			height: 100vh;
			background: transparent;
			z-index: 500;
		}

		#particles-js canvas, #particles-js2 canvas, #particles-js3 canvas {
			width: 100% !important;
			height: 100% !important;
		}

		@media (max-width: 768px) {
			.fab-container {
				bottom: 20px;
				right: 20px;
			}

			.fab-main {
				width: 50px;
				height: 50px;
			}

			.fab-icon {
				font-size: 20px;
			}

			.fab-option {
				padding: 10px 16px 10px 10px;
				gap: 10px;
			}

			.fab-option i {
				width: 32px;
				height: 32px;
				font-size: 14px;
			}

			.fab-label {
				font-size: 12px;
			}
		}
	</style>


	<!-- Fonts -->
	<link href="./bootstrap.min_files/css" rel="stylesheet">

	<!-- Scripts -->
	<script src="./bootstrap.min_files/modernizr-custom.js"></script>

	<!-- Facebook Pixel Code -->
<script>
	!function(f,b,e,v,n,t,s)
	{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
	n.callMethod.apply(n,arguments):n.queue.push(arguments)};
	if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
	n.queue=[];t=b.createElement(e);t.async=!0;
	t.src=v;s=b.getElementsByTagName(e)[0];
	s.parentNode.insertBefore(t,s)}(window, document,'script',
	'https://connect.facebook.net/en_US/fbevents.js');
	fbq('init', '565463741264864');
	fbq('track', 'PageView');
	</script>
	<noscript><img height="1" width="1" style="display:none"
	src="https://www.facebook.com/tr?id=565463741264864&ev=PageView&noscript=1"
	/></noscript>
	<!-- End Facebook Pixel Code -->

	<!-- Structured Data -->
	<script type="application/ld+json">
	{
		"@context": "https://schema.org",
		"@type": "Organization",
		"name": "iZinga",
		"url": "https://izinga.co.za",
		"logo": "https://izinga.co.za/images/izinga-logo.png",
		"description": "Leading digital platform for food delivery, parcel services, and furniture moving in Durban and across South Africa, with secure payment solutions.",
		"address": {
			"@type": "PostalAddress",
			"addressCountry": "ZA"
		},
		"contactPoint": {
			"@type": "ContactPoint",
			"telephone": "+27-81-281-5707",
			"contactType": "customer service",
			"email": "admin@curiousoft.io"
		},
		"sameAs": [
			"https://download.izinga.co.za/app"
		],
		"hasOfferCatalog": {
			"@type": "OfferCatalog",
			"name": "iZinga Services",
			"itemListElement": [
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Food Delivery",
						"description": "Order from restaurants in Durban and across South Africa with real-time tracking",
						"areaServed": "Durban, KwaZulu-Natal, South Africa"
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Parcel Delivery",
						"description": "Safe package delivery in Durban and surrounding areas with GPS tracking",
						"areaServed": "Durban, KwaZulu-Natal, South Africa"
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Furniture Delivery",
						"description": "Professional furniture moving services in Durban, including couches, appliances, and large items",
						"areaServed": "Durban, KwaZulu-Natal, South Africa"
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Payment Gateway",
						"description": "Secure payment processing for businesses"
					}
				}
			]
		}
	}
	</script>

</head>


<body id="page-top">

	<a href="#" id="scroll" style="display: none;"><span></span></a>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
		<div class="container">

			<a class="navbar-brand nav-link js-scroll-trigger" href="#page-top"><img src="bootstrap.min_files/izinga-logo.png" width="120px"></a>

			<button class="navbar-toggler collapsed" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
				<span class="icon-bar top-bar"></span>
				<span class="icon-bar middle-bar"></span>
				<span class="icon-bar bottom-bar"></span>
			</button>

			<div class="navbar-collapse collapse" id="navbarResponsive" style="">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href="#page-top">HOME</a>
					</li>
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href="#about">ABOUT</a>
					</li>
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href="./privacy.html">PRIVACY POLICY</a>
					</li>
				</ul>
			</div><!-- /collapse navbar-collapse -->

		</div><!-- /container -->
	</nav>


	<div id="particles-js"><canvas class="particles-js-canvas-el" width="750" height="1300"
			style="width: 100%; height: 100%;"></canvas></div>
<!--
	<div class="introduction-div common-bg" >
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-10 col-lg-8 mx-auto text-center">
					<h1 class="mb-4">Complete Digital Solution Platform</h1>
					<p class="lead mb-5">iZinga offers a comprehensive suite of services to meet all your business and personal needs. From food delivery to payment solutions, we've got you covered.</p>
				</div> /col-lg-8 mx-auto -->
			</div><!-- /row 
	</div>		-->

	<div class="row">		
				<div id="food-market" class="col-12 col-md-4">
			<header class="text-white box">
				<div class="row head">
					<div class="col-12 mx-auto">
						<div id="circles">
							<img class="float mobile" src="./bootstrap.min_files/izinga-deliveries.png"
								alt="header image" style="transform: matrix(1, 0, 0, 1, 14.45, 2.8);">
						</div>
						<div class="wave -one"></div>
						<div class="wave -two"></div>
						<div class="wave -three"></div>
					</div><!-- /col-lg-6 mx-auto -->
					<div class="col-12 mx-auto. mb-5 heading-button">
						<div class="h4">Parcel and Furniture Delivery</div>
						<p class="header-lead mb-3 mt-3 text-center">
							Food delivery, parcel services, furniture moving, and secure payment solutions - 
							all in one platform. Download iZinga and experience seamless digital services.
						</p>
						<a href="https://izinga-truck.web.app/">
							<button class="btn shadow">Book Now</button>	
						</a>
						<a href="https://onboard.izinga.co.za">
							<button class="btn shadow driver-btn">Become A Driver</button>	
						</a>
					</div><!-- /col-lg-6 mx-auto -->
				</div><!-- /row head -->
			</header>
		</div>
	<div id="delivery-services" class="col-12 col-md-4">
			<header class="text-white box">
				<div class="row head">
					<div class="col-12 mx-auto">
						<div id="circles">
							<img class="float mobile" src="./bootstrap.min_files/izinga-food.png"
								alt="header image" style="transform: matrix(1, 0, 0, 1, 14.45, 2.8);">
						</div>
						<div class="wave -one"></div>
						<div class="wave -two"></div>
						<div class="wave -three"></div>
					</div><!-- /col-lg-6 mx-auto -->
					<div class="col-12 mx-auto mb-5">
						<div class="h4">iZinga Food Market</div>
						<p class="header-lead mb-3 mt-3 text-center">
							Find the best local food and groceries with iZinga Food Market. Order from your favorite restaurants and stores, and enjoy fast, reliable delivery right to your door.
						</p>
						<a href="https://shop.izinga.co.za">
							<button class="btn shadow">Order Now</button>	
						</a>
						<a href="https://onboard.izinga.co.za">
							<button class="btn shadow driver-btn">Become A Driver</button>	
						</a>
					</div><!-- /col-lg-6 mx-auto -->
				</div><!-- /row head -->
			</header>
		</div>
		<div id="izinga-pay" class="col-12 col-md-4">
			<header class="text-white box">
				<div class="row head">
					<div class="col-12 mx-auto">
						<div id="circles">
							<img class="float mobile" src="./bootstrap.min_files/izinga-pay.png"
								alt="header image" style="transform: matrix(1, 0, 0, 1, 14.45, 2.8);">
						</div>
						<div class="wave -one"></div>
						<div class="wave -two"></div>
						<div class="wave -three"></div>
					</div><!-- /col-lg-6 mx-auto -->
					<div class="col-12 mx-auto mb-5">
						<div class="h4">iZinga Pay</div>
						<p class="header-lead mb-3 mt-3 text-center">
							Send payments and tips with iZinga Pay. Our secure payment gateway allows you to easily send money to friends, family, and businesses, all from your mobile device.
						</p>
						<a href="https://pay.izinga.co.za">
							<button class="btn shadow">Start Sending</button>	
						</a>
					</div><!-- /col-lg-6 mx-auto -->
						</p>
					</div><!-- /col-lg-6 mx-auto -->
				</div><!-- /row head -->
			</header>
		</div>	
	</div>

	<!-- Floating Action Button -->
	<div class="fab-container">
		<div class="fab-menu" id="fabMenu">
			<div class="fab-option" onclick="scrollToSection('food-market')">
				<i class="fas fa-utensils"></i>
				<span class="fab-label">Food Market</span>
			</div>
			<div class="fab-option" onclick="scrollToSection('delivery-services')">
				<i class="fas fa-truck"></i>
				<span class="fab-label">Delivery</span>
			</div>
			<div class="fab-option" onclick="scrollToSection('izinga-pay')">
				<i class="fas fa-credit-card"></i>
				<span class="fab-label">Pay</span>
			</div>
		</div>
		<button class="fab-main" id="fabMain" onclick="toggleFabMenu()">
			<i class="fas fa-plus fab-icon"></i>
		</button>
	</div>


	<!-- Footer -->
	<footer class="bg-dark">
		<div class="container">
			<div class="row">
					<dl class="col-4 contact-list text-center">
						<dt>Email: <a href="mailto:#">admin@curiousoft.io</a></dt>
					</dl>
					<dl class="col-4 contact-list text-center">
						<dt>Phone: <a href="tel:#">+27 81 281 5707</a></dt>
					</dl>
					<dl class="col-4 contact-list text-center">
						<dt>Adress: Randburg, Johannesburg, Africa</dt>
					</dl>

				<div class="col-md-1"></div>
			</div><!-- /row -->

		</div><!-- /.container -->

		<div id="copyright" class="copyright-bg">
			<div class="container">
				<p class="rights"><span>©&nbsp; </span><span
						class="copyright-year">2020</span><span>&nbsp;</span><span>Curiousoft</span><span>.&nbsp;</span><span>All
						Rights Reserved.</span></p>
			</div><!-- /container -->
		</div><!-- /copyright -->

	</footer>


	<!-- Scripts -->
	<script src="./bootstrap.min_files/jquery-3.3.1.min.js"></script>
	<script src="./bootstrap.min_files/bootstrap.bundle.min.js"></script>
	<script src="./bootstrap.min_files/scrolling-nav.js"></script>
	<script src="./bootstrap.min_files/jquery.easing.1.3.js"></script>
	<script src="./bootstrap.min_files/main.js"></script>
	<script src="./bootstrap.min_files/anime.min.js"></script>
	<script src="./bootstrap.min_files/particles.min.js"></script>
	<script src="./bootstrap.min_files/TweenMax.min.js"></script>
	<script src="./bootstrap.min_files/jquery.waypoints.min.js"></script>
	<script src="./bootstrap.min_files/jquery.countup.js"></script>
	<script src="./bootstrap.min_files/owl.carousel.js"></script>
	<script src="./bootstrap.min_files/glider.min.js"></script>

	<script>
		/* =================================
		   HEADER & NAVIGATION INTERACTIONS
		   ================================= */
		
		/* Header shrink on scroll */
		$(document).ready(function () {
			$(window).on("scroll", function () {
				if ($(window).scrollTop() >= 20) {
					$(".navbar").addClass("compressed");
					$("#particles-js").fadeOut(300);
				} else {
					$(".navbar").removeClass("compressed");
					$("#particles-js").fadeIn(300);
				}
			});
		});

		/* Navigation link active state */
		$('.navbar .nav-link').click(function () {
			$('.navbar .nav-link').removeClass('active');
			$(this).addClass('active');
		});

		/* =================================
		   PARALLAX MOUSE MOVEMENT EFFECT
		   ================================= */
		
		var timeout;
		$('#circles').mousemove(function (e) {
			if (timeout) clearTimeout(timeout);
			setTimeout(callParallax.bind(null, e), 200);
		});

		function callParallax(e) {
			parallaxIt(e, '.float', -30);
		}

		function parallaxIt(e, target, movement) {
			var $this = $('#circles');
			var relX = e.pageX - $this.offset().left;
			var relY = e.pageY - $this.offset().top;

			TweenMax.to(target, 1, {
				x: (relX - $this.width() / 2) / $this.width() * movement,
				y: (relY - $this.height() / 2) / $this.height() * movement,
				ease: Power2.easeOut
			});
		}

		/* =================================
		   PARTICLES BACKGROUND ANIMATION
		   ================================= */
		
		/* Particles JS */
		particlesJS("particles-js", {
			"particles": {
				"number": {
					"value": 80,
					"density": {
						"enable": true,
						"value_area": 1000
					}
				},
				"color": {
					"value": "#EEE8B9"
				},
				"shape": {
					"type": "circle",
					"stroke": {
						"width": 0,
						"color": "#FFFFFF"
					},
					"polygon": {
						"nb_sides": 5
					},
					"image": {
						"src": "img/github.svg",
						"width": 100,
						"height": 100
					}
				},
				"opacity": {
					"value": 0.48927153781200905,
					"random": false,
					"anim": {
						"enable": true,
						"speed": 0.5,
						"opacity_min": 0,
						"sync": false
					}
				},
				"size": {
					"value": 3.5,
					"random": true,
					"anim": {
						"enable": true,
						"speed": 6,
						"size_min": 1,
						"sync": false
					}
				},
				"line_linked": {
					"enable": false,
					"distance": 150,
					"color": "#383089",
					"opacity": 0.8,
					"width": 1
				},
				"move": {
					"enable": true,
					"speed": 1,
					"direction": "none",
					"random": true,
					"straight": false,
					"out_mode": "out",
					"bounce": false,
					"attract": {
						"enable": false,
						"rotateX": 600,
						"rotateY": 1200
					}
				}
			},
			"interactivity": {
				"detect_on": "canvas",
				"events": {
					"onhover": {
						"enable": true,
						"mode": "bubble"
					},
					"onclick": {
						"enable": true,
						"mode": "push"
					},
					"resize": true
				},
				"modes": {
					"grab": {
						"distance": 400,
						"line_linked": {
							"opacity": 1
						}
					},
					"bubble": {
						"distance": 83.91608391608392,
						"size": 1,
						"duration": 3,
						"opacity": 1,
						"speed": 3
					},
					"repulse": {
						"distance": 200,
						"duration": 0.4
					},
					"push": {
						"particles_nb": 4
					},
					"remove": {
						"particles_nb": 2
					}
				}
			},
			"retina_detect": true
		});
		particlesJS("particles-js2", {
			"particles": {
				"number": {
					"value": 80,
					"density": {
						"enable": true,
						"value_area": 1000
					}
				},
				"color": {
					"value": "#EEE8B9"
				},
				"shape": {
					"type": "circle",
					"stroke": {
						"width": 0,
						"color": "#FFFFFF"
					},
					"polygon": {
						"nb_sides": 5
					},
					"image": {
						"src": "img/github.svg",
						"width": 100,
						"height": 100
					}
				},
				"opacity": {
					"value": 0.48927153781200905,
					"random": false,
					"anim": {
						"enable": true,
						"speed": 0.5,
						"opacity_min": 0,
						"sync": false
					}
				},
				"size": {
					"value": 3.5,
					"random": true,
					"anim": {
						"enable": true,
						"speed": 6,
						"size_min": 1,
						"sync": false
					}
				},
				"line_linked": {
					"enable": false,
					"distance": 150,
					"color": "#383089",
					"opacity": 0.8,
					"width": 1
				},
				"move": {
					"enable": true,
					"speed": 1,
					"direction": "none",
					"random": true,
					"straight": false,
					"out_mode": "out",
					"bounce": false,
					"attract": {
						"enable": false,
						"rotateX": 600,
						"rotateY": 1200
					}
				}
			},
			"interactivity": {
				"detect_on": "canvas",
				"events": {
					"onhover": {
						"enable": true,
						"mode": "bubble"
					},
					"onclick": {
						"enable": true,
						"mode": "push"
					},
					"resize": true
				},
				"modes": {
					"grab": {
						"distance": 400,
						"line_linked": {
							"opacity": 1
						}
					},
					"bubble": {
						"distance": 83.91608391608392,
						"size": 1,
						"duration": 3,
						"opacity": 1,
						"speed": 3
					},
					"repulse": {
						"distance": 200,
						"duration": 0.4
					},
					"push": {
						"particles_nb": 4
					},
					"remove": {
						"particles_nb": 2
					}
				}
			},
			"retina_detect": true
		});
		particlesJS("particles-js3", {
			"particles": {
				"number": {
					"value": 80,
					"density": {
						"enable": true,
						"value_area": 1000
					}
				},
				"color": {
					"value": "#EEE8B9"
				},
				"shape": {
					"type": "circle",
					"stroke": {
						"width": 0,
						"color": "#FFFFFF"
					},
					"polygon": {
						"nb_sides": 5
					},
					"image": {
						"src": "img/github.svg",
						"width": 100,
						"height": 100
					}
				},
				"opacity": {
					"value": 0.48927153781200905,
					"random": false,
					"anim": {
						"enable": true,
						"speed": 0.5,
						"opacity_min": 0,
						"sync": false
					}
				},
				"size": {
					"value": 3.5,
					"random": true,
					"anim": {
						"enable": true,
						"speed": 6,
						"size_min": 1,
						"sync": false
					}
				},
				"line_linked": {
					"enable": false,
					"distance": 150,
					"color": "#383089",
					"opacity": 0.8,
					"width": 1
				},
				"move": {
					"enable": true,
					"speed": 1,
					"direction": "none",
					"random": true,
					"straight": false,
					"out_mode": "out",
					"bounce": false,
					"attract": {
						"enable": false,
						"rotateX": 600,
						"rotateY": 1200
					}
				}
			},
			"interactivity": {
				"detect_on": "canvas",
				"events": {
					"onhover": {
						"enable": true,
						"mode": "bubble"
					},
					"onclick": {
						"enable": true,
						"mode": "push"
					},
					"resize": true
				},
				"modes": {
					"grab": {
						"distance": 400,
						"line_linked": {
							"opacity": 1
						}
					},
					"bubble": {
						"distance": 83.91608391608392,
						"size": 1,
						"duration": 3,
						"opacity": 1,
						"speed": 3
					},
					"repulse": {
						"distance": 200,
						"duration": 0.4
					},
					"push": {
						"particles_nb": 4
					},
					"remove": {
						"particles_nb": 2
					}
				}
			},
			"retina_detect": true
		});

		/* =================================
		   OWL CAROUSEL SLIDER CONFIGURATION
		   ================================= */
		
		$("#owl-demo").each(function () {
			$(this).owlCarousel({
				loop: true,
				margin: 0,
				width: 255,
				nav: true,
				navText: [
					"<div class='nav-btn prev-slide'></div>", 
					"<div class='nav-btn next-slide'></div>"
				],
				dots: false,
				center: true,
				autoplay: true,
				responsiveClass: true,
				responsive: {
					0: {
						items: 1,
						nav: false,
						loop: true,
						center: true
					},
					568: {
						items: 1,
						nav: false,
						loop: true
					},
					1024: {
						items: 2,
						nav: false,
						loop: true
					},
					1336: {
						items: 4,
						nav: false,
						loop: true
					}
				}
			});
		});

		/* =================================
		   UI INTERACTIONS & ANIMATIONS
		   ================================= */
		
		/* Counter animation */
		$('.counter').countUp();

		/* Reviews slider */
		$('#myCarousel').carousel({
			interval: 3500,
			cycle: true
		});

		/* Back to top button */
		$(document).ready(function () {
			$(window).scroll(function () {
				if ($(this).scrollTop() > 100) {
					$('#scroll').fadeIn();
				} else {
					$('#scroll').fadeOut();
				}
			});
			
			$('#scroll').click(function () {
				$("html, body").animate({ scrollTop: 0 }, 600);
				return false;
			});
		});

		/* =================================
		   PWA SERVICE WORKER REGISTRATION
		   ================================= */
		
		// Register service worker for PWA functionality
		if ('serviceWorker' in navigator) {
			window.addEventListener('load', function() {
				navigator.serviceWorker.register('./sw.js')
					.then(function(registration) {
						console.log('ServiceWorker registration successful with scope: ', registration.scope);
						
						// Check for updates
						registration.addEventListener('updatefound', function() {
							const newWorker = registration.installing;
							newWorker.addEventListener('statechange', function() {
								if (newWorker.state === 'installed') {
									if (navigator.serviceWorker.controller) {
										// New content is available, refresh to update
										console.log('New content is available; please refresh.');
									} else {
										// Content is cached for the first time
										console.log('Content is cached for offline use.');
									}
								}
							});
						});
					})
					.catch(function(err) {
						console.log('ServiceWorker registration failed: ', err);
					});
			});
		}

		// Handle PWA install prompt
		let deferredPrompt;
		window.addEventListener('beforeinstallprompt', (e) => {
			// Prevent Chrome 67 and earlier from automatically showing the prompt
			e.preventDefault();
			// Stash the event so it can be triggered later
			deferredPrompt = e;
			// Show install button or banner
			console.log('PWA install prompt available');
		});

		// Handle PWA installed event
		window.addEventListener('appinstalled', (evt) => {
			console.log('PWA was installed successfully');
		});

		/* =================================
		   FLOATING ACTION BUTTON FUNCTIONS
		   ================================= */

		// Toggle floating action button menu
		function toggleFabMenu() {
			const fabMain = document.getElementById('fabMain');
			const fabMenu = document.getElementById('fabMenu');
			
			fabMain.classList.toggle('active');
			fabMenu.classList.toggle('active');
		}

		// Scroll to specific section
		function scrollToSection(sectionId) {
			const section = document.getElementById(sectionId);
			if (section) {
				section.scrollIntoView({
					behavior: 'smooth',
					block: 'start'
				});
				
				// Close the FAB menu after clicking
				setTimeout(() => {
					toggleFabMenu();
				}, 300);
			}
		}

		// Close FAB menu when clicking outside
		document.addEventListener('click', function(event) {
			const fabContainer = document.querySelector('.fab-container');
			const fabMain = document.getElementById('fabMain');
			const fabMenu = document.getElementById('fabMenu');
			
			if (!fabContainer.contains(event.target) && fabMenu.classList.contains('active')) {
				toggleFabMenu();
			}
		});
	</script>



</body>

</html>