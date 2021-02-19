require_relative "../lib/pupilfirst_xapi"
require 'dotenv'
Dotenv.load('.env.test')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.order = :random
  Kernel.srand config.seed

  config.around(:each, type: :job) do |example|
    ActiveJob::Base.queue_adapter = :test
    example.run
  ensure
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end

  config.around(:each, perform_jobs: true) do |example|
    old_perform_enqueued_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_jobs
    old_perform_enqueued_at_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = true
    example.run
  ensure
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = old_perform_enqueued_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = old_perform_enqueued_at_jobs
  end
end

def expect_actor(xapi, name:, email:)
  expect(xapi).to be_a Xapi::Agent
  expect(xapi.mbox).to eq "mailto:#{email}"
  expect(xapi.name).to eq name
  expect(xapi.object_type).to eq 'Agent'
end

class FakeLrs
  def initialize
    @statements = []
  end
  attr_reader :statements

  def save_statement(statement)
    @statements << statement
  end
end
