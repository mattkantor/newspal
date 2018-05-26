class Entity < ApplicationRecord

  belongs_to :item
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

  def self.top(count)
    ents = Entity.where("(pos=? and name ~ ?) ", "PERSON"," ").limit(12).all
    ents = ents.collect{|c|c.name}
    ents.uniq
  end
end
