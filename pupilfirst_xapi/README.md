# PupilfirstXapi

This gem subscribes to events published by Pupilfirst LMS system,
builds the XAPI statements and sends them to LRS endpoint defined
using ENV variables. The list of handled Pupilfirst's events is
defined [here](/lib/pupilfirst_xapi/statements.rb).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'pupilfirst_xapi'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install pupilfirst_xapi
```

## Usage
Add application initializer file and setup dependencies required by this gem:

### Define Pupilfirst models repository
Add this line in gem initializer:
```
PupilfirstXapi.repository = ->(klass, resource_id) { ... }
```

It could be simple lambda to fetch Pupilfirst's models or
a class with a `call(klass, repository_id)` method.

Arguments:

* `klass` - a symbol from a list defined below representing one of the entities
  from Pupilfirst's data model,
* `resource_id` - an entity id (Application Record id attribute)


Entity types that are used by this gem:

* `:course` - Pupilfirst's `Course` class
* `:target` - Pupilfirst's `Target` class
* `:user` - Pupilfirst's `User` class

The result of the lambda or repository class call method must be
an Pupilfirst's ActiveRecord object for requested class.

### Define URI builder
Add this line in gem initializer:
```
PupilfirstXapi.uri_for = ->(obj) { ... }
```

Arguments:

* `obj` - an Pupilfirst's ActiveRecord object

The result of the `PupilfirstXapi.uri_for.(obj)` call must be
the unique URI of the object passed as argument.

### Define LRS endpoint
Set environment variables:

* `LRS_ENDPOINT` - url of LRS server's XAPI endpoint
* `LRS_KEY` - authentication key
* `LRS_SECRET` - authentication secter

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
