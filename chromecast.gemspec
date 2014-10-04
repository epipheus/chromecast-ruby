Gem::Specification.new do |s|
  s.name        = "chromecast"
  s.version     = "1.0"
  s.date        = "2014-10-04"
  s.summary     = "Basic Chromecast controll via a Ruby library"
  s.description = "The gem lets you monitor Chromecast status, control volume and launch apps."
  s.authors     = ["Robert Nasiadek"]
  s.files       = [
    "init.rb",
    "lib/chromecast.rb",
    "lib/chromecast/tasks.rb",
    "lib/chromecast/protocol.pb.rb",
    "lib/chromecast/channel/media.rb",
    "lib/chromecast/channel/connection.rb",
    "lib/chromecast/channel/base.rb",
    "lib/chromecast/channel/receiver.rb",
    "lib/chromecast/channel/heartbeat.rb",
    "lib/chromecast/connection.rb",
    "lib/chromecast/application.rb",
    "lib/chromecast/channel.rb",
    "protocol.proto",
    "README",
    "chromecast.gemspec"
  ]
  s.email       = "robert@kapati.net"
  s.homepage    = "http://robzon.pl/"
  s.license     = "MIT"

  s.add_runtime_dependency 'ruby-tls', '>= 1.0.3'
  s.add_runtime_dependency 'protobuf', '>= 3.3.5'
end
