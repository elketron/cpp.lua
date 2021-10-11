-- helper functions for arduino
-- compile function
-- upload function
-- serial terminal functionality
local utils = require"funcs.utils"

local M = {}

M.compile_options = {fqbn = "arduino:avr:nano"}
M.upload_options = {
    fqbn = "arduino:avr:nano:cpu=atmega328Bold",
    port = ""
}

local function get_port()
    local out = vim.api.nvim_exec(":! arduino-cli board list",true)
    x,y = out:find("/dev/ttyUSB.")
    return out:sub(x,y)
end

function M.arduino_compile()
    file_name = utils.path_shortening(vim.api.nvim_buf_get_name(0))
    local output = vim.api.nvim_exec(":! arduino-cli compile --fqbn "..M.compile_options.fqbn.. " ".. file_name,true)
    print(output)
end

function M.arduino_upload()
   file_name = utils.path_shortening(vim.api.nvim_buf_get_name(0))
   if M.upload_options.port == "" then
        M.upload_options.port = get_port()
   end
   local output = vim.api.nvim_exec(":! arduino-cli upload -p ".. upload_options.port..  " --fqbn ".. upload_options.fqbn .. " ".. file_name)
   print(output)
end

return M

