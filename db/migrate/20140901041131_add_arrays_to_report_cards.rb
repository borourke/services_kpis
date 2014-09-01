class AddArraysToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :job_array, :string
    add_column :report_cards, :technical_array, :string
    add_column :report_cards, :project_array, :string

    remove_column :report_cards, :job_points, :string
    remove_column :report_cards, :technical_points, :string
    remove_column :report_cards, :project_points, :string
    remove_column :report_cards, :efficiency_points, :string
  end
end
