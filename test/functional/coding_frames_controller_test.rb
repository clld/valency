require 'test_helper'

class CodingFramesControllerTest < ActionController::TestCase
  setup do
    @coding_frame = coding_frames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coding_frames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coding_frame" do
    assert_difference('CodingFrame.count') do
      post :create, coding_frame: { coding_frame_schema: @coding_frame.coding_frame_schema, comment: @coding_frame.comment, description: @coding_frame.description, id: @coding_frame.id }
    end

    assert_redirected_to coding_frame_path(assigns(:coding_frame))
  end

  test "should show coding_frame" do
    get :show, id: @coding_frame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coding_frame
    assert_response :success
  end

  test "should update coding_frame" do
    put :update, id: @coding_frame, coding_frame: { coding_frame_schema: @coding_frame.coding_frame_schema, comment: @coding_frame.comment, description: @coding_frame.description, id: @coding_frame.id }
    assert_redirected_to coding_frame_path(assigns(:coding_frame))
  end

  test "should destroy coding_frame" do
    assert_difference('CodingFrame.count', -1) do
      delete :destroy, id: @coding_frame
    end

    assert_redirected_to coding_frames_path
  end
end
