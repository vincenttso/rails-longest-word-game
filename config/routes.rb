# frozen_literal_string: true

Rails.application.routes.draw do
  get 'games/new', to: 'games#new', as: 'new'
  post 'games/score', to: 'games#score', as: 'score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
