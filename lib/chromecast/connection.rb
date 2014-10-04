require 'rubygems'
require 'json'
require 'socket'
require 'openssl'

module Chromecast
  class Connection
    DEFAULT_PORT          = 8009
    DEFAULT_SOURCE        = 'source-0'
    DEFAULT_DESTINATION   = 'receiver-0'

    attr_reader :host, :port, :source, :destination, :socket
    attr_accessor :key_file, :crt_file

    def initialize(host)
      @host         = host
      @port         = DEFAULT_PORT
      @source       = DEFAULT_SOURCE
      @destination  = DEFAULT_DESTINATION
      @key_file     = 'certificate.key'
      @crt_file     = 'certificate.crt'
    end

    def certificate(type)
      case type
        when :crt
          return File.open(crt_file).read
        when :key
          return File.open(key_file).read
      end
      return nil
    end

    def open
      tcp = TCPSocket.new(host, port)
      ctx = OpenSSL::SSL::SSLContext.new
      ctx.cert = OpenSSL::X509::Certificate.new(certificate(:crt))
      ctx.key = OpenSSL::PKey::RSA.new(certificate(:key))
      ctx.ssl_version = :SSLv23
      ctx.set_params(verify_mode: OpenSSL::SSL::VERIFY_NONE)

      @socket = OpenSSL::SSL::SSLSocket.new(tcp, ctx).tap do |socket|
        socket.sync_close = true
        socket.connect
      end

      self
    end

    def write data
      @socket.write data
    end

    def has_data?
      ready = IO.select([@socket], nil, nil, 0)

      return ready != nil
    end

    def read
      return nil unless has_data?

      resp_size = @socket.read(4).unpack('N').first
      resp_data = @socket.read(resp_size)

      resp = Protocol::CastMessage.decode(resp_data)

      JSON.parse(resp.payload_utf8)
    end

    def connection
      @connection_channel ||= Channel::Connection.new(self)
    end

    def receiver
      @receiver_channel ||= Channel::Receiver.new(self)
    end

    def heartbeat
      @heartbeat_channel ||= Channel::Heartbeat.new(self)
    end

    def media
      @media_channel ||= Channel::Media.new(self)
    end
  end
end
