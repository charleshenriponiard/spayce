require "base64"

module Mangopay
  class KycsController < ApplicationController
    include HTTParty

    def new
      raise MangopayError.new(message: "#mp_user_id can't be blank") if current_user.mp_user_id.blank?

      mp_user_id = current_user.mp_user_id
      uri = "https://api.sandbox.mangopay.com/v2.01/#{ENV["YOUR_CLIENT_ID"]}/users/#{mp_user_id}/kyc/documents/"
      body = { "Type"=> "REGISTRATION_PROOF" }.to_json
      headers = {
        'Content-Type' => 'application/json', 
        'Authorization' => "Basic #{encoding}"
      }
      response  = self.class.post(uri, body: body, headers: headers)
    end 

    private 

    def encoding
      Base64.strict_encode64("#{ENV['YOUR_CLIENT_ID']}:#{ENV['MANGOPAY_KEY']}")
    end 
    
  end
end

