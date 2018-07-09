class CategoryCount < ApplicationRecord
  self.table_name="items_categories"
  belongs_to :category

  def self.get_counts(cat, days_back=90)
    out = []
    count_hash_array = cat.category_counts.order("run_date asc").all.collect do
      |f| {run_date:f.run_date, count:f.count, avg_sent:f.avg_sent}
    end

    1.upto(days_back) do |i|
      target_date = Time.now.to_date - i
      target_hash = count_hash_array.detect do |f|

        f[:run_date] == target_date

      end

      out_hash = {run_date:target_date, count:0, avg_sent:0}
      unless target_hash.nil?

        out_hash = {run_date:target_date, count:target_hash[:count], avg_sent:target_hash[:avg_sent]}

      end
      out << out_hash
    end
    return out

  end


end
