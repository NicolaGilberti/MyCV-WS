require 'services/jobs/github/github'
require 'services/jobs/stackoverflow/stackoverflow'
require 'services/jobs/ac.uk/acuk'

##
# Contains the service which aggregates and orchestrates the
# three micro services (Github, Stackoverflow, Jobs.ac.uk)
module Jobs

  ##
  # It is the service which integrates all the jobs
  # in just one list of jobs and selects only a little fraction
  # to be shown to the user
  class Service
    # the list of retrieved jobs
    attr_accessor :jobs

    ##
    # Initializes the service with the parameters needed
    # and the micro services
    #
    # Params:
    #   therm:: therm used for the search
    #   location:: location for the search
    def initialize(therms, location)
      @github = Github::Service.new(therms, location)
      @stackoverflow = Stackoverflow::Service.new(therms, location)
      @acuk = AcUk::Service.new('')
    end

    ##
    # Collects the data
    def collect
      @jobs = fetch
    end

    ##
    # Invokes the micro services to operate and stores all the retrieved data
    def fetch
      @github.fetch
      @stackoverflow.fetch
      @acuk.fetch
      @jobs = data.shuffle
    end

    private

    ##
    # Selects only a part of the results
    def data
      @github.jobs[0..3] + @stackoverflow.jobs[0..3] + @acuk.jobs[0..3]
    end
  end

end
