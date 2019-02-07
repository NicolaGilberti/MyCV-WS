##
# It is the class used to store data related to curriculum
# It is also attached to the Database if in the future those
# information will be persistent
class Curriculum < ActiveRecord::Base
  ##
  # Class method which takes the session and populates
  # the model with the data from the session
  def self.populate(data, curriculum)
    curriculum.email  = data['email']
    curriculum.password  = data['password']
    curriculum.name  = data['name']
    curriculum.image  = data['image']
    curriculum.location  = data['location']
    curriculum.gender  = data['gender']
    curriculum.birthday  = data['birthday']
    curriculum.hometown  = data['hometown']
    curriculum.age_range  = data['age_range']
    curriculum.biography  = data['biography']
    curriculum.it_languages  = data['it_languages']
    curriculum.language_spoken  = data['language_spoken']
    curriculum.facebook_auth  = data['facebook_auth']
    curriculum.github_auth  = data['github_auth']
    curriculum.linkedin_auth  = data['linkedin_auth']
    curriculum
  end
end
