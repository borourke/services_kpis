class AddScoringDetailedToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :cml_clean, :string
    add_column :report_cards, :cml_commented, :string
    add_column :report_cards, :instructions, :string
    add_column :report_cards, :tags, :string
    add_column :report_cards, :code_clean, :string
    add_column :report_cards, :code_utilized, :string
    add_column :report_cards, :code_advanced, :string
    add_column :report_cards, :complex_solution, :string
    add_column :report_cards, :delivery_timely_string, :string
    add_column :report_cards, :deliver_docs, :string
    add_column :report_cards, :communication, :string
    add_column :report_cards, :accuracy, :string
    add_column :report_cards, :spoilage, :string
  end
end
