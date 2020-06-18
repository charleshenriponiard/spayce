module Mangopay
  class UsersController < MangopaysController
    def new
      @mp_user = Mangopay::User.new
    end

    def create
      begin
      @mp_user = Mangopay::User.new(mangopay_user_params)
      created_user = @mp_user.save
      current_user.update(mp_user_id: created_user["Id"].to_i)
      redirect_to root_path
      rescue MangoPay::ResponseError => e
        @mp_errors = e
        render :new
      end
    end

    private

    def mangopay_user_params
      year = params.require(:mangopay_user)['LegalRepresentativeBirthday(1i)'].to_i
      params.require(:mangopay_user).delete('LegalRepresentativeBirthday(1i)')
      month = params.require(:mangopay_user)['LegalRepresentativeBirthday(2i)'].to_i
      params.require(:mangopay_user).delete('LegalRepresentativeBirthday(2i)')
      day =  params.require(:mangopay_user)['LegalRepresentativeBirthday(3i)'].to_i
      params.require(:mangopay_user).delete('LegalRepresentativeBirthday(3i)')

      params.require(:mangopay_user)['LegalRepresentativeBirthday'] = "#{day}-#{month}-#{year}"
      params.require(:mangopay_user).permit(
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
  end
end
