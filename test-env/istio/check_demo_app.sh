echo "curl is running... The response may be slow.\n"
RATINGS_POD_NAME=$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')
kubectl exec "$RATINGS_POD_NAME" -c ratings -- curl -vsS productpage:9080/productpage | grep -o "<title>.*</title>"
