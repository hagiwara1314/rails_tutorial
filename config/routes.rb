Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'users/sessions'
  }
  root to: "blogs#index"
  get 'blogs/search', to: "blogs#search", as: 'blog_search'
  resources :blogs
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
