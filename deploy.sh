docker build -t xwy5201314/multi-client:latest -t xwy5201314/multi-client:$SHA ./client
docker build -t xwy5201314/multi-server:latest -t xwy5201314/multi-server:$SHA ./server
docker build -t xwy5201314/multi-worker:latest -t xwy5201314/multi-worker:$SHA ./worker

# Take those images and push them to docker hub
docker push xwy5201314/multi-client:latest
docker push xwy5201314/multi-server:latest
docker push xwy5201314/multi-worker:latest

docker push xwy5201314/multi-client:$SHA
docker push xwy5201314/multi-server:$SHA
docker push xwy5201314/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xwy5201314/multi-server:$SHA
kubectl set image deployments/client-deployment client=xwy5201314/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xwy5201314/multi-worker:$SHA
