require 'ostruct'
require 'net/http'
require 'open-uri'
require 'open_uri_redirections'

module Manager

  def update_from_facebook(auth, cv)
    cv['email'] = auth.info.email
    cv['password'] = Devise.friendly_token[0,20]
    cv['name'] = auth.info.name   # assuming the @cv model has a name
    cv['image'] = auth.info.image # assuming the @cv model has an image
    cv['location'] = auth.info.location
    cv['gender'] = auth.extra.raw_info.gender
    cv['birthday'] = auth.extra.raw_info.birthday
    cv['hometown'] = auth.extra.raw_info.hometown.name
    cv['age_range'] = auth.extra.raw_info.age_range.min

  end

  def update_from_github(auth, cv)
    cv['email'] = auth.info.email
    cv['password'] = Devise.friendly_token[0,20]
    cv['name'] = auth.info.name   # assuming the @cv model has a name
    cv['image'] = auth.info.image # assuming the @cv model has an image
    cv['biography'] = auth.extra.raw_info.bio
    token = auth.credentials.token
    tmp = Array.new

    uri = URI(auth.extra.raw_info.repos_url)

    repos = JSON.parse(open(uri.to_s, :allow_redirections => :all, 'Authentication' => "token #{token}").read)
    repos.each do |gitPr|
      if not gitPr['fork']
        uri = URI(gitPr['languages_url'])
        lang = JSON.parse(open(uri.to_s, :allow_redirections => :all, 'Authentication' => "token #{token}").read)
        lang.each do |key,_|
          tmp << key
        end
      end
    end
    $uriTmp = auth.extra.raw_info.starred_url.to_s
    $realUri = $uriTmp.gsub(/{(.*?)}/,'')

    starred = JSON.parse(open($realUri, :allow_redirections => :all, 'Authentication' => "token #{token}").read)
    starred.each do |gitPr|
      uri = URI(gitPr['languages_url'])
      lang = JSON.parse(open(uri.to_s, :allow_redirections => :all, 'Authentication' => "token #{token}").read)
      lang.each do |key,_|
        tmp << key
      end
    end
    cv['ITlanguages'] = tmp.uniq
  end

  def update_from_linkedin(auth, cv)
    cv['email'] = auth.info.email
    cv['password'] = Devise.friendly_token[0,20]
    cv['name'] = auth.info.first_name   # assuming the @cv model has a name
    cv['image'] = auth.info.picture_url # assuming the @cv model has an image
    cv['languageSpoken'] = auth.extra.raw_info.lastName.preferredLocale.country
  end
end

class Curriculum < OpenStruct
end
