class AddNewreportcardhashToNewreportcards < ActiveRecord::Migration
  def change
    add_column :newreportcards, :report_card, :string
  end
end
