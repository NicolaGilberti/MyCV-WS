require 'services/jobs/job'
require 'services/jobs/ac.uk/constants'
require 'services/jobs/modules/rss_reader'

# AcUk Module contains the service which is responsible
# of collecting job offers from the web service [https://www.jobs.ac.uk/]
# This source service publishes its job offers using an RSS feed system
# and categorizing them by Academic Discipline.
module AcUk
  # It is the service that deals with operations about fetching
  # and storing data from Jobs.ac.uk
  class Service
    include JobsAcUKConstants
    include RssReader
    # The URL related to the chosen discipline
    attr_accessor :discipline_url
    # The list of fetched jobs
    attr_accessor :jobs

    # Initializes the service with an empty list of jobs
    # and chooses an academic discipline type which
    # will be used to fetch related jobs.
    #
    # Params:
    #   discipline:: academic discipline of the user
    def initialize(discipline)
      @jobs = []
      @discipline_url = url(discipline)
    end

    # Fetches the data from the source service and stores
    # the actual list of jobs internally.
    def fetch
      @jobs = fetch_rss(@discipline_url, Sources::ACUK)
    end

    private

    # It should choose the right feed url using the selected discipline.
    # In our case it was not possible to have this information, and the user
    # should insert it manually. (easy extensible)
    #
    # Params:
    #   discipline:: academic discipline of the user
    def url(discipline)
      COMPUTER_SCIENCES
    end
  end
end

