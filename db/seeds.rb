exit if !Rails.env.development?

puts "Deleting the Data"
Plan.delete_all
User.delete_all

puts "Creating User"
user = FactoryGirl.create(:user, email: "test@yellowrush.com")

puts "Creating Plans"
20.times do
  FactoryGirl.create(:plan, user: user)
end