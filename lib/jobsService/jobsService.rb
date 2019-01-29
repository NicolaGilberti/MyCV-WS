require 'jobsService/githubService'

class JobsService

  # required constructor
  def initialize
    @githubService = GithubService.new
  end

  def fetchJobs(therms)
    jobs = []
    therms.each do |therm|
      githubJobs = fetchGithubJobs(therm)
      jobs += githubJobs
    end
    jobs
  end

  private
  def fetchGithubJobs(therm)
    @githubService.fetch(therm)
  end

end
