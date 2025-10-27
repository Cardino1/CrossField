# frozen_string_literal: true

class Investor < ApplicationRecord
  before_validation :normalize_contact_email

  validates :firm_name, :values, :thesis, :request_for_startups, presence: true
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :website, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true

  private

  def normalize_contact_email
    self.contact_email = contact_email.to_s.strip.downcase
  end
end
