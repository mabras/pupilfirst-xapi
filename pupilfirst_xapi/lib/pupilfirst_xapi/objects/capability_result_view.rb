module PupilfirstXapi
  module Objects
    class CapabilityResultView
      def call(survey, uri_for)
        target_uri = uri_for.call(survey)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/resource',
          name: "survey #{survey.name}",
          description: survey.description
        ).call
      end
    end
  end
end