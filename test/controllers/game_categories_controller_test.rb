require 'test_helper'

class GameCategoriesControllerTest < ActionController::TestCase
  setup do
    @game_category = game_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_category" do
    assert_difference('GameCategory.count') do
      post :create, game_category: { name: @game_category.name }
    end

    assert_redirected_to game_category_path(assigns(:game_category))
  end

  test "should show game_category" do
    get :show, id: @game_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_category
    assert_response :success
  end

  test "should update game_category" do
    patch :update, id: @game_category, game_category: { name: @game_category.name }
    assert_redirected_to game_category_path(assigns(:game_category))
  end

  test "should destroy game_category" do
    assert_difference('GameCategory.count', -1) do
      delete :destroy, id: @game_category
    end

    assert_redirected_to game_categories_path
  end
end
