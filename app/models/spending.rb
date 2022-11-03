# frozen_string_literal: true

class Spending < ApplicationRecord
  monetize :amount_cents, allow_nil: true,
                          numericality: {
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10_000
                          }

  belongs_to :user
  validates_presence_of :name
end
