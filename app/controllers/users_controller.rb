class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @feedbacks = @user.feedbacks.order(created_at: :desc).limit(5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
