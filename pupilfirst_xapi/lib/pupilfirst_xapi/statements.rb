require "pupilfirst_xapi/statements/course_completed"
require "pupilfirst_xapi/statements/course_registered"
require "pupilfirst_xapi/statements/target_completed"
require "pupilfirst_xapi/statements/student_video_event_occured"

module PupilfirstXapi
  module Statements
    def self.subscribe(&block)
      EVENTS.each_key{|key| block.call(key)}
    end

    def self.builder_for(event)
      EVENTS.fetch(event)
    end

    EVENTS = {
      :course_completed                   => CourseCompleted,
      :student_added                      => CourseRegistered,
      :submission_graded                  => TargetCompleted,
      :submission_automatically_verified  => TargetCompleted,
      :student_video_event_occured        => StudentVideoEventOccured
    }
  end
end
