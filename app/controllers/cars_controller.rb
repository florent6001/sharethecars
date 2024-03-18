class CarsController < ApplicationController
  has_one_attached :photo
  belongs_to :company
end
