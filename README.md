![Twiddla](http://www.twiddla.com/images/logo-corner3.png)

## Installation

http://rubygems.org/gems/twiddla

    gem install twiddla

## Usage

Set up API key

    require 'twiddla'
    Twiddla.auth!('username', 'password') # set your own API key here

Create user

    options = {
      newusername: 'john_doe',
      newpassword: 'password',
      displayname: 'John Doe'
    }
    user_name = Twiddla::API.create_user(options)

Create meeting

    options = { meetingtitle: 'Title', meetingpassword: 'password' }
    session_id = Twiddla::API.create_meeting(options)

Embeddable meeting url

    meeting_url = Twiddla::API.meeting_url(session_id)

List active meetings

    meetings = Twiddla::API.active_meetings

List snapshots

    snapshots = Twiddla::API.snapshots

Delete meeting

    Twiddla::API.delete(session_id)

## Twiddla API References

http://www.twiddla.com/API/Reference.aspx
