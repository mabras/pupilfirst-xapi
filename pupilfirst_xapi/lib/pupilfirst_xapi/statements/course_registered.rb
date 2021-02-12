module PupilfirstXapi
  module Statements
    class CourseRegistered
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:, **_)
        actor = @repository.call(:user, actor_id)
        Xapi.create_statement(
          actor: Xapi.create_agent(agent_type: 'Agent', email: actor.email, name: actor.display_name),
          verb: Verbs::REGISTERED,
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
        ).tap do |obj|
          if course.ends_at.present?
            duration = ActiveSupport::Duration.build(course.ends_at - course.created_at).iso8601
            obj.with_extension("http://id.tincanapi.com/extension/planned-duration", duration)
          end
        end
      end
    end
  end
end
