class FeedbacksController < ApplicationController
  before_action :set_reservation
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.reservation = @reservation
    @reservation.done = true

    if @feedback.save && @reservation.save
      redirect_to dashboard_path, notice: 'Votre réservation a bien été clôturée.'
    else
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:comment)
  end

  def set_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end
end
