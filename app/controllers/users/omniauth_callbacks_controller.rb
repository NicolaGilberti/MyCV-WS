require 'services/data_manager/data_manager'

##
# This class is the controller of the User model.
#
# Like the model is connected with the authorization/authentication steps.
# The callback route for each provider, after the establishment of the connection,
# is this class.
#
# Because the scopes and the fields were defined before the connection,
# here all the data are received and usable.
#
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Manager
  before_action :set_data
  after_action :set_session

  ##
  # This method is the final callback for Facebook
  def facebook
    update_from_facebook(request.env['omniauth.auth'], @data)
    render 'home/collect_data'
  end

  def github
    update_from_github(request.env['omniauth.auth'], @data)
    render 'home/collect_data'
  end

  def linkedin
    update_from_linkedin(request.env['omniauth.auth'], @data)
    render 'home/collect_data'
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end

  private

  def set_data
    @data = session['data']
  end

  def set_session
    session['data'] = @data
  end
end