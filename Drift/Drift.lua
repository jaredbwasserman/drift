-- Keep track of which frames have been made movable
local movableFrames = {}

-- Make Frames movable
for key, val in pairs(_G) do
    if not movableFrames.key and
    type(val) == "table" and
    (not val.IsForbidden or not val:IsForbidden()) and
    (val.layoutType or (val.Border and val.Border.layoutType)) then
        DriftHelpers:makeMovable(val)
        table.insert(movableFrames, key)
    else
        if key == "ContainerFrame1" then
            print(not movableFrames.key)
            print(type(val) == "table")
            print(not val.IsForbidden)
            print(not val:IsForbidden())
            print(val.layoutType or (val.Border and val.Border.layoutType))
        end
    end
end
