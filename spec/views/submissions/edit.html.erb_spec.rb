require 'rails_helper'

RSpec.describe "submissions/edit", type: :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :rss_url => "MyString",
      :title => "MyString"
    ))
  end

  it "renders the edit submission form" do
    render

    assert_select "form[action=?][method=?]", submission_path(@submission), "post" do

      assert_select "input[name=?]", "submission[rss_url]"

      assert_select "input[name=?]", "submission[title]"
    end
  end
end
