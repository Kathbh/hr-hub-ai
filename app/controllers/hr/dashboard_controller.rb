class Hr::DashboardController < ApplicationController
  before_action :require_hr_role

  def show
    @cases = Case.all
    @policies = Policy.all
    @ai_response = params[:ai]
    # @case = Case.find(params[:id])
    # @employee = @case.employee
    # @messages = @case.messages.order(created_at: :asc)

    respond_to do |format|
    # format.turbo_stream { render :show, layout: false }
      format.html
    end
  end
end
