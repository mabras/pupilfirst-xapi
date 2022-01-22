module PupilfirstXapi
  module Statements
    class QuizCompleted
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        submission = @repository.call(:timeline_event, resource_id)
        return unless submission.passed?

        actor = @repository.call(:user, actor_id)
        target = submission.target
        raw, max = submission.quiz_score.split('/')
        scaled = (raw.to_f/max.to_f)&.floor(2)

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::COMPLETED_ASSIGNMENT,
          result: Xapi::Result.new(
            score: Xapi::Score.new(scaled: scaled, min: 0, max: max.to_i, raw: raw.to_i),
            success: true,
            completion: true
          ),
          object: Objects.target(target, @uri_for)
        )
      end
    end
  end
end
