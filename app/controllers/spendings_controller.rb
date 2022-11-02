class SpendingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @spendings = current_user.spendings
  end
end
