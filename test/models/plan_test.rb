# coding: UTF-8

require "test_helper"

describe Plan do
  describe "validity" do
    let(:plan) { Plan.new }

    before do
      plan.valid?
    end

    it "requires a user" do
      plan.errors[:user].must_include "can't be blank"
    end

    it "requires a description" do
      plan.errors[:description].must_include "can't be blank"
    end

    it "requires a name" do
      plan.errors[:name].must_include "can't be blank"
    end

    it "requires the name to be unique for same user" do
      existing_plan = create(:plan)
      plan.name = existing_plan.name
      plan.user = existing_plan.user
      plan.valid?

      plan.errors[:name].must_include "has already been taken"

    end

    it "does not require the name to be unique for different user" do
      existing_plan = create(:plan)
      plan.name = existing_plan.name
      plan.valid?

      plan.errors[:name].wont_include "has already been taken"
    end
  end
end