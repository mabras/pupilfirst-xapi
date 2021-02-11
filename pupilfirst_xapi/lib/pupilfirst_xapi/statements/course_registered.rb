module PupilfirstXapi
  module Statements
    class CourseRegistered
      def call(actor_id:, resource_id:, **_)
        Xapi.create_statement(
          actor: PupilfirstXapi::Actor.new.call(actor_id),
          verb: Verbs::REGISTERED,
          object: object(resource_id).call
        )
      end

      private

      def object(resource_id)
        course = PupilfirstXapi.course_class.find(resource_id)
        PupilfirstXapi::Object.new(
          id: PupilfirstXapi.uri_for(course),
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
