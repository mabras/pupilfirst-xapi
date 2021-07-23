require "pupilfirst_xapi/statements/course_completed"
require "pupilfirst_xapi/statements/course_registered"
require "pupilfirst_xapi/statements/target_completed"
require "pupilfirst_xapi/statements/video_started"
require "pupilfirst_xapi/statements/video_ended"
require "pupilfirst_xapi/statements/survey_started"
require "pupilfirst_xapi/statements/survey_ended"
require "pupilfirst_xapi/statements/capability_result_viewed"
require "pupilfirst_xapi/statements/question_answered"

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
      :video_started                      => VideoStarted,
      :video_ended                        => VideoEnded,
      :survey_started                     => SurveyStarted,
      :survey_ended                       => SurveyEnded,
      :capability_result_viewed           => CapabilityResultViewed,
      :question_answered                  => QuestionAnswered
    }
  end
end
