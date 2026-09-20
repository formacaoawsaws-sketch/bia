#!/bin/bash

set -e

ECR_REGISTRY="367429572766.dkr.ecr.us-east-1.amazonaws.com"
ECR_REPO="bia"
VITE_API_URL="bia-alb-855318757.us-east-1.elb.amazonaws.com"
CLUSTER="CLUSTER-BIA-ALB"
SERVICE="service-bia-alb"
REGION="us-east-1"

echo "==> Login no ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

echo "==> Build da imagem Docker..."
docker build --no-cache \
  --build-arg VITE_API_URL=$VITE_API_URL \
  -t $ECR_REGISTRY/$ECR_REPO:latest .

echo "==> Push da imagem para o ECR..."
docker push $ECR_REGISTRY/$ECR_REPO:latest

echo "==> Forçando novo deploy no ECS..."
aws ecs update-service \
  --cluster $CLUSTER \
  --service $SERVICE \
  --force-new-deployment \
  --region $REGION \
  --query 'service.{status:status,desiredCount:desiredCount,runningCount:runningCount}'

echo ""
echo "✅ Deploy concluído! A nova versão estará disponível em ~1-2 minutos."
