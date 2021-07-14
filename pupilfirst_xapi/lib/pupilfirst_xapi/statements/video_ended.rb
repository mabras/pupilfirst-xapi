module PupilfirstXapi
  module Statements
    class VideoEnded
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        Xapi.create_statement(
          actor: actor,
          verb: Verbs::VIDEO_ENDED,
          object: Objects.video_end(actor, resource_id, @uri_for)
        )
      end
    end
  end
end