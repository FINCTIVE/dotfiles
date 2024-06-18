kubectl cp $FILENAME nginx:/usr/share/nginx/html/

echo "how to get this file"

echo "wget $NGINX_URL/$FILENAME"
echo "NGINX_URL example: nginx.default.svc.cluster.local"

