-- Basic Lua Extension
local rightHandRef  =  nil
local playerReference  =  nil
local canRun  =  nil -- Recommened to use this when using Update functions. NOTE: If your code encounters even a single error in its functions
-- Your extension will be disabled until next game launch or until the user (If they have 'LUtilla' installed) reloads their extensions
local colliderCube  =  nil

function Start()
    Debug:Log("Template Mod: Start()")
    rightHandRef  =  Engine:FindGameObject("RightHand Controller")
    playerReference  =  Engine:FindGameObject("MainPlayer")
    colliderCube  =  Engine:CreateCube()
    
    -- We're ensuring we accurately found a valid reference to the RHC
    if not rightHandRef then
        Debug:LogError("Failed to find a reference to the RightHand Controller")
        return
    end

-- Same as above, just for the player
if not playerReference then
    Debug:LogError("Failed to find a reference to the Player")
    return
end

-- We're going to position our collider cube to be in the center of stump
colliderCube.transform.position  =  Engine:CreateVector3(-0.488999993, -2.52499962, 1.43499994)
-- Now we set it's scale
colliderCube.transform.localScale  =  Engine:CreateVector3(2.97865534, 2.97865582, 0.325944573)
-- Now mark it as is trigger
Engine:GetEngineComponent(colliderCube, "BoxCollider").isTrigger  =  true --CreateCube() always has a BoxCollider so no need to nil check

-- Now we use the new event subscription system to subscribe to it's OnTriggerEnter
Engine:Subscribe(colliderCube, "OnTriggerEnter", "TemplateExtension", "OnTriggerEnterCallback") -- The Modname is required so the engine can precisely determine in native which instance is calling Subscribe

-- We're done!
Debug:Log("TemplateExtension - Start() - Complete!")
end

function Update() -- We don't actually use update in this extension, but this is only here so you can see how to implement the canRun boolean that is HIGHLY RECOMMENDED.
    if not canRun then
        return
    end
end

-- This is called when (If "LUtilla" is installed) the user reloads their extensions or in another case when extensions need to be unloaded
function OnUnloaded()
    Debug:Log(modName .. " unloaded")
    Engine:Unsubscribe(colliderCube, "OnTriggerEnter", "TemplateExtension", "OnTriggerEnterCallback") -- Unsubscribes us from that specific callback
    if colliderCube then
        Engine:DestroyObject(colliderCube)
    end
rightHandRef  =  nil
playerReference  =  nil
canRun  =  nil
colliderCube  =  nil
end