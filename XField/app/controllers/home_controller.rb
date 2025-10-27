# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_opportunities = Opportunity.published.order(created_at: :desc).limit(4)
    @latest_articles = Article.order(published_at: :desc).limit(3)
    @investors = Investor.order(created_at: :desc).limit(6)
    @subscription = User.new
  end
end
