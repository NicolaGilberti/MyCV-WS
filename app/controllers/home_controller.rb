# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]

# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

class HomeController < ApplicationController
  def index
  end
end