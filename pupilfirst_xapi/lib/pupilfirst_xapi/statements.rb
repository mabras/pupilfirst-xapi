require "pupilfirst_xapi/statements/course_completed"
require "pupilfirst_xapi/statements/course_registered"
require "pupilfirst_xapi/statements/target_completed"

module PupilfirstXapi
  module Statements
    def self.subscribe(&block)
      EVENTS.each_key{|key| block.call(key)}
    end

    EVENTS = {
      'course.completed'  => CourseCompleted,
      'course.registered' => CourseRegistered,
      'target.completed'  => TargetCompleted,
    }
  end
end
