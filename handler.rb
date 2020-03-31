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
