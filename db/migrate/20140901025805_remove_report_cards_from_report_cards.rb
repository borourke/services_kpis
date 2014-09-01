class RemoveReportCardsFromReportCards < ActiveRecord::Migration
  def change
    remove_column :report_cards, :type, :string
    remove_column :report_cards, :deliver_docs, :string
    remove_column :report_cards, :efficiency, :string

    add_column :report_cards, :efficiency_points, :string
    add_column :report_cards, :efficiency_score, :string
  end
end
