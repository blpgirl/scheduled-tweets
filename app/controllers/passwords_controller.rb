class PasswordsController < ApplicationController
  before_action :require_user_logged_in!

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if Current.user.update(password_params)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in Successfully."
    else
      flash[:alert] =  "Invalid email or password."
      render :edit
    end
  end # update

  private
    def password_params
      # since we are using the model user then params will come with user first
      params.require(:user).permit(:password, :password_confirmation)
    end
end
