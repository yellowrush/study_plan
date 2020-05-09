require "test_helper"

describe StudyPlan do
  describe "validity" do
    let(:study_plan) { StudyPlan.new }

    before do
      study_plan.valid?
    end

    it "requires a start date" do
      study_plan.errors[:start_date].must_include "can't be blank"
    end

    it "requires a end date" do
      study_plan.errors[:end_date].must_include "can't be blank"
    end

    it "requires a user" do
      study_plan.errors[:user].must_include "can't be blank"
    end

  end

  describe "generating a weekly plan" do
    let(:study_plan) { build(:study_plan) }

    before do
      7.times do
        create(:recipe, user:study_plan.user)
      end
    end

    it "populates a plan for each date between the start date and the end date" do
      study_plan.studies.size.must_equal 0
      
      study_plan.build_plans

      study_plan.studies.size.must_equal 7
    end

    it "build valid studies" do
      study_plan.build_plans

      study_plan.studies.all?(&:valid?).must_equal true
    end

    describe "with more days than recipes" do
      let(:study_plan) { build(:study_plan, end_date: 8.days.from_now.to_date) }

      it "build valid studies" do
        study_plan.build_plans

        study_plan.studies.all?(&:valid?).must_equal true
      end

      it "reuses recipes where necessary" do
        study_plan.build_plans

        uniq_ids = study_plan.studies.map(&:recipe_id).uniq
        uniq_ids.size.must_equal 7
      end

    end

  end
end