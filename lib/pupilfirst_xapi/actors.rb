module PupilfirstXapi
  module Actors
    def self.agent(actor)
      Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.name)
    end
  end
end
