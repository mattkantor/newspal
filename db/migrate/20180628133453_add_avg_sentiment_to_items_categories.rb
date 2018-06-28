class AddAvgSentimentToItemsCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :items_categories, :avg_sent, :float
  end
end
