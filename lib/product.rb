# frozen_string_literal: true

# Instantiates Product instances
class Product
  attr_accessor :code, :name, :price

  def initialize(attrs)
    @code = attrs['code']
    @name = attrs['name']
    @price = attrs['price']
  end
end
