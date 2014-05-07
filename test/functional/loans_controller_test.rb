require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post :create, loan: { annual_insurance: @loan.annual_insurance, annual_maintenance: @loan.annual_maintenance, annual_prop_tax: @loan.annual_prop_tax, apr: @loan.apr, down_pmt: @loan.down_pmt, down_pmt_percent: @loan.down_pmt_percent, hoa_dues: @loan.hoa_dues, income_tax_rate: @loan.income_tax_rate, interest_rate: @loan.interest_rate, price: @loan.price, term: @loan.term }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should show loan" do
    get :show, id: @loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan
    assert_response :success
  end

  test "should update loan" do
    put :update, id: @loan, loan: { annual_insurance: @loan.annual_insurance, annual_maintenance: @loan.annual_maintenance, annual_prop_tax: @loan.annual_prop_tax, apr: @loan.apr, down_pmt: @loan.down_pmt, down_pmt_percent: @loan.down_pmt_percent, hoa_dues: @loan.hoa_dues, income_tax_rate: @loan.income_tax_rate, interest_rate: @loan.interest_rate, price: @loan.price, term: @loan.term }
    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete :destroy, id: @loan
    end

    assert_redirected_to loans_path
  end
end
