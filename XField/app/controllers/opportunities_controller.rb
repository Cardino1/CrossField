# frozen_string_literal: true

class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.published.order(created_at: :desc)
  end

  def new
    @opportunity = Opportunity.new
  end

  def create
    @opportunity = Opportunity.new(opportunity_params)
    if @opportunity.save
      redirect_to opportunities_path, notice: "Your opportunity has been submitted and is pending approval."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def opportunity_params
    params.require(:opportunity).permit(:opportunity_type, :title, :full_name, :organization, :description, :link)
  end
end
