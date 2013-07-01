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

// list of supported langs
var langs = ['ar', 'de', 'el', 'eo', 'en', 'es', 'fa', 'fi', 'fr', 'hi', 'io', 'it', 'ja', 'nl', 'no', 'pl', 'pt', 'ru', 'sr', 'sr_cr', 'sv', 'zh_cn', 'zh_tw'];

$("#lang-select").change(function() {

  $("select option:selected").each(function () {
    for(var i=0; i < langs.length; i++)
  {
      if( $(this).attr('id') == ('lang-'+langs[i]) )
    {
      getLang(langs[i]);
      window.location.hash = langs[i];
      break;
    }
  }
  });
});

// pulling in json language data
function getLang(abbr) {
  if(langs.indexOf(abbr) < 0)
    throw "Unsupported language";
  if(abbr == 'ar' || abbr == 'fa')
    $('body').attr('id', 'rtl');
  else
    $("body").removeAttr('id');
  var jsonUrl = "lang/" + abbr + ".json";
  $.getJSON(jsonUrl, function(data) {
    $.each(data, function(key, val) {
      // upon reaching meta description, change the content instead of just the inner html
      if(key == 'i18n-meta-description')
        $('.i18n-meta-description').attr("content", val);
      else
        i18nSpans = $('html').find("." + key);
        i18nSpans.html(val);
    });
  });
};

// set site language based on url segment
function setLangByUrl() {
  var url = document.URL;
  var id = url.substring(url.lastIndexOf('#') + 1);
  getLang(id);

  // update #lang-select based on url segment
  var rightOption = "lang-" + id;
  $("#lang-select option").filter(function(){
    return this.id == rightOption;
  }).prop('selected', true);
}
setLangByUrl();

if(navigator.langage != undefined && navigator.langage.length > 1 && langs.indexOf(navigator.langage) > -1)
{
  getLang(navigator.langage);
}
