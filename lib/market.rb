require 'pry'


require './lib/vendor'

class Market

  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = @vendors.map {|obj| obj.name }
  end

  def vendors_that_sell(item)
    list = @vendors.find_all { |obj|
      it = obj.inventory[item.to_sym]
      it != nil && it > 0
    }
  end

end
