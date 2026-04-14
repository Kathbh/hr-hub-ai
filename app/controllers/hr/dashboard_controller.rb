class Hr::DashboardController < ApplicationController
  before_action :require_hr_role

  def show
    @cases = Case.all
    @policies = Policy.all
  end
end
