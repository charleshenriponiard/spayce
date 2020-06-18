class Mangopay::Document
  include HTTParty
  include ActiveModel::Model

  attr_accessor :type, :mp_user_id, :error

  BASE = "https://api.sandbox.mangopay.com/v2.01/#{ENV["YOUR_CLIENT_ID"]}/"
  DOCUMENTS = [ "Identity proof", "Registration proof", "Articles proof", "Shereholder declaration", "Address proof" ]
  
  validates :type, presence: true
  validates :type, inclusion: { in: DOCUMENTS,  message: "%{value} n'est pas valide" }


  def save
    uri = "users/#{mp_user_id}/kyc/documents/"
    body = { "Type"=> "#{type.upcase.tr(" ", "_")}" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    return response = self.class.post("#{BASE}#{uri}", body: body, headers: headers)
  end 

  private

  def encoding
    Base64.strict_encode64("#{ENV['YOUR_CLIENT_ID']}:#{ENV['MANGOPAY_KEY']}")
  end 
end