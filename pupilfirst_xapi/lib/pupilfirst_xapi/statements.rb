require "pupilfirst_xapi/statements/course_completed"
require "pupilfirst_xapi/statements/course_registered"
require "pupilfirst_xapi/statements/target_completed"

module PupilfirstXapi
  mattr_accessor :uri_for
  mattr_accessor :repository

  module Statements
    def self.subscribe(&block)
      EVENTS.each_key{|key| block.call(key)}
    end

    def self.builder_for(event)
      EVENTS.fetch(event)
    end

    EVENTS = {
      'course.completed'  => CourseCompleted.new(PupilfirstXapi.repository, PupilfirstXapi.uri_for),
      'course.registered' => CourseRegistered.new(PupilfirstXapi.repository, PupilfirstXapi.uri_for),
      'target.completed'  => TargetCompleted.new(PupilfirstXapi.repository, PupilfirstXapi.uri_for),
    }
  end
end
