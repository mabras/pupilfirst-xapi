require 'spec_helper'

module PupilfirstXapi
  module Statements
    RSpec.describe CourseCompleted do
      let(:actor_class) { double(:actor_class) }
      let(:course_class) { double(:course_class) }
      let(:john) {  double(:john, display_name: 'John Doe', email: 'john@doe.com') }

      before(:each) do
        expect(PupilfirstXapi).to receive(:actor_class).and_return(actor_class)
        expect(actor_class).to receive(:find).with(123).once.and_return(john)

        expect(PupilfirstXapi).to receive(:course_class).and_return(course_class)
      end

      it do
        course = double(:course, name: 'Rails for Begginers', description: 'Seems easy')
        expect(course_class).to receive(:find).with(456).once.and_return(course)
        expect(PupilfirstXapi).to receive(:uri_for).with(course).and_return('rails-for-begginers')
        xapi = CourseCompleted.new.call(actor_id: 123, resource_id: 456, context_id: 789)

        expect(xapi).to be_a Xapi::Statement

        expect(xapi.actor.mbox).to eq 'mailto:john@doe.com'
        expect(xapi.verb).to eq Verbs::COMPLETED

        expect(xapi.object).to be_a Xapi::Activity
        expect(xapi.object.object_type).to eq 'Activity'
        expect(xapi.object.id).to eq 'rails-for-begginers'
        expect(xapi.object.definition.type).to eq 'http://adlnet.gov/expapi/activities/product'
        expect(xapi.object.definition.name).to eq({'en-US' => 'Rails for Begginers'})
        expect(xapi.object.definition.description).to eq({'en-US' => 'Seems easy'})
      end
    end
  end
end
