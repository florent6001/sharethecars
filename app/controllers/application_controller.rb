class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def set_company
    @user_company = current_user.company
  end
end
