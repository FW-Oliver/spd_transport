Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  namespace :admin do
    resources :locations, only: %i[index new create edit update]
  end

get "l/:qr_token",
    to: "locations#show",
    as: :location

post "l/:qr_token/request",
     to: "locations#request_transport",
     as: :request_location_transport

post "l/:qr_token/cancel/:request_id",
     to: "locations#cancel_request",
     as: :cancel_location_transport
     
root "admin/locations#index"
end


