require 'jobsService/fetchers/githubService'
require 'jobsService/fetchers/stackoverflowService'

class JobsService
  attr_accessor :therms, :location
  attr_accessor :githubJobs, :githubService
  attr_accessor :stackoverflowJobs, :stackoverflowService

  # required constructor
  def initialize(therms, location)
    @therms = therms
    @location = location
    @githubJobs = []
    @stackoverflowJobs = []
  end

  def fetchJobs
    fetchFromGithub()
    fetchFromStackoverflow()
  end

  private
  def fetchFromGithub()
    @githubService = GithubService.new(@therms.join('+'), @location)
    @githubService.fetch()
    @githubJobs = @githubService.jobs
  end

  def fetchFromStackoverflow()
    @stackoverflowService = StackoverflowService.new(@therms.join('+'), @location)
    @stackoverflowService.fetch()
    @stackoverflowJobs = @stackoverflowService.jobs
  end

end
