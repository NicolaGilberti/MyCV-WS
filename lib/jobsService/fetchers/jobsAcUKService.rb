require 'jobsService/job'

# collecter of job offers from the site https://www.jobs.ac.uk/
# from this site job offers are collected by Academic Discipline
class JobsAcUKService
  include JobsAcUKConstants
  attr_accessor :jobs, :dicipline

  def initialize(discipline)
    choose(discipline)
  end

  def fetch()
    open(@discipline) do |rss|
      feed = RSS::Parser.parse(rss)
      adapt(feed)
    end
  end

  private

  # ToDo!
  def choose(discipline)
    @discipline = AGRICULTURE_FOOD_VETERINARY
  end

  def adapt(rawJobs)
    feed.items.each do |item|
      description = ActionView::Base.full_sanitizer.sanitize(item.description)
      @jobs.push(Job.new(item.title, description, item.link))
    end
  end

end

module JobsAcUKConstants
  AGRICULTURE_FOOD_VETERINARY = "https://www.jobs.ac.uk/jobs/agriculture-food-and-veterinary/?format=rss"
  ARCHITECTURE_BUILDING_PLANNING = "https://www.jobs.ac.uk/jobs/architecture-building-and-planning/?format=rss"
  BIOLOGICAL_SCIENCES = "https://www.jobs.ac.uk/jobs/architecture-building-and-planning/?format=rss"
end