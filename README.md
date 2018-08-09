# Read Time

[![Build Status](https://travis-ci.org/deepakmahakale/read-time.svg?branch=master)](https://travis-ci.org/deepakmahakale/read-time)

**Read Time** estimates the time required to read the article. Read Time also takes images in account while estimating the time.

```ruby
@article.body.readtime  # => "1 minute read"
```

## Usage

### Install the gem using RubyGems

```bash
gem install read-time
```

or:

### Add it to your Gemfile

```ruby
gem 'read-time'
```

### Include it in your program

```ruby
require 'read-time'
```

### Call the method on the text

```ruby
@article.body.readtime #=> "2 minute read"
```

## Configuration

```ruby
# config/initializers/read-time.rb
ReadTime.configure do |config|
  config.reading_speed  = 300
  config.format         = :default # [:default, :long]
end
```

Default values can be overriden:

```ruby
text = 'word ' * 300
text.readtime #=> "2 minute read"
text.readtime(reading_speed: 300) #=> "1 minute read"
text.readtime(reading_speed: 200, format: :long) #=> "1 minute 30 second read"
```

## TODO

- I18n support
- Calculation based on images
