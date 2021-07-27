module PupilfirstXapi
  module Objects
    class Survey
      def call(survey, uri_for)
        target_uri = uri_for.call(survey)

        Builder.new(
          id: target_uri,
          type: 'http://id.tincanapi.com/activitytype/survey',
          name: "#{survey.name}",
          description: survey.description
        ).call
      end
    end
  end
end