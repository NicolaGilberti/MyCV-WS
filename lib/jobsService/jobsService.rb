require 'jobsService/githubJobs'

class JobsService

  # required constructor
  def initialize
    @githubJobs = GithubJobs.new
  end

  def fetchGithubJobs(therm)
    @githubJobs.fetch(therm)
  end

end
