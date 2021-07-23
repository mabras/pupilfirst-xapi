module PupilfirstXapi
  module Statements
    class QuestionAnswered
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor           = @repository.call(:user, actor_id)
        question_answer = @repository.call(:question_answer, resource_id)

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::ANSWERED,
          object: Objects.question_answer(question_answer, @uri_for)
        )
      end
    end
  end
end
