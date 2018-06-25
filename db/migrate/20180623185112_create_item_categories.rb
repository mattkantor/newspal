class CreateItemCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :item_categories do |t|
      t.string :name
      t.integer :item_id

      t.timestamps
    end
  end
end
