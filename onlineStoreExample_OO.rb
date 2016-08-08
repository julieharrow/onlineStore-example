class Store
  attr_accessor :shopping_cart
  def initialize(shopping_cart)
    @shopping_cart = shopping_cart
  end

  def browse_until_checkout
    until @shopping_cart.active_session == false
      puts "What are you looking for today? (MUSIC / MOVIE)"
      type = validate(gets.chomp.downcase)
      puts "How many #{type}s would you like to buy?"
      quantity = validate_num(gets.chomp.to_i)
      @shopping_cart.add_to_cart(type,quantity)
    end
  end

  def validate(media)
    until (media == "movie" || media == "music")
      puts "Please enter one of the following: (MUSIC / MOVIE)"
      media = gets.chomp.downcase
    end
    if media == "music"
      type = 'cd'
    else
      puts "What type of movie format would you like? (DVD / BLU-RAY)"
      type = gets.chomp.downcase
      validate_movie(type)
    end
  end

  def validate_movie(type)
    until (type == "dvd" || type == "blu-ray")
      puts "Please enter one of the following: (DVD / BLU-RAY)"
      type = gets.chomp.downcase
    end
    return type
  end

  def validate_num(quantity)
    until quantity > 0
      puts "Please enter a positive whole number:"
      quantity = gets.chomp.to_i
    end
    return quantity
  end
end

class ShoppingCart
  attr_accessor :items, :total_cost, :total_savings, :active_session
  def initialize(items:[], total_cost:0, total_savings:0, active_session:true)
    @items, @total_cost, @total_savings, @active_session = items, total_cost, total_savings, active_session
  end

  def add_to_cart(type, quantity)
    item = LineItem.new(type, quantity)
    @items << item
    @total_cost += (item.cost_per_unit * quantity)
    @total_savings += (item.cost_per_unit * item.discount_rate * quantity)
    continue_shopping?
  end

  def continue_shopping?
    puts "Would you like to purchase anything else?"
    if gets.chomp.downcase == "no"
      check_out
    end
  end

  def check_out
    puts "\nYour total is $#{(@total_cost - @total_savings).round(2)}.\nYou saved $#{(@total_savings).round(2)} today!"
    @active_session = false
  end
end

class LineItem
  attr_accessor :type, :quantity
  def initialize(type, quantity)
    @type, @quantity = type, quantity
  end

  def cost_per_unit
    cost_per_unit = {"cd"=>9.99, "dvd"=>12.99, "blu-ray"=>15.99}
    return cost_per_unit[@type]
  end

  def discount_rate
    item_discounts = {"cd"=>0.5, "dvd"=>0.25, "blu-ray"=>0.15}
    if @type == "dvd" && @quantity >= 5
      return 0.30
    else
      return item_discounts[@type]
    end
  end
end

puts "Welcome! Today we are having an Independence Day Sale!\nAll CDs are 50% off!  All DVDs are 25% off! All BLU-RAYs are 15% off!\nPLUS...Buy 5 or more DVDs and they are 30% off!\n\n"

user_cart = ShoppingCart.new()
zift_media = Store.new(user_cart)
zift_media.browse_until_checkout
