# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :spending do
    name { Faker::ChuckNorris.fact }
    description { Faker::Lorem.paragraph }
    amount { rand(0.01...1000) }
    category { Spending.categories.sample }
    association :user
  end
end
