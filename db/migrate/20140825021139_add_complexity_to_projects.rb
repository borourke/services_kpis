class AddComplexityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :complexity, :string
  end
end
