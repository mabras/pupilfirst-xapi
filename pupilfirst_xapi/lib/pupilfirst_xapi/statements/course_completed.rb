module PupilfirstXapi
  module Statements
    class CourseCompleted
      def call(actor_id:, resource_id:, **_)
        Xapi.create_statement(
          actor: PupilfirstXapi::Actor.new.call(actor_id),
          verb: Verbs::COMPLETED,
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
        )
      end
    end
  end
end
