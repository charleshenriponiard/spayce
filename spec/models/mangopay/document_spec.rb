require 'rails_helper'

RSpec.describe Mangopay::Document, type: :model do
  subject {
    type_attributes = {
      type: "Identity proof"
    }
  }

  it 'Should be valid' do
    document = Mangopay::Document.new(subject)
    expect(document).to be_valid
  end

  describe 'Should not be valid with bad attribute' do
    it "with type = nil" do 
      document = Mangopay::Document.new(subject)
      document.type = nil
      expect(document).to_not be_valid
    end 

    it "with type = 'test'" do
      document = Mangopay::Document.new(subject)
      document.type = "test"
      expect(document).to_not be_valid
    end 
  end
end