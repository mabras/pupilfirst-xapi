module PupilfirstXapi
  module Objects
    class Target
      def call(target, uri)
        Builder.new(
          id: uri,
          type: "http://activitystrea.ms/schema/1.0/task",
          name: target.title,
          description: target.description
        ).call
      end
    end
  end
end
