require "action_controller/railtie"
require "active_job/railtie"
require "xapi"
require "pupilfirst_xapi/version"
require "pupilfirst_xapi/engine"
require "pupilfirst_xapi/outbox"
require "pupilfirst_xapi/object"
require "pupilfirst_xapi/verbs"
require "pupilfirst_xapi/statements"

module PupilfirstXapi
  mattr_accessor :uri_for
  mattr_accessor :repository

  Statements.subscribe do |event_type|
    ActiveSupport::Notifications.subscribe("#{event_type}.pupilfirst") do |name, _start, finish, id, payload|
      Outbox << payload.merge(id: id, event_type: event_type, name: name, timestamp: finish)
    end
  end
end
