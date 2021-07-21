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
local M = {}

local function path_shortening(s)
    b,c = string.find(s,"(%w+)%.")
    s = string.sub(s,b,c - 1)
    return s
end

local function change_func(s, class)
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

local function file_write(buffer,input, index)
        local check,id = is_buf_open(buffer)
        if check then
            print(id)
            vim.api.nvim_buf_set_lines(id,index - 1, index, false, input)  
        else
            local k,l = file_exists(buffer)
            if k then

        end
end

function M.mkfun()
    local class_name = path_shortening(vim.api.nvim_buf_get_name(0))
    local or_func = change_func(vim.api.nvim_get_current_line(), class_name)  -- original function

    --print(or_func)
    file_write(class_name,or_func, -1)
end

-- file exists and is open = write to file 
-- file exists and is not open = open file & then wite fo file
-- file doesn't exist = create file & write to

local function create_file()
end

local function file_exists(buffer)
    local files = os.execute("find ./ -name '*.cpp'")
    for k,l in ipairs(files) do
        if path_shortening(files[k]) == buffer then
            return true, files[k]
        end
    end
    return false, nil
end

local function open_file()

end
-- return bool
function is_buf_open(s)
    local buffers = vim.api.nvim_list_bufs()
    local bufs = ""
    for k,l in ipairs(buffers) do
        local file = path_shortening(vim.api.nvim_buf_get_name(l))
        print(vim.api.nvim_buf_get_name(l), l, k)
        if file == s and k ~= 1 then
            return true, l
        end
    end
    return false
end

return M
