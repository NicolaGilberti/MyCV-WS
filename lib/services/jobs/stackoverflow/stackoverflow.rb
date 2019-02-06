require 'services/jobs/jobs'
require 'rss'
require 'open-uri'
require 'services/jobs/modules/rss_reader'

#feedLink: https://stackoverflow.com/jobs/feed?q=dfd&l=Italia&d=20&u=Km&r=true
# q => therm, l => location, r => remote, d => distance from location

module Stackoverflow
  class Service
    include RssReader
    attr_accessor :therm, :location, :jobs

    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
    end

    def fetch
      @jobs = fetch_rss(url, Sources::STACKOVERFLOW)
    end

    private

    def url
      "#{Sources::STACKOVERFLOW}/jobs/feed?q=#{@therm}&l=#{@location}&d=20&u=Km&r=true"
    end
  end
end
