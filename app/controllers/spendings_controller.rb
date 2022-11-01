class SpendingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @spendings = Spending.all
  end
end
