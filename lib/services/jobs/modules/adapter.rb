require 'services/jobs/job'

module Adapter
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