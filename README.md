# NGINX Playground 

Using OpenResty to learn how to build a project with NGINX and Lua.

There are two branches that should be explained:

- `comments` - holds commentary explaining the basics of the NGINX configuration file.
- `nginx-upstream-balacing` - shows an example of NGINX's standard upstreaming balancing using a hard-coded hash key.

The `master` branch holds the primary purpose of the repository. To implement a dynamic upstream strategy using [OpenResty's balancer module](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block).

To build and run the application using Docker:

`make run`

To reload NGINX configuration without having to rebuild the container:

`make reload`

After the container is up, use the following example requests to see the dynamic balancing in action.

```
curl -v localhost:8080/prefix/final/fantasy.mp4
curl -v localhost:8080/prefix/final/destination.mp4
curl -v localhost:8080/prefix/final/champions/league.mp4
```

By default, the first two hosts are returning 5xx errors and the proxy pass is redirecting the requests to the third host. But you can play around with other scenarios by simply changing the returned status code of each destination server.