class Company < ApplicationRecord
  geocoded_by :address
  has_one_attached :logo
  after_validation :geocode, if: :will_save_change_to_address?
end
