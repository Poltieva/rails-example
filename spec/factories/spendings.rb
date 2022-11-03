# frozen_string_literal: true
FactoryBot.define do
  factory :spending do
    name { Faker::ChuckNorris.fact }
    amount { rand(0.01...1000) }
    category { %w[shopping other food].sample }
    association :user
  end
end
