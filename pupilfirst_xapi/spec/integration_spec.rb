require 'rails_helper'

RSpec.describe "#xapi", type: :job do
  let(:john) {
    double(:john,
           id: 123,
           display_name: 'John Doe',
           email: 'john@example.com',
           uri: '/user/123')
  }
  let(:ror_guides) {
    double(:course,
           id: 1234,
           name: 'Ruby on Rails Guides',
           description: 'These guides are designed to make you immediately productive with Rails',
           created_at: Time.new(2021,01,01),
           ends_at: nil,
           uri: 'https://guides.rubyonrails.org/')
  }
  let(:getting_started) {
    double(:target,
           title: 'Getting Started with Rails',
           description: 'This guide covers getting up and running with Ruby on Rails.',
           uri: 'https://guides.rubyonrails.org/getting_started.html')
  }

  let(:models) {
    {
      :user => {
        123 => john,
      },
      :course => {
        1234 => ror_guides,
      },
      :target => {
        1 => getting_started
      }
    }
  }
  let(:repository) { ->(klass, resource_id) { models.dig(klass, resource_id) } }
  let(:uri_for)    { ->(obj) { obj.uri } }

  before do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    PupilfirstXapi.repository = repository
    PupilfirstXapi.uri_for = uri_for
  end

  def xapi_actor(user)
    {
      objectType: 'Agent',
      mbox: "mailto:#{user.email}",
      name: user.display_name
    }
  end

  def xapi_verb(verb)
    {
      id: verb.id,
      display: verb.display
    }
  end

  it "#works" do
    unique_id = SecureRandom.hex(10)
    timestamp = Time.now
    xapi_request = {
      actor: xapi_actor(john),
      verb: xapi_verb(PupilfirstXapi::Verbs::COMPLETED),
      object: {
        id: ror_guides.uri,
        definition: {
          name: {'en-US' => 'Ruby on Rails Guides'},
          description: {'en-US' => 'These guides are designed to make you immediately productive with Rails'},
          type: 'http://adlnet.gov/expapi/activities/product',
        },
      },
      timestamp: timestamp.iso8601,
      id: unique_id,
    }
    request = stub_request(:put, "https://test.lrs/statements?statementId=#{unique_id}")
      .with(
        body: xapi_request.to_json,
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Basic dXNlcm5hbWU6cGFzc3dvcmQ=',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v1.3.0',
          'X-Experience-Api-Version'=>'1.0.1'
        }
      ).to_return(status: 204, body: "", headers: {})

    allow_any_instance_of(ActiveSupport::Notifications::Instrumenter).to receive(:unique_id).and_return(unique_id)
    allow(Concurrent).to receive(:monotonic_time).and_return(timestamp)

    ActiveSupport::Notifications.instrument(
      "course.completed.pupilfirst",
      resource_id: ror_guides.id,
      actor_id: john.id,
    )
    expect(PupilfirstXapi::Outbox::Job).to have_been_performed.with({
      event_type: 'course.completed',
      actor_id: 123,
      resource_id: 1234,
      id: unique_id,
      timestamp: timestamp,
    })
    expect(request).to have_been_requested
  end
end
