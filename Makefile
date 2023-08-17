# Build using openresty commands
start-nginx:
	openresty -p `pwd` -c conf/nginx.conf

stop-nginx:
	openresty -p `pwd` -c conf/nginx.conf -s stop

reload-nginx:
	openresty -p `pwd` -c conf/nginx.conf -s reload

# Build using Docker containers (recommended)
build:
	docker-compose build

run: build
	docker-compose up

stop:
	docker-compose down

reload:
	docker-compose exec nginx openresty -s reload