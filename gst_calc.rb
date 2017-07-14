class Gst
  SC_GST = 9.fdiv(100)
  IGST = 18.fdiv(100)
  def get_inputs
    puts '****************Press ENTER to leave option value***************'
    #Consider product_price as total product price and total_product_price as total product price with GST
    print "Product Price(option):"
    @product_price = STDIN.gets.to_f
    print "Seller State:"
    @seller_state = STDIN.gets.chomp
    print "Buyer State:"
    @buyer_state = STDIN.gets.chomp
    print "Buyer SEZ applicable(yes/no):"
    @sez = STDIN.gets.chomp == 'yes'
    print "Total Product Price(option):"
    @total_product_price = STDIN.gets.to_f
  end

  def calculate
    if product_price_available? 
      return @product_price if @sez
      if same_state?
	return calculate_cs_gst
      else
	return calculate_igst
      end
    elsif total_product_price_available?
      if @sez
        return @total_product_price
      else
        return calculate_product_price
      end
    else
    end
  end

  def product_price_available?
    !@product_price.zero? #Error if product price is not given while testing
  end

  def total_product_price_available?
    !@total_product_price.zero?
  end

  def same_state?
    @seller_state == @buyer_state
  end
  
  def calculate_cs_gst
    sgst = cgst = @product_price * SC_GST 
    return sgst + cgst + @product_price
  end

  def calculate_igst
    return @product_price + (@product_price * IGST)
  end

  def calculate_product_price
      @total_product_price * 100 / 118
  end
end
if ARGV[0] == 'run-code'
  gst = Gst.new
  gst.get_inputs
  puts "Result: #{gst.calculate}"
end
