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
    resources :customer, only: [:show, :index]
  end
  
   namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
