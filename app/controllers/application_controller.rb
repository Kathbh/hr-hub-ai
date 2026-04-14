class ApplicationController < ActionController::Base
  before_action :set_cache_headers

  def set_cache_headers
    response.headers["Cache-Control"] = "no-store"
  end

  def after_sign_in_path_for(resource)
    hr_roles = ["hr_agent", "payroll", "gta", "benefits", "hr_bt"]

    if hr_roles.include?(resource.role)
      hr_dashboard_path
    else
      employee_path
    end
  end

  def require_hr_role
    allowed_roles = ["hr_agent", "payroll", "gta", "benefits", "hr_bt"]

    unless current_user && allowed_roles.include?(current_user.role)
      redirect_to root_path, alert: "Access denied."
    end
  end
end
