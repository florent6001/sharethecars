class ReservationsController < ApplicationController
  before_action :set_car, only: [:create]

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.car = @car
    @reservation.kilometers = 0
    @reservation.save!
    redirect_to dashboard_path, notice: "Votre réservation a bien été prise en compte."
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.done = true
    @reservation.update(reservation_params)
    @reservation.create_feedback(feedback_params)
    redirect_to dashboard_path, notice: "Votre réservation a bien été clôturée."
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

  def feedback_params
    params.require(:feedback).permit(:comment)
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :kilometers)
  end
end
