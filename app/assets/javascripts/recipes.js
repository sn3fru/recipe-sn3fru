$(document).ready(function(){

	$('.like-recipe').click(function(){
		var user_id = $(this).data('user-id');
		$.ajax({
  		url: "/recipes/"+user_id+"/like",
  		type: "POST",
  		success: function(data){
  			if (data.like) {
  				$('.like-recipe').toggle();
  				$('.unlike-recipe').toggle();
		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

	$('.unlike-recipe').click(function(){
		var user_id = $(this).data('user-id');
		$.ajax({
  		url: "/recipes/"+user_id+"/unlike",
  		type: "POST",
  		success: function(data){
  			if (data.unlike) {
  				$('.unlike-recipe').toggle();
  				$('.like-recipe').toggle();

		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

});