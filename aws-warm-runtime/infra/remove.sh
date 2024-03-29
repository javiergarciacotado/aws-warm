# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation delete-stack \
  --stack-name an-example-service

aws cloudformation wait stack-delete-complete \
  --stack-name an-example-service

aws cloudformation delete-stack \
  --stack-name an-example-network

aws cloudformation wait stack-delete-complete \
  --stack-name an-example-network