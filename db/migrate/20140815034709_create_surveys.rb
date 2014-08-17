class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :prescreen
      t.string :survey
      t.string :job_owner
      t.string :project_number
      t.integer :respondants

      t.timestamps
    end
  end
end
