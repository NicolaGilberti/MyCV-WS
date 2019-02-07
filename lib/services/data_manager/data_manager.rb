require 'ostruct'
require 'http'

##
# It contains methods to deal with integration personal data
# about the user, retrieved from the social networks. Actually
# those methods are performed by
# Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
module Manager

  ##
  # Takes data from facebook and stores them in the
  # input attribute.
  #
  # Params:
  #   auth:: the json retrieved from Fecebook
  #   cv:: the variable where to store the data
  def update_from_facebook(auth, cv)
    cv['email'] = auth.info.email if auth.info.email
    cv['password'] = Devise.friendly_token[0,20] if Devise.friendly_token[0,20]
    cv['name'] = auth.info.name if auth.info.name
    cv['image'] = auth.info.image if auth.info.image
    cv['location'] = auth.info.location if auth.info.location
    cv['gender'] = auth.extra.raw_info.gender if auth.extra.raw_info.gender
    cv['birthday'] = auth.extra.raw_info.birthday if auth.extra.raw_info.birthday
    cv['hometown'] = auth.extra.raw_info.hometown.name if auth.extra.raw_info.hometown.name
    cv['age_range'] = auth.extra.raw_info.age_range.min if auth.extra.raw_info.age_range
    cv['facebook_auth'] = true
  end

  ##
  # Takes data from Git Hub and stores them in the
  # input attribute. Moreover it performs other HTTP calls
  # to the source, in order to retrieve other data related
  # to the user and integrates them in the passed variable.
  #
  # Params:
  #   auth:: the json retrieved from Git Hub
  #   cv:: the variable where to store the data
  def update_from_github(auth, cv)
    cv['email'] = auth.info.email if auth.info.email
    cv['password'] = Devise.friendly_token[0,20] if Devise.friendly_token[0,20]
    cv['name'] = auth.info.name if auth.info.name
    cv['image'] = auth.info.image if auth.info.image
    cv['biography'] = auth.extra.raw_info.bio if auth.extra.raw_info.bio
    token = auth.credentials.token if auth.credentials.token
    tmp = Array.new

    uri = URI(auth.extra.raw_info.repos_url)

    #repos = JSON.parse(open(uri.to_s, 'Authentication' => "token #{token}").read)

    HTTP.auth("token #{token}")
    repos = JSON.parse(HTTP.get(uri.to_s).body)

    repos.each do |gitPr|
      if not gitPr['fork']
        uri = URI(gitPr['languages_url'])
        lang = JSON.parse(HTTP.get(uri.to_s).body)
        lang.each do |key,_|
          tmp << key
        end
      end
    end
    $uriTmp = auth.extra.raw_info.starred_url.to_s
    $realUri = $uriTmp.gsub(/{(.*?)}/,'')

    starred = JSON.parse(HTTP.get($realUri).body)
    starred.each do |gitPr|
      uri = URI(gitPr['languages_url'])
      lang = JSON.parse(HTTP.get(uri.to_s).body)
      lang.each do |key,_|
        tmp << key
      end
    end
    cv['it_languages'] = tmp.uniq
    cv['github_auth'] = true
  end

  ##
  # Takes data from Linkedin and stores them in the
  # input attribute.
  #
  # Params:
  #   auth:: the json retrieved from Git Hub
  #   cv:: the variable where to store the data
  def update_from_linkedin(auth, cv)
    cv['email'] = auth.info.email if auth.info.email
    cv['password'] = Devise.friendly_token[0,20] if Devise.friendly_token[0,20]
    cv['name'] = auth.info.first_name if auth.info.first_name
    cv['image'] = auth.info.picture_url if auth.info.picture_url
    cv['language_spoken'] = auth.extra.raw_info.lastName.preferredLocale.country if auth.extra.raw_info.lastName.preferredLocale.country
    cv['linkedin_auth'] = true
  end

end
