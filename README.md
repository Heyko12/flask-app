# Запуск скрипта
chmod +x deploy.sh && ./deploy.sh

# Запуск curl-пода с балансировкой
kubectl run -i --tty busybox --image=ubuntu --restart=Never -- /bin/sh

apt-get update

apt-get install curl

# Запись сообщений в логи с балансировкой из curl-пода
curl -X POST http://flask-app-service:5000/log -H "Content-Type: application/json" -d '{"message": "text"}'

# Из терминала запускаем команду для получения логов DaemonSet
kubectl logs $(kubectl get pods --no-headers | grep '^log-agent' | awk '{print $1}')

# Или через стандартную команду, но нужно имя пода
kubectl logs \<log-agent-pod\>

# Получить значение timestamp
kubectl exec -it \<log-archiver-pod\> -- /bin/sh

cd tmp && ls

exit

# Получение и разархивирование логов
kubectl cp \<log-archiver-pod\>:/tmp/app-logs-\<timestamp\>.tar.gz ./app-logs.tar.gz

tar -xzvf app-logs.tar.gz

cd tmp && cat app-logs-\<timestamp\>.log

# В конце очистим ресурсы и остановим minikube
chmod +x clear.sh && ./clear.sh
