class RemoveColumnsFromReportCards < ActiveRecord::Migration
  def change
    remove_column :report_cards, :cml_clean, :string
    remove_column :report_cards, :cml_commented, :string
    remove_column :report_cards, :instructions, :string
    remove_column :report_cards, :tags, :string
    remove_column :report_cards, :code_clean, :string
    remove_column :report_cards, :code_utilized, :string
    remove_column :report_cards, :code_advanced, :string
    remove_column :report_cards, :complex_solution, :string
    remove_column :report_cards, :delivery_timely, :string
    remove_column :report_cards, :delivery_docs, :string
    remove_column :report_cards, :communication, :string
    remove_column :report_cards, :accuracy, :string
    remove_column :report_cards, :spoilage, :string
    remove_column :report_cards, :best_in_class, :string

    add_column :report_cards, :job_points, :string
    add_column :report_cards, :technical_points, :string
    add_column :report_cards, :project_points, :string
    add_column :report_cards, :efficiency, :string
  end
end
