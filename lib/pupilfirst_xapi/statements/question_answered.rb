module PupilfirstXapi
  module Statements
    class QuestionAnswered
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor  = @repository.call(:user, actor_id)
        answer = @repository.call(:answer, resource_id)

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::ANSWERED,
          object: Objects.answer(answer, @uri_for)
        )
      end
    end
  end
end
