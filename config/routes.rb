Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get "users/:user", to: 'users#show'

  post 'users', to: 'users#create'

  post 'likedbeer', to: 'liked_beers#create'
  post 'initlikedbeers', to: 'liked_beers#initial_create'

  post "reccomended_beers", to: 'liked_beers#create_recc_beers'

end
