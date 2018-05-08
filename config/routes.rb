Rails.application.routes.draw do

  get 'news'=> 'news#index'
  get 'refresh'=> 'news#refresh'

  get 'home'=>'home#index'

  get 'api' => "api#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'news#index'


end
