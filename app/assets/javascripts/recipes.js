$(document).on("ready page:load", function(){

	$('.like-recipe').click(function(){
		var recipe_id = $(this).data('recipe-id');
		$.ajax({
  		url: "/recipes/"+recipe_id+"/like",
  		type: "POST",
  		success: function(data){
  			if (data.like) {
  				$('#like-recipe-'+recipe_id).toggle();
  				$('#unlike-recipe-'+recipe_id).toggle();
		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

	$('.unlike-recipe').click(function(){
		var recipe_id = $(this).data('recipe-id');
		$.ajax({
  		url: "/recipes/"+recipe_id+"/unlike",
  		type: "POST",
  		success: function(data){
  			if (data.unlike) {
  				$('#unlike-recipe-'+recipe_id).toggle();
  				$('#like-recipe-'+recipe_id).toggle();
		    }else{
		    	location.href = '/users/sign_in'
		    }
  		}
		});
	});

});