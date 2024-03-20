class Car < ApplicationRecord
  belongs_to :company
  has_many :reservations
  has_many :feedbacks, through: :reservations
  has_one_attached :photo
  validates :model, :color, :plate_number, presence: true
  validates :company, presence: true
end
