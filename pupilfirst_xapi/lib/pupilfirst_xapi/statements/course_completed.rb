module PupilfirstXapi
  module Statements
    class CourseCompleted
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        course = @repository.call(:course, resource_id)

        Xapi.create_statement(
          actor: Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.name),
          verb: Verbs::COMPLETED,
          object: Objects.course(course, @uri_for.call(course))
        )
      end
    end
  end
end
