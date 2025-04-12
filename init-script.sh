#!/bin/bash

# Update
yum update -y

# Install Docker and Docker Compose
yum install -y docker

mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.35.0/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Download production files from S3
aws s3api get-object --bucket jhops881-web-server-files --key docker-compose.yaml /home/ec2-user/docker-compose.yaml
aws s3api get-object --bucket jhops881-web-server-files --key nginx.conf /home/ec2-user/nginx.conf

cd /home/ec2-user

# Update domain in NGINX config from localhost to production domain
sed -i 's/localhost/jhops\.me/g' nginx.conf # change from the dev to production domain name.

# Exchange local dev builds for the production images
# 'build: ./<>'  ->  'image: jhops881/<>-server-image:latest'
sed -i 's/build: \.\/www/image: jhops881\/www-server-image:latest/g' docker-compose.yaml
sed -i 's/build: \.\/api/image: jhops881\/api-server-image:latest/g' docker-compose.yaml

# Turn on the Docker service
systemctl enable --now docker

until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker to start..."
  sleep 2
done

# Start the web servers
docker compose up -d