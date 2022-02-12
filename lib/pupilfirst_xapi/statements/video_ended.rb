module PupilfirstXapi
  module Statements
    class VideoEnded
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        target = @repository.call(:target, resource_id)
        instructor = target.course.course_authors&.first&.user
        instructor_agent = Xapi::Agent.new(name: instructor.name, mbox: "mailto:#{instructor.email}")
        context_activities = Xapi.create_context_activities(
          parent: [Xapi::Activity.new.tap { |obj| obj.id = PupilfirstXapi.uri_for.call(target.course) }]
        )
        context = Xapi.create_context(
          instructor: instructor_agent,
          platform: "ZAMN-#{actor.school.id}",
          language: "ar-SA",
          extensions: {
            "http://id.tincanapi.com/extension/attempt-id" => 1,
            "http://id.tincanapi.com/extension/browser-info": {
              code_name:"Unknow",
              name: "Unknow",
              version: "Unknow"
            }
          },
          context_activities: context_activities
        )

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::VIDEO_ENDED,
          context: context,
          result: Xapi::Result.new(
            score: Xapi::Score.new(),
            success: true,
            completion: true
          ),
          object: Objects.video_end(target, @uri_for)
        )
      end
    end
  end
end
