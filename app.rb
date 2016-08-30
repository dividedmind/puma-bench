# run with `puma -C app.rb`

BODY = "ALL YOUR BASE ARE BELONG TO US".freeze
RESPONSE = [
  200,
  {
    'Content-Type' => 'text/plain',
    'Content-Length' => BODY.length.to_s
  },
  [BODY]].freeze

app { RESPONSE }
