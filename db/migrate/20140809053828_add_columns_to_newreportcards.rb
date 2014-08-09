class AddColumnsToNewreportcards < ActiveRecord::Migration
  def change
    add_column :newreportcards, :report_card, :string
    remove_column :newreportcards, :points
  end
end
