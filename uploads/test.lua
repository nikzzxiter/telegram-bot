-- Dummy Lua script 1KB

print("Starting Lua test...")

function fillText()
    local text = ""
    local base = "1234567890abcdef"

    for i = 1, 50 do
        text = text .. base .. " line " .. i .. "\n"
    end

    return text
end

local dummy1 = "Test string one for Lua"
local dummy2 = "Test string two for Lua"
local dummy3 = "More filler data here"

for i = 1, 30 do
    print(dummy1)
    print(dummy2)
    print(dummy3)
end

print(fillText())
