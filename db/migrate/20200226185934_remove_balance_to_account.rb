class RemoveBalanceToAccount < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :balance
  end
end
