Rails.application.routes.draw do

  #root to: 'static#index'

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

  devise_scope :user do
    root :to => 'static#index'
  end

  #get '/user' => "static#index", :as => :user_root

def after_sign_in_path_for(resource_or_scope)
  get 'static#index'
end

def after_sign_out_path_for(resource_or_scope)
  # your_path
end

  devise_for :users
  devise_for :admins

end
