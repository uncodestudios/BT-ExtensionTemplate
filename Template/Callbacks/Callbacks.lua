-- Callbacks.lua
-- Manages our single Callback to showcase how extensions can be split across lua files
-- MAKE SURE EVERY FILE YOUR EXTENSION USES IS IN THE .config

function OnTriggerEnterCallback(other) -- other is a Collider
    if other:CompareTag("Player") then
        Debug:Log("Player passed through trigger!")
    end
end
