# Stores the constants relative to the provenience of the
# collected jobs by the Jobs::Service. Moreover it is used
# to differentiate data by views.
module Sources
  # Git Hub:: 'https://jobs.github.com'
  GITHUB =  'https://jobs.github.com'
  # Stack Overflow:: 'https://stackoverflow.com'
  STACKOVERFLOW = 'https://stackoverflow.com'
  # Jobs.ac.uk:: 'https://www.jobs.ac.uk'
  ACUK = 'https://www.jobs.ac.uk'
end


# It models an internal structure representation of
# a well-formatted. This class inherits from OpenStruct
# [https://ruby-doc.org/stdlib-2.4.1/libdoc/ostruct/rdoc/OpenStruct.html]
# which essentially is similar to a Hash, that allows the
# definition of arbitrary attributes with their accompanying values.
class Job < OpenStruct
end
