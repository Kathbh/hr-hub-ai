class Case < ApplicationRecord
  belongs_to :employee
  has_many :messages

  enum status: { open: 0, on_hold: 1, resolved: 2, cancelled: 3 }
  enum priority: { low: 0, standard: 1, high: 2 }
end

