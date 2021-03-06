Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'app'
  devise_scope :user do
  resource :registration,
    only: [:new, :create, :edit, :update],
    path: 'users',
    path_names: { new: 'sign_up' },
    controller: 'devise/registrations',
    as: :user_registration do
      get :cancel
    end
  end

  resources :users do
    member do
      get :confirm_destroy
    end
  end

  root to: 'static#index'
  get 'o-stronie' => 'static#about', as: :about
  get 'dokumentacja' => 'static#docs', as: :docs
  get 'podrecznik' => 'static#howto', as: :howto
  get 'index' => 'static#index', as: :index

  resources :hosts do
    member do
      get :confirm_destroy
      get :test
      get :ssh
      get :show_ssh
    end
  end

  resources :posts do
    member do
      get :confirm_destroy
    end
    collection do
      get :published
    end
  end

  resources :playbooks do
     member do
       get :confirm_destroy
     end
  end

  resources :runs, only: [:index, :new, :create, :show]

end
