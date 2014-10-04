module Chromecast
  module Channel
    class Media < Base
      NAMESPACE = 'urn:x-cast:com.google.cast.media'

      def initialize connection
        super(connection, NAMESPACE, :json)
        @request_id = 0
      end

      def get_status
        send(type: 'GET_STATUS')
      end

      def pause
        send(type: 'PAUSE')
      end

      private

      def next_request_id
        @request_id += 1
      end
      
      def send data
        super(data.merge(
          requestId: next_request_id,
          mediaSessionId: '0B5C6066-F8B2-77F4-E5F1-8CEC223F0A22'
        ))
        @request_id
      end
    end
  end
end
