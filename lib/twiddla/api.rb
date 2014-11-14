module Twiddla
  class API
    class << self
      attr_accessor :username
      attr_writer   :password

      def create_user(options)
        api_call('CreateUser', options)
      end

      def create_meeting(options={})
        call('new', options)
      end

      def meeting_url(session_id, options = {})
        params = { sessionid: session_id }.merge(options)
        "#{twiddla_url('api/Start')}?#{URI.encode_www_form(params)}"
      end

      def active_meetings
        api_call('ListActive').split(',')
      end

      def snapshots(session_id = nil)
        params = session_id ? { sessionid: session_id } : {}
        api_call('ListSnapshots', params)
      end

      def delete_meeting(session_id)
        api_call('DeleteSession', { sessionid: session_id })
      end

      private

      def api_call(path, params = {})
        call("api/#{path}", params)
      end

      def call(path, params = {})
        uri = URI.parse(twiddla_url(path))
        response = Net::HTTP.post_form(uri, auth_params.merge(params))
        check_for_errors_and_return response.body.to_s
      end

      def twiddla_url(path)
        "http://www.twiddla.com/#{path}.aspx"
      end

      def auth_params
        { username: username, password: @password }
      end

      LEADING_NEGATIVE_INTEGER = /^-\d/
      def check_for_errors_and_return(response_body)
        raise APIError.new(response_body) if response_body.match(LEADING_NEGATIVE_INTEGER)
        response_body
      end
    end
  end

  class Twiddla::APIError < Exception; end
end
