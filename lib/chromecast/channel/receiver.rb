module Chromecast
  module Channel
    class Receiver < Base
      NAMESPACE = 'urn:x-cast:com.google.cast.receiver'
      
      def initialize connection
        super(connection, NAMESPACE, :json)
        @request_id = 0
      end

      def launch app_id
        send(type: 'LAUNCH', appId: app_id)
      end

      def stop session_id
        send(type: 'STOP', sessionId: session_id)
      end

      def get_status
        send(type: 'GET_STATUS')
      end

      def get_app_availability apps
        send(type: 'GET_APP_AVAILABILITY', appId: [apps].flatten)
      end

      def set_volume level
        send(type: 'SET_VOLUME', volume: {level: level})
      end

      def mute
        send(type: 'SET_VOLUME', volume: {muted: true})
      end

      def unmute
        send(type: 'SET_VOLUME', volume: {muted: false})
      end

      private

      def next_request_id
        @request_id += 1
      end
      
      def send data
        super(data.merge(requestId: next_request_id))
        @request_id
      end
    end
  end
end
