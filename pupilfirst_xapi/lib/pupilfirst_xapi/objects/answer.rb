module PupilfirstXapi
  module Objects
    class Answer
      def call(answer, uri_for)
        target_uri = uri_for.call(answer)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/assessment',
          name: answer.question_description,
          description: answer.question_description
        ).with_extension('answer_id', answer.answer_id)
          .with_extension('http://adlnet.gov/expapi/activities/question', answer.question_description)
          .call
      end
    end
  end
end