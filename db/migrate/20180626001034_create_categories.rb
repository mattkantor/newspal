class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :alias_tags, array: true, default: []

      
    end
  end
end
