class CarsController < ApplicationController
  before_action :set_company

  def index
    @cars = @user_company.cars

    return unless params[:start_date].present? && params[:end_date].present?

    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])

    @cars = @cars.where.not(id: Reservation.where("start_date <= ? AND end_date >= ?", @end_date, @start_date).select(:car_id))
  end

  def show
    @car = Car.find(params[:id])
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @reservation = Reservation.new
  end
end
