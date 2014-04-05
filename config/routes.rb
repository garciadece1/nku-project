NkuProject::Application.routes.draw do
  root "upload#index"
  post "upload/import" => "upload#import"
  get "upload/import" => "upload#index"
  resources :file, only: [:show] do
   
    get "download"
   
  end
end
