class AddTypeToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :type, :string
  end
end
