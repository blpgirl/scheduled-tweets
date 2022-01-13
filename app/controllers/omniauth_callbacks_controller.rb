class OmniauthCallbacksController < ApplicationController
  def twitter
    # Rails.logger.info auth

    Current.user.twitter_accounts.create(
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )
    redirect_to twitter_accounts_path, notice: "Account connected successfully"
  end

  def auth
    # to get credentials from OmniAuth
    request.env["omniauth.auth"]
  end
end
