# Changelog

### 0.3.8 (06.08.2021)

* add add_question_answered_statement event

### 0.3.7 (06.08.2021)

* add capability_result_viewed event

### 0.3.6 (06.08.2021)

* add survey_started event
* add survey_ended event

### 0.3.5 (21.07.2021)
* target as video events resource

### 0.3.4 (20.07.2021)
* add video_started event
* add video_ended event

### 0.3.3 (09.07.2021)
* Change: Allow any Rails version >= 6.0.3.4

### 0.3.2 (17.05.2021)
* Change: Add lessons total number information also when no course duration is set

### 0.3.1 (14.05.2021)
* Change: add course information in target request host field
* add target position in course information

### 0.3.0 (13.05.2021)
* Change: Add course lessons number information to target request.
* Fix: correct target extension keys as uri

### 0.2.2 (13.05.2021)
* Change: Add course information to target request. Added course_id and course_name

### 0.2.1 (02.03.2021)

* Change: Update growthtribe_xapi gem to 0.0.2

### 0.2.0 (02.03.2021)

+ Add: Allow to set LRS endpoint adapter by setting `PupilfirstXapi.lrs` module
  variable. If not set default one (`PupilfirstXapi::Lrs`) will be used.
  The LRS adapter must implement a `call` method with single argument of XAPI
  statement. The statement passed to LRS adapter could be `nil` and in this case
  it must not send it to LRS store.
  Useful in tests when you do not want any HTTP requests to be made. Just add
  your own LRS adapter.

### 0.1.0 (02.03.2021)

Initial release.
