/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// We start the client side facebook SDK so we can easily deal with Like buttons, etc.
jQuery(document).ready(function($$) {
  console.log('[Facebook] launch, appId=' + GET_GLOBAL('apiKeyFacebook'));
  // Now, asynchronously load the FB SDK
  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
});

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// Function called in response to getLoginStatus()
// Presently this is just for informational purposes, until we get the backend
// sorted out.
function fb_statusChangeCallback(response) {
  console.log('[Facebook] statusChangeCallback: response.status=', response.status);
  // The response object is returned with a status field that lets the
  // app know the current login status of the person.
  // Full docs on the response object can be found in the documentation
  // for FB.getLoginStatus().
//  jQuery('#magic-sign-in-button').hide();
//  jQuery('#magic-sign-out-button').hide();
//  jQuery('#magic-sign-in-msg2').show();
//  jQuery('#my-fb-status').innerHTML = '';
  if (response.status === 'connected') {
//    // Logged into your app and Facebook.
//    jQuery('#magic-sign-out-button').show();
//    jQuery('#my-fb-status').innerHTML = 'Log in with Facebook...';
//    jQuery('#magic-sign-in-msg2').hide();
//    fb_sanityCheckAPI();
  } else if (response.status === 'not_authorized') {
//    // The person is logged into Facebook, but not your app.
//    jQuery('#magic-sign-in-button').show();
  } else {
//    // Not logged into Facebook so not sure if logged into this app or not.
//    jQuery('#magic-sign-in-button').show();
  }

  // NOTE: toggling magic-sign-in-button is a hack, we really should tell the server and force a refresh...
  // but it works for the MVP stage for now
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
// Code executed after the FB SDK completes asynchronous loading
window.fbAsyncInit = function() {
  // Associate our API key
  console.log('[Facebook] appId=' + GET_GLOBAL('apiKeyFacebook'));
  FB.init({
    appId      : GET_GLOBAL('apiKeyFacebook'),
    xfbml      : true,
    version    : 'v2.2'
  });

  // Test if user is logged in ('connected'), logged into FB but not our app ('not_authorized') or not at all
  FB.getLoginStatus(function(response) {
    fb_statusChangeCallback(response);
  });
};

///* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//// Sanity check the Graph API
//function fb_sanityCheckAPI() {
//  console.log('[Facebook] Fetching your information.... ');
//  FB.api('/me', function(response) {
//    console.log('[Facebook] Successful login for: ' + response.name);
//    document.getElementById('my-fb-status').innerHTML = 'Hi, ' + response.name + '!';
//    // TODO: change to 'Welcome Back' if its been a while...
//  });
//}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// There needs to be a generic login javascript somewhere. But lets just dump this stuff here for now.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function magicSendPlaylist() {
  FB.getLoginStatus(function(response) {
    if (response.status === 'connected') {
      // Note: we can get here when signed in already with facebook, but not connected to backend!
      alert("magicSendPlaylist: Not yet implemented");
    } else if (response.status === 'not_authorized') {
      jQuery('#appModalLogin').modal();
    } else {
      jQuery('#appModalLogin').modal();
    }
  });
  // hmm. For some reason, $() used to work in this method. Then I tried to integrate jquery document init to properly init things...
}

function magicLoginWithFacebook() {
  alert("magicLoginWithFacebook: Not yet implemented");
//  jQuery('#appModalLogin').modal('hide')
//  FB.login(function(response){
//    fb_statusChangeCallback(response);
//  });
}

function magicLogout() {
  alert("To sign out, disconnect the app from within facebook.");
}

function magicPremium() {
  FB.getLoginStatus(function(response) {
    if (response.status === 'connected') {
      // Note: we can get here when signed in already with facebook, but not connected to backend!
      alert("magicPremium: Not yet implemented");
    } else if (response.status === 'not_authorized') {
      jQuery('#appModalLogin').modal();
    } else {
      jQuery('#appModalLogin').modal();
    }
  });
}
