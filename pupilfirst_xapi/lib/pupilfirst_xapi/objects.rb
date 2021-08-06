require_relative 'objects/builder'
require_relative 'objects/course'
require_relative 'objects/target'
require_relative 'objects/video_start'
require_relative 'objects/video_end'
require_relative 'objects/survey_start'
require_relative 'objects/survey_end'

module PupilfirstXapi
  module Objects
    def self.course(course, uri_for)
      Course.new.call(course, uri_for)
    end

    def self.target(target, uri_for)
      Target.new.call(target, uri_for)
    end

    def self.video_start(target, uri_for)
      VideoStart.new.call(target, uri_for)
    end

    def self.video_end(target, uri_for)
      VideoEnd.new.call(target, uri_for)
    end

    def self.survey_start(survey, uri_for)
      SurveyStart.new.call(survey, uri_for)
    end

    def self.survey_end(survey, uri_for)
      SurveyEnd.new.call(survey, uri_for)
    end
  end
end
