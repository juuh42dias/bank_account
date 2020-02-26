class CreateAccountTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transactions do |t|
      t.references :account, foreign_key: true
      t.decimal :amount
      t.string :operation_type

      t.timestamps
    end
  end
end
