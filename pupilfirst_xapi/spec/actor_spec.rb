require 'spec_helper'

module PupilfirstXapi
  RSpec.describe Actor do
    it do
      klass = double(:actor_class)
      john = double(:john, display_name: 'John Doe', email: 'john@doe.com')
      expect(PupilfirstXapi).to receive(:actor_class).and_return(klass)
      expect(klass).to receive(:find).with(123).once.and_return(john)

      xapi = Actor.new.call(123)
      expect(xapi).to be_a Xapi::Agent
      expect(xapi.mbox).to eq 'mailto:john@doe.com'
      expect(xapi.name).to eq 'John Doe'
      expect(xapi.object_type).to eq 'Agent'
    end
  end
end
