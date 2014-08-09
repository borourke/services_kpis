class ChangeColumnType < ActiveRecord::Migration
  def change
  	remove_column :report_cards, :user_id
  	add_column :report_cards, :user_id, :integer
  end
end
