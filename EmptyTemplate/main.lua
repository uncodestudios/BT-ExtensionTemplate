-- Basic Empty Lua Extension
local canRun = false

function Start()
    -- Your Code
end

function Update()
    if not canRun then
        return
    end
end

function OnUnloaded()
    canRun = false
end