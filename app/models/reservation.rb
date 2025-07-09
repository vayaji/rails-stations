class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{1,})\z/i, message: "有効なメールアドレスを入力してください" }
  validates :sheet_id, uniqueness: { scope: [:schedule_id, :date, :screen_id] }
end
