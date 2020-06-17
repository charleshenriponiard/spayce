class Mangopay::User
  include ActiveModel::Model

  attr_accessor :Email,
                :LegalRepresentativeEmail,
                :LegalRepresentativeFirstName,
                :LegalRepresentativeLastName,
                :LegalPersonType,
                :LegalRepresentativeBirthday,
                :LegalRepresentativeNationality,
                :LegalRepresentativeCountryOfResidence,
                :AddressLine1,
                :AddressLine2,
                :City,
                :PostalCode,
                :Country,
                :CompanyNumber,
                :Name

  def save
    MangoPay::LegalUser.create(legal_user)
  end

  def legal_user
    return {
      LegalRepresentativeEmail: self.LegalRepresentativeEmail,
      LegalRepresentativeFirstName: self.LegalRepresentativeFirstName,
      LegalRepresentativeLastName: self.LegalRepresentativeLastName,
      LegalRepresentativeAddress: {
        AddressLine1: self.AddressLine1,
        AddressLine2: self.AddressLine2,
        City: self.City,
        PostalCode: self.PostalCode,
        Country: self.Country
      },
      Name: self.Name,
      Email: self.Email,
      LegalRepresentativeBirthday: Date.parse(self.LegalRepresentativeBirthday).to_time.to_i,
      LegalRepresentativeNationality: self.LegalRepresentativeNationality,
      LegalRepresentativeCountryOfResidence: self.LegalRepresentativeCountryOfResidence,
      LegalPersonType: self.LegalPersonType,
      CompanyNumber: self.CompanyNumber,
    }
  end
end
