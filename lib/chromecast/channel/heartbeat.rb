module Chromecast
  module Channel
    class Heartbeat < Base
      NAMESPACE = 'urn:x-cast:com.google.cast.tp.heartbeat'
      
      def initialize connection
        super(connection, NAMESPACE, :json)
      end

      def ping
        send(type: 'PING')
      end

      def pong
        send(type: 'PONG')
      end
    end
  end
end

