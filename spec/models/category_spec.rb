require 'rails_helper'

describe Category, type: :model do
  fixtures :sources, :items, :entities
  before do


  end



  describe "Should create some categories from Entities"
  it "should add a category" do
    cats_count = Category.count
    Category.build_from_entities
    expect(Category.count).not_to eq(cats_count)
  end

  it "should create some stats for multiple days" do

      expect(1).to eq(0)
  end
  it "should not create cats from single word people names" do

      expect(1).to eq(0)
  end
  it "handle alias terms for computing numbers" do

      expect(1).to eq(0)
  end

end
