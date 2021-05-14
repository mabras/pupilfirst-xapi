require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe CourseRegistered do
      it do
        john   = double(:john, name: 'John Doe', email: 'john@doe.com')
        course = double(:course, name: 'Rails for Begginers', description: 'Seems easy', created_at: 1.week.ago, ends_at: nil,
                                 targets: [
                                   double(:target, title: '1st target', description: 'Seems easy'),
                                   double(:target, title: '2nd target', description: 'Seems not easy')
                                  ])
        data = {
          course: { 456 => course },
          user: { 123 => john },
        }
        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == course ? 'rails-for-begginers' : nil }

        xapi = CourseRegistered.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::REGISTERED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/product'
        expect(xapi.object.definition.name).to eq({'en-US' => 'Rails for Begginers'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
        expect(xapi.object.definition.extensions).to eq nil
      end

      it do
        starts_at = 1.week.ago
        ends_at   = 3.days.after
        duration  = ActiveSupport::Duration.build(ends_at - starts_at).iso8601

        john   = double(:john, name: 'John Doe', email: 'john@doe.com')
        course = double(:course, name: 'Rails for Begginers', description: 'Seems easy', created_at: starts_at, ends_at: ends_at,
                                 targets: [
                                   double(:target, title: '1st target', description: 'Seems easy'),
                                   double(:target, title: '2nd target', description: 'Seems not easy')
                                  ])
        data = {
          course: { 456 => course },
          user: { 123 => john },
        }
        repository = ->(klass, resource_id) { data.dig(klass, resource_id) }
        uri_for = ->(obj) { obj == course ? 'rails-for-begginers' : nil }

        xapi = CourseRegistered.new(repository, uri_for).call(actor_id: 123, resource_id: 456)

        expect(xapi).to be_a Xapi::Statement
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq Verbs::REGISTERED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/product'
        expect(xapi.object.definition.name).to eq({'en-US' => 'Rails for Begginers'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
        expect(xapi.object.definition.extensions).to eq({
          "http://id.tincanapi.com/extension/planned-duration" => duration,
          "http://id.tincanapi.com/extension/ending-position" => 2
        })
      end
    end
  end
end
