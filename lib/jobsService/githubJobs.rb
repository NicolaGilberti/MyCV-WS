class GithubJobs
  def initialize
  end

  def fetch(therm)
    Github::Jobs.positions(search: therm)
  end
end
