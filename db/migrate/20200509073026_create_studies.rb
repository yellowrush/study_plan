class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.date :date, null:false
      t.references :study_plan, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
