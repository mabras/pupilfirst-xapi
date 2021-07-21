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
        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::VIDEO_ENDED,
          object: Objects.video_end(target, @uri_for)
        )
      end
    end
  end
end
