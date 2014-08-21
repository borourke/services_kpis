class AddDeliveryDocsToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :delivery_docs, :string
  end
end
