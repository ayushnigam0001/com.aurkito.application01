#!/bin/bash

# Fail the script if any command fails
set -e

# Create a temporary SSH key file
echo touch command
touch /tmp/deploy_key.pem
echo cat private key command
cat PRIVATE.key > /tmp/deploy_key.pem
echo permission 600
chmod 600 /tmp/deploy_key.pem

# Connect to the EC2 instance and perform deployment steps
ssh -i /tmp/deploy_key.pem -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << 'EOF'
  echo Pulling the Docker image.
  docker pull $DOCKERHUB_USERNAME/my-app-image:latest

  echo Stopping and removing existing container...
  docker stop my-app-container || true
  docker rm my-app-container || true

  echo Running new container...
  docker run -d --name my-app-container -p 80:80 $DOCKER_USERNAME/my-app-image:latest
EOF
