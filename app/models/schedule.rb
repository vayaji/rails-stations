class Schedule < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy

  def formatted_start_time
    start_time.strftime("%m/%d (%a) %H:%M 上映")
  end
end