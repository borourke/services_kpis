class AddScoringToReportCards < ActiveRecord::Migration
  def change
    add_column :report_cards, :job_score, :string
    add_column :report_cards, :technical_score, :string
    add_column :report_cards, :delivery_score, :string
    add_column :report_cards, :overall_score, :string
  end
end
