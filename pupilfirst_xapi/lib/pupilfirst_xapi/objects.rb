require_relative 'objects/builder'
require_relative 'objects/course'
require_relative 'objects/target'
require_relative 'objects/video_start'

module PupilfirstXapi
  module Objects
    def self.course(course, uri_for)
      Course.new.call(course, uri_for)
    end

    def self.target(target, uri_for)
      Target.new.call(target, uri_for)
    end

    def self.video_start(student, video_id, uri_for)
      VideoStart.new.call(student, video_id, uri_for)
    end


    def self.video_end(student, video_id, uri_for)
      VideoEnd.new.call(student, video_id, uri_for)
    end
  end
end
