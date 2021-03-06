require 'test_helper'

class AlertaControllerTest < ActionController::TestCase
  setup do
    @alertum = alerta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alerta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alertum" do
    assert_difference('Alertum.count') do
      post :create, alertum: { producto_id: @alertum.producto_id, texto: @alertum.texto }
    end

    assert_redirected_to alertum_path(assigns(:alertum))
  end

  test "should show alertum" do
    get :show, id: @alertum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alertum
    assert_response :success
  end

  test "should update alertum" do
    patch :update, id: @alertum, alertum: { producto_id: @alertum.producto_id, texto: @alertum.texto }
    assert_redirected_to alertum_path(assigns(:alertum))
  end

  test "should destroy alertum" do
    assert_difference('Alertum.count', -1) do
      delete :destroy, id: @alertum
    end

    assert_redirected_to alerta_path
  end
end
