class AddStatusToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :status, :integer, default:0
  end
end
