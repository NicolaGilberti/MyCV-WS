require 'open-uri'
require 'open_uri_redirections'
require 'services/jobs/modules/adapter'

##
# It contains operations about fetching RSS feeds
# directly from an online source.
# It uses the Adapter in order to adapt its own data.
module RssReader
  include Adapter

  ##
  # Performs an HTTP GET call, fetches the results
  # and parses the result into a well-known structure
  #
  # Params:
  #   url:: URL representing the source
  #   source:: constant representing the source
  def fetch_rss(url, source)
    open(url, :allow_redirections => :all) do |rss|
      adapt_rss(RSS::Parser.parse(rss), source)
    end
  end
end