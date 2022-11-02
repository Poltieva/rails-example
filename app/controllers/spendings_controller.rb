class SpendingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_spending, only: %i[edit update]

  def index
    @spendings = current_user.spendings
  end

  def new
    @spending = current_user.spendings.build
  end

  def edit; end

  def update
    respond_to do |format|
      if @spending.update(spending_params)
        format.turbo_stream
        format.html { redirect_to spendings_path, status: :see_other, notice: "Spending was successfully updated." }
      else
        format.html {render :edit}
      end
    end
  end

  private
  def spending_params
    params.require(:spending).permit(:name, :amount, :category)
  end

  def find_spending
    @spending = current_user.spendings.find(params[:id])
  end
end
