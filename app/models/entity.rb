class Entity < ApplicationRecord

  belongs_to :item, counter_cache: true
  attr_accessor :count

  def self.find_create(name, type, id, published)

    name = Entity.clean(name)
    Entity.where(name:name,  pos:type, item_id:id, item_date:published).first_or_create

  end

  def self.clean(name)
    name = name.gsub("'s","")
    name = name.gsub("'","")
    name = name.gsub(":","")

    name
  end

  def self.get_daily_entities(date=Time.now.to_date - 1) #yesterday
    Entity.select("*").where("date(item_date)=?", date).where("pos=?", "PERSON").all#.group("name").all
  end


  def self.top_strings(count,days_back)
    tops = self.top(count, days_back)
    ents = tops.collect{|c|c.name}
    ents.uniq
  end

  def self.top(count=10, days_back=5)
      return Entity.select("name,pos,count(*)").joins(:item).where("items.published > ?", DateTime.now-days_back).where("((pos=? or pos=? or pos=?) and name ~ ?) ", "PERSON","ORG","GPE"," ").group("entities.name, entities.pos").order("count desc").limit(count).all
      #return Entity.select("name,count(*)").joins(:item).where("items.published > ?", DateTime.now-days_back).where("((pos=? or pos=? or pos=?) and name ~ ?) ", "PERSON","ORG","GPE"," ").group("entities.name").order("count desc").limit(count).all
  end


end
