Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'mypage', to: 'users#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :artists do
    collection do
      get :favorites
    end
    resources :members, only: [:index]
    member do
      post 'toggle_favorite'
    end
  end
  resources :live_schedules do
    resources :venues, only: [:new, :create]
  end
  resources :live_records do
    get 'details', on: :member, format: :json
    resources :venues, only: [:new, :create]
  end
  resources :goods do
    resources :categories, only: [:new, :create]
  end
  get 'statistics', to: 'statistics#index'
  root 'home#index'
end
