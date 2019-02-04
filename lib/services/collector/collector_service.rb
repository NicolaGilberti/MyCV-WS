require 'services/github/github'
require 'services/stackoverflow/stackoverflow'
require 'services/ac.uk/acuk'

module CollectorService
  class Jobs
    attr_accessor :therms, :location, :jobs
    attr_accessor :stackoverflow_service, :github_service, :acuk_service

    # required constructor
    def initialize(therms, location)
      @therms = therms
      @location = location
      @jobs = []
    end

    def fetch
      @jobs = shuffle(fetch_github[0..3] + fetch_stackoverflow[0..3] + fetch_acuk[0..3])
    end

    private
    def fetch_github
      @github_service = GithubService::Jobs.new(@therms.join('+'), @location)
      @github_service.fetch
      @github_jobs = @github_service.jobs
    end

    def fetch_stackoverflow
      @stackoverflow_service = StackoverflowService::Jobs.new(@therms.join('+'), @location)
      @stackoverflow_service.fetch
      @stackoverflow_jobs = @stackoverflow_service.jobs
    end

    def fetch_acuk
      @acuk_service = AcUKService::Jobs.new('')
      @acuk_service.fetch
      @acuk_jobs = @acuk_service.jobs
    end

    def shuffle(array)
      array.shuffle
    end
  end

end
