/*    
@licstart  The following is the entire license notice for the 
JavaScript code in this page.

Copyright (C) 2013  Peng Zhong

The JavaScript code in this page is free software: you can
redistribute it and/or modify it under the terms of the GNU
General Public License (GNU GPL) as published by the Free Software
Foundation, either version 3 of the License, or (at your option)
any later version.  The code is distributed WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU GPL for more details.

As additional permission under GNU GPL version 3 section 7, you
may distribute non-source (e.g., minimized or compacted) forms of
that code without the copy of the GNU GPL normally required by
section 4, provided you include this license notice and a URL
through which recipients can access the Corresponding Source.   


@licend  The above is the entire license notice
for the JavaScript code in this page.
*/

var jPM = $.jPanelMenu();
jPM.on();

// smooth scrolling to href#
$('a[href*=#]:not([href=#])').click(function() {
  if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'')
    || location.hostname == this.hostname) {

      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top - 32
        }, 1000);
        return false;
      }
    }
});

var langs = ['ar', 'ca', 'de', 'el', 'eo', 'en', 'es', 'fa', 'fi', 'fr', 'hi', 'io', 'it', 'ja', 'nl', 'no', 'pl', 'pt', 'ru', 'sr', 'sr_cr', 'sv', 'zh_cn', 'zh_tw', 'he'];

// the actual html replacing function
function updateWithJSON(abbr) {
  //if(langs.indexOf(abbr) < 0)
  //  throw "Unsupported language";
  if(abbr == 'ar' || abbr == 'fa' || abbr == 'he')
    $('body').attr('id', 'rtl');
  else
    $("body").removeAttr('id');

  var jsonUrl = "/lang/" + abbr + ".json";
  $.getJSON(jsonUrl, function(data) {
    $.each(data, function(key, val) {
      if(key == 'i18n-meta-description')
        $('.i18n-meta-description').attr("content", val);
      else
        i18nSpans = $('html').find("." + key);
        i18nSpans.html(val);
    });
  });

  // hack to hide hideable again
  setTimeout('$(".hideable").hide()', 1500);
};

// set language based on <select>
$("#lang-select").change(function() {
  $("select option:selected").each(function () {
    for(var i=0; i < langs.length; i++) {
      if( $(this).attr('id') == ('lang-'+langs[i]) ) {
        updateWithJSON(langs[i]);
        window.location.hash = langs[i];
        break;
      }
    }
  });
});

// set site language based on url segment
function setLangByHash() {
  var url = document.URL;
  var id = url.substring(url.lastIndexOf('#') + 1);
  updateWithJSON(id);

  // update <select> also
  var rightOption = "lang-" + id;
  $("#lang-select option").filter(function(){
    return this.id == rightOption;
  }).prop('selected', true);

  

}
setLangByHash();

if(navigator.language != undefined && navigator.language.length > 1 && langs.indexOf(navigator.language) > -1)
{
  updateWithJSON(navigator.language);
}

// hide hideable by default
$(".hideable").hide();

// expand & hide sections
$('.toggle-section').click(function() {
  var section = $(this).parent().parent().parent().parent()
  if (section.hasClass('expanded')) {
    section.find('.hideable').slideUp();
    section.removeClass('expanded');
  } else {
    section.find('.hideable').slideDown();
    section.addClass('expanded');
  }
})
