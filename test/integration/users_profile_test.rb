# rails generate integration_test users_profile
require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:kyc)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    # This checks for an img tag with class gravatar inside a top-level heading tag (h1).
    assert_select 'h1>img.gravatar'
    # assert_match is less specific assertion than assert_select
    # unlike assert_select, using assert_match in this context
    # doesn’t require us to indicate which HTML tag we’re looking for
    assert_match @user.microposts.count.to_s, response.body    
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
