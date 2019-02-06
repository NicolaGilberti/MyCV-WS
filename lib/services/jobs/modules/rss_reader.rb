require 'open-uri'
require 'open_uri_redirections'
require 'services/jobs/modules/adapter'

module RssReader
  include Adapter

  def fetch_rss(url, source)
    open(url, :allow_redirections => :all) do |rss|
      adapt_rss(RSS::Parser.parse(rss), source)
    end
  end
end