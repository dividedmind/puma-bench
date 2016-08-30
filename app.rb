# run with `puma -C app.rb`
THROTTLE = (ENV['THROTTLE'] || 0).to_f
THREADS_MIN = (ENV['THREADS_MIN'] || 0).to_i
THREADS_MAX = (ENV['THREADS_MAX'] || 16).to_i

puts "Using #{THROTTLE} s throttle."

$out = STDOUT

BODY = "ALL YOUR BASE ARE BELONG TO US".freeze
RESPONSE = [
  200,
  {
    'Content-Type' => 'text/plain',
    'Content-Length' => BODY.length.to_s
  },
  [BODY]].freeze

app do |env|
  sleep THROTTLE
  RESPONSE
end

threads THREADS_MIN, THREADS_MAX

activate_control_app 'unix:///tmp/pumactl.sock', no_token: true
