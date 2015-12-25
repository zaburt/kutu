require 'test_helper'

class GameCommentsControllerTest < ActionController::TestCase
  setup do
    @game_comment = game_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_comment" do
    assert_difference('GameComment.count') do
      post :create, game_comment: { comment: @game_comment.comment, game_id: @game_comment.game_id, user_id: @game_comment.user_id }
    end

    assert_redirected_to game_comment_path(assigns(:game_comment))
  end

  test "should show game_comment" do
    get :show, id: @game_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_comment
    assert_response :success
  end

  test "should update game_comment" do
    patch :update, id: @game_comment, game_comment: { comment: @game_comment.comment, game_id: @game_comment.game_id, user_id: @game_comment.user_id }
    assert_redirected_to game_comment_path(assigns(:game_comment))
  end

  test "should destroy game_comment" do
    assert_difference('GameComment.count', -1) do
      delete :destroy, id: @game_comment
    end

    assert_redirected_to game_comments_path
  end
end
