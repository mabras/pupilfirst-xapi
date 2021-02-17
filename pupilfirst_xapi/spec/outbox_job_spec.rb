require 'rails_helper'

module PupilfirstXapi
  RSpec.describe Outbox::Job, type: :job do
    let(:id)        { SecureRandom.uuid }
    let(:timestamp) { Time.now }

    it 'schedules new xapi statement push' do
      ActiveJob::Base.queue_adapter = :test
      payload = {actor_id: 123, resource_id: 456, id: id, timestamp: timestamp, event_type: 'any.event'}
      expect {
        Outbox << payload
      }.to have_enqueued_job(Outbox::Job).with(payload)
    end
  end
end
