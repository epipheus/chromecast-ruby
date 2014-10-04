module Chromecast
  module Channel
    class Base
      attr_accessor :connection, :namespace, :type

      def initialize connection, namespace, type
        self.connection = connection
        self.namespace  = namespace
        self.type       = type
      end

      def send data
        #puts "SEND: #{data}"
        #puts ""

        msg = new_message(data)

        encoded = msg.encode
        size = [encoded.size].pack('N')

        connection.write(size + encoded)

        return nil
      end

      private

      def new_message(payload)
        m = Protocol::CastMessage.new

        m.protocol_version = Protocol::CastMessage::ProtocolVersion::CASTV2_1_0
        m.source_id = connection.source
        m.destination_id = connection.destination
        m.namespace = namespace

        case type
          when :json
            m.payload_type = Protocol::CastMessage::PayloadType::STRING
            m.payload_utf8 = payload.to_json
          when :string
            m.payload_type = Protocol::CastMessage::PayloadType::STRING
            m.payload_utf8 = payload
          when :binary
            m.payload_type = Protocol::CastMessage::PayloadType::BINARY
            m.payload_binary = payload
        end

        return m
      end
    end
  end
end
