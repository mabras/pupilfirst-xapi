require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe TargetCompleted do
      it do
        target = double(:target, title: '1st target', description: 'Seems easy')
        john   = double(:john, display_name: 'John Doe', email: 'john@doe.com')
        data = {
          target: { 456 => target },
          user: { 123 => john },
        }
        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == target ? 'target-1' : nil }

        xapi = TargetCompleted.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::COMPLETED_ASSIGNMENT

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'target-1'
        expect(xapi.object.definition.type).to eq 'http://activitystrea.ms/schema/1.0/task'
        expect(xapi.object.definition.name).to eq({'en-US' => '1st target'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
      end
    end
  end
end
