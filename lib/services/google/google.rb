require "google/apis/jobs_v3"

# It doesn't work for now because I din't update my
# billing details on google :P
class GoogleService
  attr_accessor :jobs_client

  def initialize
    # instantiate the client
    @jobs_client = Google::Apis::JobsV3::CloudTalentSolutionService.new

    jobs_client.authorization = Google::Auth.get_application_default(
      "https://www.googleapis.com/auth/jobs"
    )

    # ProjectId to get company list
    default_project_id = "projects/sde-lab";
    # Request list of companies
    response = jobs_client.list_project_companies(default_project_id)

    # Print the request id
    puts "Request id : " + response.metadata.request_id

    # List all companies for your project
    puts "Companies: "
    if response.companies
      response.companies.each do |company|
        puts company.name
      end
    else
      puts "No companies found"
    end
  end

end
