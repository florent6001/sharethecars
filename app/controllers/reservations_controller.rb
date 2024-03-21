class ReservationsController < ApplicationController
  before_action :set_car, only: [:create]

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.car = @car
    @reservation.save!
    redirect_to dashboard_path, notice: "Votre réservation a bien été prise en compte."
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to dashboard_path
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
