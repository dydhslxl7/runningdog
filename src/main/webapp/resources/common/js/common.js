//탑메뉴
$(document).ready(function() {
	$('.menuAll > ul > li.menuAll_close').on('click', function() {
		$('.menuBtn').removeClass('on')
		$(this).removeClass('on');
		$('#header').removeClass('active');
		$('.menuAll').slideUp(200);
		$('.menuAll').removeClass('on');
	});
	$('.menuBtn').on('click', function() {
		if ($(this).hasClass('on')) {

			$(this).removeClass('on');
			$('#header').removeClass('active');
			$('.menuAll').slideUp(200);
			$('.menuAll').removeClass('on');
		} else {
			$(this).addClass('on');
			$('#header').addClass('active');
			$('.menuAll').slideDown(200);
			$('.menuAll').addClass('on');
		}
	});
	$(window).on('scroll', function() {
		if ($(this).scrollTop() > 10) {
			$('#header').addClass('on');
			$('#mHeader').addClass('on');
		} else {
			$('#header').removeClass('on');
			$('#mHeader').removeClass('on');
		}
	});
});


//탑메뉴
//$(document).ready(function() {
//	$('#mHeader dl dt button.xi-align-justify').on('click', function() {
//		if ($(this).removeClass('collapsed')) {
//			$('#mHeader').addClass('on');
//		} else {
//			$('#mHeader').removeClass('on');
//		}
//	});
//});



// 서브 비주얼 //
$(document).ready(function() {
	$(".animal-vagas").vegas({
		slides : [ {
			src : "/runningdog/resources/images/content/animalBg01.jpg"
		}, {
			src : "/runningdog/resources/images/content/animalBg01.jpg"
		} ],
		// animation: 'kenburns',
		animation : 'random',
		delay : 7000,
		overlay : '/runningdog/resources/images/btnIcn/overlay_01.png'
	});

});

// 지그재그 레이아웃
$(document).ready(function() {
	// external js: masonry.pkgd.js, imagesloaded.pkgd.js
	// init Masonry
	var grid = document.querySelector('.grid');

	var msnry = new Masonry(grid, {
		itemSelector : '.grid-item',
		columnWidth : '.grid-sizer',
		percentPosition : true
	});

	imagesLoaded(grid).on('progress', function() {
		// layout Masonry after each image loads
		msnry.layout();
	});

});

// 탑버튼
$(document).ready(function() {
	$('#topRollBtn').fadeOut();
	$(window).scroll(function() {
		if ($(this).scrollTop() > 150) {
			$('#topRollBtn').fadeIn();
		} else {
			$('#topRollBtn').fadeOut();
		}
	});

	$("#topRollBtn").click(function() {
		$('html, body').animate({
			scrollTop : 0
		}, 400);
		return false;
	});
});



// 썸머노트 무료 에디터
$(document).ready(function() {
	$('#summernote').summernote({
		placeholder : 'content',
		minHeight : 300,
		maxHeight : null,
		focus : true,
		lang : 'ko-KR',
		callbacks: {
			onImageUpload : function(files) {
				sendFile(files[0], this);
			}
		}
	});
});