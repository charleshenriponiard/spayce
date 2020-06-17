require 'net/http'
require 'uri'
require 'rest-client'

module Mangopay
  class KycsController < ApplicationController
    def new
      raise MangopayError.new(message: "#mp_user_id can't be blank") if current_user.mp_user_id.blank?
      mp_user_id = current_user.mp_user_id
      uri = "https://api.sandbox.mangopay.com/v2.01/#{ENV["YOUR_CLIENT_ID"]}/users/#{mp_user_id}/kyc/documents/"
      body = { "Tag"=> "custom meta", "Type"=> "TEST"}
      headers = {'Content-Type' => 'application/json', 'Authorization' => "Basic #{ENV['YOUR_CLIENT_ID']}:#{ENV['MANGOPAY_KEY']}"}
      # response = http.request_post(uri, body.to_json)
      # http = Net::HTTP.new(uri)
      # http.use_ssl = true
      # request = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json',  'Authorization' => ENV["MANGOPAY_KEY"]})
      # request.body = body.to_json
      # response = http.request(request)
      a = RestClient.post(uri, body, headers)
      byebug
      # res = Net::HTTP.post URI(uri)
      # res.header = {"Content-Type" => "application/json", "API_KEY" => "#{ENV['MANGOPAY_KEY']}"}
      # res.body = { "Tag"=> "custom meta", "Type"=> "TEST"}.to_json

      # request = Net::HTTP::Post.new(uri)
      # request['Content-Type'] = "application/json"
      # request.body = { "Tag"=> "custom meta", "Type"=> "TEST"}.to_json
      # response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      #   http.request(request)
      # end
      
      # puts response.inspect
      # byebug
    
    end 

    def create

    end 
    
  end
end

