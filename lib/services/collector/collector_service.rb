require 'services/github/github'
require 'services/stackoverflow/stackoverflow'
require 'services/ac.uk/Service'

class CollectorService
  attr_accessor :therms, :location
  attr_accessor :github_jobs, :github_service
  attr_accessor :stackoverflow_jobs, :stackoverflow_service
  attr_accessor :acukJobs, :acukService

  # required constructor
  def initialize(therms, location)
    @therms = therms
    @location = location
    @github_jobs = []
    @stackoverflow_jobs = []
  end

  def fetch
    fetch_github
    fetch_stackoverflow
  end

  private
  def fetch_github
    @github_service = GithubService.new(@therms.join('+'), @location)
    @github_service.fetch
    @github_jobs = @github_service.jobs
  end

  def fetch_stackoverflow
    @stackoverflow_service = StackoverflowService.new(@therms.join('+'), @location)
    @stackoverflow_service.fetch
    @stackoverflow_jobs = @stackoverflow_service.jobs
  end

  def fetch_acuk

  end

end
