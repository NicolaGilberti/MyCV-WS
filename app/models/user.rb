class User < ActiveRecord::Base
  #attr_accessor :supportString, :supportJson
  #attr_accessible :supportString, :supportJson
  validates :provider, uniqueness: true
  devise  :registerable,:rememberable
  # :timeoutable,  :lockable, :trackable, :recoverable, :confirmable, :validatable
  devise :omniauthable , :omniauth_providers => [:facebook, :github, :linkedin]
  devise :database_authenticatable, :authentication_keys => [:provider]

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.provider = data['provider'] if user.provider.blank?
      end
      if (data = session['devise.github_data']) && session['devise.github_data']['extra']['raw_info']
        user.provider = data['provider'] if user.provider.blank?
      end
      if (data = session['devise.linkedin_data']) && session['devise.linkedin_data']['extra']['raw_info']
        user.provider = data['provider'] if user.provider.blank?
      end
    end
  end

  def self.create_from_facebook_data(auth)
    #where(:provider => auth.provider, :uid => auth.uid).first_or_create do |user|
    find_or_create_by(:provider => auth.provider, :uid => auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.location = auth.info.location
      user.gender = auth.extra.raw_info.gender
      user.birthday = auth.extra.raw_info.birthday
      user.hometown = auth.extra.raw_info.hometown.name
      user.age_range = auth.extra.raw_info.age_range.min
    end
  end

  def self.create_from_github_data(auth)
    #where(:provider => auth.provider, :uid => auth.uid).first_or_create do |user|
    find_or_create_by(:provider => auth.provider, :uid => auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.biography = auth.extra.raw_info.bio
      tmp = Array.new
      JSON.parse(Net::HTTP.get(URI(auth.extra.raw_info.repos_url))).each do |gitPr|
        if not gitPr['fork']
          JSON.parse(Net::HTTP.get(URI(gitPr['languages_url']))).each do |key,_|
            tmp << key
          end
        end
      end
      $uriTmp = auth.extra.raw_info.starred_url.to_s
      $realUri = $uriTmp.gsub(/{(.*?)}/,'')
      JSON.parse(Net::HTTP.get(URI($realUri))).each do |gitPr|
        JSON.parse(Net::HTTP.get(URI(gitPr['languages_url']))).each do |key,_|
          tmp << key
        end
      end
      user.ITlanguages = tmp.uniq
    end
  end

  def self.create_from_linkedin_data(auth)
    #where(:provider => auth.provider, :uid => auth.uid).first_or_create do |user|
    find_or_create_by(:provider => auth.provider, :uid => auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.first_name   # assuming the user model has a name
      user.image = auth.info.picture_url # assuming the user model has an image
      user.languageSpoken = auth.extra.raw_info.lastName.preferredLocale.country
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
