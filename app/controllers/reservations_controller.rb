class ReservationsController < ApplicationController
  def create
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to dashboard_path
  end
end
