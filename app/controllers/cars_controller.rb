class CarsController < ApplicationController
  before_action :set_company, only: [:index]

  def index
    @cars = @company.cars.includes(:company)
  end

  def show
    @car = Car.find(params[:id])
  end

  private

  def set_company
    @company = Company.find(1)
  end
end
