require 'rails_helper'

RSpec.describe "submissions/index", type: :view do
  before(:each) do
    assign(:submissions, [
      Submission.create!(
        :rss_url => "Rss Url",
        :title => "Title"
      ),
      Submission.create!(
        :rss_url => "Rss Url",
        :title => "Title"
      )
    ])
  end

  it "renders a list of submissions" do
    render
    assert_select "tr>td", :text => "Rss Url".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
