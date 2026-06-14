Rails.application.routes.draw do
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "static_pages#aircraft_list_index"

  get "aircraft_list", to: "static_pages#aircraft_list_index"
  get "flight_log", to: "static_pages#flight_log_index"
  get "daily_inspection", to: "static_pages#daily_inspection_index"
  get "inspection_and_maintenance", to: "static_pages#inspection_and_maintenance_index"

end
