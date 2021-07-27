require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe QuestionAnswered do
      it do
        john   = double(:john, name: 'John Doe', email: 'john@doe.com')
        answer = double(
          :answer,
          answer_id: 42,
          question_id: 4,
          question_description: "What is your favorite animal?",
          alternative_id: nil,
          survey_group_id:7,
          user_external_id: 'a6ad5226-7d8b-4108-9cc9-f0821de150f5',
          answer_type: 'open_ended',
          content: 'Content',
          score: 0.0,
          level: 1.0,
          language: 'en',
          created_at: 1.week.ago,
          ends_at: nil
        )

        data = {
          answer: { 456 => answer },
          user: { 123 => john }
        }

        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == answer ? 'rails-for-begginers' : nil }

        xapi = QuestionAnswered.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::ANSWERED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/assessment'
        expect(xapi.object.definition.name).to eq({'en-US' => 'What is your favorite animal?'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'What is your favorite animal?'})
        expect(xapi.object.definition.extensions.fetch('http://adlnet.gov/expapi/activities/question')).to eq("What is your favorite animal?")
      end
    end
  end
end