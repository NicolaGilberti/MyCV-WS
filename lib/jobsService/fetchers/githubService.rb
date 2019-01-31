require 'jobsService/job'

class GithubService
  attr_accessor :jobs, :therm, :location

  def initialize(therm, location)
    @therm = therm
    @location = location
    @jobs = []
  end

  def fetch()
    adapt(Github::Jobs.positions(search: @therm, location: @location))
  end

  private

  def adapt(rawJobs)
    rawJobs.each do |rawJob|
      description = ActionView::Base.full_sanitizer.sanitize(rawJob.description)
      @jobs.push(Job.new(rawJob.title, description, rawJob.url))
    end
  end

end
