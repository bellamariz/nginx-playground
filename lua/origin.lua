local cjson = require "cjson"
local requests = require "resty.requests"
local origin = {}

-- mock data for hosts and paths for proxy_pass
-- this data is saved to a shared dict with the key being the <destination> field in the request URI
local mock_pass = function(destination)
  local proxy_pass_data = {
    ["hosts"] = {"127.0.0.2", "127.0.0.3", "127.0.0.4"},
    ["paths"] = {
      ["default"] = "final/" .. destination .. ".mp4"
    }
  } 

  ngx.shared.cached_pass_data:set(destination, cjson.encode(proxy_pass_data))
end

-- access hosts and paths for <destination> 
-- save these values to the ctx table (nginx request context table)
origin.proxy_pass_data = function(destination)
  mock_pass(destination)
  
  local cached_pass_data = ngx.shared["cached_pass_data"]
  local destination_data = cached_pass_data:get(destination)
  local hosts_and_paths = cjson.decode(destination_data)
  local path = hosts_and_paths["paths"]["default"]

  ngx.ctx.hosts = hosts_and_paths.hosts
  ngx.ctx.path = hosts_and_paths["paths"]["default"]
end

return origin

