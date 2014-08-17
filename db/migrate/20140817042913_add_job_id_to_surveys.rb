class AddJobIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :job_id, :integer
  end
end
