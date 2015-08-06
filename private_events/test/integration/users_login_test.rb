require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nikola)
  end

  test "signin with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "signin with valid information then signout" do
    get signin_path
    post signin_path, session: { email: @user.email, password: 'password' }
    assert is_signed_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
    # Simulate a logout from another window.
    delete signout_path
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path, count: 0
  end

  test "signin with remembering" do
    sign_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "signin without remembering" do
    sign_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
