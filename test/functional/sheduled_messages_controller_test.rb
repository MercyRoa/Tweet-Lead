require 'test_helper'

class SheduledMessagesControllerTest < ActionController::TestCase
  setup do
    @sheduled_message = sheduled_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sheduled_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sheduled_message" do
    assert_difference('SheduledMessage.count') do
      post :create, sheduled_message: @sheduled_message.attributes
    end

    assert_redirected_to sheduled_message_path(assigns(:sheduled_message))
  end

  test "should show sheduled_message" do
    get :show, id: @sheduled_message.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sheduled_message.to_param
    assert_response :success
  end

  test "should update sheduled_message" do
    put :update, id: @sheduled_message.to_param, sheduled_message: @sheduled_message.attributes
    assert_redirected_to sheduled_message_path(assigns(:sheduled_message))
  end

  test "should destroy sheduled_message" do
    assert_difference('SheduledMessage.count', -1) do
      delete :destroy, id: @sheduled_message.to_param
    end

    assert_redirected_to sheduled_messages_path
  end
end
