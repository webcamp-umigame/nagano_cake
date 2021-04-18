Rails.application.routes.draw do
    devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  # admin側サイトのrouting
  namespace :admin do
    root 'homes#top'
    resources :products
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_products, only: [:update]
  end

  # customer側サイトのrouting
  scope module: :customer do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :products, only: [:index, :show]
    resource :customers, only: [:show, :edit, :update]
      get 'customers/unsubscribe' => 'customers#unsubscribe'
      patch 'customers/withdraw'  => 'customers#withdraw'
    resources :orders, only: [:new, :create, :index, :show]
      post 'orders/confirm' => 'orders#confirm'
      get 'orders/thanx'    => 'orders#thanx'
    resources :cart_items, only: [:index, :create, :update, :destroy]
      delete 'cart_items/destroy_all'    => 'cart_items#destroy_all'
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end
end
