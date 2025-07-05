require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transactions_index_url
    assert_response :success
  end

  test "should get new" do
    get transactions_new_url
    assert_response :success
  end

  test "should get create" do
    get transactions_create_url
    assert_response :success
  end
end
