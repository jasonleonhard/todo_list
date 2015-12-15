Rails.application.routes.draw do
  get 'todo_items/index'

  resources :todo_lists
  root 'todo_lists#index'
end