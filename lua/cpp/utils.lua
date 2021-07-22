local M = {}

local function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function M.path_shortening(s)
    b,c = string.find(s,"(%w+)%.")
    s = string.sub(s,b,c - 1)
    return s
end

function M.change_func(s, class)
    b,c = string.find(s," (%w+)%(")
    if b == nil then
        b,c = string.find(s," (%w+) %(")
    end
    if b == nil then
        b,c = string.find(s," (%w+)_(%w+)%(")
    end
    if b == nil then
        b,c = string.find(s," (%w+)_(%w+) %(")
    end
    s =  {string.sub(s,5,b) .. class .. "::" .. string.sub(s,b + 1,#s - 1) .. "{","\t","}"}
    return s
end

local function file_exists(buffer)
    local find = io.popen("find ./ -name '*.cpp'")
    local result = split(find:read("*a"), "\n")
    for v,k in ipairs(result) do 
        if string.find(k, "Todo") ~= nil then
            return true, k
        end
    end
    return false, nil
end

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
