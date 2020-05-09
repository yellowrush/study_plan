class StudyPlan < ApplicationRecord
  belongs_to :user
  has_many :studies

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user, presence: true

  def build_plans
    user_recipe_ids = user.recipes.pluck(:id)

    (start_date..end_date).each do |date|
      unused_recipe_ids = user_recipe_ids - studies.map(&:recipe_id)

      if unused_recipe_ids.empty?
        available_recipe_ids = user_recipe_ids
      else 
        available_recipe_ids = unused_recipe_ids
      end
      
      studies.build(date: date, recipe_id: available_recipe_ids.sample)
    end
  end
end