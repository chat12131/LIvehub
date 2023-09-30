class Venue < ApplicationRecord
  has_many :live_schedule, dependent: :nullify
  belongs_to :user
  validates :name, presence: true
end
