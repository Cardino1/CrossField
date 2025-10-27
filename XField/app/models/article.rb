# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, :author, :summary, :content, :published_at, presence: true

  scope :recent, -> { order(published_at: :desc) }
end
