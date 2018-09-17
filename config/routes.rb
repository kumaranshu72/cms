Rails.application.routes.draw do
  resources :bookings
  resources :holidays
  root 'dashboard#index'
  devise_for :users
  resources :conference_rooms
  post '/search' => 'search#search_room'
  get '/searchPage' =>  'search#search_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
