require 'rails_helper'

RSpec.describe Invoice, type: :model do
  subject {
    user = User.create!(
      first_name: "baba",
      last_name: 'Le roux',
      status: 0,
      email: "test@gmail.com",
      password: "secret",
      phone_number: "06 06 06 06 06"
    )

    company = Company.create!(
      user: user,
      name: "MONSIEUR BENOIT CALIN",
      siret: 	84955687300016,
      legal_structure: "Entrepreneur individuel",
      vat: 0,
      start_activity: "27-03-2019",
      street_number: 8,
      street: "crs de la martinique",
      zip_code: 33000,
      city: "Bordeaux",
      country: "France",
      code_ape: '6201Z'
    )

    client = Client.create!(
      company: company,
      name: "Maurice",
      email: "maurice.jean@gmail.com"
    )

    invoice_attributes = {
      client: client, 
      amount: 1000.02,
      file: "en attente de mieux",
      description: "Je suis une description test pour vérifier si ça fonctionne bien !",
      ref_number: "A1234GTE",
      end_date: Date.today - 1,
      status: 1,
      code_promo: "SPAYCE",
    }
  }

  it 'client is valid with valid attributes' do
    invoice = Invoice.new(subject)
    expect(invoice).to be_valid
  end

  it 'should be not valid without file attribute' do
    invoice = Invoice.new(subject)
    invoice.file = nil
    expect(invoice).to_not be_valid
  end

  it "should be not valid without ref_number attribute" do
    invoice = Invoice.new(subject)
    invoice.ref_number = nil
    expect(invoice).to_not be_valid
  end

  it "should be not valid without client references" do
    invoice = Invoice.new(subject)
    invoice.client = nil
    expect(invoice).to_not be_valid
  end

  describe "amount attribute" do
    it 'should be not valid without amount attribute' do
      invoice = Invoice.new(subject)
      invoice.amount = nil
      expect(invoice).to_not be_valid
    end

    it 'should be an integer and greater than 0' do
      invoice = Invoice.new(subject)
      invoice.amount = "a"
      expect(invoice).to_not be_valid
    end
  end

  describe "description attribute" do
    it 'should be valid without description attribute' do
      invoice = Invoice.new(subject)
      invoice.description = nil
      expect(invoice).to be_valid
    end

    it 'should be not valid if description attribute is present but smaller than 50 chars' do
      invoice = Invoice.new(subject)
      invoice.description = "bonjour"
      expect(invoice).to_not be_valid
    end 
  end

  describe 'end_date attribute' do
    it "should be not valid without end_date attribute" do
      invoice = Invoice.new(subject)
      invoice.end_date = nil
      expect(invoice).to_not be_valid
    end

    it "end_date can't be in the future" do
      invoice = Invoice.new(subject)
      invoice.end_date = Date.today + 1
      expect(invoice).to_not be_valid
    end
  end

  describe 'status attribute' do
    it 'should be not valid without end_date attribute' do
      invoice = Invoice.new(subject)
      invoice.status = nil
      expect(invoice).to_not be_valid
    end
    it 'should be between 0..4' do
      invoice = Invoice.new(subject)
      invoice.status = 5
      expect(invoice).to_not be_valid
    end
  end
end 