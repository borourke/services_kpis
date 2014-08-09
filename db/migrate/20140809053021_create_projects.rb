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

    remove_column :newreportcards, :project_name
    remove_column :newreportcards, :project_type
    remove_column :newreportcards, :team
    remove_column :newreportcards, :delivery_date
    remove_column :newreportcards, :hours
    remove_column :newreportcards, :spoilage
    remove_column :newreportcards, :project_number
    remove_column :newreportcards, :sla_accuracy
    remove_column :newreportcards, :accuracy
    remove_column :newreportcards, :user_id
    remove_column :newreportcards, :report_card
    remove_column :newreportcards, :code
    remove_column :newreportcards, :cml
    remove_column :newreportcards, :delivery
    remove_column :newreportcards, :project
  end
end
