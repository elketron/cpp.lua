local M = {}

local patterns = {
    " (%w+)%(",
    " (%w+) %(", 
    " (%w+)_(%w+)%(",
    " (%w+)_(%w+) %(",
    " (%w+)%g%(",
    " (%w+)%g %(",
    " (%w+)%g%g%(",
    " (%w+)%g%g %(",
    " (%w+)%g%g%g%(",
    " (%w+)%g%g%g %(" 
}

-- split a string into a table
function M.split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

-- make the path shorter to where only the name of the file remains
function M.path_shortening(s)
    b,c = string.find(s,"(%w+)%.")
    s = string.sub(s,b,c - 1)
    return s
end

-- change function prototype to normal function
function M.change_func(s, class)
    for k,v in ipairs(patterns) do
        b,c = string.find(s,v)
        if b ~= nil then
            break
        end
    end
    s =  {string.sub(s,5,b) .. class .. "::" .. string.sub(s,b + 1,#s - 1) .. "{","}"}
    return s
end

-- search files in file structure and return true if it is found
local function file_exists(buffer)
    local find = io.popen("find ./ -name '*.cpp'")
    local result = M.split(find:read("*a"), "\n")
    for v,k in ipairs(result) do 
        if string.find(k, "Todo") ~= nil then
            return true, k
        end
    end
    return false, nil
end

-- write to file 
function M.file_write(buffer,input, index)
    local k,id = file_exists(buffer)
    if k then
        vim.api.nvim_command("edit " .. id)
        vim.api.nvim_buf_set_lines(id,index - 1, index, false, input)  
    else
        print("file" .. buffer .. ".cpp doesn't exist" )
    end
end

return M
