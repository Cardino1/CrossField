# frozen_string_literal: true

class NewsController < ApplicationController
  def index
    @articles = Article.order(published_at: :desc)
  end
end
