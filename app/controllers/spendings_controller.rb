# frozen_string_literal: true

class SpendingsController < ApplicationController
  include TurboStreamErrorsConcern

  before_action :authenticate_user!, except: :page
  before_action :find_spending, only: %i[edit update destroy]

  def create
    @spending = current_user.spendings.build(spending_params)
    respond_to do |format|
      if @spending.save
        @spendings_sum = current_user.spendings.sum(:amount_cents)
        format.turbo_stream
        format.html do
          redirect_to spendings_path, status: :see_other,
                                      notice: 'Spending was successfully created.'
        end
      else
        format.turbo_stream do
          render turbo_stream:
            stream_errors(@spending.errors.full_messages.join(';'))
        end
        format.html do
          redirect_to spendings_path, status: :unprocessable_entity,
                                      alert: @spending.errors.full_messages.join(';')
        end
      end
    end
  end

  def index
    @filter = params[:filter]

    case @filter
    when 'amount'
      @spendings = current_user.spendings.order(amount_cents: :desc)
    when 'category'
      @spendings = current_user.spendings.with_category(params[:category])
    else
      @spendings = current_user.spendings
    end

    @spendings_sum = @spendings.sum(:amount_cents)
  end

  def new
    @spending = current_user.spendings.build
  end

  def edit; end

  def update
    respond_to do |format|
      if @spending.update(spending_params)
        @spendings_sum = current_user.spendings.sum(:amount_cents)
        format.turbo_stream
        format.html do
          redirect_to spendings_path, status: :see_other,
                                      notice: 'Spending was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @spending.destroy
    @spendings_sum = current_user.spendings.sum(:amount_cents)
    respond_to do |format|
      format.html { redirect_to spendings_path, notice: 'Spending was successfully destroyed' }
      format.turbo_stream
    end
  end

  def page
    @user = User.where(uuid: params[:uuid]).last
    @spendings = Spending.where(user: @user)
    @spendings_sum = @spendings.sum(:amount_cents)
  end

  private

  def spending_params
    params.require(:spending).permit(:name, :amount, :description, :category, :amount_cents, :amount_currency)
  end

  def find_spending
    @spending = current_user.spendings.find(params[:id])
  end
end
