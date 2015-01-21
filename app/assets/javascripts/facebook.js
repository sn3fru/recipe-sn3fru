window.fbAsyncInit = function() {
  FB.init({
    appId      : 1528420927427686, // App ID
    cookie     : true,  // enable cookies to allow the server to access
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.1' // use version 2.1
  });
};


// Load the SDK Asynchronously
(function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
}(document));


function fblogin() {
  FB.login(function(response) {
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      location.href = '/users/auth/facebook/callback'
    }
  });
}


$(document).on("ready page:load", function(){
  $('#facebook-sign-in').click(function(e) {
    e.preventDefault();
    fblogin();
  });
});
