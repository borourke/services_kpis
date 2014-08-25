class MovingColumnsAround < ActiveRecord::Migration
  def change
  	remove_column :projects, :project_type
  end
end
