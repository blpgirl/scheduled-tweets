Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "main#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "password/reset", to: "registrations#new_reset"
  post "password/reset", to: "registrations#reset"
  get "password/reset/edit", to: "registrations#edit_password_reset"
  patch "password/reset/edit", to: "registrations#update_password_reset"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"
end
