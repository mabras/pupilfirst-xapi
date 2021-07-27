module PupilfirstXapi
  module Objects
    class SurveyEnd
      def call(survey, uri_for)
        target_uri = uri_for.call(survey)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/assessment',
          name: survey.name,
          description: survey.description
        ).with_extension(
          'http://id.tincanapi.com/extension/target', survey.slug
        ).call
      end
    end
  end
end
