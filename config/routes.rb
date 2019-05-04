Rails.application.routes.draw do

  resources :puzzles

  root to: 'puzzles#index'

end
