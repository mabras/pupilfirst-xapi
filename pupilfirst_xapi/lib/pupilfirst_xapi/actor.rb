module PupilfirstXapi
  class Actor
    def call(actor_id)
      actor = PupilfirstXapi.actor_class.find(actor_id)
      Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.display_name)
    end
  end
end
