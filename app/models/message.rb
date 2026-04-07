class Message < ApplicationRecord
  belongs_to :employee
  belongs_to :case, optional: true

  validates :content, presence: true
  validates :sender, presence: true
  validates :channel, presence: true
end

