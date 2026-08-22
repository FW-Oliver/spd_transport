Rails.application.routes.draw do

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

    get "locations/:id",
        to: "locations#show",
        as: :location

    get "activities",
        to: "activities#index",
        as: :activities

    get "/",
        to: "dashboard#index",
        as: :dashboard

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

    get "information",
    to: "information#index",
    as: :information

    get "information/rules",
        to: "information#rules",
        as: :information_rules

    get "information/access",
        to: "information#access",
        as: :information_access

    get "information/routes",
        to: "information#routes",
        as: :information_routes
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