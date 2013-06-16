Crowdarmor::Application.routes.draw do
  resources :alerts


  get "tweet/processed"

  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match "/processed" => "tweet#processed"
  match "/dashboard" => "tweet#index", :as => :dashboard
end
