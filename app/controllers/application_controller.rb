class ApplicationController < ActionController::Base
  before_action :set_current_user
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    # to make the method return true or false set !!
    !!Current.user
  end

  def require_user_logged_in!
    if !logged_in?
      flash[:notice]= "You must be log in to perform that action."
      redirect_to login_path
    end
  end

end
