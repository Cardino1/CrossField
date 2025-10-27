# frozen_string_literal: true

module Admin
  class OpportunitiesController < BaseController
    before_action :set_opportunity, only: [:show, :edit, :update, :destroy, :approve, :reject]

    def index
      @opportunities = Opportunity.order(created_at: :desc)
    end

    def show; end

    def new
      @opportunity = Opportunity.new(status: :published)
    end

    def edit; end

    def create
      @opportunity = Opportunity.new(opportunity_params.merge(status: :published))
      if @opportunity.save
        redirect_to admin_opportunity_path(@opportunity), notice: "Opportunity created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @opportunity.update(opportunity_params)
        redirect_to admin_opportunity_path(@opportunity), notice: "Opportunity updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @opportunity.destroy
      redirect_to admin_opportunities_path, notice: "Opportunity removed."
    end

    def approve
      @opportunity.update(status: :published)
      redirect_to admin_opportunities_path, notice: "Opportunity approved."
    end

    def reject
      @opportunity.update(status: :rejected)
      redirect_to admin_opportunities_path, alert: "Opportunity rejected."
    end

    private

    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    def opportunity_params
      params.require(:opportunity).permit(
        :opportunity_type,
        :title,
        :full_name,
        :organization,
        :description,
        :link,
        :status
      )
    end
  end
end
