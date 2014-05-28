require 'spec_helper'

describe "news_posts/new" do
  before(:each) do
    assign(:news_post, stub_model(NewsPost,
      :title => "MyString",
      :text => "MyText",
      :tags => "MyString",
      :creator_id => 1,
      :for_roles => 1
    ).as_new_record)
  end

  it "renders new news_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", news_posts_path, "post" do
      assert_select "input#news_post_title[name=?]", "news_post[title]"
      assert_select "textarea#news_post_text[name=?]", "news_post[text]"
      assert_select "input#news_post_tags[name=?]", "news_post[tags]"
      assert_select "input#news_post_creator_id[name=?]", "news_post[creator_id]"
      assert_select "input#news_post_for_roles[name=?]", "news_post[for_roles]"
    end
  end
end
