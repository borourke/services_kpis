class AddProjectNameToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :project_name, :string
  end
end
