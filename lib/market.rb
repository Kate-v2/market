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

  def sell(item, qty)
    all = total_inventory
    return false if all.keys.include?(item) == false
    # return false if qty is too high
    tf = all[item] >= qty
    pick_vendor(item, qty)
    return tf
  end

  def pick_vendor(item, qty)
    shops = vendors_that_sell(item)
    enough = shops.map {|obj| obj.inventory [item] >= qty; obj }
    enough = enough.sort_by{ |obj| obj.inventory[item]}
    shop = nil
    if enough.count >= 1
      shop = enough[0]
      shop.sell_stock(item, qty)
    else
      shop_around(item, qty, shops)
    end
  end

  def shop_around(item, qty, shops)
    return if qty == 0
    head, *tail = shops
    qty = head.sell_stock(item, qty)
    shop_around(item, qty, tail)
  end

end
