class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  validates :location, presence: true
  validates :date, presence: true
end
