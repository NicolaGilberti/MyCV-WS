require 'services/job'
require 'ostruct'
require 'open-uri'
require 'json'
require 'uri'

module GithubService
  class GJob < OpenStruct
    def ==(other)
      self.id == other.id
    end
  end

  class Jobs
    attr_accessor :jobs, :therm, :location

    def initialize(therm, location)
      @therm = therm
      @location = location
      @jobs = []
    end

    def fetch(opts={})
      params = opts.merge(page: 0)
                   .map { |k, v| "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}" }
                   .join('&')

      json = JSON.parse(open("https://jobs.github.com/positions.json?#{params}").read)

      raw_jobs = json.map { |job| GithubService::GJob.new(job) }
      adapt(raw_jobs)
    end

    private

    def adapt(raw_jobs)
      raw_jobs.each do |rawJob|
        description = ActionView::Base.full_sanitizer.sanitize(rawJob.description)
        @jobs.push(Job.new(rawJob.title, description, rawJob.uri, JobSource::GITHUB))
      end
    end
  end
end