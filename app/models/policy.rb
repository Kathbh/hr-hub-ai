class Policy < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :category, presence: true
  validates :country, presence: true
  validates :visibility, inclusion: { in: ["public", "internal"] }

  def tag_list
    tags&.split(",")&.map(&:strip) || []
  end
end

