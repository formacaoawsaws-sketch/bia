#!/bin/bash

set -e

# ============================================================
# PASSO 1 — Informe o novo IP público do frontend (EC2 do ECS)
# ============================================================
if [ -z "$1" ]; then
  echo ""
  echo "Uso: ./comunicacao.sh <novo-ip-frontend>"
  echo "Exemplo: ./comunicacao.sh 3.87.162.133"
  echo ""
  exit 1
fi

NOVO_IP=$1
VITE_API_URL="http://$NOVO_IP"

ECR_REGISTRY="367429572766.dkr.ecr.us-east-1.amazonaws.com"
ECR_REPO="bia"
CLUSTER="Cluster-bia2"
SERVICE="service-bia2"
REGION="us-east-1"

echo ""
echo "================================================="
echo " BIA — Restaurando comunicação da aplicação"
echo "================================================="
echo " Novo IP do frontend : $NOVO_IP"
echo " VITE_API_URL        : $VITE_API_URL"
echo "================================================="
echo ""

# ============================================================
# PASSO 2 — Atualiza o .env do frontend com o novo IP
# ============================================================
echo "==> Atualizando .env do frontend..."
sed -i "s|VITE_API_URL=.*|VITE_API_URL=$VITE_API_URL|g" /home/ec2-user/bia/client/.env
sed -i "s|VITE_API_URL=.*|VITE_API_URL=$VITE_API_URL|g" /home/ec2-user/bia/client/.env.production
echo "    .env atualizado com $VITE_API_URL"

# ============================================================
# PASSO 3 — Login no ECR
# ============================================================
echo ""
echo "==> Login no ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

# ============================================================
# PASSO 4 — Build da imagem com novo IP
# ============================================================
echo ""
echo "==> Build da imagem Docker com novo IP..."
cd /home/ec2-user/bia
docker build --no-cache \
  --build-arg VITE_API_URL=$VITE_API_URL \
  -t $ECR_REGISTRY/$ECR_REPO:latest .

# ============================================================
# PASSO 5 — Push para o ECR
# ============================================================
echo ""
echo "==> Push da imagem para o ECR..."
docker push $ECR_REGISTRY/$ECR_REPO:latest

# ============================================================
# PASSO 6 — Força novo deploy no ECS
# ============================================================
echo ""
echo "==> Forçando novo deploy no ECS..."
aws ecs update-service \
  --cluster $CLUSTER \
  --service $SERVICE \
  --force-new-deployment \
  --region $REGION \
  --query 'service.{status:status,desiredCount:desiredCount,runningCount:runningCount}'

echo ""
echo "================================================="
echo " ✅ Comunicação restaurada com sucesso!"
echo " A aplicação estará disponível em ~1-2 minutos."
echo " Frontend: http://$NOVO_IP"
echo "================================================="
