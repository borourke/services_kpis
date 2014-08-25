class AddUserNameToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :user_name, :string
  end
end
