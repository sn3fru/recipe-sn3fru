// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require turbolinks
//= require bootstrap
//= require_tree .


var windowz = 30;

function fullscreen(element){
    if (element.closest('.window').attr('data-scaled') === "false"){
        element.closest('.window')
        .css('width', '100%')
        .css('height', '100%')
        .attr('data-scaled', 'true');
    } else{
        element.closest('.window')
        .css('width', '800px')
        .css('height', '600px')
        .attr('data-scaled', 'false');
    }
}
var movementStrength = 5;
var height = movementStrength / $(window).height();
var width = movementStrength / $(window).width();

$("html").mousemove(function(e){

		  var pageX = e.pageX - ($(window).width() / 2);
		  var pageY = e.pageY - ($(window).height() / 2);

		  var newvalueX = width * pageX * -1;
		  var newvalueY = height * pageY * -1;

		  $('body').css("background-position", (50+newvalueX)+"% "+(50+newvalueY)+"%");
});

function loadstatus(frame){
    //alert(frame + 'loaded');
    $('.window').first().find('.subloader').hide('slide',{direction:'right'},500);
}

$(document).ready(function(){
    var $reload = $('.reload'),
        $tab = $('.tab'),
        windowIterate = 0,
        $toggleSidebar = $('.toggleSidebar'),
        $sidebar = $('.sidebar'),
        sidebarToggled = false;

    var m = false,
        u = false,
        z = false;

    setTimeout(function(){
        $('#pictureframe').hide();
    },3400);

    $('body').keypress(function( event ) {
        if(event.which === 109) m = true;
        if(event.which === 117) u = true;
        if(event.which === 122) z = true;
        if (m && u && z) alert('give me coffee money!');
    });

    setInterval(function(){
        $('.hireme').toggleClass('animated bounce');
    }, 3000);

    $toggleSidebar.click(function(){
        if(!sidebarToggled){
            $sidebar.addClass('animated bounceOutLeft');
            setTimeout(function(){
                $sidebar.css('width', '0px');
                $('.screenestate').css('width', '100%');
                sidebarToggled = true;
            }, 500);
        }else{
            $sidebar.css('width', '20%');
            $('.screenestate').css('width', '80%');
            sidebarToggled = false;
            $sidebar.removeClass('animated bounceOutLeft');
            $sidebar.addClass('animated bounceInleft');
        }

    });

    (function(){
        $('.loading').hide();
        $('.sidebar').addClass('animated bounceInLeft');
        $('.toggleSidebar').addClass('animated bounceInLeft');
        $('.tipjar').addClass('animated bounceInRight');
    })();

    $('.screenestate').find('.window').hide();

    /*$('.draggable').draggable({
        containment: '.screenestate',
        handle: $(this).find('.menu')
    }).resizable();
    */
    $('.sidebar ul li').click(function(){
        if($(this).has('ul')){
            if($(this).find('ul').css('height') === '0px'){
                $(this).find('ul').css('height', 'auto');
            }else{
                $(this).find('ul').css('height', '0');
            }
        }
    });

    $('.sidebar ul li ul li').click(function(){
        windowIterate+=20;
        var link = $(this).find('a').attr('data-link');
        $('.window').last().clone()
            .draggable()
            .css({
                'top' : windowIterate+'px',
                'left': windowIterate+'px',
                'z-index' : windowIterate
            })
            .show()
            .prependTo('.screenestate')
            .find('.browserview')
            .attr('src', link);
            $('.window')
            .first()
            .find('.windowTitle')
            .html($(this).find('a').html());
            $('.window')
            .first()
            .find('.urlthingy')
            .val(link);
            $('.window')
            .first()
            .find('.subloader')
            .show();
    });

});