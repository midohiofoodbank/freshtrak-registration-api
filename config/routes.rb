# frozen_string_literal: true

Jets.application.routes.draw do
  resources :guest_authentications, only: :create

  namespace :api do
    resources :reservations, only: %i[index show create delete] do
      collection do
        get :events_count
      end
    end  
    resource :user, only: %i[show update]
    resources :households, only: %i[show create update delete]
  end

  post 'auth_callbacks/facebook'
  post 'twilio/sms'
  post 'twilio/email'

  root 'jets/public#show'

  # The jets/public#show controller can serve static utf8
  # content out of the public folder.
  # Note, as part of the deploy process Jets uploads
  # files in the public folder to s3
  # and serves them out of s3 directly.
  # S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any '*catchall', to: 'jets/public#show'
end
