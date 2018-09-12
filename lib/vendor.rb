require 'pry'



class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory[item.to_sym] == nil ? 0 : @inventory[item.to_sym]
  end

  def stock(item, qty)
    available = @inventory.find{ |key, value| key.to_s == item }
    if available == nil
      @inventory[item.to_sym] = qty
    else
      @inventory[item.to_sym] += qty
    end
  end





end
