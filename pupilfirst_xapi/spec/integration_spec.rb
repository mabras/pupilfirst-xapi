require 'rails_helper'

RSpec.describe "#xapi", type: :job, perform_jobs: true do
  let(:john) {
    double(:john,
           id: 123,
           name: 'John Doe',
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
           uri: 'https://guides.rubyonrails.org/',
           targets: [
             double(:target, title: '1st target', description: 'Seems easy'),
             double(:target, title: '2nd target', description: 'Seems not easy')
            ]
          )
  }
  let(:getting_started) {
    double(:target,
           title: 'Getting Started with Rails',
           description: 'This guide covers getting up and running with Ruby on Rails.',
           uri: 'https://guides.rubyonrails.org/getting_started.html',
           course: ror_guides
          )
  }
  let(:good_one) { double(:timeline_event, target: getting_started, passed?: true) }
  let(:bad_one) { double(:timeline_event, target: getting_started, passed?: false) }


  let(:models) {
    {
      :user => {
        123 => john,
      },
      :course => {
        1234 => ror_guides,
      },
      :timeline_event => {
        1 => good_one,
        2 => bad_one,
      }
    }
  }
  let(:repository) { ->(klass, resource_id) { models.dig(klass, resource_id) } }
  let(:uri_for)    { ->(obj) { obj.uri } }

  before do
    PupilfirstXapi.repository = repository
    PupilfirstXapi.uri_for = uri_for
  end

  def xapi_actor(user)
    {
      objectType: 'Agent',
      name: user.name,
      mbox: "mailto:#{user.email}",
    }
  end

  def xapi_verb(verb)
    {
      id: verb.id,
      display: verb.display
    }
  end

  it "#works" do
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
          extensions: {"http://id.tincanapi.com/extension/ending-position"=>2}
        },
      },
      timestamp: timestamp.iso8601,
      version: '1.0.1',
    }
    request = stub_request(:post, "https://test.lrs/statements")
      .with(
        body: xapi_request.to_json,
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Basic a2V5OnNlY3JldA==',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v1.3.1',
          'X-Experience-Api-Version'=>'1.0.1'
        }
      ).to_return(status: 204, body: "", headers: {})

    allow(Concurrent).to receive(:monotonic_time).and_return(timestamp)

    ActiveSupport::Notifications.instrument(
      "course_completed.pupilfirst",
      resource_id: ror_guides.id,
      actor_id: john.id,
    )
    expect(PupilfirstXapi::Outbox::Job).to have_been_performed.with(
      hash_including({
        event_type: :course_completed,
        actor_id: 123,
        resource_id: 1234,
      })
    )

    expect(request).to have_been_requested
  end
end
