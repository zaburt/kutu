require 'test_helper'

class GameLabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_label = game_labels(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get game_labels_path
    assert_response :success
  end

  test "should get new" do
    get new_game_label_path
    assert_response :success
  end

  test "should create game_label" do
    assert_difference('GameLabel.count') do
      post game_labels_path, params: { game_label: { description: @game_label.description, name: @game_label.name } }
    end

    assert_redirected_to game_label_path(GameLabel.last)
  end

  test "should show game_label" do
    get game_label_path(@game_label)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_label_path(@game_label)
    assert_response :success
  end

  test "should update game_label" do
    patch game_label_path(@game_label), params: { game_label: { description: @game_label.description, name: @game_label.name } }
    assert_redirected_to game_label_path(@game_label)
  end

  test "should destroy game_label" do
    assert_difference('GameLabel.count', -1) do
      delete game_label_path(@game_label)
    end

    assert_redirected_to game_labels_path
  end
end
