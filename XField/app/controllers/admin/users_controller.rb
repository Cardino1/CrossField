# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    def index
      @users = User.order(created_at: :desc)
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_users_path, notice: "Subscriber removed."
    end
  end
end
