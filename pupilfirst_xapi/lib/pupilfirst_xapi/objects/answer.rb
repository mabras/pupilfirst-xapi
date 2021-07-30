module PupilfirstXapi
  module Objects
    class Answer
      def call(answer, uri_for)
        target_uri = uri_for.call(answer)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/assessment',
          name: answer.question.description,
          description: answer.question.description
        ).with_extension('http://adlnet.gov/expapi/activities/question', answer.question.description)
        .with_extension('http://adlnet.gov/expapi/activities/answer', answer.content || answer.alternatives.as_json)
          .call
      end
    end
  end
end