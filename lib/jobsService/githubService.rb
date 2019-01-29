require 'jobsService/job'

class GithubService
  def initialize
  end

  def fetch(therm)
    rawJobs = Github::Jobs.positions(search: therm)
    adaptedJobs = adaptJobs(rawJobs)
    adaptedJobs
  end

  private

  def adaptJobs(rawJobs)
    adaptedJobs = []
    rawJobs.each do |rawJob|
      adaptedJob = Job.new(rawJob.title, rawJob.description)
      adaptedJobs.push(adaptedJob)
    end
    adaptedJobs
  end

end
