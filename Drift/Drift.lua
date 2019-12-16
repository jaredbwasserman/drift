-- Keep track of which frames have been made movable
local movableFrames = {}

local function makeFramesMovable()
    for key, val in pairs(_G) do
        if not movableFrames[key] and
        type(val) == "table" and
        DriftHelpers:isNotForbidden(val) and
        (val.layoutType or (val.Border and val.Border.layoutType)) then
            DriftHelpers:makeMovable(val)
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
