require 'test_helper'

class KvsControllerTest < ActionController::TestCase
  setup do
    @kv = kvs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kvs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kv" do
    assert_difference('Kv.count') do
      post :create, kv: { fields: @kv.fields, values: @kv.values }
    end

    assert_redirected_to kv_path(assigns(:kv))
  end

  test "should show kv" do
    get :show, id: @kv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kv
    assert_response :success
  end

  test "should update kv" do
    put :update, id: @kv, kv: { fields: @kv.fields, values: @kv.values }
    assert_redirected_to kv_path(assigns(:kv))
  end

  test "should destroy kv" do
    assert_difference('Kv.count', -1) do
      delete :destroy, id: @kv
    end

    assert_redirected_to kvs_path
  end
end
