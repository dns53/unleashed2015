/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// Common object initialisation code.
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

jQuery.noConflict();

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// Initialise common elements here.
// By default, hide all login related stuff
jQuery(document).ready(function($$) {
  console.log('[pz-common-init] document ready');

  // The following elements are in views/nav.tpl

  if (GET_GLOBAL('authenticated') === 'True') {
    $$('#magic-login-status')[0].textContent = 'Hello, ' + GET_GLOBAL('users_name');
    $$('#magic-sign-in-button').hide();
    $$('#magic-sign-out-button').show();
  } else {
    $$('#magic-sign-in-button').show();
    $$('#magic-sign-out-button').hide();
    $$('#magic-login-status')[0].textContent = 'Guest';
  }
  $$('#magic-login-status').show();

  // The following elements are in views/playlist-playlist.tpl
  $$('#magic-sign-in-msg2').show();

  authomatic.setup({
    //popupWidth: 200,
    //popupHeight: 100,
    onLoginComplete: function(result) {
       if (result.user) {
         location.reload()
       } else if (result.error) {
          alert('Unable to sign in.\nLogin provder message: ' + result.error.message);
       }
    },
    onPopupOpen: function(url) {
      // Hide the caller
      $$('#appModalLogin').modal('hide');
    }
  });
  authomatic.popupInit();
});

