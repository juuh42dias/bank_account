class RemoveStatusFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :status, :boolean
  end
end
