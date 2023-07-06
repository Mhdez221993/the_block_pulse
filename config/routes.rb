Rails.application.routes.draw do
  root 'articles#index'

  resources :posts
  resources :articles do
    resources :comments
  end
end
