# frozen_string_literal: true

require "test_helper"

class OpportunityTest < ActiveSupport::TestCase
  test "requires essential fields" do
    opportunity = Opportunity.new
    assert_not opportunity.valid?
    assert_includes opportunity.errors[:title], "can't be blank"
  end
end
