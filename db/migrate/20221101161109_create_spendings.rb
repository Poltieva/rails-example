class CreateSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings do |t|
      t.string :name
      t.string :category
      t.monetize :amount

      t.timestamps
    end
  end
end
