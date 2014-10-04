module Chromecast
  class Tasks
    include Rake::DSL if defined? Rake::DSL

    def install_tasks
      desc "Setup all necessary files"
      task setup: ['setup:protocol', 'setup:certificate']

      namespace :setup do
        desc "Generate certificates for TLS"
        task :certificate do
          system('openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout certificate.key -out certificate.crt')
        end

        desc "Generate Ruby code for Chromecast protocol"
        task :protocol do
          system('protoc --ruby_out lib/chromecast/ protocol.proto && echo Generated protocol code')
        end
      end
    end
  end
end

Chromecast::Tasks.new.install_tasks
