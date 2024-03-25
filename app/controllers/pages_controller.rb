class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @feedback = Feedback.new
  end

  def team
    @company = current_user.company
    @team = User.where(company: @company)
  end
end
