require 'test_helper'

class ReviewCommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:review_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review_comment" do
    assert_difference('ReviewComment.count') do
      post :create, :review_comment => { }
    end

    assert_redirected_to review_comment_path(assigns(:review_comment))
  end

  test "should show review_comment" do
    get :show, :id => review_comments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => review_comments(:one).to_param
    assert_response :success
  end

  test "should update review_comment" do
    put :update, :id => review_comments(:one).to_param, :review_comment => { }
    assert_redirected_to review_comment_path(assigns(:review_comment))
  end

  test "should destroy review_comment" do
    assert_difference('ReviewComment.count', -1) do
      delete :destroy, :id => review_comments(:one).to_param
    end

    assert_redirected_to review_comments_path
  end
end
