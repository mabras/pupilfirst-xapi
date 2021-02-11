require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe TargetCompleted do
      let(:actor_class) { double(:actor_class) }
      let(:target_class) { double(:target_class) }
      let(:john) {  double(:john, display_name: 'John Doe', email: 'john@doe.com') }

      before(:each) do
        expect(PupilfirstXapi).to receive(:actor_class).and_return(actor_class)
        expect(actor_class).to receive(:find).with(123).once.and_return(john)

        expect(PupilfirstXapi).to receive(:target_class).and_return(target_class)
      end

      it do
        target = double(:target, title: '1st target', description: 'Seems easy')
        expect(target_class).to receive(:find).with(456).once.and_return(target)
        expect(PupilfirstXapi).to receive(:uri_for).with(target).and_return('target-1')
        xapi = TargetCompleted.new.call(actor_id: 123, resource_id: 456, context_id: 789)

        expect(xapi).to be_a Xapi::Statement

        expect(xapi.actor.mbox).to eq 'mailto:john@doe.com'
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
