class AddRoundToHappinessSurveys < ActiveRecord::Migration
  def change
    remove_column :happiness_surveys, :round, :integer
    add_column :happiness_surveys, :round, :string
  end
end
