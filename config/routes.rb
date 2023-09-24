Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'mypage', to: 'users#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :artists do
    collection do
      get :favorites
    end
    member do
      post 'toggle_favorite'
    end
  end

  root 'home#index'
end
