module PupilfirstXapi
  module Objects
    class VideoStart
      def call(student, video_id, uri_for)
        student_uri = uri_for.call(student)
        puts video_id

        Builder.new(
          id: student_uri,
          type: "http://activitystrea.ms/schema/1.0/event",
          name: student.name,
          description: "student started video #{video_id}"
        ).call
      end
    end
  end
end
