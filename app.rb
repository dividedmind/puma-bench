# run with `puma -C app.rb`

require './puma_max_backlog'

THROTTLE = (ENV['THROTTLE'] || 0).to_f
THREADS_MIN = (ENV['THREADS_MIN'] || 0).to_i
THREADS_MAX = (ENV['THREADS_MAX'] || 16).to_i
MAX_BACKLOG = (ENV['MAX_BACKLOG'] || 31337).to_i

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

max_backlog = PumaMaxBacklog.new '/throttle', MAX_BACKLOG
app do |env|
  max_backlog.check
  sleep THROTTLE
  RESPONSE
end

threads THREADS_MIN, THREADS_MAX
