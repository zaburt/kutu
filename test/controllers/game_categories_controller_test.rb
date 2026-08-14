require 'test_helper'

class GameCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_category = game_categories(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get game_categories_path
    assert_response :success
  end

  test "should get new" do
    get new_game_category_path
    assert_response :success
  end

  test "should create game_category" do
    assert_difference('GameCategory.count') do
      post game_categories_path, params: { game_category: { name: @game_category.name } }
    end

    assert_redirected_to game_category_path(GameCategory.last)
  end

  test "should show game_category" do
    get game_category_path(@game_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_category_path(@game_category)
    assert_response :success
  end

  test "should update game_category" do
    patch game_category_path(@game_category), params: { game_category: { name: @game_category.name } }
    assert_redirected_to game_category_path(@game_category)
  end

  test "should destroy game_category" do
    assert_difference('GameCategory.count', -1) do
      delete game_category_path(@game_category)
    end

    assert_redirected_to game_categories_path
  end
end
