class CreateHappinessSurveyTable < ActiveRecord::Migration
  def change
    create_table :happiness_surveys do |t|
      t.integer :user_id
      t.integer :meaning
      t.integer :enthusiasm
      t.integer :pride
      t.integer :energy
      t.integer :recognition
      t.integer :support
      t.integer :stamina
      t.integer :growth
      t.integer :development
      t.string :comments
      t.integer :round

      t.timestamps
    end
  end
end
