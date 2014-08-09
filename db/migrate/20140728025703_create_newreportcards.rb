class CreateNewreportcards < ActiveRecord::Migration
  def change
  	create_table :newreportcards do |t|
      t.string :project_name
      t.string :project_type
      t.string :services_member
      t.string :team
      t.date   :delivery_date
      t.integer :hours
      t.decimal :spoilage
      t.string :project_number
      t.integer :sla_accuracy
      t.integer :accuracy
      t.string :points
      t.timestamps
    end
  end
end
