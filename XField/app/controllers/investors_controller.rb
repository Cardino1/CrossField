# frozen_string_literal: true

class InvestorsController < ApplicationController
  def index
    @investor = Investor.new
    @investors = Investor.order(created_at: :desc)
  end

  def create
    @investor = Investor.new(investor_params)
    if @investor.save
      redirect_to investors_path, notice: "Thank you! Our team will review your submission."
    else
      @investors = Investor.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def investor_params
    params.require(:investor).permit(
      :firm_name,
      :values,
      :thesis,
      :portfolio_highlights,
      :request_for_startups,
      :website,
      :contact_email
    )
  end
end
