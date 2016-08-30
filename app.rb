# run with `puma -C app.rb`

THROTTLE = ENV['THROTTLE'].to_f || 0
THREADS_MIN = ENV['THREADS_MIN'].to_i || 0
THREADS_MAX = ENV['THREADS_MAX'].to_i || 16

puts "Using #{THROTTLE} s throttle."

BODY = "ALL YOUR BASE ARE BELONG TO US".freeze
RESPONSE = [
  200,
  {
    'Content-Type' => 'text/plain',
    'Content-Length' => BODY.length.to_s
  },
  [BODY]].freeze

app do
  sleep THROTTLE
  RESPONSE
end

threads THREADS_MIN, THREADS_MAX

activate_control_app 'unix:///pumactl.sock', no_token: true
