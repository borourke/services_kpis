class StupidStringStuff < ActiveRecord::Migration
  def change
  	remove_column :report_cards, :user_id
  	remove_column :report_cards, :services_member
  	add_column :report_cards, :services_member, :integer
  end
end
