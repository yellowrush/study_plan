FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_user_#{n}@yellowrush.com" }
    password "password"
  end
end
