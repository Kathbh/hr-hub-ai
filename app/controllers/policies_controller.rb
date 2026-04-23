class PoliciesController < ApplicationController
  before_action :authenticate_user!

  def show
    @policy = Policy.find(params[:id])
    render "employee_portal/policies/show", layout: false
  end
end
