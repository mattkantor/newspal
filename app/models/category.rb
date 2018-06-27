class Category < ApplicationRecord
  has_many :items_categories
  validates_uniqueness_of :name

  enum status: [:open, :flagged]

  def cat_types
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

  def self.compute_daily_trends(the_date=Time.now.to_date-1)


      Category.open.each do |cat|
        items_count = Item.where("date(published)=?", the_date).where("? ~ lower(title) like or ? ~ lower(body)", cat.name, cat.name).count
        #todo - alias
        puts "#{cat.name} has #{items_count} for #{the_date}"
        ItemsCategory.create( category_id:cat.id, count:items_count, run_date:the_date) if items_count > 0

      end


  end

end
