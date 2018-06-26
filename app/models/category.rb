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

  def self.compute_daily_trends
    the_date = Item.first.published.to_date
    loop do
      Category.open.each do |cat|
        Item.where("date(published)=?", the_date).where("lower(title) like ? or lower(body) like ?", cat.name, cat.name)
        #todo - alias
      end
      the_date = the_date + 1
    break if the_date > Time.now_to_date - 1




    end
  end

end
