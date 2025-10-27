# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        ActiveSupport::SecurityUtils.secure_compare(username, ENV.fetch("XFIELD_ADMIN_USERNAME", "Admin")) &&
          ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("XFIELD_ADMIN_PASSWORD", "Team111***"))
      end
    end
  end
end
