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

  end




end
