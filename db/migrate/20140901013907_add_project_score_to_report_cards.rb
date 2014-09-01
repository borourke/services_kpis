class AddProjectScoreToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :project_score, :string
  end
end
