require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe SurveyEnded do
      it do
        john   = double(:john, name: 'John Doe', email: 'john@doe.com')
        survey = double(
          :survey,
          name: 'Rails for Beginners',
          external_name: 'Seems easy',
          slug: 'a6ad5226-7d8b-4108-9cc9-f0821de150f5',
          created_at: 1.week.ago,
          ends_at: nil,
          targets: [
            double(:target, title: '1st target', description: 'Seems easy'),
            double(:target, title: '2nd target', description: 'Seems not easy')
          ]
        )

        data = {
          survey: { 456 => survey },
          user: { 123 => john }
        }

        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == survey ? 'rails-for-begginers' : nil }

        xapi = SurveyEnded.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::COMPLETED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/assessment'
        expect(xapi.object.definition.name).to eq({'en-US' => 'Rails for Beginners'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
        expect(xapi.object.definition.extensions.fetch('http://id.tincanapi.com/extension/target')).to eq('a6ad5226-7d8b-4108-9cc9-f0821de150f5')
      end
    end
  end
end
