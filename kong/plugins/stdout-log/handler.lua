local cjson = require "cjson"
local basic_serializer = require "kong.plugins.log-serializers.basic"

local BasePlugin = require "kong.plugins.base_plugin"
local StdoutLogHandler = BasePlugin:extend()

StdoutLogHandler.PRIORITY = 9
StdoutLogHandler.VERSION = "0.0.1"

function StdoutLogHandler:new()
  StdoutLogHandler.super.new(self, "stdout-log")
end

function StdoutLogHandler:log(conf)
  StdoutLogHandler.super.log(self)
  local message = cjson.encode(basic_serializer.serialize(ngx))
  message = message:gsub("apikey%=(%w+)", "apikey=xxx"):gsub("authorization\":\"([^%\"]+)", "authorization\":\"xxx")
  print(message)
end

return StdoutLogHandler
