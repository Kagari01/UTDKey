    setfpscap(20)
    wait(1)
    local Players = game:service('Players')
    local VirtualUser = game:service('VirtualUser')

    -- Đợi cho đến khi LocalPlayer được khởi tạo
    while not Players.LocalPlayer do
        wait()
    end

    local player = Players.LocalPlayer

    -- Kết nối sự kiện Idled
    player.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)



    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "UTD   | Any: discord.gg/fm7cQEGYsF",
        SubTitle = "by kagari1314",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    -- ICON: https://lucide.dev/icons/
    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "aperture" }),
        Unit = Window:AddTab({ Title = "Unit", Icon = "eye"}),
        Play = Window:AddTab({ Title = "Teleport", Icon = "chevrons-up" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "wifi-off" }),
        Settings = Window:AddTab({ Title = "Config", Icon = "settings" })
    }

    local Options = Fluent.Options

    do
        Fluent:Notify({
            Title = "qeo com",
            Content = "NEW UPDATE SOON",
            SubContent = "",
            Duration = 5
        })

        Tabs.Main:AddParagraph({
            Title = "dm me if anyone can help me create macro",
            Content = "MY BAD:("
        })

        -- MAIN

        -- AUTO START
        local autoStartEnabled = false
        local autoStartThread
        local function autoStart()
            while autoStartEnabled do
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):WaitForChild("PlayerVoteToStartMatch"):FireServer()
                wait(5)
            end
        end
        local ToggleAutoStart = Tabs.Main:AddToggle("AutoStartToggle", {Title = "Auto Start", Default = false })
        ToggleAutoStart:OnChanged(function()
            autoStartEnabled = Options.AutoStartToggle.Value
            if autoStartEnabled then
                autoStartThread = coroutine.create(autoStart)
                coroutine.resume(autoStartThread)
            else
                if autoStartThread and coroutine.status(autoStartThread) == "suspended" then
                    coroutine.yield(autoStartThread)
                end
            end
        end)
        Options.AutoStartToggle:SetValue(false)

        -- AUTO REPLAY
        local autoReplayEnabled = false
        local autoReplayThread
        local function autoReplay()
            while autoReplayEnabled do
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):WaitForChild("PlayerVoteReplay"):FireServer()
                wait(5)
            end
        end
        local ToggleAutoReplay = Tabs.Main:AddToggle("AutoReplayToggle", {Title = "Auto Replay", Default = false })
        ToggleAutoReplay:OnChanged(function()
            autoReplayEnabled = Options.AutoReplayToggle.Value
            if autoReplayEnabled then
                autoReplayThread = coroutine.create(autoReplay)
                coroutine.resume(autoReplayThread)
            else
                if autoReplayThread and coroutine.status(autoReplayThread) == "suspended" then
                    coroutine.yield(autoReplayThread)
                end
            end
        end)
        Options.AutoReplayToggle:SetValue(false)

        -- AUTO FISH
        local autoFishEnabled = false
        local autoFishThread
        local function autoFish()
            while autoFishEnabled do
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):WaitForChild("PlayerCatchFish"):FireServer()
                wait(2) -- Đợi 5 giây trước khi bắt cá lần tiếp theo
            end
        end
        local ToggleAutoFish = Tabs.Main:AddToggle("AutoFishToggle", {Title = "Auto Fish", Default = false })
        ToggleAutoFish:OnChanged(function()
            autoFishEnabled = Options.AutoFishToggle.Value
            if autoFishEnabled then
                autoFishThread = coroutine.create(autoFish)
                coroutine.resume(autoFishThread)
            else
                if autoFishThread and coroutine.status(autoFishThread) == "suspended" then
                    coroutine.yield(autoFishThread)
                end
            end
        end)
        --SUMMON X10
        Options.AutoFishToggle:SetValue(false)
            local autoSummonEnabled = false
        local autoSummonThread
        local function autoSummon()
            while autoSummonEnabled do
                local summonArgs = {
                    [1] = 10
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):WaitForChild("PlayerBuyTower"):FireServer(unpack(summonArgs))
                wait(0.00000000000000001) 
            end
        end
        local ToggleAutoSummon = Tabs.Main:AddToggle("AutoSummonToggle", 
                {Title = "Auto Summon X10", 
                Default = false })
        ToggleAutoSummon:OnChanged(function()
            autoSummonEnabled = Options.AutoSummonToggle.Value
            if autoSummonEnabled then
                autoSummonThread = coroutine.create(autoSummon)
                coroutine.resume(autoSummonThread)
            else
                if autoSummonThread and coroutine.status(autoSummonThread) == "suspended" then
                    coroutine.yield(autoSummonThread)
                end
            end
        end)
        Options.AutoSummonToggle:SetValue(false)

    --MESSAGE GUI
local ToggleMessageGuiButton = Tabs.Main:AddToggle("ToggleMessageGui", {
    Title = "Disable Message",
    Default = false
})

local player = game.Players.LocalPlayer
local messagesGui = player.PlayerGui:WaitForChild("MessagesGui")

ToggleMessageGuiButton:OnChanged(function(isEnabled)
    if isEnabled then
        -- Tắt MessageGui khi bật toggle
        messagesGui.Enabled = false
    else
        -- Bật MessageGui khi tắt toggle
        messagesGui.Enabled = true
    end
end)


        -- UNIT 

        Tabs.Unit:AddParagraph({
            Title = "i can only make manual macro",
            Content = "MY BAD:("
        })

    --AUTO UPGRADE
            local autoUpgradeEnabled = false
        local autoUpgradeThread
        local function autoUpgrade()
            while autoUpgradeEnabled do
                local towers = workspace:WaitForChild("EntityModels"):WaitForChild("Towers"):GetChildren()
                for _, tower in pairs(towers) do
                    local towerName = tower.Name
                    local upgradeArgs = {
                        [1] = towerName
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("GenericModules"):WaitForChild("Service"):WaitForChild("Network"):WaitForChild("PlayerUpgradeTower"):FireServer(unpack(upgradeArgs))
                end
                wait(5)
            end
        end
        local ToggleAutoUpgrade = Tabs.Unit:AddToggle("AutoUpgradeToggle", {Title = "Auto Upgrade", Default = false })
        ToggleAutoUpgrade:OnChanged(function()
            autoUpgradeEnabled = Options.AutoUpgradeToggle.Value
            if autoUpgradeEnabled then
                autoUpgradeThread = coroutine.create(autoUpgrade)
                coroutine.resume(autoUpgradeThread)
            else
                if autoUpgradeThread and coroutine.status(autoUpgradeThread) == "suspended" then
                    coroutine.yield(autoUpgradeThread)
                end
            end
        end)
        Options.AutoUpgradeToggle:SetValue(false)

-- MAP: valley of the end
local autoPlaceEnabled = false
local autoPlaceThread

local function placeTowers()
    while autoPlaceEnabled do
        -- Pika
        local args1 = {
            [1] = "7278445232:50",
            [2] = Vector3.new(-655.709228515625, 509.85272216796875, 178.39761352539062),
            [3] = 0
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GenericModules"):WaitForChild("Service"):WaitForChild("Network"):WaitForChild("PlayerPlaceTower"):FireServer(unpack(args1))

        -- Another Pika
        local args3 = {
            [1] = "7278445232:56",
            [2] = Vector3.new(-651.108154296875, 509.852783203125, 181.02072143554688),
            [3] = 0
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GenericModules"):WaitForChild("Service"):WaitForChild("Network"):WaitForChild("PlayerPlaceTower"):FireServer(unpack(args3))
        
        -- Goku
        local args2 = {
            [1] = "7278445232:50",
            [2] = Vector3.new(-650.1400756835938, 509.8526916503906, 178.034912109375),
            [3] = 0
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GenericModules"):WaitForChild("Service"):WaitForChild("Network"):WaitForChild("PlayerPlaceTower"):FireServer(unpack(args2))
        


        wait(1) -- Đặt độ trễ giữa mỗi lần đặt unit
        
        if not autoPlaceEnabled then -- Kiểm tra nếu toggle bị tắt
            break
        end
    end
end

local ToggleAutoPlace = Tabs.Unit:AddToggle("AutoPlaceToggle", {
    Title = "Farm Valley of the End", 
    Description = "Pika, Goku",
    Default = false
})

ToggleAutoPlace:OnChanged(function()
    autoPlaceEnabled = Options.AutoPlaceToggle.Value
    if autoPlaceEnabled then
        -- Khi bật toggle, bắt đầu vòng lặp
        autoPlaceThread = coroutine.create(placeTowers)
        coroutine.resume(autoPlaceThread)
    else
        -- Khi tắt toggle, dừng vòng lặp
        autoPlaceEnabled = false
    end
end)

Options.AutoPlaceToggle:SetValue(false)



        --TELEPORT TO MAP SELECT
        local TeleportToggle = Tabs.Play:AddToggle("TeleportToggle", {
            Title = "Teleport",
            Default = false
        })
        local function teleportToRandomModel()
            local teleporters = workspace:WaitForChild("Lobby"):WaitForChild("ClassicPartyTeleporters"):GetChildren()
            if #teleporters > 0 then
                local randomTeleporter = teleporters[math.random(1, #teleporters)]
                local worldPivot = randomTeleporter.WorldPivot
                if worldPivot then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(worldPivot.Position + Vector3.new(0, 5, 0))
                end
            end
        end
        TeleportToggle:OnChanged(function(isEnabled)
            if isEnabled then
                wait(3)
                teleportToRandomModel()
            end
        end)

        --START TELEPORT
        local autoStartTeleportEnabled = false
        local autoStartTeleportThread
        local function autoStartTeleport()
            wait(4)
            while autoStartTeleportEnabled do
                local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):WaitForChild("PlayerQuickstartTeleport")
                if remoteEvent then
                    remoteEvent:FireServer()
                end
                wait(4)  
            end
        end
        local AutoStartTeleportToggle = Tabs.Play:AddToggle("AutoStartTeleportToggle", {
            Title = "Auto Start Teleport",
            Default = false
        })
        AutoStartTeleportToggle:OnChanged(function(isEnabled)
            autoStartTeleportEnabled = isEnabled
            if autoStartTeleportEnabled then
                autoStartTeleportThread = coroutine.create(autoStartTeleport)
                coroutine.resume(autoStartTeleportThread)
            else
                if autoStartTeleportThread and coroutine.status(autoStartTeleportThread) == "suspended" then
                    coroutine.yield(autoStartTeleportThread)
                end
            end
        end)

        -- KIEM TRA REMOTEEVENT
        local function getRemoteEvent(name)
        local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GlobalInit"):WaitForChild("RemoteEvents"):FindFirstChild(name)
        if remoteEvent then
            return remoteEvent
        end
        end

        --MAP
        local MapDropdown = Tabs.Play:AddDropdown("Map", {
            Title = "Map",
            Values = {"KameIsland", "PlanetNamek", "HiddenLeafVillage", "Marineford", "KamiiUniversity", "Space", "SkeletonHeelStone", "CostaSmeralda", "KamiLookout", "ValleyOfTheEnd", "RubyPalace", "AntNest", "TrostDistrict"},
            Multi = false,
            Default = 1,
        })
        local selectedMapValue = "Any"  
        local playerSelectedMapEvent = getRemoteEvent("PlayerSelectedMap")
        if playerSelectedMapEvent then
            MapDropdown:OnChanged(function(Value)
                print("Map Dropdown changed:", Value)
                selectedMapValue = Value
                local args = { [1] = selectedMapValue }
                playerSelectedMapEvent:FireServer(unpack(args))
            end)
        end

        --GAME MODE
        local GameModeDropdown = Tabs.Play:AddDropdown("Game Mode", {
        Title = "Game Mode",
        Values = {"Classic", "Hard"},
        Multi = false,
        Default = 1,
        })
        local selectedGMValue = "Any"
        local playerSelectedGamemodeEvent = getRemoteEvent("PlayerSelectedGamemode")
        if playerSelectedGamemodeEvent then
            GameModeDropdown:OnChanged(function(Value)
                print("Game Mode Dropdown changed:", Value)
                selectedGMValue = Value
                local args = { [1] = selectedGMValue }
                playerSelectedGamemodeEvent:FireServer(unpack(args))
            end)
        end

        --AUTO RECONNECT
        local autoReconnectEnabled = false
        local autoReconnectThread
        local function autoReconnect()
            while autoReconnectEnabled do
                repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
                local lp = game:GetService('Players').LocalPlayer
                local po = game.CoreGui.RobloxPromptGui.promptOverlay
                local ts = game:GetService('TeleportService')            
                po.ChildAdded:Connect(function(a)
                    if a.Name == 'ErrorPrompt' then
                        repeat
                            ts:Teleport(5902977746) --ID GAME
                            task.wait(2)
                        until not autoReconnectEnabled 
                    end
                end)
                
                task.wait(10) 
            end
        end
        local AutoReconnectToggle = Tabs.Misc:AddToggle("AutoReconnectToggle", {
            Title = "Auto Reconnect",
            Default = false
        })
        AutoReconnectToggle:OnChanged(function(isEnabled)
            autoReconnectEnabled = isEnabled
            if autoReconnectEnabled then
                autoReconnectThread = coroutine.create(autoReconnect)
                coroutine.resume(autoReconnectThread)
            else
                if autoReconnectThread and coroutine.status(autoReconnectThread) == "suspended" then
                    coroutine.yield(autoReconnectThread)
                end
            end
        end)

    -- Thêm input cho người dùng nhập số FPS
local Input = Tabs.Misc:AddInput("FPSInput", {
    Title = "Set FPS",
    Default = "60", -- FPS mặc định
    Placeholder = "Enter FPS",
    Numeric = true, -- Chỉ cho phép số
    Finished = true, -- Chỉ gọi callback khi nhấn Enter
    Callback = function(Value)
        local fps = tonumber(Value) -- Chuyển đổi giá trị nhập vào thành số
        if fps and fps > 0 then -- Kiểm tra nếu giá trị hợp lệ
            setfpscap(fps) -- Đặt giới hạn FPS
            print("FPS set to:", fps)
        else
            print("Invalid FPS value:", Value)
        end
    end
})

-- Lắng nghe sự thay đổi giá trị nhập
Input:OnChanged(function()
    local fps = tonumber(Input.Value) -- Lấy giá trị và chuyển thành số
    if fps and fps > 0 then
        setfpscap(fps) -- Cập nhật FPS khi giá trị thay đổi
        print("FPS updated to:", fps)
    else
        print("Invalid FPS value:", Input.Value)
    end
end)





    end

    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    SaveManager:LoadAutoloadConfig()

