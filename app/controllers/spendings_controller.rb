class SpendingsController < ApplicationController
  def index
    @spendings = Spending.all
  end
end
