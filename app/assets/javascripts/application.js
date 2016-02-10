// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function(){
	$('.flash').fadeOut(5000);

	$('.link').hover(function(){
		$(this).css({
			'color': '#F2583E',
			'border-bottom': '3px solid',
			});
		}, function(){
			$('.link').css({
				'color': '#000000',
				'border-bottom': '0px',
			});
		}
	);

		$(".modal-link").on("click", function(e){
			// prevent default is needed to avoid link taking us to a new page
			e.preventDefault();
			// primarily for testing
			console.log("clicked on about link");
			// changes display option to reveal display:none element
			$(".outer-modal").css({"display": "block"})
		});

		// clicking anywhere on the page makes the image go away - only relevant if the link has been clicked
		$(".outer-modal").on("click", function(){
			$(".outer-modal").css({"display": "none"})
		});

	}
);