./build.sh
aws ecs update-service --cluster Cluster-bia2 --service service-bia2 --force-new-deployment
