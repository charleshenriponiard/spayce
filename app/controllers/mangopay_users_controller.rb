class MangopayUsersController < ApplicationController
  def new
    @mp_user = MangoPay::NaturalUser.new()
  end

  def create
    @mp_user = MangoPay::NaturalUser.create(params_formated)
    # unless @mp_user.nil?
    #   redirect_to root_path
    # else
    #   render :new
    # end 
  end

  private

  def mangopay_params
    params.require(:mangopay_users).permit(
      :Tag,
      :Email,
      :FirstName,
      :LastName,
      :Birthday,
      :BirthPlace,
      :Nationality,
      :CountryOfResidence,
      :Occupation,
      :InComeRange,
      :AddressLine1, 
      :AddressLine2, 
      :City, 
      :Region, 
      :PostalCode,
      :Country
    )
  end

  def params_formated
    params = mangopay_params
    return {
      Tag: params["Tag"],
      Email: params["Email"],
      FirstName: params["FirstName"],
      LastName: params["LastName"],
      Address: {
        AddressLine1: params["AddressLine1"],
        AddressLine2: params["AddressLine2"],
        City: params["City"],
        Region: params["Region"],
        PostalCode: params["PostalCode"],
        Country: params["Country"]
      },
      Birthday: Date.parse('01-01-1999').to_time.to_i,
      Birthplace: params["Birthday"],
      Nationality: params["Nationality"],
      CountryOfResidence: params["CountryOfResidence"],
      Occupation: params["Occupation"],
      IncomeRange: params["IncomeRange"]
    }
  end
end 



# params[:Address] = {
#   AddressLine1: params["AddressLine1"],
#   AddressLine2: params["AddressLine2"],
#   City: params["City"],
#   Region: params["Region"],
#   PostalCode: params["PostalCode"],
#   Country: params["Country"]
# }