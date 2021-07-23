module PupilfirstXapi
  module Objects
    class QuestionAnswer
      def call(question_answer, uri_for)
        target_uri = uri_for.call(question_answer)

        Builder.new(
          id: target_uri,
          type: 'http://adlnet.gov/expapi/activities/assessment',
          name: "question answered #{question_answer.question_description}",
          description: question_answer.question_description
        ).with_extension('answer_id', question_answer.answer_id)
          .with_extension('http://adlnet.gov/expapi/activities/question', question_answer.question_description)
          .call
      end
    end
  end
end