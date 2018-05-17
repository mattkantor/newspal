require 'rails_helper'

RSpec.describe "submissions/new", type: :view do
  before(:each) do
    assign(:submission, Submission.new(
      :rss_url => "MyString",
      :title => "MyString"
    ))
  end

  it "renders new submission form" do
    render

    assert_select "form[action=?][method=?]", submissions_path, "post" do

      assert_select "input[name=?]", "submission[rss_url]"

      assert_select "input[name=?]", "submission[title]"
    end
  end
end
