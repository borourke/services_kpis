class AddCommentsToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :comments, :string
  end
end
