$(".vpop").on('click', function(e) {
  e.preventDefault();
  $("#video-popup-overlay,#video-popup-iframe-container,#video-popup-container,#video-popup-close").show();
  
  var srchref='',autoplay='',id=$(this).data('id');
  if($(this).data('type') == 'vimeo') var srchref="//player.vimeo.com/video/";
  else if($(this).data('type') == 'youtube') var srchref="https://www.youtube.com/embed/";
  
  if($(this).data('autoplay') == true) autoplay = '?autoplay=1';
  
  $("#video-popup-iframe").attr('src', srchref+id+autoplay);
  
  $("#video-popup-iframe").on('load', function() {
    $("#video-popup-container").show();
  });
});

$("#video-popup-close, #video-popup-overlay").on('click', function(e) {
  $("#video-popup-iframe-container,#video-popup-container,#video-popup-close,#video-popup-overlay").hide();
  $("#video-popup-iframe").attr('src', '');
});


/**
 * main.js
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2017, Codrops
 * http://www.codrops.com
 */
{
	class ImgItem {
		constructor(el) {
			this.DOM = {};
			this.DOM.el = el;
			this.DOM.svg = this.DOM.el.querySelector('.item__svg');
			this.DOM.path = this.DOM.svg.querySelector('path');
			this.paths = {};
			this.paths.start = this.DOM.path.getAttribute('d');
			this.paths.end = this.DOM.el.dataset.morphPath;
			this.DOM.deco = this.DOM.svg.querySelector('.item__deco');
			this.DOM.image = this.DOM.svg.querySelector('image');
			this.DOM.title = this.DOM.el.querySelector('.item__meta > .item__title');
			this.DOM.subtitle = this.DOM.el.querySelector('.item__meta > .item__subtitle');
			this.CONFIG = {
				// Defaults:
				animation: {
					path: {
						duration: this.DOM.el.dataset.animationPathDuration || 1500,
						delay: this.DOM.el.dataset.animationPathDelay || 0,
						easing: this.DOM.el.dataset.animationPathEasing || 'easeOutElastic',
						elasticity: this.DOM.el.dataset.pathElasticity || 400,
						scaleX: this.DOM.el.dataset.pathScalex || 1,
						scaleY: this.DOM.el.dataset.pathScaley || 1,
						translateX: this.DOM.el.dataset.pathTranslatex || 0,
						translateY: this.DOM.el.dataset.pathTranslatey || 0,
						rotate: this.DOM.el.dataset.pathRotate || 0
					},
					image: {
						duration: this.DOM.el.dataset.animationImageDuration || 2000,
						delay: this.DOM.el.dataset.animationImageDelay || 0,
						easing: this.DOM.el.dataset.animationImageEasing || 'easeOutElastic',
						elasticity: this.DOM.el.dataset.imageElasticity || 400,
						scaleX: this.DOM.el.dataset.imageScalex || 1.1,
						scaleY: this.DOM.el.dataset.imageScaley || 1.1,
						translateX: this.DOM.el.dataset.imageTranslatex || 0,
						translateY: this.DOM.el.dataset.imageTranslatey || 0,
						rotate: this.DOM.el.dataset.imageRotate || 0
					},
					deco: {
						duration: this.DOM.el.dataset.animationDecoDuration || 2500,
						delay: this.DOM.el.dataset.animationDecoDelay || 0,
						easing: this.DOM.el.dataset.animationDecoEasing || 'easeOutQuad',
						elasticity: this.DOM.el.dataset.decoElasticity || 400,
						scaleX: this.DOM.el.dataset.decoScalex || 0.9,
						scaleY: this.DOM.el.dataset.decoScaley || 0.9,
						translateX: this.DOM.el.dataset.decoTranslatex || 0,
						translateY: this.DOM.el.dataset.decoTranslatey || 0,
						rotate: this.DOM.el.dataset.decoRotate || 0
					}
				}
			};
			this.initEvents();
		}
		initEvents() {
			this.mouseenterFn = () => {
				this.mouseTimeout = setTimeout(() => {
					this.isActive = true;
					this.animate();
				}, 75);
			}
			this.mouseleaveFn = () => {
				clearTimeout(this.mouseTimeout);
				if( this.isActive ) {
					this.isActive = false;
					this.animate();
				}
			}
			this.DOM.el.addEventListener('mouseenter', this.mouseenterFn);
			this.DOM.el.addEventListener('mouseleave', this.mouseleaveFn);
			this.DOM.el.addEventListener('touchstart', this.mouseenterFn);
			this.DOM.el.addEventListener('touchend', this.mouseleaveFn);
		}
		getAnimeObj(targetStr) {
			const target = this.DOM[targetStr];
			let animeOpts = {
				targets: target,
				duration: this.CONFIG.animation[targetStr].duration,
				delay: this.CONFIG.animation[targetStr].delay,
				easing: this.CONFIG.animation[targetStr].easing,
				elasticity: this.CONFIG.animation[targetStr].elasticity,	
				scaleX: this.isActive ? this.CONFIG.animation[targetStr].scaleX : 1,
				scaleY: this.isActive ? this.CONFIG.animation[targetStr].scaleY : 1,
				translateX: this.isActive ? this.CONFIG.animation[targetStr].translateX : 0,
				translateY: this.isActive ? this.CONFIG.animation[targetStr].translateY : 0,
				rotate: this.isActive ? this.CONFIG.animation[targetStr].rotate : 0
			};
			if( targetStr === 'path' ) {
				animeOpts.d = this.isActive ? this.paths.end : this.paths.start;
			}
			anime.remove(target);
			return animeOpts;
		}
		animate() {
			// Animate the path, the image and deco.
			anime(this.getAnimeObj('path'));
			anime(this.getAnimeObj('image'));
			anime(this.getAnimeObj('deco'));
			// Title and Subtitle animation
			anime.remove(this.DOM.title);
			anime({
				targets: this.DOM.title,
				easing: 'easeOutQuad',
				translateY: this.isActive ? [
					{value: '-50%', duration: 200},
					{value: ['50%', '0%'], duration: 200}
				] : [
					{value: '50%', duration: 200},
					{value: ['-50%', '0%'], duration: 200}
				],
				opacity: [
					{value: 0, duration: 200},
					{value: 1, duration: 200}
				]
			});
			anime.remove(this.DOM.subtitle);
			anime({
				targets: this.DOM.subtitle,
				easing: 'easeOutQuad',
				translateY: this.isActive ? {value: ['50%', '0%'], duration: 200, delay: 250} : {value: '0%', duration: 1},
				opacity: this.isActive ? {value: [0,1], duration: 200, delay: 250} : {value: 0, duration: 1}
			});
		}
	}

	const items = Array.from(document.querySelectorAll('.shape-item'));
	const init = (() => items.forEach(item => new ImgItem(item)))();
};


/* UPDATES */
           $(function() {
				"use strict";
                //caching
				//next and prev buttons
				var $cn_next	= $('#cn_next');
				var $cn_prev	= $('#cn_prev');
				//wrapper of the left items
				var $cn_list  = $('#cn_list');
				var $pages		= $cn_list.find('.cn_page');
				//how many pages
				var cnt_pages	= $pages.length;
				//the default page is the first one
				var page  = 1;
				//list of news (left items)
				var $items  = $cn_list.find('.cn_item');
				//the current item being viewed (right side)
				var $cn_preview = $('#cn_preview');
				//index of the item being viewed. 
				//the default is the first one
				var current		= 1;
				
				/*
				for each item we store its index relative to all the document.
				we bind a click event that slides up or down the current item
				and slides up or down the clicked one. 
				Moving up or down will depend if the clicked item is after or
				before the current one
				*/
				$items.each(function(i){
					var $item = $(this);
					$item.data('idx',i+1);
					
					$item.bind('click',function(){
						var $this   = $(this);
						$cn_list.find('.item_selected').removeClass('item_selected');
						$this.addClass('item_selected');
						var idx			= $(this).data('idx');
						var $current  = $cn_preview.find('.cn_content:nth-child('+current+')');
						var $next		= $cn_preview.find('.cn_content:nth-child('+idx+')');
						
						if(idx > current){
							$current.stop().animate({'top':'-300px'},600,'easeOutBack',function(){
								$(this).css({'top':'310px'});
							});
							$next.css({'top':'310px'}).stop().animate({'top':'5px'},600,'easeOutBack');
						}
						else if(idx < current){
							$current.stop().animate({'top':'310px'},600,'easeOutBack',function(){
								$(this).css({'top':'310px'});
							});
							$next.css({'top':'-300px'}).stop().animate({'top':'5px'},600,'easeOutBack');
						}
						current = idx;
					});
				});
				
				/*
				shows next page if exists:
				the next page fades in
				also checks if the button should get disabled
				*/
				$cn_next.bind('click',function(e){
					var $this = $(this);
					$cn_prev.removeClass('disabled');
					++page;
					if(page == cnt_pages)
						$this.addClass('disabled');
					if(page > cnt_pages){ 
						page = cnt_pages;
						return;
					}	
					$pages.hide();
					$cn_list.find('.cn_page:nth-child('+page+')').fadeIn();
					e.preventDefault();
				});
				/*
				shows previous page if exists:
				the previous page fades in
				also checks if the button should get disabled
				*/
				$cn_prev.bind('click',function(e){
					var $this = $(this);
					$cn_next.removeClass('disabled');
					--page;
					if(page == 1)
						$this.addClass('disabled');
					if(page < 1){ 
						page = 1;
						return;
					}
					$pages.hide();
					$cn_list.find('.cn_page:nth-child('+page+')').fadeIn();
					e.preventDefault();
				});
				
});



var animateButton = function(e) {

  e.preventDefault;
  //reset animation
  e.target.classList.remove('animate');
  
  e.target.classList.add('animate');
  setTimeout(function(){
    e.target.classList.remove('animate');
  },700);
};

var bubblyButtons = document.getElementsByClassName("bubblyButtons");

for (var i = 0; i < bubblyButtons.length; i++) {
  bubblyButtons[i].addEventListener('click', animateButton, false);
}