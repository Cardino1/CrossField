# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def create
    @subscription = User.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: "Thanks for subscribing to updates!"
    else
      @latest_opportunities = Opportunity.published.order(created_at: :desc).limit(4)
      @latest_articles = Article.order(published_at: :desc).limit(3)
      @investors = Investor.order(created_at: :desc).limit(6)
      render "home/index", status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:user).permit(:email)
  end
end
