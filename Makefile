run-nginx:
	openresty -p `pwd` -c conf/nginx.conf

stop-nginx:
	openresty -p `pwd` -c conf/nginx.conf -s stop

reload-nginx:
	openresty -p `pwd` -c conf/nginx.conf -s reload