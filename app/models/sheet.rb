class Sheet < ApplicationRecord
  validates :row, presence: true
  validates :column, presence: true
end