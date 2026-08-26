Rails.application.routes.draw do
  # Admin
  namespace :admin do
    get "/",
        to: "dashboard#index",
        as: :dashboard

    resources :locations, only: %i[index new create edit update] do
      get :qr_poster, on: :member
    end

    resources :transporter_actions

    resources :information_pages do
      member do
        post :toggle_publish
      end
    end
  end

  # Public landing page
  root "home#index"

  # Role selection
  get "role/:role",
      to: "home#role",
      as: :role

  # Viewer dashboard
  get "dashboard",
      to: "dashboard#index",
      as: :dashboard

  # Sessions / authentication
  resource :session
  resources :passwords, param: :token

# Transporter
namespace :transporter do
  get "turbo_test",
      to: "turbo_test#show",
      as: :turbo_test

  post "turbo_test",
      to: "turbo_test#send_test",
      as: :turbo_test_send

  get "locations/:id",
      to: "locations#show",
      as: :location

  resources :activities, only: [ :index, :show ]

  get "/",
      to: "dashboard#index",
      as: :dashboard

  get "information",
      to: "information#index",
      as: :information

  get "information/:slug",
      to: "information#show",
      as: :information_page

  post "locations/:location_id/activities",
       to: "activities#create",
       as: :location_activities

  post "requests/:id/accept",
       to: "requests#accept",
       as: :accept_request

  post "requests/:id/start_transport",
       to: "requests#start_transport",
       as: :start_transport

  post "requests/:id/complete",
       to: "requests#complete",
       as: :complete_request
end

 # Admin
 namespace :admin do
  resources :locations, only: %i[index new create edit update] do
    get :qr_poster, on: :member
  end

  resources :transporter_actions

  resources :information_pages do
    member do
      post :toggle_publish
    end
  end
end

  # Public clinic QR-code routes
  get "l/:qr_token",
      to: "locations#show",
      as: :location

  post "l/:qr_token/request",
       to: "locations#request_transport",
       as: :request_location_transport

  post "l/:qr_token/cancel/:request_id",
       to: "locations#cancel_request",
       as: :cancel_location_transport
end
