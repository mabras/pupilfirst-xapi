module PupilfirstXapi
  module Objects
    class Target
      def call(target, uri, course_uri)
        Builder.new(
          id: uri,
          type: "http://activitystrea.ms/schema/1.0/task",
          name: target.title,
          description: target.description
        ).tap do |obj|
          obj.with_extension('course_id', course_uri)
        end.call
      end
    end
  end
end
