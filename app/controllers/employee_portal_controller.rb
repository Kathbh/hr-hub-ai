class EmployeePortalController < ApplicationController
  before_action :authenticate_user!

  def show
    @employee = current_user.employee
    @cases = @employee.cases.order(created_at: :desc)
    @messages = @employee.messages.order(created_at: :desc)
    @policies = Policy.all # later we filter by region/country
  end
end
