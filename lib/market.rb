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
      it = obj.inventory[item]
      it != nil && it > 0
    }
    # This is extra because technically
    # we're identifying who sells it,
    # but this says if it's in stock
  end

  def sorted_item_list
    list = @vendors.map { |obj| obj.inventory.keys }
    list = list.flatten.uniq
    # list = list.map {|sym| sym.to_s }
    list.sort
  end

  def total_inventory
    all = {}
    @vendors.each { |obj|
      hash = obj.inventory
      keys = hash.keys
      hash.each {|key, val|
        all[key] == nil ? all[key] = val : all[key] += val
      }
    }
    return all

  end


end
