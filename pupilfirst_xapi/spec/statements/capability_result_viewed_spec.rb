require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe CapabilityResultViewed do
      it do
        john              = double(:john, name: 'John Doe', email: 'john@doe.com')
        capability_result = double(
          :capability_result,
          name: 'Rails for Beginners',
          description: 'Seems easy',
          created_at: 1.week.ago,
          ends_at: nil,
          targets: [
            double(:target, title: '1st target', description: 'Seems easy'),
            double(:target, title: '2nd target', description: 'Seems not easy')
          ]
        )

        data = {
          capability_result: { 456 => capability_result },
          user: { 123 => john }
        }

        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == capability_result ? 'rails-for-begginers' : nil }

        xapi = CapabilityResultViewed.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::VIEWED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/resource'
        expect(xapi.object.definition.name).to eq({'en-US' => 'survey Rails for Beginners'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
      end
    end
  end
end