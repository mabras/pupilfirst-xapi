require 'spec_helper'

module PupilfirstXapi
  RSpec.describe Outbox do
    let(:id)        { SecureRandom.uuid }
    let(:timestamp) { Time.now }
    let(:john)      { double(:john, display_name: 'John Doe', email: 'john@doe.com') }
    let(:course)    { double(:course, name: 'Rails for Begginers', description: 'Seems easy', created_at: 1.week.ago, ends_at: nil) }
    let(:target)    { double(:target, title: '1st target', description: 'Seems easy') }
    let(:data) {
      {
        course: { 456 => course },
        target: { 456 => target },
        user:   { 123 => john },
      }
    }
    let(:repository) { ->(klass, resource_id) { data.dig(klass, resource_id) } }
    let(:uri_for) do
      ->(obj) do
        case obj
        when course
          'rails-for-begginers'
        when target
          'target-1'
        else
          nil
        end
      end
    end

    it 'post xapi statements to provided lrs' do
      [
        ['course.completed', Verbs::COMPLETED, 'rails-for-begginers'],
        ['course.registered', Verbs::REGISTERED, 'rails-for-begginers'],
        ['target.completed', Verbs::COMPLETED_ASSIGNMENT, 'target-1'],
      ].each do |event_type, expected_verb, expected_object_id|
        lrs = FakeLrs.new
        Outbox.new(lrs: lrs, repository: repository, uri_for: uri_for)
          .call(actor_id: 123, resource_id: 456, context_id: 789, id: id, timestamp: timestamp, event_type: event_type)
        expect(lrs.statements.count).to eq(1)
        xapi = lrs.statements.first
        expect(xapi).to be_a Xapi::Statement
        expect(xapi.id).to eq(id)
        expect(xapi.timestamp).to eq(timestamp)
        expect_actor(xapi.actor, name: 'John Doe', email: 'john@doe.com')
        expect(xapi.verb).to eq(expected_verb)
        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.id).to eq(expected_object_id)
      end
    end
  end
end
