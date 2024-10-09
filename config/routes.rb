Rails.application.routes.draw do
  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
     resources :orders, only: [:index, :show, :update]
  end
  
  devise_scope :customer do
    get '/customers/sign_out' => 'devise/sessions#destroy'
  end
  
  scope module: :public do
    root 'homes#top'

    get 'customers/mypage' => 'customers#show', as: 'mypage'
    # 'cart_items/destroy_all' => 'customers#show', as: 'mypage'
    resources :customers, only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end
  
   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
