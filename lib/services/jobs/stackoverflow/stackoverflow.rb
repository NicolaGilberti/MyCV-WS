require 'services/jobs/jobs'
require 'rss'
require 'open-uri'
require 'services/jobs/modules/rss_reader'

#feedLink:
# q => therm, l => location, r => remote, d => distance from location

##
# Contains the service used to interact with
# Stackoverflow RSS jobs feed web service
#
# Example:
# [https://stackoverflow.com/jobs/feed?q=dfd&l=Italia&d=20&u=Km&r=true]
module Stackoverflow

  ##
  # It is the service which deals with operations of
  # connecting, querying, fetching and adapting
  # job offers from Stackoverflow source
  class Service
    include RssReader
    # therm for the search
    attr_accessor :therm
    # location for the search
    attr_accessor :location
    # list of stored jobs
    attr_accessor :jobs

    ##
    # Initializes the service with a :therm used to query the
    # source, a :location and creates an empty list of jobs.
    #
    # Params:
    #   therm:: therm for the search (Ex. "remote developer")
    #   location:: location for the search of the jobs
    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
    end

    ##
    # Downloads the data from Stackoverflow web service.
    def fetch
      @jobs = fetch_rss(url, Sources::STACKOVERFLOW)
    end

    private

    ##
    # Just computes a dynamic and parametrized query to submit
    # to the remote web service
    def url
      "#{Sources::STACKOVERFLOW}/jobs/feed?q=#{@therm}&l=#{@location}&d=20&u=Km&r=true"
    end
  end
end
