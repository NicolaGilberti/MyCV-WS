# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]
require 'jobsService/jobsService'

class HomeController < ApplicationController
  def index
  end

  def jobs
    jobsService = JobsService.new(['ruby', 'python'], 'Italia')
    jobsService.fetchJobs()
    @githubJobs = jobsService.githubJobs
    @stackoverflowJobs = jobsService.stackoverflowJobs
  end
end
