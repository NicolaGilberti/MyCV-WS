require 'services/jobs/github/github'
require 'services/jobs/stackoverflow/stackoverflow'
require 'services/jobs/ac.uk/acuk'

module Jobs
  class Service
    attr_accessor :jobs

    def initialize(therms, location)
      @github = Github::Service.new(therms, location)
      @stackoverflow = Stackoverflow::Service.new(therms, location)
      @acuk = AcUk::Service.new('')
    end

    def collect
      @jobs = fetch
    end

    def fetch
      @github.fetch
      @stackoverflow.fetch
      @acuk.fetch
      data.shuffle
    end

    private

    def data
      @github.jobs[0..3] + @stackoverflow.jobs[0..3] + @acuk.jobs[0..3]
    end
  end

end
