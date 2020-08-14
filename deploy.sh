docker build -t hasanmubarok/multi-client:latest -t hasanmubarok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hasanmubarok/multi-server:latest -t hasanmubarok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hasanmubarok/multi-worker:latest -t hasanmubarok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hasanmubarok/multi-client:latest
docker push hasanmubarok/multi-server:latest
docker push hasanmubarok/multi-worker:latest

docker push hasanmubarok/multi-client:$SHA
docker push hasanmubarok/multi-server:$SHA
docker push hasanmubarok/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hasanmubarok/multi-server:$SHA
kubectl set image deployments/client-deployment client=hasanmubarok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hasanmubarok/multi-worker:$SHA
