require 'rails_helper'

RSpec.describe Client, type: :model do
  subject {
    user = User.create!(
      first_name: "baba",
      last_name: 'Le roux',
      email: "test@gmail.com",
      password: "secret",
      phone_number: "06 06 06 06 06",
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
      code_ape: '6201Z',
    )

    attributes = {
      company: company,
      name: "Maurice",
      email: "maurice.jean@gmail.com"
    }
  }

  it 'client is valid with valid attributes' do
    client = Client.new(subject)
    expect(client).to be_valid
  end

  it 'should be not valid without name' do
    client = Client.new(subject)
    client.name = nil
    expect(client).to_not be_valid
  end

  describe "email attribute" do
    it 'should be not valid without email' do
      client = Client.new(subject)
      client.email = nil
      expect(client).to_not be_valid
    end

    it 'should be not valid with wrong email' do
      client = Client.new(subject)
      client.email = "/@gmail.com"
      expect(client).to_not be_valid
      client.email = "bernard@.com"
      expect(client).to_not be_valid
      client.email = "bernard.gmail.com"
      expect(client).to_not be_valid
    end 
  end 

  it "should be not valid without company references" do
    client = Client.new(subject)
    client.company = nil
    expect(client).to_not be_valid
  end
end