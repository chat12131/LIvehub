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
  resources :live_schedules do
    resources :venues, only: [:new, :create]
  end
  resources :live_records do
    resources :venues, only: [:new, :create]
  end
  root 'home#index'
end
