Rails.application.routes.draw do
  sitepress_pages
  resources :projects

  namespace :photos do
    resources :exports, only: [:index] do
      get :download, on: :collection
    end
  end

  resources :photos do
    get :gallery, on: :collection
  end

  # Mission Control
  mount MissionControl::Jobs::Engine, at: "/jobs"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest

  # Defines the root path route ("/")
  root "application#welcome"
end
