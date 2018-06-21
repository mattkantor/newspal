class Entity < ApplicationRecord

  belongs_to :item, counter_cache: true
  attr_accessor :count

  def self.find_create(name, type, id)

    name = Entity.clean(name)
    Entity.where(name:name,  pos:type, item_id:id).first_or_create

  end

  def self.clean(name)
    name = name.gsub("'s","")
    name = name.gsub("'","")
    name = name.gsub(":","")

    name
  end

  def self.top(count=10, days_back=5)

      ents = Entity.select("name,count(*)").joins(:item).where("items.published > ?", DateTime.now-days_back).where("(pos=? and name ~ ?) ", "PERSON"," ").group("entities.name").order("count desc").limit(count).all


    ents = ents.collect{|c|c.name}
    ents.uniq
  end


end
