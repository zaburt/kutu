require 'test_helper'

class GameCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_comment = game_comments(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get game_comments_path
    assert_response :success
  end

  test "should get new" do
    get new_game_comment_path
    assert_response :success
  end

  test "should create game_comment" do
    assert_difference('GameComment.count') do
      post game_comments_path, params: { game_comment: { comment: @game_comment.comment, game_id: @game_comment.game_id, user_id: @game_comment.user_id } }
    end

    assert_redirected_to game_comment_path(GameComment.last)
  end

  test "should show game_comment" do
    get game_comment_path(@game_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_comment_path(@game_comment)
    assert_response :success
  end

  test "should update game_comment" do
    patch game_comment_path(@game_comment), params: { game_comment: { comment: @game_comment.comment, game_id: @game_comment.game_id, user_id: @game_comment.user_id } }
    assert_redirected_to game_path(@game_comment.game)
  end

  test "should destroy game_comment" do
    assert_difference('GameComment.count', -1) do
      delete game_comment_path(@game_comment)
    end

    assert_redirected_to game_comments_path
  end
end
