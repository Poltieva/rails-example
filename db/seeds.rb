if User.all.empty?
  3.times do
    FactoryBot.create(:user)
  end
end

if Spending.all.empty?
  10.times do
    FactoryBot.create(:spending, user: User.last)
  end
end