class Study < ApplicationRecord
  belongs_to :study_plan
  belongs_to :recipe
end