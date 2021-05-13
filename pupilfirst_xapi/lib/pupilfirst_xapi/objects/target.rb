module PupilfirstXapi
  module Objects
    class Target
      def call(target, uri_for)
        course = target.course
        target_uri = uri_for.call(target)
        course_uri = uri_for.call(course)

        Builder.new(
          id: target_uri,
          type: "http://activitystrea.ms/schema/1.0/task",
          name: target.title,
          description: target.description
        ).tap do |obj|
          obj.with_extension('http://id.tincanapi.com/extension/course_id', course_uri)
          obj.with_extension('http://id.tincanapi.com/extension/course_name', course.name)
          obj.with_extension('http://id.tincanapi.com/extension/course_lessons_number', course.targets.count)
        end.call
      end
    end
  end
end
