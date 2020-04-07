require 'rails_helper'


RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject { described_class.new(
      id: 11,
      price_cents: 100,
      name: "Modern Skateboards",
      quantity: 1,
      category: Category.create(name:"Apparel")
    ) }
    
    it "is valid with valid attributes" do 
          expect(subject).to be_valid
    end

    it "is not valid without a name" do 
      subject.name = nil
      subject.save
      expect(subject.errors.full_messages).to eq ["Name can't be blank"]
    end

    it "is not valid without price" do 
      subject.price_cents = nil 
      subject.save
      expect(subject.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
    end

    it "is not valid without quantity" do 
      subject.quantity = nil 
      subject.save
      expect(subject.errors.full_messages).to eq ["Quantity can't be blank"]
    end

    it "is not valid without category" do 
      subject.category = nil 
      subject.save
      expect(subject.errors.full_messages).to eq ["Category can't be blank"]
    end

  end
end
