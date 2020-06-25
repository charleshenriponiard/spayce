class Mangopay::Document
  include HTTParty
  include ActiveModel::Model

  attr_accessor :type, :mp_user_id, :file, :mp_document_id

  BASE = "https://api.sandbox.mangopay.com/v2.01/#{ENV["YOUR_CLIENT_ID"]}/"
  DOCUMENTS = [ "Identity proof", "Registration proof", "Articles proof", "Shereholder declaration", "Address proof" ]
  
  validates :type, presence: true
  validates :type, inclusion: { in: DOCUMENTS,  message: "%{value} n'est pas valide" }


  def create_document
    uri = "users/#{mp_user_id}/kyc/documents/"
    body = { "Type"=> "#{type.upcase.tr(" ", "_")}" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    response = self.class.post("#{BASE}#{uri}", body: body, headers: headers)
    self.mp_document_id = response["Id"].to_i
  end

  def create_file
    uri = "users/#{mp_user_id}/kyc/documents/#{mp_document_id}/pages/"
    body = { "File"=> "#{encoding_file}" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    response = self.class.post("#{BASE}#{uri}", body: body, headers: headers)
    return response
  end

  def submit_document
    uri = "users/#{mp_user_id}/kyc/documents/#{mp_document_id}"
    body = {  "Tag": "custom meta",
              "Status": "VALIDATION_ASKED" }.to_json
    headers = {
      'Content-Type' => 'application/json', 
      'Authorization' => "Basic #{encoding}"
    }
    response = self.class.put("#{BASE}#{uri}", body: body, headers: headers)
  end 

  # def get_docs
  #   uri = "/users/#{mp_user_id}/kyc/documents/"
  #   headers = {
  #     'Content-Type' => 'application/json', 
  #     'Authorization' => "Basic #{encoding}"
  #   }
  #   response = self.class.get("#{BASE}#{uri}", headers: headers)
  #   #<HTTParty::Response:0x7f9d0c1a2268 
  #   parsed_response={
  #     "Type"=>"IDENTITY_PROOF", "UserId"=>"82553758", "Id"=>"82570009", "Tag"=>nil, "CreationDate"=>1593002827, 
  #     "ProcessedDate"=>nil, "Status"=>"CREATED", "RefusedReasonType"=>nil, "RefusedReasonMessage"=>nil
  #   }, 
  #   @response=#<Net::HTTPOK 200 OK readbody=true>, 
  #   @headers={"date"=>["Wed, 24 Jun 2020 12:47:32 GMT"], "content-type"=>["application/json; charset=utf-8"], 
  #     "transfer-encoding"=>["chunked"], "connection"=>["close"], 
  #     "set-cookie"=>["__cfduid=df3cb9605fb19d2d9e183c6e7886dc0121593002851; expires=Fri, 24-Jul-20 12:47:31 GMT; path=/; domain=.mangopay.com; HttpOnly; SameSite=Lax"], 
  #     "cache-control"=>["no-cache"], "pragma"=>["no-cache"], "expires"=>["-1"], "x-ratelimit"=>["19", "49", "80", "98"], 
  #     "x-ratelimit-remaining"=>["2281", "4451", "8720", "105502"], 
  #     "x-ratelimit-reset"=>["1593003720", "1593004620", "1593006420", "1593089160"], 
  #     "cf-cache-status"=>["DYNAMIC"], "cf-request-id"=>["0387f796400000cd8b179e0200000001"], 
  #     "expect-ct"=>["max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""], 
  #     "server"=>["cloudflare"], "cf-ray"=>["5a868ed06fe0cd8b-CDG"]
  #     }>
  # end

  private

  def encoding
    Base64.strict_encode64("#{ENV['YOUR_CLIENT_ID']}:#{ENV['MANGOPAY_KEY']}")
  end

  def encoding_file
    Base64.strict_encode64("#{file.tempfile.read}")
  end
end