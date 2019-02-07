require 'services/jobs/job'

##
# Contains methods for dealing with formatting operations
# into internal well understood data structures of the data
# retrieved from external job offers web services
module Adapter

  ##
  # Adapts an RSS feed data structure into an internal
  # representation of it.
  #
  # Specs of RSS [https://validator.w3.org/feed/docs/rss2.html]
  #
  # Params:
  #   feed:: the entire XML feed structure
  #   source:: a constant rapresenting the source
  def adapt_rss(feed, source)
    [].tap do |jobs|
      feed.items.each do |item|
        jobs.push(
            Job.new(:title => item.title,
                    :description => ActionView::Base.full_sanitizer.sanitize(item.description),
                    :uri => item.link, :source => source
            )
        )
      end
    end
  end


  ##
  # Adapts a list of a Jobs formatted JSONs
  # into a list of Jobs formatted into an internal representation of it
  #
  # Params:
  #   raw_jobs:: list of JSONJobs
  def adapt_github_json(raw_jobs)
    [].tap do |jobs|
      raw_jobs.each do |rawJob|
        jobs.push(
            Job.new(:title => rawJob.title,
                    :description => ActionView::Base.full_sanitizer.sanitize(rawJob.description),
                    :uri => rawJob.uri, :source => Sources::GITHUB
            )
        )
      end
    end

  end
end