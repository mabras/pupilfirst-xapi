module PupilfirstXapi
  module Objects
    class VideoEnd
      def call(target, uri_for)
        target_uri = uri_for.call(target)

        Builder.new(
          id: target_uri,
          type: "http://activitystrea.ms/schema/1.0/event",
          name: "video in #{target.title}",
          description: target.description
        ).call
      end
    end
  end
end
