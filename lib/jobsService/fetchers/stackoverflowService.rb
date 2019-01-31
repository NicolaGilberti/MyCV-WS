require 'jobsService/job'
require 'rss'
require 'open-uri'

#feedLink: https://stackoverflow.com/jobs/feed?q=dfd&l=Italia&d=20&u=Km&r=true
# q => therm, l => location, r => remote, d => distance from location

class StackoverflowService
  BASE_URL = 'https://stackoverflow.com'
  attr_accessor :jobs, :therm, :location

  def initialize(therm, location)
    @therm = therm
    @location = location
    @jobs = []
  end

  def fetch()
    url = "#{BASE_URL}/jobs/feed?q=#{@therm}&l=#{@location}&d=20&u=Km&r=true"
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      adapt(feed)
    end
  end

  private

  def adapt(feed)
    feed.items.each do |item|
      description = ActionView::Base.full_sanitizer.sanitize(item.description)
      @jobs.push(Job.new(item.title, description, item.link))
    end
  end

end
