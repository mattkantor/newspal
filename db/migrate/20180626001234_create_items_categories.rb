class CreateItemsCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :items_categories do |t|
      t.integer :item_id
      t.integer :category_id
      t.integer :count
      t.date :run_date

      t.timestamps
    end
  end
end
