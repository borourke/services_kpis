class AddUseridToNewreportcards < ActiveRecord::Migration
  def change
    add_column :newreportcards, :user_id, :integer
  end
end
