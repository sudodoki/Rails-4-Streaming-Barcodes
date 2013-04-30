require 'test_helper'

class BarcodesControllerTest < ActionController::TestCase
  setup do
    @barcode = barcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barcode" do
    assert_difference('Barcode.count') do
      post :create, barcode: { code: @barcode.code, user_id: @barcode.user_id }
    end

    assert_redirected_to barcode_path(assigns(:barcode))
  end

  test "should show barcode" do
    get :show, id: @barcode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @barcode
    assert_response :success
  end

  test "should update barcode" do
    patch :update, id: @barcode, barcode: { code: @barcode.code, user_id: @barcode.user_id }
    assert_redirected_to barcode_path(assigns(:barcode))
  end

  test "should destroy barcode" do
    assert_difference('Barcode.count', -1) do
      delete :destroy, id: @barcode
    end

    assert_redirected_to barcodes_path
  end
end
