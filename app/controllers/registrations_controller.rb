class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account."
    else
      render :new
    end
  end

  def new_reset
  end

  def reset
    @user = User.find_by(email: params[:email])
    if @user.present?
      # send the email. rails g mailer Password reset. deliver_later is to set it as a background job.
      # deliver_now is great for testing so you see exactly when the email is send but later is better for production
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If an account with that email exists, then an email with a link to reset the password was send."

  end

  def edit_password_reset
    # this will get the user and confirmed that the token hasnt expired yet
    # you can call without the ! but it wont throw an exception when token is expired although user will be nil
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to sign_in_path, alert: "The token has expired. Please try again."
  end

  def update_password_reset
      @user = User.find_signed!(params[:token], purpose: "password_reset")
      if @user.update(password_params)
        redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
      else
        render :edit_password_reset
      end
  end

  private
    def user_params
      params.require(:user).permit(:email,:password,:password_confirmation)
    end

    def password_params
      # since we are using the model user then params will come with user first
      params.require(:user).permit(:password, :password_confirmation)
    end
end
