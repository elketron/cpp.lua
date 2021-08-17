local utils = require"funcs.utils"

local function print_arr(arr)
    for  _,k in ipairs(arr) do
        print(_,k)
    end
end

local function init(lines)
    local win_pos = vim.api.nvim_win_get_cursor(0) -- get current cursor position
    local line = vim.api.nvim_buf_get_lines(0,win_pos[1] - 1, win_pos[1] + lines - 1, false)
    local ext = utils.split(vim.api.nvim_buf_get_name(0),"%.")
    return win_pos[1], line, ext[2]
end


local M = {}

-- this file type variable is only here for the exeptions
M.file_type = {
    ["lua"] = "--",
    ["hs"]  = "--",
    ["py"]  = "#"
}

local function set_comment_option(ext)
    for  v,k in next, M.file_type, nil do
        if v == string.sub(ext, 1, #ext - 1) then
            return k
        end
    end
    return "//"
end
-- get current line
-- get file extension
-- place comment symbol at beginning of line
-- do for all lines
function M.comment(lines)
    local pos,line,ext = init(lines)
    local com_opt = set_comment_option(ext)
    
    --change line to commented line
    for  _,k in ipairs(line) do
        line[_] = com_opt .. " " .. line[_]
    end

    --set lines
    vim.api.nvim_buf_set_lines(0,pos - 1, pos + lines - 1, false, line)

end

function M.uncomment(lines)
    local pos,line,ext = init(lines)
    local com_opt = set_comment_option(ext)
    local com_len = #com_opt + 2 -- lenght of comment option + space character
    
    for  _,k in ipairs(line) do
        line[_] = string.sub(line[_], com_len, #line[_])
    end

    vim.api.nvim_buf_set_lines(0,pos - 1, pos + lines - 1, false , line)
end

return M
