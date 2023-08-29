docker build -t soheilr/multi-client:latest -t soheilr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t soheilr/multi-server:latest -t soheilr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t soheilr/multi-worker:latest -t soheilr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push soheilr/multi-client:latest
docker push soheilr/multi-server:latest
docker push soheilr/multi-worker:latest

docker push soheilr/multi-client:$SHA
docker push soheilr/multi-server:$SHA
docker push soheilr/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployment/client-deployment client=soheilr/multi-client:$SHA
kubectl set image deployment/server-deployment server=soheilr/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=soheilr/multi-worker:$SHA