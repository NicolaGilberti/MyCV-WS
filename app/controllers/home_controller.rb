# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]
require 'services/collector/collector_service'

class HomeController < ApplicationController
  def index
  end

  def jobs
    collector = CollectorService::Jobs.new(%w('ruby python'), 'Italia')
    collector.fetch
    @jobs = collector.jobs
  end
end
