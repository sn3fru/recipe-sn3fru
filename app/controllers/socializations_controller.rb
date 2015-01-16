class SocializationsController < ApplicationController
  #before_filter :load_socializable

  def follow
    if current_user
      user = User.where(id: params[:user_id]).first
      current_user.follow!(user)
      render json: { follow: true }
    else
      flash[:notice] = "Sign in before continue"
      render json: { redirect: new_user_session_path }
    end
  end

  def unfollow
    if current_user
      user = User.where(id: params[:user_id]).first
      current_user.unfollow!(user)
      render json: { unfollow: true}
    else
      flash[:notice] = "Sign in before continue"
      render json: { redirect: new_user_session_path }
    end
  end

  def recipe_like
    if current_user
      recipe = Recipe.where(id: params[:recipe_id]).first
      current_user.like!(recipe)
      render json: { like: true }
    else
      flash[:notice] = "Sign in before continue"
      render json: { redirect: new_user_session_path }
    end
  end

  def recipe_unlike
    if current_user
      recipe = Recipe.where(id: params[:recipe_id]).first
      current_user.unlike!(recipe)
      render json: { unlike: true}
    else
      flash[:notice] = "Sign in before continue"
      render json: { redirect: new_user_session_path }
    end
  end

  private

  def load_socializable
    @socializable =
        case
          when id = params[:comment_id] # Must be before :item_id, since it's nested under it.
            @community.comments.find(id)
          when id = params[:item_id]
            @community.items.find(id)
          else
            raise ArgumentError, "Unsupported socializable model, params: " +
                params.keys.inspect
        end
    raise ActiveRecord::RecordNotFound unless @socializable
  end

end


