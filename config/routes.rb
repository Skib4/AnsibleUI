Rails.application.routes.draw do

  #  get 'runs/new'
  #  get 'runs/create'
  # get 'runs/update'
  #  get 'runs/edit'
  #  get 'runs/destroy'
  #  get 'runs/show'
  # get 'runs/index'
  devise_for :admins
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

def after_sign_in_path_for(resource_or_scope)
  # your_path
end

def after_sign_out_path_for(resource_or_scope)
  # your_path
end

resources :posts do
member do
    get :confirm_destroy
end
collection do
  get :published
end
end

resources :hosts do
member do
    get :confirm_destroy
    get :test
end
end

resources :playbooks do
member do
    get :confirm_destroy
end
collection do
  get :published
end
end

  resources :runs do
    member do
      get :confirm_destroy
    end
    collection do
      get :published
    end
  end

#get '/posts' => 'posts#index'
#get '/posts/new' => 'posts#new'


#  get 'static/terms'
#  get 'static/privacy'
#  get 'static/howto'
#  get 'static/docs'
#  get 'static/about'
#  get 'static/index'

  get 'o-stronie' => 'static#about', as: :about
  get 'dokumentacja' => 'static#docs', as: :docs
  get 'podrecznik' => 'static#howto', as: :howto
  get 'warunki-prywatnosci' => 'static#privacy', as: :privacy
  get 'index' => 'static#index', as: :index
  get 'warunki' => 'static#terms', as: :terms


#  get 'hosts/new'
#  get 'hosts/edit'
#  get 'hosts/index'
#  get 'hosts/show'

#  get 'new-host' => 'hosts#new', as: :newhost
#  get 'edit-host' => 'hosts#edit', as: :edithost
#  get 'host' => 'hosts#index', as: :host
#  get 'show-host' => 'hosts#show', as: :showhost

#  get 'playbooks/new'
#  get 'playbooks/edit'
#  get 'playbooks/index'
#  get 'playbooks/show'

#  get 'new-playbook' => 'playbooks#new', as: :newplaybook
#  get 'edit-playbook' => 'playbooks#edit', as: :editplaybook
#  get 'playbook' => 'playbooks#index', as: :playbook
#  get 'show-playbook' => 'playbooks#show', as: :showplaybook

#  get 'posts/new'
#  get 'posts/edit'
#  get 'posts/index'
#  get 'posts/show'

#  get 'new-post' => 'posts#new', as: :newpost
#  get 'edit-post' => 'posts#edit', as: :editpost
#  get 'show-post' => 'posts#show', as: :showpost
#  get 'post' => 'posts#index', as: :post

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
