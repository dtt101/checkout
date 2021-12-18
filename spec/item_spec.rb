require 'minitest/autorun'
require './lib/item'

describe Item do

  describe "#new" do
    it "creates a new Item" do
      _(Item.new("001", "Lavender Heart", 9.25)).must_be_instance_of Item
    end
  end

end