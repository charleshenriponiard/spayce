class MangopayUsersController < ApplicationController

  def new
    @mp_user = MangoPay::NaturalUser.new()
  end

  def create
    @mp_user = MangoPay::NaturalUser.create(params_formated)
    until @mp_user.blank?
      redirect_to root_path
    else
      render :new
    end 
  end

  private

  def mangopay_params
    params.require(:mangopay_users).permit(
      :Tag,
      :Email,
      :FirstName,
      :LastName,
      :Address,
      :AddressLine1,
      :AddressLine2,
      :City,
      :Region,
      :PostalCode,
      :Country,
      :Birthday,
      :BirthPlace,
      :Nationality,
      :CountryOfRestsidance,
      :Occupation,
      :InComeRange
    )
  end

  def params_formated
    params = mangopay_params
    byebug
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
      Birthday: Date.parse('01-01-2000').to_time.to_i,
      Birthplace: 'Paris',
      Nationality: 'FR',
      CountryOfResidence: 'FR',
      Occupation: 'Worker',
      IncomeRange: 1
    }
  end 
  
end 