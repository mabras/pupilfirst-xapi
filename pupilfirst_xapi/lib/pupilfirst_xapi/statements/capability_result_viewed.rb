module PupilfirstXapi
  module Statements
    class CapabilityResultViewed
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor             = @repository.call(:user, actor_id)
        capability_result = @repository.call(:capability_result, resource_id)
        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::VIEWED,
          object: Objects.capability_result_viewed(capability_result, @uri_for)
        )
      end
    end
  end
end
