# Create `serverless` shout service

A simple service to transform the input string to all upcase and return it.

> Pascal Hurni, march 2020

## Create the project

`sls create -t aws-ruby -p phi-ruby-shout`

```
Serverless: Generating boilerplate...
Serverless: Generating boilerplate in "/Users/pascal.hurni/CPNV/Modules/CLD2/Exercices/serverless/phi-ruby-shout"
 _______                             __
|   _   .-----.----.--.--.-----.----|  .-----.-----.-----.
|   |___|  -__|   _|  |  |  -__|   _|  |  -__|__ --|__ --|
|____   |_____|__|  \___/|_____|__| |__|_____|_____|_____|
|   |   |             The Serverless Application Framework
|       |                           serverless.com, v1.39.1
 -------'

Serverless: Successfully generated boilerplate for template: "aws-ruby"
```

## Configure the service

`cd phi-ruby-shout`

### Modify the `serverless.yml` config file with the following:

1. Update the service name to match AWS name policies:

```
service: si-t1a-phi-ruby-shout
```

2. Add some more config (notably the bucket)

```
provider:
  region: eu-west-1
  deploymentBucket: si-t1a-serverless.cpnv.ch
```

3. Adapt the service name and function name (the one to be called later)

```
functions:
  shout:
    handler: handler.shout
```

4. Add an HTTP endpoint to be called

```
functions:
  shout:
    handler: handler.shout
    events:
      - http:
          path: shout
          method: post
```


### Update the code

Modify the handler function in `handler.rb`

```ruby
def shout(event:, context:)
  {
    statusCode: 200,
    body: event[:body].upcase
  }
end
```


## Deploy the service

First configure some keys (done only once):

`sls config credentials --provider aws --key <AWS_KEY> --secret <AWS_SECRET>`

```
Serverless: Setting up AWS...
Serverless: Saving your AWS profile in "~/.aws/credentials"...
Serverless: Success! Your AWS access keys were stored under the "default" profile.
```

Then deploy with:

`sls deploy`

```
Serverless: Packaging service...
Serverless: Excluding development dependencies...
Serverless: Uploading CloudFormation file to S3...
Serverless: Uploading artifacts...
Serverless: Uploading service si-t1a-phi-ruby-shout.zip file to S3 (216 B)...
Serverless: Validating template...
Serverless: Creating Stack...
Serverless: Checking Stack create progress...
................
Serverless: Stack create finished...
Service Information
service: si-t1a-phi-ruby-shout
stage: dev
region: eu-west-1
stack: si-t1a-phi-ruby-shout-dev
resources: 9
api keys:
  None
endpoints:
  POST - https://3aa1tuxyze.execute-api.eu-west-1.amazonaws.com/dev/shout
functions:
  shout: si-t1a-phi-ruby-shout-dev-shout
layers:
  None
```

Notice the `endpoints` part!

## Run the service

Use `curl` to talk to the endpoint:

`curl --data "Hello world, could you shout please" https://3aa1tuxyze.execute-api.eu-west-1.amazonaws.com/dev/shout`

```
HELLO WORLD, COULD YOU SHOUT PLEASE
```

## Debug the service

In case you have some errors like:

`{"message": "Internal server error"}`

Consult the log: `sls logs -f shout`

```
START RequestId: 21bafabc-c617-42e6-9ec4-357d988e5505 Version: $LATEST
Critical exception from handler
{
"errorMessage": "undefined method `upcase' for nil:NilClass",
"errorType": "Function<NoMethodError>",
"stackTrace": [
"/var/task/handler.rb:4:in `shout'"
]
}
END RequestId: 21bafabc-c617-42e6-9ec4-357d988e5505
REPORT RequestId: 21bafabc-c617-42e6-9ec4-357d988e5505	Duration: 32.80 ms	Billed Duration: 100 ms	Memory Size: 1024 MB	Max Memory Used: 40 MB	Init Duration: 128.16 ms

Unknown application error occurred
Function<NoMethodError>
```

## Image
### Test

    curl --data-binary "@test/unicorn.jpg" https://pxyiq8fk75.execute-api.eu-west-1.amazonaws.com/dev/sepia -o "test/unicorncopy.jpg"



