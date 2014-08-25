class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_type
      t.string :team
      t.date :delivery_date
      t.integer :hours
      t.decimal :spoilage
      t.string :project_number
      t.integer :sla_accuracy
      t.integer :accuracy
      t.integer :user_id
      t.integer :report_card

      t.timestamps
    end
  end
end
