# frozen_string_literal: true

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module XField
  class Application < Rails::Application
    config.load_defaults 7.1

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc

    config.generators.system_tests = nil
  end
end
