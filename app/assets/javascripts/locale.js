$(function(){

  $('#language_select').bind('change', function () {
    var locale = $(this).val();


    var oldURL = window.location.protocol + "//" + window.location.host + window.location.pathname;

    console.log(oldURL);

    var pathArray = oldURL.split( '/' );
    pathArray[3] = locale;


    var newURL = "";

    for (i=0; i < pathArray.length; i++) {
      newURL += pathArray[i];
      if (pathArray.length > i + 1) {
        newURL += "/";
      }
    }
    
    window.location.replace(newURL);
  });

});
