Rails.application.routes.draw do

  root "products#index"
  resources :products do
    resources :items, except: [:index]
  end

end