class AddNewreportcardcategoriesToNewreportcards < ActiveRecord::Migration
  def change
    add_column :newreportcards, :code, :string
    add_column :newreportcards, :cml, :string
    add_column :newreportcards, :delivery, :string
    add_column :newreportcards, :project, :string
  end
end
