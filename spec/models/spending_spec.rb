# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spending, type: :model do
  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:spending)).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should not be valid without a name' do
      expect(build(:spending, name: nil)).to_not be_valid
    end
    it 'should not be valid with negative amount' do
      expect(build(:spending, amount: -1)).to_not be_valid
    end
    it 'should not be valid with zero amount' do
      expect(build(:spending, amount: 0)).to_not be_valid
    end
    it 'should not be valid with amount greater than 10 000' do
      expect(build(:spending, amount: 100_000)).to_not be_valid
    end
    it 'should not be valid without user_id' do
      expect(build(:spending, user_id: nil)).to_not be_valid
    end
  end
end
