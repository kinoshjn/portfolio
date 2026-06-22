Rails.application.routes.draw do
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

# root "static_pages#aircraft_list_index"
  root "aircrafts#index"

  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :aircrafts, only: %i[index] 
  resources :flight_logs, only: %i[index] 
  resources :flight_records, only: %i[index] 
  resources :safety_incidents, only: %i[index] 
  resources :daily_inspections, only: %i[index] 
  resources :daily_inspection_items, only: %i[index] 
  resources :inspection_maintenances, only: %i[index] 
  resources :inspection_maintenance_items, only: %i[index] 

  get "aircraft_list_index", to: "static_pages#aircraft_list_index"
  get "flight_log_index", to: "static_pages#flight_log_index"
  get "daily_inspection_index", to: "static_pages#daily_inspection_index"
  get "inspection_and_maintenance_index", to: "static_pages#inspection_and_maintenance_index"

  get "aircraft_show", to: "static_pages#aircraft_show"
  get "aircraft_new", to: "static_pages#aircraft_new"
  get "aircraft_edit", to: "static_pages#aircraft_edit"

  get "flight_log_show", to: "static_pages#flight_log_show"
  get "flight_log_new", to: "static_pages#flight_log_new"
  get "flight_log_edit",  to: "static_pages#flight_log_edit"

  get "daily_inspection_show", to: "static_pages#daily_inspection_show"
  get "daily_inspection_new", to: "static_pages#daily_inspection_new"
  get "daily_inspection_edit", to: "static_pages#daily_inspection_edit"

  get "inspection_and_maintenance_show", to: "static_pages#inspection_and_maintenance_show"
  get "inspection_and_maintenance_new", to: "static_pages#inspection_and_maintenance_new"
  get "inspection_and_maintenance_edit", to: "static_pages#inspection_and_maintenance_edit"

  get "delete_confirm_index", to: "static_pages#delete_confirm_index"
end
