class AddPaymentCentsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :payment_cents, :integer
  end
end
