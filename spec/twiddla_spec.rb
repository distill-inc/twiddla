require 'spec_helper'

describe Twiddla::API do
  before :each do
    Twiddla.auth!('username', 'password')
    @response = mock()
    @response.stub(:body).and_return('')
    Net::HTTP.stub(:post_form).and_return(@response)
    @session_id = rand(1000)
  end

  describe '.create_user' do
    it 'calls "CreateUser"' do
      options = {
        newusername: 'foo',
        newpassword: 'bar',
        displayname: 'foo bar',
        email:       'foo@example.com',
      }
      Twiddla::API.should_receive(:api_call).with('CreateUser', options).and_return(options[:displayname])
      Twiddla::API.create_user(options)
    end
  end

  describe '.create_meeting' do
    it 'calls "new"' do
      Twiddla::API.should_receive(:call).with('new', {}).and_return(@session_id)
      Twiddla::API.create_meeting
    end
  end

  describe '.meeting_url' do
    it 'creates embeddable url' do
      regex = /api\/Start\.aspx\?sessionid=#{@session_id}$/
      Twiddla::API.meeting_url(@session_id).should match(regex)
    end
  end

  describe '.active_meetings' do
    it 'calls "ListActive"' do
      session_ids = [@session_id, @session_id + 1].map(&:to_s)
      Twiddla::API.should_receive(:api_call).with('ListActive').and_return(session_ids.join(','))
      Twiddla::API.active_meetings.should == session_ids
    end
  end

  describe '.snapshots' do
    it 'calls "ListSnapshots"' do
      Twiddla::API.should_receive(:call).with('api/ListSnapshots', { sessionid: @session_id })
      Twiddla::API.snapshots(@session_id)
    end
  end

  describe '.delete_meeting' do
    it 'calls "DeleteSession"' do
      Twiddla::API.should_receive(:call).with('api/DeleteSession', { sessionid: @session_id }).and_return('1')
      Twiddla::API.delete_meeting(@session_id)
    end
  end
end
