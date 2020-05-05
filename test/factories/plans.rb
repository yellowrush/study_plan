FactoryGirl.define do
  factory :plan do
    name "tom"
    description "rails engineer"
    association(:user)
  end
end
