class CreateEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :pos
      t.integer :item_id

      t.timestamps
    end
  end
end
