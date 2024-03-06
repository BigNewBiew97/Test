repeat wait() until getgenv().LoadUi and getgenv().IslandCaller and getgenv().SettingManager 
local Title = "W-azure" .. (getgenv().Premium and " [Premium]" or "")
local SubTitle = "True V2 discord.gg/w-azure"
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/vinhuchi/rblx/main/FixedFluent.lua"))()
local UiSetting = Fluent.Options
local IslandCaller = IslandCaller or getgenv().IslandCaller
local SettingManager = getgenv().SettingManager 
local Window = getgenv().Window or Fluent:CreateWindow({
    Title = Title,
    SubTitle = SubTitle,
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})
local UiOrders = {"Main Farm","Stack Auto farm","Sub Farming","Status","Player-Status","Fruit","Local Player","Travel","Pvp-Visual","Raid-Material","RaceV4-Mirage","Sea Events","Shop","Setting","Webhook","Game-Server","One Click"}
local TabCollections = {
}
ElementsCollection = {}
for _,Name in pairs(UiOrders) do
    ElementsCollection[Name]={}
end

local UiIntilize = {
    ["Main Farm"] = {
        {Mode="Label",Title="Only Turn On 1 Farm At The Same Time"},
        {Mode="Toggle",Title="Auto Katakuri",Description="Turn On Auto Kill Cake Prince And Auto Kill Dough King By Default",Args={"Katakuri","Enable"}},
        {Mode="Toggle",Title="Auto Bone",Description="",Args={"Bone","Enable"}},
        {Mode="Toggle",Title="Kill Aura",Description="Farm Near Lv Mob Or Near Position",Args={"Kill Aura","Enable"}},
        {Mode="Toggle",Title="Fully Auto Dough King",Description="",Args={"Full Dough King","Enable"}},
        {Mode="Label",Title="Setting For Auto Farm"},
        {Mode="Label",Title="Anchor Position"},
        {Mode="Toggle",Title="TP Back Anchor Position",Description="If Exceed Anchor Position Will Tp Back To Anchor Position",Args={"Kill Aura","AnchorTPBack"}},
        {Mode="Button",Title="Set Anchor Position",Callback=function ()
            pcall(function ()
                getgenv().Setting["Kill Aura"].AnchorPosition = tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
            end)
        end},
        {Mode="Dropdown",Title="Distace From Anchor",Table = (function ()
            local Table = {}
            for i=400,4000,400 do 
                table.insert(Table,i)
            end
            return Table
        end)(),Default=getgenv().Setting["Kill Aura"].DistanceFromAnchor/400,OnChange=function (state)
            getgenv().Setting["Kill Aura"].DistanceFromAnchor = state
        end},
        {Mode="Toggle",Title="Use Sword",Args = {"Mastery","Sword"}},
        {Mode="Toggle",Title="Sword Switcher",Description="Switch Sword When Have Enough Skills (Default) or Max Mastery",Args={"SwordSwitcher","Enable"}},
        {Mode="Toggle",Title="Only Switch Max Mastery",Description="Only Switch When Max Mastery",Args={"SwordSwitcher","MaxMastery"}},
        {Mode="Toggle",Title="Switch Sword When Low", Description = "Must Enable Use Sword", Args={"Mastery","Sword/Low"}},
        {Mode="Label",Title="Go To Setting To Select Skills"},
        {Mode="Toggle",Title="Mastery Farm",Description="Need Enable Auto Katakuri Or Bone", Args={"Mastery","Enable"}},
        {Mode="Toggle",Title ="Aimbot Camera " ,Description = "Aimbot for Mastery Using Camera", Args={"Mastery","Camera"}},
        {
            Mode = "Dropdown",
            Title = "Matery Health",
            Args = {"Mastery", "Health"},
            Table = {20,25,30,35,40,45,50},
            Default = (function ()
                local Default = {20,25,30,35,40,45,50}
                local Found = 1
                if not table.find(Default,getgenv().Setting.Mastery.Health) then 
                    getgenv().Setting.Mastery.Health = 30
                else
                    Found = table.find(Default,getgenv().Setting.Mastery.Health) 
                end
                return Found
            end)(),
            OnChange = function(value)
                getgenv().Setting.Mastery.Health = tonumber(value)
                SettingManager:Save()
            end
        },        
        {Mode="Toggle",Title="Mastery Fruit / Gun", Description = "Default Is Fruit, Turning On = Using Gun, Must Enable Mastery Farm",Args = {"Mastery","Fruit/Gun"}},
        {
            Mode = "Toggle",
            Title = "Disable Silent Aim",
            Args = {"Pvp", "DisableSilentAim"},
            OnChange = function(state)
                getgenv().Setting.Pvp.DisableSilentAim = state
                SettingManager:Save()
            end
        },
        {Mode="Button",Title="Fps Boost",Callback = getgenv().LiteFpsBoost}
    },
    ["Stack Auto farm"] = {
        {Mode="Label",Title="Can Turn On Many Auto Farm Cuz Stackable"},
        {Mode="Toggle",Title="Auto Elite",Description="Sea 3 Function Only",Args={"Elite","Enable"}},
        {Mode="Toggle",Title="Auto Pirate Raid",Description="Sea 3 Function Only",Args={"Pirate Raid","Enable"}},
        {Mode="Toggle",Title="Auto Open Haki Pad",Description="Sea 3 Function Only",Args={"Open Pad","Enable"}},
        {Mode="Toggle",Title="Auto Spawn Rip Indra",Description="Sea 3 Function Only", Args = {"Spawn Rip Indra","Enable"}},
        {Mode="Toggle",Title="Auto Rip Indra",Description = "Only Kill Rip Indra, Doesnt Do Anything Else",Args={"Rip Indra","Enable"}},
        {Mode="Toggle",Title="Auto Tushita",Descrition="Sea 3 Function only",Args={"Tushita","Enable"}},
        {Mode="Toggle",Title="Do Puzzle Electric Claw",Description="Sea 3 Function Only",Args={"Unlock Electric Claw","Enable"}},
        {Mode="Toggle",Title="Auto Dough King" ,Description="", Args = {"Dough King","Enable"}},
        {Mode="Toggle",Title="Auto Cake Prince",Description="",Args = {"Cake Prince","Enable"}},
        {Mode="Toggle",Title="Auto Spawn Soul Reaper",Args = {"Spawn Soul Reaper","Enable"}},
        {Mode="Toggle",Title="Auto Soul Reaper",Args = {"Soul Reaper","Enable"}},
        {
            Mode = "Dropdown",
            Title = "Select Boss To Snipe",
            Multi = true, 
            Table = AllBoss[tostring(game.PlaceId)],
            Default = getgenv().Setting.BossSniper.SelectedBoss or {},
            OnChange = function(state)
                local Values = {}
                for Value, State in pairs(state) do
                    if  type(Value) == "string" then
                        table.insert(Values, Value)
                    end
                end 
                

                getgenv().Setting.BossSniper.SelectedBoss = Values
                SettingManager:Save()
            end
        },     
        {Mode="Toggle",Title="Start Boss Snipe",Description="",Args={"BossSniper","Enable"}},
        {Mode="Toggle",Title="Auto Bartilo Quest",Description="Sea 2 Function",Args = {"Bartilo","Enable"}},
        {Mode="Toggle",Title="Auto Race Evolve",Description="Sea 2 Function, Need Bartilo Quest Finish",Args = {"Race Evolve","Enable"}},
        {Mode="Toggle",Title="Auto Factory",Description="Sea 2 Function Only",Args = {"Factory","Enable"}},
        {Mode="Toggle",Title="Auto Spawn Black Beard",Description="Sea 2 Function Only", Args = {"Spawn Black Beard","Enable"}},
        {Mode="Toggle",Title="Auto Black Beard",Description="Sea 2 Function Only", Args = {"Black Beard","Enable"}},
        {Mode="Toggle",Title="Auto Ghoul",Description="Travel To Sea2 and Stack Farming Until Have Ghoul", Args = {"Get Ghoul","Enable"}},
        {Mode="Toggle",Title="Auto Soul Guitar",Args = {"Soul Guitar","Enable"}},
        {Mode="Toggle",Title="Auto Soul Guitar Material",Args = {"Material Soul Guitar","Enable"}},
        {Mode="Toggle",Title="Auto CDK (DO NOT USE TESTING)",Args = {"CDK","Enable"}},
        
        --{Mode="Toggle",Title="Auto Collect Gift", Description="Sea 3 Function Event",Args = {"Winter Event","Enable"}}
    },
    ["Sub Farming"] = {
        {Mode="Label",Title="Disable All Stack + Main Farm Before Using"},
        {Mode="Button",Title="Upgrade Yoru V2",Description="Only useable if you have yoru",Callback=function()
            IslandCaller("YoruV2")
        end},
        {Mode="Toggle",Title="Yoru V3",Description="Auto Upgrade Yoru V3",Args = {"YoruV3","Enable"}},
        {Mode="Dropdown",Title="Select Player",Description="Select Account to upgrade together",Table=IslandCaller("__StrGetPlayers"),OnChange=function (state)
            getgenv().Setting["YoruV3"].SelectedPlayer = state
        end},
        {Mode="Button",Title="Refresh Players",Callback=function()
            ElementsCollection["Sub Farming"]["Select Player"]:SetValues(IslandCaller("__StrGetPlayers"))
        end},
        {Mode="Toggle",Title="Account To Upgrade Yoru V3",Description="Turn On This If This Is Account Want to Upgrade, do not if account to spawn Black Beard",Args = {"YoruV3","Upgrade"}},
        {Mode="Toggle",Title="Race Evolve Hop",Description="Turning On This Will Make Race Evolve Hopping For Faster Farming",Args = {"Race Evolve","Hop"}},
        {Mode="Toggle",Title="Black Beard Hop",Description="Auto Hop For Black Beard",Args={"Black Beard Hop","Enable"}},
        {Mode="Toggle",Title="Tushita Hop (Need All Haki Colors)",Description="Auto Chest + Auto Elite Till Find Cup And Spawn Then Get Tushita",Args={"Tushita Hop__1","Enable"}},
        {Mode="Toggle",Title="Hybrid Fruit Hop",Description="Pirate Raid + Collect Fruit Hop",Args={"Hybrid Fruit Hop","Enable"}},
        {Mode="Toggle",Title="Raid Fruit Hop",Description="Pirate Raid + Collect Fruit + Raid Hop" ,Args={"Raid Fruit Hop","Enable"}},
        {Mode="Toggle",Title="Auto Law",Description="Auto Farm Law",Args={"Law","Enable"}},
        {Mode="Toggle",Title="Auto Cyborg",Description="Auto Chest For Fist Then Auto Law",Args={"Fully Cyborg","Enable"}},
        {Mode="Toggle",Title="Auto Ghoul Hop",Description="Auto Find Torch + Ghoul (Very Rare, Dont Recommend)",Args={"Fully Ghoul","Enable"}},
        {Mode="Toggle",Title="Boss Snipe Hop",Description="",Args={"BossSniper","Hop"}},
        {Mode="Label",Title="Chest Count"},
        {Mode="Toggle",Title="Auto Chest",Description="Stop On God Chalice And Fist Of Darkness By Default",Args={"Collect Chest","Enable"}},
        {Mode="Toggle",Title="Auto Chest Hop",Description="Hop After x Chest",Args = {"Collect Chest","Hop"}},
        {
            Mode = "Dropdown",
            Title = "x Chest To Hop",
            Args = {"Collect Chest", "LimitChest"},
            Table = {20,25,30,35,40,45,50,60,70},
            Default = (function ()
                local Default = {20,25,30,35,40,45,50,60,70}
                local Found = 9
                if not table.find(Default,getgenv().Setting["Collect Chest"].LimitChest) then 
                    getgenv().Setting["Collect Chest"].LimitChest = 70
                else
                    Found = table.find(Default,getgenv().Setting["Collect Chest"].LimitChest) 
                end
                return Found
            end)(),
            OnChange = function(value)
                getgenv().Setting["Collect Chest"].LimitChest = tonumber(value)
                SettingManager:Save()
            end
        },        

        {Mode="Toggle",Title="Insta Tp Chest",Description="Have A Risk Of Getting Banned(Noone yet)",Args={"Collect Chest","InstaTP"}},
        {Mode="Toggle",Title="Auto Level Observation",Description="Farm Observation Level Till Max",Args={"Level Observation","Enable"}},
        {Mode="Toggle",Title="Level Observation Hop",Description="Hopping For leveling Observation",Args={"Level Observation","Hop"}},
        {Mode="Toggle",Title="Auto Observation V2",Description="Must Have Maxed Ken Haki + Finish Citizen Quest",Args = {"Evolve Observation","Enable"}},
        {Mode="Toggle",Title="Observation V2 Hop",Description="Hopping For Finding Materials To Get Evolve Faster",Args = {"Evolve Observation","Hop"}},
        {Mode="Toggle",Title="Auto Saber Hop",Args={"__SaberHop","Enable"}},
        {Mode="Toggle",Title="Auto Pole Hop",Args={"__PoleHop","Enable"}},
        {Mode="Toggle",Title="Auto Citizen Quest",Description="Must Be Level 1800 Above",Args = {"Citizen Quest","Enable"}},
        {Mode="Toggle",Title="Citizen Quest Hop",Description="",Args = {"Citizen Quest","Hop"}},
        {Mode="Toggle",Title="Auto Get Rainbow Haki",Description="",Args = {"Rainbow Haki","Enable"}},
        {Mode="Toggle",Title="Rainbow Haki Hop",Description="Hopping For Fast Getting Rainbow Haki",Args = {"Rainbow Haki","Hop"}},
    },
    ["Status"] = {
        {Mode="Label",Title="Client Time"},
        {Mode="Label",Title="Farming Status"},
        {Mode="Label",Title="Weapon Status [One Click]"},
        {Mode="Label",Title="Dimension Kill"},
        {Mode="Label",Title="Bribe Status"},
        {Mode="Label",Title="Elite Status"},
        {Mode="Label",Title="Mirage Status"},
        {Mode="Label",Title="Kitsune Status"},
        {Mode="Label",Title="FullMoon Status"},
    },
    ["Player-Status"] = {
        {Mode="Label",Title="W.I.P"}
    },
    ["Fruit"] = {
        {
            Mode = "Toggle",
            Title = "Auto Collect Fruit",
            Description = "Stackable With Auto Farm",
            Args = {"GetFruit", "Enable"},
            OnChange = function(state)
                getgenv().Setting.GetFruit.Enable = state
            end
        },
        {
            Mode = "Toggle",
            Title = "Auto Store Fruit",
            Args = {"Fruit", "AutoStore"},
            OnChange = function(state)
                getgenv().Setting.Fruit.AutoStore = state
            end
        },
        {
            Mode = "Toggle",
            Title = "Snipe Fruit",
            Args = {"Fruit", "EnableSnipeFruit"},
            Description = "Auto Buy Fruit If In The List And You Dont Have Fruit In That List",
            OnChange = function(state)
                getgenv().Setting.Fruit.EnableSnipeFruit = state
            end
        },
        {
            Mode = "Toggle",
            Title = "Snipe Mirage Fruit [Premium]",
            Description = "Stackable with Auto Farm, Snipe If In Mirage Fruit Stock And Mirage Dealer Appear",
            Args = {"Mirage Snipe Fruit", "Enable"},
            OnChange = function(state)
                getgenv().Setting["Mirage Snipe Fruit"].Enable = state
            end
            
        },
        {
            Mode = "Dropdown",
            Title = "Select Fruit To Snipe",
            Multi = true, 
            Table = FruitTable,
            Default = getgenv().Setting.Fruit.FruitsToSnipe or {},
            OnChange = function(state)
                local Values = {}
                for Value, State in pairs(state) do
                    if  type(Value) == "string" then
                        table.insert(Values, Value)
                    end
                end 
                

                getgenv().Setting.Fruit.FruitsToSnipe = Values
                SettingManager:Save()
            end
        }
    },
    ["Local Player"] = {
        --[[{
            Mode = "Button",
            Title = "Kick Player Safe Zone",
            Description = "Near Safe Zone + Need To Shit On Ship",
            Callback = KickPlayer
        },
        {
            Mode = "Button",
            Title = "Buy Ship",
            Description = "",
            Callback = function()
=
            end
        },

        {
            Mode = "Button",
            Title = "Fly",
            Description = "",
            Callback = function()
            end
        },
        {
            Mode = "Button",
            Title = "Stop Fly",
            Description = "",
            Callback = function()
            end
        },]]
        {
            Mode = "Button",
            Title = "Remove Enemies Skill Stun",
            Callback = function()
                IslandCaller("RemoveEnemiesStun")
            end
        },
        {
            Mode = "Toggle",
            Title = "No Clip",
            Args = {"LocalPlayer", "NoClip"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.NoClip = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "No Clip Ship",
            Args = {"LocalPlayer", "NoClipShip"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.NoClipShip = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "Auto Buso",
            Args = {"LocalPlayer", "AutoBuso"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.AutoBuso = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "Auto Enable Observation",
            Args = {"LocalPlayer", "AutoEnableObservation"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.AutoEnableObservation = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "Water Walker",
            Args = {"LocalPlayer", "WaterWalker"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.WaterWalker = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "Auto Use Race V3",
            Args = {"LocalPlayer", "AutoUseV3"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.AutoUseV3 = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Toggle",
            Title = "Auto Use Race V4",
            Args = {"LocalPlayer", "AutoUseV4"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.AutoUseV4 = state
                SettingManager:Save()
            end
        },
        {

            Mode = "Toggle",
            Title = "Soru No CD",
            Args = {"LocalPlayer", "SoruNoCD"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.SoruNoCD = state
                SettingManager:Save()
            end
        },
        {

            Mode = "Toggle",
            Title = "Dash Modify",
            Args = {"LocalPlayer", "DashModify"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.DashModify = state
                SettingManager:Save()
            end
        },
        {

            Mode = "Toggle",
            Title = "Dash No CD",
            Args = {"LocalPlayer", "DashNoCD"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.DashNoCD = state
                SettingManager:Save()
            end
        },
        {

            Mode = "Toggle",
            Title = "Change Dash Rage",
            Args = {"LocalPlayer", "DoDashRange"},
            OnChange = function(state)
                getgenv().Setting.LocalPlayer.DoDashRange = state
                SettingManager:Save()
            end
        },
        {
            Mode = "Dropdown",
            Title = "Dash Range",
            Args = {"LocalPlayer", "DashRange"},
            Table = {100,150,200,250,300,500,750,1000},
            Default = (function ()
                local Default = {100,150,200,250,300,500,750,1000}
                local Found = 3
                if not table.find(Default,getgenv().Setting.LocalPlayer.DashRange) then 
                    getgenv().Setting.LocalPlayer.DashRange = 200 
                else
                    Found = table.find(Default,getgenv().Setting.LocalPlayer.DashRange) 
                end
                return Found
            end)(),
            OnChange = function(value)
                getgenv().S