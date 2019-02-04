require 'services/job'
require 'rss'
require 'open-uri'
require 'services/modules/rss_reader'

#feedLink: https://stackoverflow.com/jobs/feed?q=dfd&l=Italia&d=20&u=Km&r=true
# q => therm, l => location, r => remote, d => distance from location

module StackoverflowService
  class Jobs
    include RssReader
    include JobSource
    attr_accessor :jobs, :therm, :location, :url
    BASE_URL = 'https://stackoverflow.com'

    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
      @url = "#{BASE_URL}/jobs/feed?q=#{@therm}&l=#{@location}&d=20&u=Km&r=true"
    end

    def fetch
      @jobs = fetch_rss(@url, JobSource::STACKOVERFLOW)
    end
  end
end
