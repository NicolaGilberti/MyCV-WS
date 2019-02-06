class User < ActiveRecord::Base
  #attr_accessor :supportString, :supportJson
  #attr_accessible :supportString, :supportJson
  validates :provider, uniqueness: true
  devise  :registerable,:rememberable
  # :timeoutable,  :lockable, :trackable, :recoverable, :confirmable, :validatable
  devise :omniauthable , :omniauth_providers => [:facebook, :github, :linkedin]
  devise :database_authenticatable, :authentication_keys => [:provider]
end
