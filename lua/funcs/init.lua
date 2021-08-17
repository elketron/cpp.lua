local mkfun = require("funcs.cpp")
local comment = require("funcs.comment")
local M = {}

M.mkfun = mkfun.mkfun
M.com = comment.comment
M.unc = comment.uncomment

return M

