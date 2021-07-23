module PupilfirstXapi
  module Verbs
    COMPLETED             = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/completed', name: 'completed')
    COMPLETED_ASSIGNMENT  = Xapi.create_verb(id: 'https://w3id.org/xapi/dod-isd/verbs/completed-assignment', name: 'completed assignment')
    REGISTERED            = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/registered', name: 'registered')
    VIDEO_STARTED         = Xapi.create_verb(id: 'http://activitystrea.ms/schema/1.0/start', name: 'start')
    VIDEO_ENDED           = Xapi.create_verb(id: 'http://activitystrea.ms/schema/1.0/consume', name: 'consumed')
    STARTED               = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/initialized', name: 'initialized')
  end
end
