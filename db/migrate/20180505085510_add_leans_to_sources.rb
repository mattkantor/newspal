class AddLeansToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :leans, :integer
  end
end
