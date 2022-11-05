class RemoveUuid < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :uuid
  end
end
