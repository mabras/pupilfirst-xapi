require "rails"
require "xapi"
require "pupilfirst_xapi/version"
require "pupilfirst_xapi/engine"
require "pupilfirst_xapi/outbox"
require "pupilfirst_xapi/actor"
require "pupilfirst_xapi/object"
require "pupilfirst_xapi/verbs"
require "pupilfirst_xapi/statements"

module PupilfirstXapi
  mattr_accessor :uri_for
  mattr_accessor :actor_class
  def self.actor_class
    @@actor_class.constantize
  end
  mattr_accessor :course_class
  def self.course_class
    @@course_class.constantize
  end
  mattr_accessor :target_class
  def self.target_class
    @@target_class.constantize
  end

  Statements.subscribe do |event_type|
    ActiveSupport::Notifications.subscribe("#{event_type}.pupilfirst") do |name, _start, finish, id, payload|
      Outbox << payload.merge(id: id, name: name, timestamp: finish)
    end
  end
end
