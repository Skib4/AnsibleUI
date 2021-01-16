Rails.application.routes.draw do

  get 'user/index' => 'user#index'
  get 'user/show' => 'user#show'
  get 'user/new' => 'user#new'
  get 'user/create' => 'user#create'

  get 'locale', to: 'locales#save_locale', as: :set_locale

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

  devise_for :admins

  root to: 'static#index'

  get 'o-stronie' => 'static#about', as: :about
  get 'dokumentacja' => 'static#docs', as: :docs
  get 'podrecznik' => 'static#howto', as: :howto
  get 'warunki-prywatnosci' => 'static#privacy', as: :privacy
  get 'index' => 'static#index', as: :index
  get 'warunki' => 'static#terms', as: :terms

  resources :hosts do
    member do
      get :confirm_destroy
      get :test
      get :ssh
      get :confirm_ssh
      get :copy_id
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

  resources :runs do
    member do
      get :confirm_destroy
    end
  end

end
