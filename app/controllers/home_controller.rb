# Just a NOTE:
# in order to read encrypted credentials
# Rails.application.credentials.aws[:access_key_id]


# If u want to add environments (just add them as we were doing in old secrets)
# Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]

require 'services/jobs/jobs'
require 'open-uri'
require 'net/http'

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
    # data = `curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '#{json(nil)}'  http://compagniadenoialtri.altervista.org/enrico/sde/europass/api.php`.to_s

    @data = `curl http://compagniadenoialtri.altervista.org/enrico/sde/europass/api.php`.to_s
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

  def json(data)
    %q{
    {
  "firstName": "Gigi",
  "surname": "Babbuino",
  "addressLine": "Via Palazzi 106",
  "postalCode": "36090",
  "municipality": "",
  "country": {
    "code": "IT",
    "label": "Italy"
  },
  "email": "gigi.babbuino@mail.com",
  "telephoneList": [
    {
      "contact": "+39 3259984572",
      "use": {
        "code": "mobile",
        "label": "Mobile"
      }
    },
    {
      "contact": "+39 3259984571",
      "use": {
        "code": "home",
        "label": "Home"
      }
    }
  ],
  "birthday": "1980-04-11",
  "gender": {
    "code": "M",
    "label": "Male"
  },
  "photo": "", // Da vedere
  "job": "Resource assistant",
  "workExperienceList": [
    {
      "from": "2002-08",
      "to": "",
      "current": "true",
      "position": "Head CEO of things",
      "activities": "I did things and stuff",
      "employer": {
        "name": "Agency of BABA",
        "addressLine": "Via Palazzi 106",
        "postalCode": "36090",
        "municipality": "",
        "country": {
          "code": "IT",
          "label": "Italy"
        }
      }
    },
    {
      "from": "2002-03",
      "to": "2002-07",
      "current": "false",
      "position": "Not head CEO of things",
      "activities": "I did things and stuff but worse",
      "employer": {
        "name": "Agency of BABA",
        "addressLine": "Via Palazzi 106",
        "postalCode": "36090",
        "municipality": "",
        "country": {
          "code": "IT",
          "label": "Italy"
        }
      }
    }
  ],
  "educationList": [
    {
      "from": "1997",
      "to": "2001",
      "current": "false",
      "title": "PhD - Thesis title: 'How to eat seagulls'",
      "activities": "Lots of stuffs and sss",
      "organization": {
        "name": "University of BABABA",
        "municipality": "",
        "country": {
          "code": "IT",
          "label": "Italy"
        }
      }
    },
    {
      "from": "1993",
      "to": "1997",
      "current": "false",
      "title": "Bachelor in stuff",
      "organization": {
        "name": "High School of BABABA",
        "municipality": "",
        "country": {
          "code": "IT",
          "label": "Italy"
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
