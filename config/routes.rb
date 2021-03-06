Rails.application.routes.draw do

  resources :submissions, only:[:new, :create]
  get 'news'=> 'news#index'
  get 'sources'=> 'news#sources'
  get 'refresh'=> 'news#refresh'


  get 'home'=>'home#index'
  get 'api' => "api#index"


  get 'api/stats'=> 'api#stats'
  get 'api/top_ten'=> 'api#top_ten'


  get 'how'=>'news#how'
  get 'contact'=>'home#contact'


  get 'follow' => 'news#follow'
  get 'unfollow' => 'news#unfollow'

  get 'topics' => 'categories#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'news#index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
