require_relative 'test_helper'

require './lib/market'
require './lib/vendor'


class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")

  end

  def test_it_exists
    assert_instance_of Market, @market
  end


  def test_it_gets_defaults_and_attributes
    # -- defualts --
    assert_equal [], @market.vendors
    # -- assigned --
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_can_add_vendors
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @market.add_vendor(@vendor_1)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @market.add_vendor(@vendor_2)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_3)

    actual = @market.vendors
    expected = [@vendor_1, @vendor_2, @vendor_3]

    assert_equal expected, actual
  end

  def test_it_gets_vendor_names
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    name1 = @vendor_1.name
    name2 = @vendor_2.name
    name3 = @vendor_3.name
    names = [name1, name2, name3]

    assert_equal names, @market.vendor_names
  end

  def test_it_can_list_vendors_who_sell_specific_items
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @market.add_vendor(@vendor_1)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @market.add_vendor(@vendor_2)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_3)

    list = @market.vendors_that_sell("Peaches")
    peaches = [@vendor_1, @vendor_3]

    assert_equal peaches, list
    # TO DO - add another test example, but this is fine
  end

  def test_it_can_return_a_list_of_all_items_sorted
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @market.add_vendor(@vendor_1)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @market.add_vendor(@vendor_2)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_3)

    list = @market.sorted_item_list
    sorted = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]

    assert_equal sorted, list
  end

  def test_it_can_list_total_market_inventory
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @market.add_vendor(@vendor_1)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @market.add_vendor(@vendor_2)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_3)

    list = @market.total_inventory
    all = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}

    assert_equal all, list
  end

  def test_it_can_sell_items
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @market.add_vendor(@vendor_1)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @market.add_vendor(@vendor_2)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_3)

    # sale = @market.sell("Peaches", 200)
    # assert_equal false, sale

    sale = @market.sell("Onion", 1)
    assert_equal false, sale

    sale = @market.sell("Banana Nice Cream", 5)
    impact = @vendor_2.inventory["Banana Nice Cream"]
    assert_equal true, sale
    assert_equal 45, impact

    sale = @market.sell("Peaches", 40)
    impact_1 = @vendor_1.inventory["Peaches"]
    impact_2 = @vendor_3.inventory["Peaches"]
    assert_equal true, sale
    assert_equal 0, impact_1
    assert_equal 60, impact_2

  end







end
