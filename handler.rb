require 'json'

def to_upper_case(event:, context:)
  begin
    puts "Received Request: #{event}"
    {
        statusCode: 200,
        body: {
            message: 'Serverless toUpperCase',
            input: event[:body].upcase
        }.to_json
    }
  rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
    {
        statusCode: 400,
        body: JSON.generate("Bad request, please POST a request body!")
    }
  end
end
