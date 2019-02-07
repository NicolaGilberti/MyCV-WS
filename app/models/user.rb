##
# This class is generated with the Devise gem.
# It is used to manage the connection between social networks
# and the Rails application.
#
# Devise with this class and its initializer manage autoamtically the 3-legged connection
# to perform the authentication/authorization with the providers.
#
# The initializer command for the oauth connection:
# config.omniauth :provider, 'APP_ID', 'APP_SECRET', scope: 'scope_1,scope_2,...' [, extra_options]
class User < ActiveRecord::Base
  #attr_accessor :supportString, :supportJson
  #attr_accessible :supportString, :supportJson
  validates :provider, uniqueness: true
  devise  :registerable,:rememberable
  # :timeoutable,  :lockable, :trackable, :recoverable, :confirmable, :validatable
  devise :omniauthable , :omniauth_providers => [:facebook, :github, :linkedin]
  devise :database_authenticatable, :authentication_keys => [:provider]
end
