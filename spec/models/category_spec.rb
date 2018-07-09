require 'rails_helper'

describe Category, type: :model do
  fixtures :sources, :items, :entities, :categories, :category_counts
  before do


  end

  describe "Merge categories"
  it "shouls be able to merge 2 categories and stats without making a mess" do
    merge_name="Donald Trump"
    old_name = "Trump "
    cat = Category.where(name:old_name).first

    Category.merge(merge_name, [cat.id])
    dest_cat = Category.where(name:merge_name).first
    merged_cat = Category.where(name:old_name).first
    expect(merged_cat.status).to eq("flagged")
    expect(dest_cat.alias_tags).to eq(["Trump "])


  end

  describe "Should create some categories from Entities"

  it "should add a category" do
    cats_count = Category.count
    Category.build_from_entities
    expect(Category.count).not_to eq(cats_count)
  end

  it "should create some stats for multiple days" do
      FactoryBot.create(:category)
      start_count = CategoryCount.all.count
      Category.compute_daily_trends(DateTime.new( 2018, 06, 23 ) )
      expect(start_count).not_to eq(CategoryCount.count)
  end

  it "should not create duplicate categories" do
    FactoryBot.create(:category)
    start_count = CategoryCount.all.count
    Category.create(name:"Donald Trump", alias_tags:[], cat_type:"PERSON", status:0)
    expect(start_count).to eq(CategoryCount.count)
  end

  it "should not create cats from single word people names" do
      expect(1).to eq(0)
  end
  it "handle alias terms for computing numbers" do
      expect(1).to eq(0)
  end

end
