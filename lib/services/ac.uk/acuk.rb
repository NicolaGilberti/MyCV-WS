require 'services/job'
require 'services/ac.uk/constants'
require 'services/modules/rss_reader'

# collector of job offers from the site https://www.jobs.ac.uk/
# from this site job offers are collected by Academic Discipline
module AcUKService
  class Jobs
    include JobsAcUKConstants
    include RssReader
    include JobSource
    attr_accessor :jobs, :uri, :feed

    def initialize(discipline)
      @jobs = []
      @uri = choose_url(discipline)
    end

    def fetch
      @jobs = fetch_rss(@uri, JobSource::ACUK)
    end

    private

    # ToDo!
    def choose_url(discipline)
      AGRICULTURE_FOOD_VETERINARY
    end

  end

end

