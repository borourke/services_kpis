class RenameNewreportcardsToReportcards < ActiveRecord::Migration
  def change
  	rename_table :newreportcards, :report_cards
  end
end
