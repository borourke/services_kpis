class AddSurveyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survey_id, :integer
  end
end
