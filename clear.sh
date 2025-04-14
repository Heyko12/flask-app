kubectl delete -f cronjob.yaml
kubectl delete -f log-reader-rolebinding.yaml
kubectl delete -f log-reader-role.yaml
kubectl delete -f DaemonSet.yaml
kubectl delete -f flask-app.yaml
kubectl delete -f service.yaml
kubectl delete -f configmap.yaml
kubectl delete pod busybox
# minikube stop