// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// commenting out for now, don't know if we really need these

//= require jquery
//= require jquery_ujs

//= require store/spree_core
//= require store/spree_auth
//= require store/spree_promo

//= require_tree
//= require_self

MBP.scaleFix();
MBP.hideUrlBarOnLoad();


function LoadModalDialog(href, height){
  // do popup dialog if screen width is > 580
  // on ie7 don't do popup dialog, too many issues
  oldie = ($.browser.msie && parseInt($.browser.version, 10) <= 7);
  if (($(window).width() > 580) && (!oldie)) {
    tmt.jquery.modalframe.open(href + '_box', { height: height });
    return false; // don't execute original href
  }
  return true; // execute original href
}

var breakpoint;

function get_breakpoint(){
  var bp = 1;
  if ($(window).width() >= 320){
    bp = 2;
  }
  if ($(window).width() >= 390){
    bp = 3;
  }
  if ($(window).width() >= 580){
    bp = 4;
  }
  if ($(window).width() >= 770){
    bp = 5;
  }
  if ($(window).width() >= 950){
    bp = 6;
  }
  if ($(window).width() >= 1150){
    bp = 7;
  }
  // console.log("BreakPoint: " + bp);
  return bp;
}

function LoadCarousel(selector, container){

  var moduleWidth;
  var scroll_size;
  var rows;
  switch(selector){
  case '.brand-page #more-brand-products ul':
    scroll_size = 1;
    moduleWidth = 190;
    rows = 2;
    switch(breakpoint){
    case 2:
      scroll_size = 2;
      moduleWidth = 155;
      break;
    case 3:
      scroll_size = 2;
      break;
    case 4:
      scroll_size = 3;
      break;
    case 5:
      scroll_size = 4;
      break;
    case 6:
      scroll_size = 5;
      break;
    case 7:
      scroll_size = 6;
      break;
    }
    break;
  case '#photos ul':
    scroll_size = 1;
    rows = 1;
    switch(breakpoint){
    case 1:
      moduleWidth = 190;
      break;
    case 2:
      moduleWidth = 310;
      break;
    default:
      moduleWidth = 380;
    }
    break;
  }

  if (typeof jQuery(selector).data('jcarousel') === 'undefined'){
    // Create first time
    $(selector).jcarousel({ scroll: scroll_size, rows: rows, moduleWidth: moduleWidth });
  } else {
    // Return html to pre-jcarousel state
    $(selector).appendTo(container);
    $(container + ' div.jcarousel-skin-tango').remove();
    $(container + ' ul').removeAttr('style').removeClass();
    $(container + ' ul li').removeAttr('style').removeAttr('jcarouselindex').removeClass();
    $(container + ' ul').addClass('jcarousel-skin-tango');
    if (selector === '.brand-page #more-brand-products ul'){
      $(selector).addClass('item');
    }

    // Clear old instance pointer
    jQuery(selector).data('jcarousel', null);

    // Recreate carousel with new params
    $(selector).jcarousel({ scroll: scroll_size, rows: rows, moduleWidth: moduleWidth });
  }
}

function LoadCarousels(){
  LoadCarousel('.brand-page #more-brand-products ul', '.brand-page #more-brand-products');
  LoadCarousel('#photos ul', '#photos');
  $('.brand-products ul').jcarousel({ scroll: 2, rows: 1, moduleWidth: 197 });
}

function EnableTouchWipe(selector){
  // enable touch wipe for carousel on product details page
  $(selector).touchwipe({
    wipeLeft: function() {
      $(selector).find('.jcarousel-next').click();
    },
    wipeRight: function() {
      $(selector).find('.jcarousel-prev').click();
    },
    preventDefaultEvents: false,
    preventDefaultLeftRightEvents: true
  });
}

function EnableTouchWipes(){
  EnableTouchWipe('.brand-page #more-brand-products');
  EnableTouchWipe('#photos');
  $('#products').find('.brand-products').each(function(){
      EnableTouchWipe(this);
  });
}

function SetLogo(){
  var logo = $(".brand-page header #brand-logo");
  var logo_img = $(".brand-page header #brand-logo img");
  var love = $('.brand-page header #love-link-box');
  if (breakpoint >= 6) {
    logo_img.imgCenter( { scaleToFit: false } );

    if (logo_img.width() < 200) {
      love.css("left", ((logo.width() - logo_img.width()) / 2) + logo_img.width() + 5);
    } else {
      love.css("left", 205);
    }
    if (logo_img.height() < 70) {
      love.css("top", ((logo.height() - logo_img.height()) / 2) + logo_img.height() - 14);
    } else {
      love.css("top", 70-14);
    }
  } else {
    logo_img.css("left", 0);
    logo_img.css("bottom", 0);
    logo_img.css("margin-left", 0);
    love.css("left", logo_img.width() + 5);
    love.css("top", 40-14);
  }

  logo.css("visibility", "visible");
  logo.css("overflow", "visible");
  love.show();

}

function CenterLogo(){
  $(".brand-page header #brand-logo img").imgCenter( { scaleToFit: false } );
}

$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').placeholder();

  // $('.edit-cart-item').on('click', function(){
  //   return LoadModalDialog(this.href, 600);
  // });

  // $('.edit-shipping-address').on('click', function(){
  //   return LoadModalDialog(this.href, 655);
  // });

  // $('.edit-payment-method').on('click', function(){
  //   return LoadModalDialog(this.href, 800);
  // });

  // $('.signin').on('click', function(){
  //   return LoadModalDialog(this.href, 350);
  // });

  // $('.new-member').on('click', function(){
  //   return LoadModalDialog(this.href, 400);
  // });
  $(".brand-page header #brand-logo img").bind('load', function(){
    SetLogo();
  });

  breakpoint = get_breakpoint();

  LoadCarousels();

  // Click link for hearts and You Love
  $(document).on('click', '.love-link', function(event){
    event.stopPropagation();
    var hearted_link = $(this);
    if(hearted_link.hasClass("loved")) return;
    if(hearted_link.hasClass("logged-out")){
        window.location.href = "/login";
        return;
    }
    $("#heart_product_id").val($(this).data("product-id"));
    $.post('/hearts/', $("#new_heart").serialize(),function(result){
        hearted_link.text("You Love");
        hearted_link.addClass("loved");
        old_hearts = parseInt(hearted_link.siblings().filter(":first").text());
        hearted_link.siblings().filter(":first").text(old_hearts+1)
    });
  });

  // click link for empty cart button
  $('form').on('click', '.empty-cart-button', function(event){
    $('form.empty-cart-form').submit();
  });

  // Click link for photos and hover state
  $(document).on('click', '.item .photo, .item .photo .hover', function(){
    window.location.href = $(this).attr('url');
  });

  // Click link to show search field
  $('#search-link').on('click', function() {
    $('#search-link').hide();
    $('#search-field').show('fast');
  });
 
  $('.brand-page #details-tab').on('click', function(){
    $('.brand-page .copy-tab').hide();
    $('.brand-page #details').show();
    $('#product-copy').scrollTop(0);
  });
  $('.brand-page #about-tab').on('click', function(){
    $('.brand-page .copy-tab').hide();
    $('.brand-page #about').show();
    $('#product-copy').scrollTop(0);
  });
  $('.brand-page #return-policy-tab').on('click', function(){
    $('.brand-page .copy-tab').hide();
    $('.brand-page #return-policy').show();
    $('#product-copy').scrollTop(0);
  });
  $('.brand-page #shipping-details-tab').on('click', function(){
    $('.brand-page .copy-tab').hide();
    $('.brand-page #shipping-details').show();
    $('#product-copy').scrollTop(0);
  });

  // If touch
  if (Modernizr.touch) {
    EnableTouchWipes();
  } else {
    // enable hover state for appropriate photos
    $(document).on('mouseenter', '.brand-page .item .photo, .item.grid-item .photo, .item.list-item .brand-products .photo', function(){
      $(this).children('.hover').show();
    });
    $(document).on('mouseleave', '.brand-page .item .photo, .item.grid-item .photo, .item.list-item .brand-products .photo', function(){
      $(this).children('.hover').hide();
    });
  }

  // Endless scrolling
  $(window).scroll(function(){
    url = $('#product_loader').attr('url');
    if (url && ($(window).scrollTop() > ($(document).height() - $(window).height() - 200))) {
      $('#product_loader').attr('url', '');
      $.getScript(url);
    }
  });
  $(window).scroll();

  $(window).on('resize', function(e){

    if (breakpoint != get_breakpoint()){
      breakpoint = get_breakpoint();

      // Resizes carousels to new breakpoint
      LoadCarousels();
      SetLogo();
    }

  });

});

