class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :user
  has_many :feedbacks
end
