require 'rails_helper'

RSpec.describe "submissions/show", type: :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :rss_url => "Rss Url",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Rss Url/)
    expect(rendered).to match(/Title/)
  end
end
