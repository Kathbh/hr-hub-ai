module EmployeePortal
  class CasesController < ApplicationController
    before_action :authenticate_user!

    def index
      @cases = current_user.cases.order(created_at: :desc)
    end
    def show
      @case = current_user.cases.find(params[:id])
      @messages = @case.messages.order(created_at: :asc)
    end
  end
end
