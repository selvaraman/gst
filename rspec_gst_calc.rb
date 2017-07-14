require_relative 'gst_calc'
require 'rspec'
describe 'gst_calculator' do
  context "find total product price with gst if product price given" do
    it "if SEZ applicable is true and total product price is given,  total product price with gst and total product price should be equal" do
      gst = Gst.new
      gst.instance_variable_set(:@product_price, 900)
      gst.instance_variable_set(:@seller_state, 'TN')
      gst.instance_variable_set(:@seller_state, 'Kerala')
      gst.instance_variable_set(:@sez, true)
      expect(gst.calculate).to eq(900)
    end
    it "if SEZ applicable is false and same state,  total product price with gst and total product price should be 18% of total product price" do
      gst = Gst.new
      gst.instance_variable_set(:@product_price, 900)
      gst.instance_variable_set(:@seller_state, 'TN')
      gst.instance_variable_set(:@seller_state, 'TN')
      gst.instance_variable_set(:@sez, false)
      expect(gst.calculate).to eq(1062)
    end
    it "if SEZ applicable is false and different state,  total product price with gst should be 9% of sgst and 9% of cgst" do
      gst = Gst.new
      gst.instance_variable_set(:@product_price, 900)
      gst.instance_variable_set(:@seller_state, 'TN')
      gst.instance_variable_set(:@seller_state, 'Kerala')
      gst.instance_variable_set(:@sez, false)
      expect(gst.calculate).to eq(1062)
    end
  end
  context "find total product price if product price with gst given" do
    it "if SEZ applicable is false and same state,  total product price should be 118 / 100 of total product price with gst" do
      gst = Gst.new
      gst.instance_variable_set(:@total_product_price, 1062)
      gst.instance_variable_set(:@seller_state, 'TN')
      gst.instance_variable_set(:@seller_state, 'Kerala')
      gst.instance_variable_set(:@sez, false)
      expect(gst.calculate).to eq(900)
    end
  end
end
