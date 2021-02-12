require_relative "../lib/pupilfirst_xapi"
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
end

def expect_actor(xapi, name:, email:)
  expect(xapi).to be_a Xapi::Agent
  expect(xapi.mbox).to eq "mailto:#{email}"
  expect(xapi.name).to eq name
  expect(xapi.object_type).to eq 'Agent'
end

