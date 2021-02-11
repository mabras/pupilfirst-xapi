module PupilfirstXapi
  module Verbs
    COMPLETED             = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/completed', name: 'completed')
    COMPLETED_ASSIGNMENT  = Xapi.create_verb(id: 'https://w3id.org/xapi/dod-isd/verbs/completed-assignment', name: 'completed assignment')
    REGISTERED            = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/registered', name: 'registered')
  end
end
