require 'pry'



class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory[item] == nil ? 0 : @inventory[item]
  end

  def stock(item, qty)
    available = @inventory.find { |key, value| key == item }
    if available == nil
      @inventory[item] = qty
    else
      @inventory[item] += qty
    end
  end

  # TO DO - Test me
  def sell_stock(item, qty)
    available = @inventory.find { |key, value| key == item }
    if available == nil
      "ERROR"
    elsif qty > @inventory[item]
      remaining = qty - @inventory[item]
    else
      @inventory[item] -= qty
    end
  end




end
