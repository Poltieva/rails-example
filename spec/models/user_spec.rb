# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:user)).to be_valid
    end
  end

  context 'with invalid attributes' do
    context 'with invalid email' do
      it 'should be invalid' do
        expect(build(:user, email: nil)).to_not be_valid
      end
    end

    context 'with invalid password' do
      it 'should be invalid' do
        expect(build(:user, password: nil)).to_not be_valid
      end
    end

    context 'with invalid password' do
      it 'should be invalid' do
        expect(build(:user, username: nil)).to_not be_valid
      end
    end
  end

  describe '#filtered_spendings' do
    let(:user) { create(:user) }
    before(:each) do
      2.times { create(:spending, category: :other, user: user) }
      2.times { create(:spending, category: :cafes, user: user) }
    end
    context 'without any filter' do
      it 'should return all spendings' do
        expect(user.filtered_spendings({})).to eq(user.spendings)
      end
    end
    context 'with an "amount" filter' do
      it 'should return all spendings sorted by amount' do
        expect(user.filtered_spendings({filter: 'amount'})).to eq(user.spendings.order(amount_cents: :desc))
      end
    end
    context 'with "category" filter' do
      context 'with "other" category' do
        it 'should return only spendings with category "other"' do
          expect(user.filtered_spendings({filter: 'category', category: 'other'}))
            .to eq(user.spendings.where(category: :other))
        end
      end
      context 'with "other" category' do
        it 'should return only spendings with category "cafes"' do
          expect(user.filtered_spendings({filter: 'category', category: 'cafes'}))
            .to eq(user.spendings.where(category: :cafes))
        end
      end
    end
  end
end