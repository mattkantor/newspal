class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :source_id
      t.string :title
      t.text :body
      t.datetime :published
      t.string :image_url

      t.timestamps
    end
  end
end
