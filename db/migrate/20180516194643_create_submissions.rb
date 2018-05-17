class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.string :rss_url
      t.string :title

      t.timestamps
    end
  end
end
