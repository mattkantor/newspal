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
end
