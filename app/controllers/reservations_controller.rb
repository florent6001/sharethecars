class ReservationsController < ApplicationController
  belongs_to :cars
  belongs_to :users
end
