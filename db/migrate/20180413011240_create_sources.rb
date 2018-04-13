class CreateSources < ActiveRecord::Migration[5.1]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :rss_url
      t.string :logo_url

      t.timestamps
    end
  end
end
