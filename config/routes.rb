Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root "chats#index", as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :contacts

  resources :chats do
    member do
      get :show_personal
    end
  end

  resources :users, only: :none do
    collection do
      get :search
      post :search
    end
  end

  mount ActionCable.server => '/cable'
end
