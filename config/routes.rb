NkuProject::Application.routes.draw do

  root "upload#index"


  get "files/show"
  get "files/download"
  post "upload/import" => "upload#import"
  get "upload/import" => "upload#index"
  get "verify-email/:key" => "verifications#show", as: 'show_verifications'
  get "sign-in" => "sessions#new", as: 'sign_in'
  get "sign-up" => "users#new", as: 'sign_up'
  get "sign-out" => "sessions#destroy", as: 'sign_out'

  get "f/:key" => "files#show", as: 'file'
  get "f/:key/download" => "files#download", as: 'file_download'

  
  resources :users
  resource :sessions, only: [:create, :destroy]

  resources :files, only: [:show, :index, :destroy] do 
    get "download"
  end
end
