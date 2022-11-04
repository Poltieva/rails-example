# frozen_string_literal: true

module SpendingsHelper
  def display_amount(amount)
    "Total: #{amount / 100.0}"
  end
end
