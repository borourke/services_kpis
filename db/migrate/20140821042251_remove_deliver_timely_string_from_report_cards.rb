class RemoveDeliverTimelyStringFromReportCards < ActiveRecord::Migration
  def change
    remove_column :report_cards, :delivery_timely_string, :string
    add_column :report_cards, :delivery_timely, :string
  end
end
