require 'json'

def to_upper_case(event:, context:)
  begin
    puts "Received Request: #{event}"
    {
        statusCode: 200,
        body: event["body"].upcase,
    }
  rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
    {
        statusCode: 400,
        body: e.message,
    }.to_json
  end
end
