local mkfun = require("funcs.cpp")
local comment = require("funcs.comment")
local ard = require("funcs.arduino")
local M = {}

M.mkfun = mkfun.mkfun
M.com = comment.comment
M.unc = comment.uncomment
M.acom = ard.arduino_compile
M.aup = ard.arduino_upload

return M

