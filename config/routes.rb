# Rails.application.routes.draw do
#   # Devise routes for authentication
#   devise_for :authors
#   devise_for :authors, path: 'authors', path_names: { sign_out: 'logout' }, as: 'author_devise'

#   # Define custom routes for authors
#   resources :authors, only: [:index, :show, :new, :create, :edit, :update, :destroy]
#   resources :authors do
#     resources :books
#   end


#   # Define custom routes for books
#   resources :books, only: [:index, :show, :new, :create, :edit, :update]

#   # Filterrific routes for authors and books


#   # Set the root path to the authors' index page
#   root to: 'authors#index'
# end


Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :authors
  # Define custom routes for authors
  resources :authors, only: [:index, :show, :new, :create, :edit, :update]

  # Define custom routes for books, including the nested routes under authors
  resources :books
  # Define nested routes for books under authors
  # resources :authors do
  #   resources :books
  # end

 # Filterrific routes for authors and books (you can define Filterrific routes here)

  # Set the root path to the authors' index page
  root to: 'authors#index'

  # config/routes.rb

resources :books do
  collection do
    get 'd/download_csv', to: 'books#download_csv'
  end
end

  # devise_scope :author do
  #   root to: 'devise/sessions#new'
  # end
  end
