class CleanupAndRedo < ActiveRecord::Migration[5.1]
  def up
    drop_table :item_categories

  end
  def down
    #create_table :item_categories
  end

end
