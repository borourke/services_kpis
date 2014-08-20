class CreateReportCardsTable < ActiveRecord::Migration
  def change
    create_table :report_cards do |t|
      t.string :job_score
      t.string :technical_score
      t.string :delivery_score
      t.string :best_in_class
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
