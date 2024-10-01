Rails.application.routes.draw do
  root to: "homes#top"
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_scope :customer do
    get '/customers/sign_out' => 'devise/sessions#destroy'
  end
  
  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    # 'cart_items/destroy_all' => 'customers#show', as: 'mypage'
    resources :customers, only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end
  
   namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
