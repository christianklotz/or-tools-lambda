# or-tools-lambda

Package Python applications using [Google or-tools](https://developers.google.com/optimization/)
for [AWS Lambda](https://aws.amazon.com/lambda).

Instead of creating and configuring your own EC2 instance to work around the 
installations requirements to run the application on Lambda, `or-tools-lambda` 
uses Docker to create a deployable package locally.


## Prerequisites

You'll need to have [Docker](https://www.docker.com) installed. Clone the repo 
to package the `handler.py` sample function that includes a basic program using
`or-tools` .

To make this work with your existing Python project, simply add `Dockerfile` 
and `package.sh`.


## Build

The `package.sh` creates a `dist` folder and `dist.zip` containing the folder 
contents as well as `or-tools` dependency.

First, build the Docker image.

    $ docker build -t or-tools-lambda .


Run `package.sh` within the Docker container.

    $ docker run --rm -v $(pwd):/handler -w /handler -i or-tools-lambda ./package.sh


> **Note:** The `package.sh` script does not check for or installs any 
> additional that you may have added to your Python application.
> Should you require any, follow the instructions in the [AWS Lambda documentation](http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html)
> and adjust `package.sh` accordingly, so all dependencies are  included in the
> resulting `dist.zip`.


## Deploy

If you want to test the application on AWS Lambda, upload `dist.zip` using the 
AWS console or the [AWS CLI](https://aws.amazon.com/cli‎).

    $ aws lambda update-function-code --function-name MyLambdaFunction --zip-file fileb://dist.zip


After invoking the function you should see something like this.

```json
"{\"x\": 1.0, \"y\": 2.0}"
```


## Acknowledgements

The approach was originally described in [tunamonster/aws_lambda_ortools](https://github.com/tunamonster/aws_lambda_ortools).