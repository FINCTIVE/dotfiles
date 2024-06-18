rm -f nohup.out

nohup kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80 &
nohup kubectl port-forward svc/istio-ingressgateway -n istio-system 8443:443 &
nohup kubectl port-forward svc/grafana -n istio-system 3000:3000 &
nohup kubectl port-forward svc/locust-master -n locust 8089:8089 &