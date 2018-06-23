class AddItemDateToEntities < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :item_date, :datetime
    Entity.all.each do |ent|
      ent.item_date = ent.item.published
      ent.save(validate:false)
    end
  end
end
