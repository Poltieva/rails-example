class ChangeCategoryTypeAndAddDescr < ActiveRecord::Migration[7.0]
  def change
    add_column :spendings, :description, :text
    change_column :spendings, :category, 'integer USING CAST(category AS integer)'
  end
end
