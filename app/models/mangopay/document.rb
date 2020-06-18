class Mangopay::Document
  include HTTParty
  include ActiveModel::Model

  attr_accessor :type, :mp_user_id, :file, :mp_document_id

  BASE = "https://api.sandbox.mangopay.com/v2.01/#{ENV["YOUR_CLIENT_ID"]}/"
  DOCUMENTS = [ "Identity proof", "Registration proof", "Articles proof", "Shereholder declaration", "Address proof" ]
  
  validates :type, presence: true
  validates :type, inclusion: { in: DOCUMENTS,  message: "%{value} n'est pas valide" }

  # has_one_attached :page

  def save
    uri = "users/#{mp_user_id}/kyc/documents/"
    body = { "Type"=> "#{type.upcase.tr(" ", "_")}" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    response = self.class.post("#{BASE}#{uri}", body: body, headers: headers)
    self.mp_document_id = response["Id"].to_i
  end

  def save_file
    uri = "users/#{mp_user_id}/kyc/documents/#{mp_document_id}/pages/"
    body = { "File"=> "#{encoding_file}" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    response = self.class.post("#{BASE}#{uri}", body: body, headers: headers)
  end 

  private

  def encoding
    Base64.strict_encode64("#{ENV['YOUR_CLIENT_ID']}:#{ENV['MANGOPAY_KEY']}")
  end

  def encoding_file
    Base64.strict_encode64("#{file}")
  end 

  
end