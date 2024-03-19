class Car < ApplicationRecord
  belongs_to :company
  has_one_attached :photo
  validates :model, :color, :plate_number, presence: true
  validates :company, presence: true
end
