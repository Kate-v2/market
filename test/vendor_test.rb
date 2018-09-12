require_relative 'test_helper'

require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_gets_attributes_and_sets_defaults
    # --- assigned ---
    assert_equal "Rocky Mountain Fresh", @vendor.name
    # --- default ---
    empty = {}
    assert_equal empty, @vendor.inventory
  end

  def test_it_checks_stock
    assert_equal 0, @vendor.check_stock("Peaches")
  end

  def test_it_adds_stock
    # -- adds an item that doesn't exist --
    @vendor.stock("Peaches", 30)
    assert_equal 30, @vendor.check_stock("Peaches")
    hash = {"Peaches" => 30 }
    assert_equal hash, @vendor.inventory
    # -- adds more of the same item --
    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
    hash = {"Peaches" => 55 }
    assert_equal hash, @vendor.inventory
    # -- adds a different item --
    @vendor.stock("Tomatoes", 12)
    assert_equal 12, @vendor.check_stock("Tomatoes")
    hash = {"Peaches" => 55, "Tomatoes" => 12 }
    assert_equal hash, @vendor.inventory
  end

  def test_it_can_sell_stock
    # -- before --
    @vendor.stock("Peaches", 30)
    hash = {"Peaches" => 30 }
    assert_equal hash, @vendor.inventory
    # -- after --
    @vendor.sell_stock("Peaches", 5)
    hash = {"Peaches" => 25 }
    assert_equal hash, @vendor.inventory

    assert_equal "ERROR", @vendor.sell_stock("Onions", 5)

    assert_equal 5, @vendor.sell_stock("Peaches", 30)



  end


end
