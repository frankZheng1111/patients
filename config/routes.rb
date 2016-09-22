Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "patients#index"
  post "set_locale", to: "base#change_locale"

  resources :patients
  resources :locations, only: [:show]


end
