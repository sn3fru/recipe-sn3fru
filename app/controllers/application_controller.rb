class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :activities

  def follow
    user = User.find(params[:id])
    current_user.follow!(user) # => This assumes you have a variable current_user who is authenticated
  end

  def activities
    if current_user
      @activities = Activity.where(recipient: current_user).last(10)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end
