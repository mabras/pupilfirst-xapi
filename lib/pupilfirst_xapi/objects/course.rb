module PupilfirstXapi
  module Objects
    class Course
      def call(course, uri_for)
        uri = uri_for.call(course)

        Builder.new(
          id: uri,
          type: 'http://adlnet.gov/expapi/activities/product',
          name: course.name,
          description: course.description
        ).tap do |obj|
          obj.with_extension('http://id.tincanapi.com/extension/ending-position', course.targets.count)
          if course.ends_at.present?
            duration = ActiveSupport::Duration.build(course.ends_at - course.created_at).iso8601
            obj.with_extension("http://id.tincanapi.com/extension/planned-duration", duration)
          end
        end.call
      end
    end
  end
end
