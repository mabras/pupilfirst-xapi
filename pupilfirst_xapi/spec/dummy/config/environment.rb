Rails.application.configure do
  config.eager_load = false

  # Override Rails 5's default of :async, and force jobs to run inline.
  test_adapter = ActiveJob::QueueAdapters::TestAdapter.new
  test_adapter.perform_enqueued_jobs = true
  config.active_job.queue_adapter = test_adapter
end
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
