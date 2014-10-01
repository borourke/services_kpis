class ChangeCommentsFromReportcards < ActiveRecord::Migration
  def change
    remove_column :report_cards, :comments, :string
    add_column :report_cards, :comments, :text
  end
end
