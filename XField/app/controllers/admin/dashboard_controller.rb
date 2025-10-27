# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def index
      @opportunities_pending = Opportunity.pending.order(created_at: :desc)
      @recent_articles = Article.order(published_at: :desc).limit(5)
      @recent_subscribers = User.order(created_at: :desc).limit(10)
    end
  end
end
