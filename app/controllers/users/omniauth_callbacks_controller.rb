require 'services/data_manager/data_manager'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Manager
  before_action :set_data
  after_action :set_session

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