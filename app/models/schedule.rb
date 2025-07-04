class Schedule < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy

  # def formatted_start_time
  #   start_time.strftime("%m/%d (%a) %H:%M 上映")
  # end

  def time_range
    "#{start_time.strftime('%H:%M')} ~ #{end_time.strftime('%H:%M')}"
  end
end