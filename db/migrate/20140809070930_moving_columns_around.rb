class MovingColumnsAround < ActiveRecord::Migration
  def change
  	add_column :report_cards, :type, :string
  	remove_column :projects, :project_type
  end
end
