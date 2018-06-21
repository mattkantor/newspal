class AddEntitiesCountToItems < ActiveRecord::Migration[5.1]
  def change

     add_column :items, :entities_count, :integer, default: 0
  end
end
