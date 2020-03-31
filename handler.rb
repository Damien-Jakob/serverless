require 'json'

def to_upper_case(event:, context:)
  begin
    {
        statusCode: 200,
        body: event["body"].upcase,
    }
  rescue StandardError => e
    {
        statusCode: 400,
        body: e.message,
    }.to_json
  end
end

def sepia(event:, context:)
  begin
    puts event
    {
        statusCode: 200,
        body: event,
    }.to_json
  rescue StandardError => e
    {
        statusCode: 400,
        body: e.message,
    }.to_json
  end
end
