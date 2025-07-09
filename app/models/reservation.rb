class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
  belongs_to :screen
  belongs_to :user
  validates :sheet_id, uniqueness: { scope: [:schedule_id, :date, :screen_id] }
end
