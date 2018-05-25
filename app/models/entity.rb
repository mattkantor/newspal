class Entity < ApplicationRecord

  belongs_to :item
  attr_accessor :count

  def self.find_create(name, type, id)

    name = clean(name)
    Entity.find_create(name:name,  pos:type, item_id:id).first_or_create
  end

  def clean(name)
    name = name.gsub("'s","")
    name = name.gsub("'","")
    name = name.gsub(":","")

    name
  end

  def self.top(count)
    Entity.where("(pos=? and name ~ ?) ", "PERSON"," ").limit(12).all
  end
end
