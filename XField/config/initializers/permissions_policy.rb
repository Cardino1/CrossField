# frozen_string_literal: true

Rails.application.configure do
  config.permissions_policy do |policy|
    policy.camera :none
    policy.geolocation :none
    policy.microphone :none
  end
end
