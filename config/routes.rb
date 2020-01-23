Rails.application.routes.draw do
  resources :disliked_beers
    resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "dislikedbeer", to: 'disliked_beers#create'
  post "reviews", to: 'reviews#create'
  get "users/:user", to: 'users#show'
  get "/:id/beers", to: 'users#beers'

  post 'users', to: 'users#create'

  post 'likedbeer', to: 'liked_beers#create'
  post 'initlikedbeers', to: 'liked_beers#initial_create'

  post "reccomended_beers", to: 'liked_beers#create_recc_beers'

end
