require 'services/jobs/job'
require 'services/jobs/ac.uk/constants'
require 'services/jobs/modules/rss_reader'

# collector of job offers from the site https://www.jobs.ac.uk/
# from this site job offers are collected by Academic Discipline
module AcUk
  class Service
    include JobsAcUKConstants
    include RssReader
    attr_accessor :discipline, :jobs

    def initialize(discipline)
      @jobs = []
      @discipline = discipline
    end

    def fetch
      @jobs = fetch_rss(url(@discipline), Sources::ACUK)
    end

    private

    # ToDo!
    def url(discipline)
      AGRICULTURE_FOOD_VETERINARY
    end
  end
end

