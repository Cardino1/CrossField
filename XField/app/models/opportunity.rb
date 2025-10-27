# frozen_string_literal: true

class Opportunity < ApplicationRecord
  enum status: { pending: 0, published: 1, rejected: 2 }
  enum opportunity_type: { jobs: 0, research: 1, open_source: 2, co_founder: 3 }

  OPPORTUNITY_TYPE_LABELS = {
    "jobs" => "Jobs",
    "research" => "Research",
    "open_source" => "Open Source",
    "co_founder" => "Co-Founder"
  }.freeze

  validates :opportunity_type, :title, :full_name, :organization, :description, presence: true
  validates :opportunity_type, inclusion: { in: opportunity_types.keys }
  validates :link, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true

  scope :published, -> { where(status: statuses[:published]) }

  def opportunity_type_label
    OPPORTUNITY_TYPE_LABELS[opportunity_type] || opportunity_type.humanize
  end

  def self.opportunity_type_options
    opportunity_types.keys.map { |key| [OPPORTUNITY_TYPE_LABELS[key], key] }
  end
end
