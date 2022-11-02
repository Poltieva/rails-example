class Spending < ApplicationRecord
  monetize :amount_cents, allow_nil: true,
           numericality: {
             greater_than_or_equal_to: 0,
             less_than_or_equal_to: 10000
           }

  has_one :user
end
