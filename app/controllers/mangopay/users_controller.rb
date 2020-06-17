module Mangopay
  class UsersController < ApplicationController
    def new
      @mp_user = MangoPay::LegalUser.new()
    end
  
    def create
      begin
      @mp_user = MangoPay::LegalUser.create(params_formated)
      current_user.update(mp_user_id: @mp_user["Id"].to_i)
      byebug
      redirect_to root_path
      rescue MangoPay::ResponseError => e
        @mp_errors = e
        render :new
      end 
    end
  
    private
  
    def mangopay_params
      params.require(:mangopay_users).permit(
        :Email,
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
      )
    end
  
    def params_formated
      params = mangopay_params
      return {
        LegalRepresentativeEmail: params["LegalRepresentativeEmail"],
        LegalRepresentativeFirstName: params["LegalRepresentativeFirstName"],
        LegalRepresentativeLastName: params["LegalRepresentativeLastName"],
        LegalRepresentativeAddress: {
          AddressLine1: params["AddressLine1"],
          AddressLine2: params["AddressLine2"],
          City: params["City"],
          PostalCode: params["PostalCode"],
          Country: params["Country"]
        },
        Name: params["Name"],
        Email: params["Email"],
        LegalRepresentativeBirthday: Date.strptime("01/01/2000", "%m/%d/%Y").to_time.to_i,
        LegalRepresentativeNationality: params["LegalRepresentativeNationality"],
        LegalRepresentativeCountryOfResidence: params["LegalRepresentativeCountryOfResidence"],
        LegalPersonType: params["LegalPersonType"],
        CompanyNumber: params["CompanyNumber"],
      }
    end
  end
end
