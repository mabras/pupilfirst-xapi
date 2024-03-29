module PupilfirstXapi
  module Verbs
    COMPLETED             = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/completed', name: 'completed')
    COMPLETED_ASSIGNMENT  = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/attempted', name: 'attempted')
    REGISTERED            = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/registered', name: 'registered')
    EARNED                = Xapi.create_verb(id: 'http://id.tincanapi.com/verb/earned', name: 'earned')
    VIDEO_STARTED         = Xapi.create_verb(id: 'http://activitystrea.ms/schema/1.0/start', name: 'start')
    VIDEO_ENDED           = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/watched', name: 'watched')
    STARTED               = Xapi.create_verb(id: 'http://adlnet.gov/expapi/verbs/initialized', name: 'initialized')
    VIEWED                = Xapi.create_verb(id: 'http://id.tincanapi.com/verb/viewed', name: 'viewed')
    ANSWERED              = Xapi.create_verb(id: 'https://w3id.org/xapi/dod-isd/verbs/answered', name: 'answered')
  end
end
