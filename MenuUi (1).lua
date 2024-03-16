
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ToiLaModder/ToiLaModderHub/main/LibUiMenu.lua"))()
lib:SetTitle("Toi La Modder | Blox Fruit")
lib:SetIcon("http://www.roblox.com/asset/?id=13560227978") 
lib:AddButton("Script Pc", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ToiLaModder/ToiLaModderHub/SCR/BloxFruitPc.lua"))()
end)
lib:AddButton("Script Mobile", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ToiLaModder/ToiLaModderHub/SCR/BloxFruitMobile.lua"))()
end)
lib:AddButton("Show Item", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ToiLaModder/ToiLaModderHub/SCR/ShowItem.lua"))()
end)
lib:SetBackgroundColor(40, 40, 40)

lib:SetCloseBtnColor(255, 0, 0)

lib:SetTitleColor(255, 255, 255)

lib:SetButtonsColor(55, 55 ,55)

lib:SetTheme("Aqua")
