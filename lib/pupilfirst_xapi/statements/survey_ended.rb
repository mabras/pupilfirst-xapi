module PupilfirstXapi
  module Statements
    class SurveyEnded
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        survey = @repository.call(:survey, resource_id)

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::COMPLETED,
          object: Objects.survey_end(survey, @uri_for)
        )
      end
    end
  end
end
