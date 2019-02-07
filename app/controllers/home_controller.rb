# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

require 'services/jobs/jobs'
require 'open-uri'
require 'net/http'
require 'base64'

class HomeController < ApplicationController
  def collect_data
    session['data'] = Curriculum.new if session['data'] == nil
  end

  def update_data
    @curriculum = Curriculum.populate(session['data'], Curriculum.new)
    session['data'] = @curriculum
  end

  def jobs

    @curriculum = Curriculum.new(curriculum_params)

    session['data'] = @curriculum

    collector = Jobs::Service.new(@curriculum.it_languages, @curriculum.location)
    collector.collect
    @jobs = collector.jobs
  end

  def generate_cv
    @position = params['position']
    # data = `curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '#{json(nil)}'  http://compagniadenoialtri.altervista.org/enrico/sde/europass/api.php`.to_s
    @image = Base64.encode64(open(session['data']['image']).to_a.join).gsub("\n", '')
    #hash = JSON.parse(json)
    #_json = compile(hash, session['data'])

    #@data = `curl http://compagniadenoialtri.altervista.org/enrico/sde/europass/api.php`.to_s
    #download = post_xml('https://europass.cedefop.europa.eu/rest/v1/document/to/pdf-cv', data)
    #IO.copy_stream(download, '/tmp/my_file.pdf')

  end

  private
  def curriculum_params
    params.require(:curriculum).permit!
  end

  def post_xml(url_string, xml_string)
    uri = URI.parse url_string
    request = Net::HTTP::Post.new uri.path
    request.body = xml_string
    request.content_type = 'text/xml'
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
    response.body
  end

  def json
    %q{
    {
  "firstName": "",
  "surname": "",
  "addressLine": "",
  "postalCode": "",
  "municipality": "",
  "country": {
    "code": "",
    "label": ""
  },
  "email": "",
  "telephoneList": [
    {
      "contact": "",
      "use": {
        "code": "mobile",
        "label": "Mobile"
      }
    },
    {
      "contact": "",
      "use": {
        "code": "home",
        "label": "Home"
      }
    }
  ],
  "birthday": "",
  "gender": {
    "code": "",
    "label": ""
  },
  "photo": "", // Da vedere
  "job": "",
  "workExperienceList": [
    {
      "from": "",
      "to": "",
      "current": "",
      "position": "",
      "activities": "",
      "employer": {
        "name": "",
        "addressLine": "",
        "postalCode": "",
        "municipality": "",
        "country": {
          "code": "",
          "label": ""
        }
      }
    }
  ],
  "educationList": [
    {
      "from": "",
      "to": "",
      "current": "",
      "title": "",
      "activities": "",
      "organization": {
        "name": "",
        "municipality": "",
        "country": {
          "code": "",
          "label": ""
        }
      }
    }
  ],
  "skills": {
    "linguistic": [
      {
        "description": {
          "code": "IT",
          "label": "Italian"
        },
        "proficiency": {
          "listening": "A1",
          "reading": "C2",
          "spokenInteraction": "B2",
          "spokenProduction": "C4",
          "writing": "C2"
        },
        "verifiedBy": "GIGI"
      }
    ],
    "communication": "Boring text.",
    "organisational": "Boring text v2.0",
    "computer": "Super boring text.",
    "other": "I do stuff i guess.",
    "driving": ["A", "B"]
  },
  "achievementList": [
    {
      "title": {
        "code": "publications",
        "label": "Publications"
      },
      "description": "AIJYUAGYGSUYGIAGAUGUAGUYAGUYAGUGAU"
    }
  ],
  "options": {
    "language": "en"
  }
}
    }
  end
end
