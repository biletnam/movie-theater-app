Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "theaters#index"
  
  resources :theaters do
    resources :auditoria
    resources :movies
  end

  resources :movies do
    resources :movie_screenings
  end

  resources :movie_screenings do
    resources :ticket_orders
  end
end
