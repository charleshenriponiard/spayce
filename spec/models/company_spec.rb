require 'rails_helper'

RSpec.describe Company, type: :model do
  subject {
    user = User.create!(
      first_name: "baba",
      last_name: 'Le roux',
      email: "test@gmail.com",
      password: "secret",
      phone_number: "06 06 06 06 06",
    )

    company_attributes = {
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
      code_ape: '6201Z',
    }
  }

  it 'is valid with valid attributes' do
    company = Company.new(subject)
    expect(company).to be_valid
  end

  it 'is not valid without name' do
    company = Company.new(subject)
    company.name = ""
    expect(company).to_not be_valid
  end

  it 'is not valid without siret' do
    company = Company.new(subject)
    company.siret = nil
    expect(company).to_not be_valid
  end

  it 'is not valid without legal_structure' do
    company = Company.new(subject)
    company.legal_structure = nil
    expect(company).to_not be_valid
  end 

  it 'is not valid without street_number' do
    company = Company.new(subject)
    company.street_number = nil
    expect(company).to_not be_valid
  end
  
  it 'is not valid without street' do
    company = Company.new(subject)
    company.street = nil
    expect(company).to_not be_valid
  end

  it 'is not valid without city' do
    company = Company.new(subject)
    company.city = nil
    expect(company).to_not be_valid
  end

  it 'is not valid without country' do
    company = Company.new(subject)
    company.country = nil
    expect(company).to_not be_valid
  end

  it "should be not valid without user references" do
    company = Company.new(subject)
    company.user = nil
    expect(company).to_not be_valid
  end

  describe "VAT" do
    it 'is not valid without vat' do
      company = Company.new(subject)
      company.vat = nil
      expect(company).to_not be_valid
    end
    it 'is not valid with vat other than 0, 2.1, 5.5, 10, 20' do
      company = Company.new(subject)
      company.vat = 3
      expect(company).to_not be_valid
    end
    it 'is valid with vat in 0, 2.1, 5.5, 10, 20' do
      company = Company.new(subject)
      company.vat = 0
      expect(company).to be_valid
      company = Company.new(subject)
      company.vat = 2.1
      expect(company).to be_valid
      company.vat = 5.5
      expect(company).to be_valid
      company.vat = 10
      expect(company).to be_valid
      company.vat = 20
      expect(company).to be_valid
    end
  end

  describe 'start_activity' do
    it 'is not valid without start_activity' do
      company = Company.new(subject)
      company.start_activity = nil
      expect(company).to_not be_valid
    end
  
    it 'is not valid with start_activity assign to tomorrow' do
      company = Company.new(subject)
      company.start_activity = Date.today + 1
      expect(company).to_not be_valid
    end
  end

  describe "zip_code" do
    it 'is not valid without zip_code' do
      company = Company.new(subject)
      company.zip_code = nil
      expect(company).to_not be_valid
    end

    it 'is not valid with number smaller or bigger' do
      company = Company.new(subject)
      company.zip_code = 01000
      expect(company).to_not be_valid
      company.zip_code = 355555
      expect(company).to_not be_valid
    end
  end

  describe "code APE" do
    it 'is not valid without code_ape' do
      company = Company.new(subject)
      company.code_ape = nil
      expect(company).to_not be_valid
    end

    it 'is not valid with wrong structure number' do
      company = Company.new(subject)
      company.code_ape = "62010"
      expect(company).to_not be_valid
    end
  end
end 