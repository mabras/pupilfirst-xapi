require "action_controller/railtie"
require "active_job/railtie"
require "growthtribe_xapi"
require "pupilfirst_xapi/version"
require "pupilfirst_xapi/outbox"
require "pupilfirst_xapi/objects"
require "pupilfirst_xapi/verbs"
require "pupilfirst_xapi/statements"

module PupilfirstXapi
  mattr_accessor :uri_for
  mattr_accessor :repository

  Statements.subscribe do |event_type|
    ActiveSupport::Notifications.subscribe("#{event_type}.pupilfirst") do |_name, _start, finish, _id, payload|
      Outbox << payload.merge(event_type: event_type, timestamp: finish)
    end
  end
end
