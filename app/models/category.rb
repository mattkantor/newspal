class Category < ApplicationRecord
  has_many :category_counts
  validates_uniqueness_of :name

  enum status: [:open, :flagged]

  def self.cat_types
    ["PERSON", "ORG"]
  end

  def self.build_from_entities
    tops = Entity.top(50,60)
    tops.each do |t|
      cats = Category.where(name:t.name)
      Category.create(name:t.name, cat_type:t.pos)
      #make sure the term isn't coined in an alias too
    end
  end

  def self.top_strings(count,days_back)
    tops = self.top(count, days_back)
    ents = tops.collect{|c|c.name}
    ents.uniq
  end

  def self.top(count=10, days_back=3)
    #select name, category_id, sum(count) as sum from items_categories inner join categories on (categories.id=items_categories.category_id and categories.status!=1)  group by category_id, name order by sum desc limit 20;

      CategoryCount.select("name,category_id, sum(count)").joins("inner join categories on (categories.id=items_categories.category_id and categories.status!=1)").where("items_categories.run_date > ?", DateTime.now-days_back).group(" category_id, name").order("sum desc").limit(count).all
  end

  def self.merge(name, ids_to_merge)
    new_cat = Category.where(name:name).first_or_create
    Category.find(ids_to_merge).each do |cat|
      new_alias_tags = new_cat.alias_tags << cat.name
      cat.alias_tags.each do |tag|
        new_cat.alias_tags << tag
      end
      new_cat.alias_tags = new_alias_tags.uniq
      if new_cat.save(validate:false)
        cat.update_attributes({status:1})
        new_cat.build_all_sums
      end
    end
  end

  def self.compute_all_daily_trends
    return if Item.count ==0
    the_date = Item.order("id asc").first.published.to_date
    end_date = Time.now.to_date-1
    loop do
      break if the_date > end_date
      the_date = the_date + 1
      Category.compute_daily_trends(the_date)
    end
  end

  def build_all_sums
    1.upto(90) do |i|
      target_date = Time.now.to_date - i
      build_sums(target_date)
    end
  end

  def build_sums(the_date)
    qry = []
    things = [self.name] + self.alias_tags
    things.each do |aliaz|
      qry <<  "(lower(title) ~ '#{ aliaz.downcase}' or lower(body) ~ '#{ aliaz.downcase}')" if !aliaz.blank?
    end

    compound = qry.join(" OR ")
    puts compound
    items_qry = Item.where("date(published)=? and (#{compound})", the_date)
    items = items_qry.all
    items_count = items.count
    if items_count > 0
      items_sent = (items.reduce(0) {|sum,i| sum + i.sentiment})/items_count
      puts "#{self.name} has #{items_count} for #{the_date}"
      CategoryCount.find_or_initialize_by(category_id:self.id,run_date:the_date).update_attributes!(count:items_count,  avg_sent:items_sent)
    else
      cat_count = CategoryCount.where(category_id:self.id).where(run_date:the_date).first

    end
  end

  def get_item_data_for_sums(the_date)

  end

  def self.compute_daily_trends(the_date=Time.now.to_date-1)

      Category.open.each do |cat|
        #cat.category_counts.where(run_date:the_date).destroy_all
        cat.build_sums(the_date)
      end


  end

end
