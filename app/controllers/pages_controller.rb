class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @car_availables_tomorrow =
      current_user.company.cars
                  .where.not(id: Reservation.where("start_date <= ? AND end_date >= ?", Date.tomorrow, Date.tomorrow)
                  .select(:car_id))
                  .count
    @average_kilometers = current_user.reservations.average(:kilometers).to_i
    @feedback = Feedback.new
  end

  def team
    @company = current_user.company
    @team = User.where(company: @company)
  end
end
