# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

require 'services/jobs/jobs'

class HomeController < ApplicationController
  def collect_data
    session['data'] = Curriculum.new if session['data'] == nil
  end

  def update_data
    @curriculum = Curriculum.populate(session['data'], Curriculum.new)
  end

  def jobs
    @curriculum = Curriculum.new(curriculum_params)
    collector = Jobs::Service.new(@curriculum.it_languages, @curriculum.location)
    collector.collect
    @jobs = collector.jobs
  end

  def generate_cv
    @position = params['position']
    @xml = `curl http://compagniadenoialtri.altervista.org/enrico/sde/europass/api.php`
  end

  private
  def curriculum_params
    params.require(:curriculum).permit!
  end
end
