class Employee < ApplicationRecord
  has_one :user #updated after AddEmployeeToUser
  has_many :cases
  has_many :messages

  enum employment_status: { active: 0, terminated: 1 }

  def full_name
    terminated? ? "#{first_name} #{last_name} (terminated)" : "#{first_name} #{last_name}"
  end

  def hr_agent? #Updated after AddRoleToEmployee
    role == "hr_agent"
  end
end
