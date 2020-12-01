Rails.application.routes.draw do

#  root 'posts#index'
#  root 'users#sign_in'
devise_scope :user do
  root :to => 'devise/sessions#new'
end

def after_sign_in_path_for(resource_or_scope)
  # your_path
end

def after_sign_out_path_for(resource_or_scope)
  # your_path
end

  get 'o-stronie' => 'posts#about', as: :about
  get 'dokumentacja' => 'posts#docs', as: :docs
  get 'podrecznik' => 'posts#howto', as: :howto
  get 'warunki-prywatnosci' => 'posts#privacy', as: :privacy

  get 'static/terms'
  get 'static/privacy'
  get 'static/howto'
  get 'static/docs'
  get 'static/about'
  get 'hosts/new'
  get 'hosts/edit'
  get 'hosts/index'
  get 'hosts/show'
  get 'playbooks/new'
  get 'playbooks/edit'
  get 'playbooks/index'
  get 'playbooks/show'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/index'
  get 'posts/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
