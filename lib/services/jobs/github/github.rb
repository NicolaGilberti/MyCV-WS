require 'services/jobs/job'
require 'services/jobs/modules/adapter'
require 'ostruct'
require 'open-uri'
require 'json'
require 'uri'

module Github
  class Service
    include Adapter
    attr_accessor :therm, :location, :jobs

    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
    end

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