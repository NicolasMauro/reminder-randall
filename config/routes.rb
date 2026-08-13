Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource  :account,  only: %i[edit update]
  resources :meetings, only: :index
  get "m/:token" => "meetings#ack", as: :meeting_ack

  post "hooks/loopmessage" => "hooks#loopmessage"
  post "hooks/twilio"      => "hooks#twilio"

  root "meetings#index"
end
