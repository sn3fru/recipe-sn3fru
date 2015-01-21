$(document).on("ready page:load", function(){

	$('.follow-link').click(function(){
		var user_id = $(this).data('user-id');
		$.ajax({
  		url: "/users/"+user_id+"/follow",
  		type: "POST",
  		success: function(data){
  			if (data.follow) {
  				$('.follow-link').toggle();
  				$('.unfollow-link').toggle();
		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

	$('.unfollow-link').click(function(){
		var user_id = $(this).data('user-id');
		$.ajax({
  		url: "/users/"+user_id+"/unfollow",
  		type: "POST",
  		success: function(data){
  			if (data.unfollow) {
  				$('.unfollow-link').toggle();
  				$('.follow-link').toggle();

		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

});