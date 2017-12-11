Apipie.configure do |config|
  config.app_name                = "Student"
  config.copyright               = "&copy; 2017 Treeni Sustainability Solutions"
  config.api_base_url            = "/"
  config.doc_base_url            = "/apipie"
  config.app_info                = "STUDENT CURD"
  # where is your API defined?
  config.translate = false
  #   config.authenticate = Proc.new do
  #    authenticate_or_request_with_http_basic do |username, password|
  #      username == "sai" && password == "sai"
  #   end
  # end

  # config.authorize = Proc.new do |controller, method, doc|
  #   !method   # show all controller doc, but no method docs.
  # end
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
