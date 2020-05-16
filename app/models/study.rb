class Study < ApplicationRecord
  belongs_to :study_plan, inverse_of: :studies
  belongs_to :recipe
end