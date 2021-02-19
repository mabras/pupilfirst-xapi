module PupilfirstXapi
  module Statements
    class CourseCompleted
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        Xapi.create_statement(
          actor: Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.name),
          verb: Verbs::COMPLETED,
          object: object(resource_id).call
        )
      end

      private

      def object(resource_id)
        course = @repository.call(:course, resource_id)
        PupilfirstXapi::Object.new(
          id: @uri_for.call(course),
          type: 'http://adlnet.gov/expapi/activities/product',
          name: course.name,
          description: course.description
        )
      end
    end
  end
end
