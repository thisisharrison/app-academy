require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Harry") }
  let(:cake) { Dessert.new("cake", 10, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(cake.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(cake.quantity).to eq(10)
    end
    
    it "starts ingredients as an empty array" do
      expect(cake.ingredients).to be_empty
    end
    
    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "a lot", chef) }.to raise_error(ArgumentError)
    end
  end
  
  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cake.add_ingredient("egg")
      expect(cake.ingredients).to include("egg")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["egg", "flour", "sugar", "milk", "lemon"]
      
      ingredients.each { |el| cake.add_ingredient(el) }
      # check before #mix!
      expect(cake.ingredients).to eq(ingredients)
      cake.mix!
      # check does not equal
      expect(cake.ingredients).not_to eq(ingredients)
      # check once sorted, still equals
      expect(cake.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      cake.eat(1)
      expect(cake.quantity).to eq(9)
    end

    it "raises an error if the amount is greater than the quantity" do 
      expect { cake.eat(11) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      # method stubs 
      allow(chef).to receive(:titleize).and_return("Chef Harry the Great Baker")
      expect(cake.serve).to eq("Chef Harry the Great Baker has made 10 cakes!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      # Dessert#make_more calls @chef#bake
      allow(chef).to receive(:bake).with(cake)
      # now make_more
      cake.make_more
    end
  end
end
