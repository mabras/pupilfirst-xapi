require 'spec_helper'

module PupilfirstXapi
  RSpec.describe Object do
    it do
      xapi = Object.new(id: 'any-uri', name: 'Something', description: 'from nothing', type: 'type-uri').call

      expect(xapi).to be_a Xapi::Activity
      expect(xapi.id).to eq 'any-uri'
      expect(xapi.definition.name).to eq({'en-US' => 'Something'})
      expect(xapi.definition.description).to eq({'en-US' => 'from nothing'})
      expect(xapi.definition.type).to eq 'type-uri'
      expect(xapi.definition.extensions).to eq nil
      expect(xapi.object_type).to eq 'Activity'
    end

    it do
      xapi = Object.new(id: 'any-uri', name: 'Something', description: 'from nothing', type: 'type-uri')
        .with_extension('ext-type-1', 'any-value-1')
        .with_extension('ext-type-2', 'any-value-2')
        .call

      expect(xapi).to be_a Xapi::Activity
      expect(xapi.id).to eq 'any-uri'
      expect(xapi.definition.name).to eq({'en-US' => 'Something'})
      expect(xapi.definition.description).to eq({'en-US' => 'from nothing'})
      expect(xapi.definition.type).to eq 'type-uri'
      expect(xapi.definition.extensions).to eq({
        'ext-type-1' => 'any-value-1',
        'ext-type-2' => 'any-value-2',
      })
      expect(xapi.object_type).to eq 'Activity'
    end

    it do
      xapi = Object.new(id: 'any-uri', name: 'Something', description: 'from nothing', type: 'type-uri')
        .with_extension('ext-type', 'any-value-1')
        .with_extension('ext-type', 'any-value-2')
        .call

      expect(xapi).to be_a Xapi::Activity
      expect(xapi.id).to eq 'any-uri'
      expect(xapi.definition.name).to eq({'en-US' => 'Something'})
      expect(xapi.definition.description).to eq({'en-US' => 'from nothing'})
      expect(xapi.definition.type).to eq 'type-uri'
      expect(xapi.definition.extensions).to eq({
        'ext-type' => 'any-value-2',
      })
      expect(xapi.object_type).to eq 'Activity'
    end
  end
end
