class Company < ApplicationRecord
  geocoded_by :address
  has_many :chatrooms
  has_many :cars
  has_many :users, dependent: :destroy
  has_one_attached :logo
  after_validation :geocode, if: :will_save_change_to_address?
end
