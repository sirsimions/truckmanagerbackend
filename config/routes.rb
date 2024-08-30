Rails.application.routes.draw do
   resources :trucks, only: [:index]
   resources :authors, only: [:create, :show, :index]
   
   resources :loadings do
    collection do
      get :filter_options
    end
  end

  get 'filter-options', to: 'trucks#filter_options'
  get 'filters', to: 'loadings#filter_options'
  post 'charts', to: 'trucks#charts'
  post 'chart-data', to: 'trucks#charts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'upload', to: 'uploads#create'
  get 'charts', to: 'trucks#charts'  # This is the new route for fetching chart data
  get 'truck', to: 'trucks#show'
  get 'trucks', to: 'trucks#index'
  get 'loadings', to: 'loadings#index'
  get 'truck_turnaround', to: 'loadings#truck_turnaround'
  get 'total_days_in_msa', to: 'loadings#total_days_in_msa'
  
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
