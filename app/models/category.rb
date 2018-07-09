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
      CategoryCount.select("categories.*, *").joins(:category).where("categories.status!=1").where("run_date > ?", DateTime.now-days_back).order("count desc").limit(count).all
  end

  def self.merge(name, ids_to_merge)
    new_cat = Category.where(name:name).first_or_create
    to_delete = []

    Category.find(ids).each do |cat|
      new_alias_tags = new_cat.alias_tags << cat.name
      new_cat.alias_tags = new_alias_tags.uniq
      if new_cat.save(validate:false)
        cat.update_attributes({status:1})
        #merge all the related tables
        counts_to_merge = cat.category_counts
        counts_to_merge.each do |count_obj|
          #get the target object and increment, otherwise create
          target_obj = CategoryCount.where(category_id:cat.id, run_date:count_obj.run_date).first_or_create
          target_obj.count = target_obj.count + count_obj.count



          #need to re-calculate sentiment
          if target_obj.save(validate:false)
            to_delete << count_obj
          end
        end


      end
      to_delete.delete(true)
  end

  end

  def self.compute_all_daily_trends
    return if Item.count ==0
    the_date = Item.order("id asc").first.published.to_date
    end_date = Time.now.to_date-1


    loop do
      puts the_date

      break if the_date > end_date
      the_date = the_date + 1
      Category.compute_daily_trends(the_date)


    end
  end

  def build_sums(the_date)
    qry = []
    things = [self.name] + self.alias_tags
    things.each do |aliaz|
      qry <<  "(lower(title) ~ '#{ aliaz.downcase}' or lower(body) ~ '#{ aliaz.downcase}')" if !aliaz.blank?
    end
    compound = qry.join(" OR ")
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
