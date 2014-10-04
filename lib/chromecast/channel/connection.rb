module Chromecast
  module Channel
    class Connection < Base
      NAMESPACE = 'urn:x-cast:com.google.cast.tp.connection'
      
      def initialize connection
        super(connection, NAMESPACE, :json)
      end

      def connect
        send(type: 'CONNECT')
      end

      def close
        send(type: 'CLOSE')
      end
    end
  end
end
