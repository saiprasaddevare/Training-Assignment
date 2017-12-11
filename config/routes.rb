Rails.application.routes.draw do
  apipie
  resources :records, only: [:index, :create, :destroy, :update, :last] 
  get '/last', to: 'records#last' 
  root 'students#index' 
end
