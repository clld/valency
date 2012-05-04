require 'test_helper'

class AlternationsControllerTest < ActionController::TestCase
  setup do
    @alternation = alternations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alternations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alternation" do
    assert_difference('Alternation.count') do
      post :create, alternation: { alternation_name: @alternation.alternation_name, alternation_type: @alternation.alternation_type, coding_frames_of_alternation: @alternation.coding_frames_of_alternation, description: @alternation.description, id: @alternation.id }
    end

    assert_redirected_to alternation_path(assigns(:alternation))
  end

  test "should show alternation" do
    get :show, id: @alternation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alternation
    assert_response :success
  end

  test "should update alternation" do
    put :update, id: @alternation, alternation: { alternation_name: @alternation.alternation_name, alternation_type: @alternation.alternation_type, coding_frames_of_alternation: @alternation.coding_frames_of_alternation, description: @alternation.description, id: @alternation.id }
    assert_redirected_to alternation_path(assigns(:alternation))
  end

  test "should destroy alternation" do
    assert_difference('Alternation.count', -1) do
      delete :destroy, id: @alternation
    end

    assert_redirected_to alternations_path
  end
end
