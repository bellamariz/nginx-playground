local cjson = require "cjson"
local requests = require "resty.requests"
local origin = {}

local mock_pass = function()
  local proxy_pass_data = {
    ["hosts"] = {"127.0.0.2", "127.0.0.3", "127.0.0.4"},
    ["paths"] = {
      ["default"] = "anything-i-want"
    }
  } 

  ngx.shared.cached_pass_data:set("destination", cjson.encode(proxy_pass_data))
end

origin.proxy_pass_data = function(channel)
  mock_pass()
  
  local cached_pass_data = ngx.shared["cached_pass_data"]
  local destination_data = cached_pass_data:get("destination")
  local hosts_and_paths = cjson.decode(destination_data)
  local path = hosts_and_paths["paths"]["default"]

  ngx.ctx.hosts = hosts_and_paths.hosts
  ngx.ctx.path = hosts_and_paths["paths"]["default"]
end

return origin

