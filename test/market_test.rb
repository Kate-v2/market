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



end
