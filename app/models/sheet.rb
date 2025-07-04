class Sheet < ApplicationRecord
  validates :row, presence: true
  validates :column, presence: true
  has_many :reservations, dependent: :destroy

  def formatted_name
    "#{row}-#{column}"
  end
end