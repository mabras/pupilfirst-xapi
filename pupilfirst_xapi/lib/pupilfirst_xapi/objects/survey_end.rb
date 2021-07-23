module PupilfirstXapi
  module Objects
    class SurveyEnd
      def call(survey, uri_for)
        target_uri = uri_for.call(survey)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/assessment',
          name: "survey #{survey.name}",
          description: survey.description
        ).with_extension(
          'survey_slug', survey.slug
        ).call
      end
    end
  end
end
