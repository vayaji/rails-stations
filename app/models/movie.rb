class Movie < ApplicationRecord
  has_many :schedules, dependent: :destroy
  validates :name, uniqueness: true
end
