-- take a function template
-- add the class name / namespace
-- place in anothef file
--
-- class bananas
-- void name(int banana);
-- void bananas::name(int banana){
--
-- }
-- writes to another file
local utils = require("cpp.utils")

local M = {}

function M.mkfun()
    local class_name = utils.path_shortening(vim.api.nvim_buf_get_name(0))
    local or_func = utils.change_func(vim.api.nvim_get_current_line(), class_name)  -- original function

    utils.file_write(class_name,or_func, -1)
    vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(0) - 1,0})
end

return M
