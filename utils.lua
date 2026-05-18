--- @enum LogLevel
local LogLevel = {
  ALL = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
}

--- @class Logger
--- @field file file* File handle for the log file
--- @field level LogLevel The minimum log level to log
local Logger = {}

function Logger:new(filename)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  obj.file = io.open(filename, 'a')
  obj.level = LogLevel.ALL
  return obj
end

--- @param level LogLevel|number The minimum log level to log
function Logger:set_level(level)
  self.level = level
end

function Logger:log(message)
  local timestamp = os.date '%Y-%m-%d %H:%M:%S'
  self.file:write(string.format('[%s] %s\n', timestamp, message))
  self.file:flush()
end

--- Match a tag against a list of tags
---
--- @param tag string The tag to match
--- @param tags string[] | string The list of tags to match against, or a single
local function match_tag(tag, tags)
  local tag_star = tag .. '*'

  if type(tags) == 'string' then
    return tag == tags or tag_star == tags
  end

  if type(tags) == 'table' then
    for _, t in ipairs(tags) do
      if tag == t or tag_star == t then
        return true
      end
    end
  end

  return false
end

return {
  Logger = Logger,
  match_tag = match_tag,
}
