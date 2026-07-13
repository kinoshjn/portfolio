Rails.application.routes.draw do
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

  resources :aircrafts, only: %i[index show new create]
  resources :flight_logs, only: %i[index show new create]

  resources :daily_inspections, only: %i[index show new create]
  resources :inspection_maintenances, only: %i[index show new create]

  get "aircraft_list_index", to: "static_pages#aircraft_list_index"
  get "flight_log_index", to: "static_pages#flight_log_index"
  get "daily_inspection_index", to: "static_pages#daily_inspection_index"
  get "inspection_maintenance_index", to: "static_pages#inspection_maintenance_index"

  get "aircraft_show", to: "static_pages#aircraft_show"
  get "aircraft_new", to: "static_pages#aircraft_new"
  get "aircraft_edit", to: "static_pages#aircraft_edit"
  patch "aircraft_update", to: "static_pages#aircraft_update"
  delete "aircraft_destroy", to: "static_pages#aircraft_destroy"

  get "flight_log_show", to: "static_pages#flight_log_show"
  get "flight_log_new", to: "static_pages#flight_log_new"
  get "flight_log_edit/:id", to: "static_pages#flight_log_edit", as: "flight_log_edit"
  patch "flight_log_update/:id", to: "static_pages#flight_log_update", as: "flight_log_update"
  delete "flight_log_destroy", to: "static_pages#flight_log_destroy"

  get "daily_inspection_show", to: "static_pages#daily_inspection_show"
  get "daily_inspection_new", to: "static_pages#daily_inspection_new"
  get "daily_inspection_edit/:id", to: "static_pages#daily_inspection_edit", as: "daily_inspection_edit"
  patch "daily_inspection_update/:id", to: "static_pages#daily_inspection_update", as: "daily_inspection_update"
  delete "daily_inspection_destroy", to: "static_pages#daily_inspection_destroy"

  get "inspection_maintenance_show", to: "static_pages#inspection_maintenance_show"
  get "inspection_maintenance_new", to: "static_pages#inspection_maintenance_new"
  get "inspection_maintenance_edit/:id", to: "static_pages#inspection_maintenance_edit", as: "inspection_maintenance_edit"
  patch "inspection_maintenance_update/:id", to: "static_pages#inspection_maintenance_update", as: "inspection_maintenance_update"
  delete "inspection_maintenance_destroy", to: "static_pages#inspection_maintenance_destroy"

  get "delete_confirm_index", to: "static_pages#delete_confirm_index"

  # 2026.7/8  使い方説明
  get "how_to_use", to: "static_pages#how_to_use"
  get "how_to_use_images_add", to: "static_pages#how_to_use_images_add"

  # 2026.7/11 プライベートポリシー
  get "privacy_policy", to: "static_pages#privacy_policy"

  # 2026.7/11 利用規約(Terms of Use)
  get "terms_of_use", to: "static_pages#terms_of_use"

  # 2026.7/11 問い合わせ(Inquiries)
  get "inquiries", to: "static_pages#inquiries"
end
