Rails.application.routes.draw do
  resources :holidays
  root 'dashboard#index'
  devise_for :users
  resources :conference_rooms
  post '/search' => 'conference_rooms#search'
  get '/searchPage' =>  'conference_rooms#search_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
