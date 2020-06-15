class MangopayUsersController < ApplicationController
  def new
    @mp_user = MangoPay::NaturalUser.new()
  end

  def create
    begin
    @mp_user = MangoPay::NaturalUser.create(params_formated)
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
      :FirstName,
      :LastName,
      :Birthday,
      :BirthPlace,
      :Nationality,
      :CountryOfResidence,
      :AddressLine1, 
      :AddressLine2, 
      :City, 
      :PostalCode,
      :Country
    )
  end

  def params_formated
    params = mangopay_params
    return {
      Email: params["Email"],
      FirstName: params["FirstName"],
      LastName: params["LastName"],
      Address: {
        AddressLine1: params["AddressLine1"],
        AddressLine2: params["AddressLine2"],
        City: params["City"],
        PostalCode: params["PostalCode"],
        Country: params["Country"]
      },
      Birthday: Date.parse('01-01-1999').to_time.to_i,
      Birthplace: params["Birthday"],
      Nationality: params["Nationality"],
      CountryOfResidence: params["CountryOfResidence"]
    }
  end
end