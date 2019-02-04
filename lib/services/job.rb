class Job
  attr_accessor :title, :description, :uri, :source

  def initialize(title, description, uri, source)
    @title = title
    @description = description
    @uri = uri
    @source = source
  end
end

module JobSource
  GITHUB = 0
  STACKOVERFLOW = 1
  ACUK = 2
end
