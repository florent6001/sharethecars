class CarsController < ApplicationController
  before_action :set_company

  def index
    @cars = @user_company.cars
  end

  def show
    @car = Car.find(params[:id])
  end
end
