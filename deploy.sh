set -x
set -e

echo "Запуск minikube..."
minikube start

echo "Сборка Docker-образа..."
eval $(minikube -p minikube docker-env)
docker build -t flask-app-image .

echo "Применение ConfigMap..."
kubectl apply -f configmap.yaml

echo "Применение Service..."
kubectl apply -f service.yaml

echo "Применение Deployment для Flask-приложения..."
kubectl apply -f flask-app.yaml

echo "Применение DaemonSet..."
kubectl apply -f DaemonSet.yaml

echo "Применение CronJob..."
kubectl apply -f log-reader-role.yaml
kubectl apply -f log-reader-rolebinding.yaml
kubectl apply -f cronjob.yaml

echo "Развертывание заmeвершено."
sleep 10
kubectl wait --for=condition=ready pod -l app=flask-app --timeout=120s
kubectl get all