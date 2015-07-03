/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// Code for page-main
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

// Javascript specific for main.swgi:
// Javascript head-tag code included after bootstrap and jquery

// Code executed immediately inside head

jQuery(document).ready(function($$) {

  // Prepare tag cloud shown in main page when document element is completed.
  // Markup is in main-chart-select.tpl

  if(!$$('#magicTagCanvas').tagcanvas({
    textColour: '#ff0000',
    outlineColour: '#ff00ff',
    reverse: true,
    depth: 0.8,
    maxSpeed: 0.05
  },'mytags')) {
    // something went wrong, hide the canvas container
    $$('#magicTagCanvasContainer').hide();
  }
});

// The playlist buttons are rendered disabled until at least one word is selected
// FIXME: encapsulate this in a page-local object / namespace
function magicTagAappend(txt) {
  jQuery.noConflict();
  var text = jQuery('#magicWordList');
  gap = " ";
  if (text.val().length == 0) gap="";
  text.val(text.val() + gap + txt);
  jQuery("#btnPlaylist").removeAttr("disabled");
  jQuery("#btnAussiePlaylist").removeAttr("disabled");
}

