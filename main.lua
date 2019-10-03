if (DRUIDMANA == nil) then 
    DRUIDMANA = {}
end

function initialize() 
    local druidManaBarFrame = CreateFrame("Frame", "DruidManaBarFrame", PlayerFrame)
    druidManaBarFrame:SetSize(106, 17)
    druidManaBarFrame:SetPoint("RIGHT", -3, -25)
    druidManaBarFrame:SetFrameStrata("LOW")
    druidManaBarFrame:SetBackdrop({
        --bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 64,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3, },
    })
    
    druidManaBarFrame.bar = CreateFrame("StatusBar", "DruidManaBar", druidManaBarFrame)
    druidManaBarFrame.bar:SetFrameStrata("BACKGROUND")
    druidManaBarFrame.bar:SetPoint("TOPLEFT", 3, -3)
    druidManaBarFrame.bar:SetPoint("TOPRIGHT", -3, -3)
    druidManaBarFrame.bar:SetHeight(11)
    druidManaBarFrame.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    druidManaBarFrame.bar:GetStatusBarTexture():SetHorizTile(false)
    druidManaBarFrame.bar:GetStatusBarTexture():SetVertTile(false)
    druidManaBarFrame.bar:SetStatusBarColor(0/255, 0/255, 225/255)

    return druidManaBarFrame
end

function updateDruidManaBarValues()
    local manaCurrent, manaMax = UnitPower("player", 0), UnitPowerMax("player", 0)
    druidManaBarFrame.bar:SetMinMaxValues(0, manaMax)
    druidManaBarFrame.bar:SetValue(manaCurrent)
end

function toggleManaBarVisibility()
    local isShapeshifted = GetShapeshiftForm() ~= 0
    if isShapeshifted then
        druidManaBarFrame:Show()
        druidManaBarFrame.bar:Show()
    else
        druidManaBarFrame:Hide()
        druidManaBarFrame.bar:Hide()
    end
end

function registerUpdateEvents()
    local frame = CreateFrame("Frame")
    frame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player", "MANA")
    frame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player", "RAGE")
    frame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player", "ENERGY")
    frame:SetScript("OnEvent", function(self, event, ...)
        updateDruidManaBarValues()
    end)
end

function registerShapeshiftEvent() 
    local frame = CreateFrame("Frame")
    frame:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player")
    frame:SetScript("OnEvent", function() 
        toggleManaBarVisibility()
    end)  
end

localizedClass, englishClass, classIndex = UnitClass("player")
if englishClass == "DRUID" then 
    druidManaBarFrame = initialize()
    registerShapeshiftEvent()
    toggleManaBarVisibility()
    registerUpdateEvents()

    print("DruidMana loaded!")
end
