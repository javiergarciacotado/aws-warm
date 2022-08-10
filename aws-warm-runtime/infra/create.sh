# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name an-example-network \
  --template-body file://network.yaml \
  --capabilities CAPABILITY_IAM

aws cloudformation wait stack-create-complete \
  --stack-name an-example-network

aws cloudformation create-stack \
  --stack-name an-example-service \
  --template-body file://service.yaml \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=a-basic-network \
      ParameterKey=ServiceName,ParameterValue=aws-warm-v1 \
      ParameterKey=ImageUrl,ParameterValue=docker.io/library/aws-warm:latest \
      ParameterKey=ContainerPort,ParameterValue=9090

aws cloudformation wait stack-create-complete --stack-name an-example-service

CLUSTER_NAME=$(aws cloudformation describe-stacks --stack-name an-example-network --output text --query 'Stacks[0].Outputs[?OutputKey==`ClusterName`].OutputValue | [0]')
echo "ECS Cluster:       " $CLUSTER_NAME

TASK_ARN=$(aws ecs list-tasks --cluster $CLUSTER_NAME --output text --query 'taskArns[0]')
echo "ECS Task:          " $TASK_ARN

ENI_ID=$(aws ecs describe-tasks --cluster $CLUSTER_NAME --tasks $TASK_ARN --output text --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value')
echo "Network Interface: " $ENI_ID

PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --output text --query 'NetworkInterfaces[0].Association.PublicIp')
echo "Public IP:         " $PUBLIC_IP

echo "You can access your service at http://$PUBLIC_IP:9090"