require "application_system_test_case"

class OrderdetailsTest < ApplicationSystemTestCase
  setup do
    @orderdetail = orderdetails(:one)
  end

  test "visiting the index" do
    visit orderdetails_url
    assert_selector "h1", text: "Orderdetails"
  end

  test "creating a Orderdetail" do
    visit orderdetails_url
    click_on "New Orderdetail"

    fill_in "Order", with: @orderdetail.order_id
    fill_in "Product", with: @orderdetail.product_id
    fill_in "Quantity", with: @orderdetail.quantity
    click_on "Create Orderdetail"

    assert_text "Orderdetail was successfully created"
    click_on "Back"
  end

  test "updating a Orderdetail" do
    visit orderdetails_url
    click_on "Edit", match: :first

    fill_in "Order", with: @orderdetail.order_id
    fill_in "Product", with: @orderdetail.product_id
    fill_in "Quantity", with: @orderdetail.quantity
    click_on "Update Orderdetail"

    assert_text "Orderdetail was successfully updated"
    click_on "Back"
  end

  test "destroying a Orderdetail" do
    visit orderdetails_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Orderdetail was successfully destroyed"
  end
end
