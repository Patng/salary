require 'test_helper'

class WagesControllerTest < ActionController::TestCase
  setup do
    @wage = wages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wage" do
    assert_difference('Wage.count') do
      post :create, wage: { avg: @wage.avg, company: @wage.company, high: @wage.high, location_id: @wage.location_id, low: @wage.low, title: @wage.title, total: @wage.total }
    end

    assert_redirected_to wage_path(assigns(:wage))
  end

  test "should show wage" do
    get :show, id: @wage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wage
    assert_response :success
  end

  test "should update wage" do
    patch :update, id: @wage, wage: { avg: @wage.avg, company: @wage.company, high: @wage.high, location_id: @wage.location_id, low: @wage.low, title: @wage.title, total: @wage.total }
    assert_redirected_to wage_path(assigns(:wage))
  end

  test "should destroy wage" do
    assert_difference('Wage.count', -1) do
      delete :destroy, id: @wage
    end

    assert_redirected_to wages_path
  end
end
