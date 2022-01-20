module PupilfirstXapi
  module Objects
    class Target
      def call(target, uri_for)
        course = target.course
        target_uri = uri_for.call(target)

        Builder.new(
          id: target_uri,
          type: "http://adlnet.gov/expapi/activities/unit-test",
          name: target.title,
          description: target.description
        ).tap do |obj|
          obj.with_extension('http://id.tincanapi.com/extension/host', Objects.course(course, uri_for).as_json)
          obj.with_extension('http://id.tincanapi.com/extension/position', target.sort_index)
        end.call
      end
    end
  end
end
