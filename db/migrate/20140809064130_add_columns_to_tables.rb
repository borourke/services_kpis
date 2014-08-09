class AddColumnsToTables < ActiveRecord::Migration
  def change
  	add_column :projects, :client_id, :integer
  	add_column :report_cards, :user_id, :integer
  	add_column :report_cards, :project_id, :integer
  	add_column :report_cards, :client_id, :integer
  end
end
