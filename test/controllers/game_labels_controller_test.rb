require 'test_helper'

class GameLabelsControllerTest < ActionController::TestCase
  setup do
    @game_label = game_labels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_labels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_label" do
    assert_difference('GameLabel.count') do
      post :create, game_label: { description: @game_label.description, name: @game_label.name }
    end

    assert_redirected_to game_label_path(assigns(:game_label))
  end

  test "should show game_label" do
    get :show, id: @game_label
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_label
    assert_response :success
  end

  test "should update game_label" do
    patch :update, id: @game_label, game_label: { description: @game_label.description, name: @game_label.name }
    assert_redirected_to game_label_path(assigns(:game_label))
  end

  test "should destroy game_label" do
    assert_difference('GameLabel.count', -1) do
      delete :destroy, id: @game_label
    end

    assert_redirected_to game_labels_path
  end
end
