module PupilfirstXapi
  module Statements
    class TargetCompleted
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        submission = @repository.call(:timeline_event, resource_id)
        return unless submission.passed?

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::COMPLETED_ASSIGNMENT,
          object: Objects.target(submission.target, @uri_for.call(submission.target))
        )
      end
    end
  end
end
