require "rails"
require "xapi"
require "pupilfirst_xapi/version"
require "pupilfirst_xapi/engine"
require "pupilfirst_xapi/outbox"
require "pupilfirst_xapi/object"
require "pupilfirst_xapi/verbs"
require "pupilfirst_xapi/statements"

module PupilfirstXapi
  Statements.subscribe do |event_type|
    ActiveSupport::Notifications.subscribe("#{event_type}.pupilfirst") do |name, _start, finish, id, payload|
      Outbox << payload.merge(id: id, event_type: name, timestamp: finish)
    end
  end
end
