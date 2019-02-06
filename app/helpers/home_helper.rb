module HomeHelper
  def logged_complete?(data)
    data['github_auth'] || data['facebook_auth'] || data['linkedin_auth']
  end
end
