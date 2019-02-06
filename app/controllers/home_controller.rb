# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

require 'services/data_manager/data_manager'
require 'services/jobs/jobs'

class HomeController < ApplicationController
  def collect_data
    session['data'] = Curriculum.new if session['data'] == nil
  end

  def update_data
    @data = session['data']
  end

  def jobs
    collector = Jobs::Service.new(%w('ruby python'), 'Italia')
    collector.collect
    @jobs = collector.jobs
  end
end
