class AddUserAssosiationToSpendings < ActiveRecord::Migration[7.0]
  def change
    add_reference :spendings, :user, foreign_key: true
  end
end
