Ebay::Api.configure do |ebay|
  ebay.auth_token = ENV['EBAY_AUTH_TOKEN']
  ebay.dev_id = ENV['EBAY_DEV_ID']
  ebay.app_id = ENV['EBAY_APP_ID']
  ebay.cert = ENV['EBAY_CERT_ID']

  ebay.use_sandbox = !Rails.env.production?
end