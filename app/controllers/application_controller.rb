class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.role == "hr"
      hr_dashboard_path
    else
      employee_path
    end
  end
end
