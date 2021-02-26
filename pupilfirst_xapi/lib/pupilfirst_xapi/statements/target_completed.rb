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
          actor: Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.name),
          verb: Verbs::COMPLETED_ASSIGNMENT,
          object: object(submission.target).call
        )
      end

      private

      def object(target)
        PupilfirstXapi::Object.new(
          id: @uri_for.call(target),
          type: "http://activitystrea.ms/schema/1.0/task",
          name: target.title,
          description: target.description
        )
      end
    end
  end
end
