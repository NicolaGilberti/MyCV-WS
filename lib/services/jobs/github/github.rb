require 'services/jobs/job'
require 'services/jobs/modules/adapter'
require 'open-uri'
require 'json'
require 'uri'

##
# It contains the service responsible with the collection
# of job offers from the GitHubJobs API [https://jobs.github.com/api].
# this source allows us to filter data by a :therm and :location.
module Github

  ##
  # It represents the service that actually interacts
  # with the outside web service. Moreover it adapts
  # and stores the data fetched.
  class Service
    include Adapter
    # Therm for the search
    attr_accessor :therm
    # Location for the search
    attr_accessor :location
    # List of stored jobs
    attr_accessor :jobs

    ##
    # Initializes the service with the parameters needed
    # for the API call and an empty list of jobs
    #
    # Params:
    #   therm:: therm used for the search
    #   location:: location for the search
    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
    end

    ##
    # It is the operation that actually fetches and adapts the
    # data from the source web service
    #
    # Params:
    #   opts:: options for the remote call
    def fetch(opts={})
      params = opts.merge(page: 0)
                   .map { |k, v| "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}" }
                   .join('&')

      json = JSON.parse(open("#{Sources::GITHUB}/positions.json?#{params}").read)

      raw_jobs = json.map { |job| Job.new(job) }
      @jobs = adapt_github_json(raw_jobs)
    end
  end
end