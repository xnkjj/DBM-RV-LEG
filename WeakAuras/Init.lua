WeakAuras = {}
WeakAuras.L = {}

local versionString = GetAddOnMetadata("WeakAuras", "Version");
--[===[@debug@
if versionString == "2.5.12" then
  versionString = "Dev"
end
--@end-debug@]===]
WeakAuras.versionString = versionString
WeakAuras.printPrefix = "|cff9900FF".."WeakAuras: "..FONT_COLOR_CODE_CLOSE

WeakAuras.prettyPrint = function(msg)
  print(WeakAuras.printPrefix .. msg)
end

WeakAuras.PowerAurasPath = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\"
WeakAuras.PowerAurasSoundPath = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\"

--These function stubs are defined here to reduce the number of errors that occur if WeakAuras.lua fails to compile
function WeakAuras.RegisterRegionType()
end

function WeakAuras.RegisterRegionOptions()
end

function WeakAuras.StartProfileSystem()
end
function WeakAuras.StartProfileAura()
end
function WeakAuras.StopProfileSystem()
end
function WeakAuras.StopProfileAura()
end
