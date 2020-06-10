MangoPay.configure do |c|
    c.preproduction = true
    c.client_id = ENV['YOUR_CLIENT_ID']
    c.client_apiKey = ENV['MANGOPAY_KEY']
    c.http_timeout = 10000
  end