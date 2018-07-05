class CategoryCount < ApplicationRecord
  self.table_name="items_categories"
  belongs_to :category




end
