---@class Utils
---@field fn    Utils.Fn
---@field class Utils.Class
---@field picker Utils.Class.Picker
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

return M
