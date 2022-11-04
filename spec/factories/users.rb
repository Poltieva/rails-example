# frozen_string_literal: true
require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
    username { Faker::Internet.username }
  end
end
