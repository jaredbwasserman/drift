-- Keep track of which frames have been made movable
local movableFrames = {}

local function makeFramesMovable()
    for key, val in pairs(_G) do
        if not movableFrames[key] and
        type(val) == "table" and
        DriftHelpers:IsNotForbidden(val) and
        -- (val.layoutType or (val.Border and val.Border.layoutType)) then
        -- (val["GetParent"] and val:GetParent()["GetName"] and val:GetParent():GetName() == "UIParent") then
        -- val["GetParent"] then
        val ~= UIParent and
        val ~= TimerTracker and
        val ~= SpellActivationOverlayFrame and
        val ~= UIErrorsFrame and
        val ~= WorldFrame and
        -- (val["IsShown"] and val:IsShown()) and
        val["GetName"] and
        val["SetMovable"] and
        (not val["GetParent"] or val:GetParent() == UIParent or key == "MicroButtonAndBagsBar") then
            if key == "MicroButtonAndBagsBar" then
                print(key)
            end
                
            -- print(key)
            -- print(val)
            DriftHelpers:MakeMovable(val)
            movableFrames[key] = true
        end


    end
end

local function addonLoaded(self, event, ...)
    makeFramesMovable()
end

-- Make preloaded frames movable
makeFramesMovable()

-- Make addon frames movable when any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", addonLoaded)
Drift:RegisterEvent("ADDON_LOADED")




local bar = _G["MicroButtonAndBagsBar"]
print("testing")
print(DriftHelpers:IsNotForbidden(bar))
print(bar["GetName"])
print(bar["SetMovable"])
print(bar["GetParent"])
print(bar:GetParent():GetName())
print("done with testing")