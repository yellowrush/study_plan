FactoryGirl.define do
  factory :study_plan do
    start_date { Date.today }
    end_date { 6.days.from_now.to_date }
    
    association(:user)
  end
end
