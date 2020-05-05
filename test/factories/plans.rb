FactoryGirl.define do
  factory :plan do
    name { Faker::Hipster.sentence }
    description { Faker::Hipster.paragraph }
    association(:user)
  end
end
