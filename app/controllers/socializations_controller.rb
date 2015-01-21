class SocializationsController < ApplicationController
  #before_filter :load_socializable

  def follow
    if current_user
      user = User.where(id: params[:user_id]).first
      current_user.follow!(user)
      user.create_activity key: 'user.follow', recipient: user, owner: current_user unless user.id == current_user.id
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
      recipe.create_activity key: 'recipe.like', recipient: recipe.user, owner: current_user unless recipe.user.id == current_user.id
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

  def mark_notifications_as_read
    activities = Activity.find(params[:activity_id])
    activities.mark_as_read! :for => current_user
    trackable = activities.trackable.is_a?(User) ? activities.owner.profile : activities.trackable
    redirect_to trackable
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


