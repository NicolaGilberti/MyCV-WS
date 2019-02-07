# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

require 'services/jobs/jobs'
require 'open-uri'
require 'net/http'
require 'base64'

##
# It is the process which manages the application flow
# and session. It is the orchestrator of the internal services
# which stores and retrieves data from services for the user.
#
# The actual flow of the application is:
#   1. Collecting data from Social Networks Providers
#   2. Allow the user to visualize and modify the data
#   3. Retrieve and show a list of possible compatible job offers to apply for
#   4. Generate a PDF containing the CV of the user
class HomeController < ApplicationController

  ##
  # Initializes the session in order to make it populate later by
  # Devise and OAuth services then renders the root view of the system
  #
  #  It responds to:
  #     GET /home/collect_data
  def collect_data
    session['data'] = Curriculum.new if session['data'] == nil
  end

  ##
  # Populates the session and a model with data collected
  # from social networks and renders the update_data form
  #
  #  It responds to:
  #     POST /home/collect_data
  def update_data
    @curriculum = Curriculum.populate(session['data'], Curriculum.new)
    session['data'] = @curriculum
  end

  ##
  # Takes the updated data from the previous step,
  # initializes a Jobs::Service and performs its operations
  # in order to fetch some job offers and renders those Jobs offers
  #
  #  It responds to:
  #     POST /home/jobs
  def jobs
    @curriculum = Curriculum.new(curriculum_params)
    session['data'] = @curriculum
    collector = Jobs::Service.new(@curriculum.it_languages, @curriculum.location)
    collector.collect
    @jobs = collector.jobs
  end

  ##
  # It takes the chosen Type of Application for the CV, converts the image link
  # in base64 format and renders the Javascript view which accesses GetXML and Europass
  # services in order to generate and send the CV to the user
  #
  #  It responds to:
  #     GET /home/generate_cv/:position
  def generate_cv
    @position = params['position']
    @image = Base64.encode64(open(session['data']['image']).to_a.join).gsub("\n", '')
  end

  private

  ##
  # Just permitting only trusted parameters
  def curriculum_params
    params.require(:curriculum).permit!
  end
end
