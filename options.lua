if (DRUIDMANA == nil) then 
    DRUIDMANA = {}
end

DRUIDMANA.optionspanel = CreateFrame( "Frame", "MyAddonPanel", UIParent);
DRUIDMANA.optionspanel.name = "DruidMana";

InterfaceOptions_AddCategory(DRUIDMANA.optionspanel);