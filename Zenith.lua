-- // Zenith Hub | Blox Fruit (Elerium Edition)
-- // Owner: Vannderl | Script by: Kraxzyv
-- // Features: Auto Farm Max 2800, Fast Attack, ESP, Auto Stats, Dev Tool

local Elerium = loadstring(game:HttpGet("https://raw.githubusercontent.com/lerkermer/lerkermer/main/Elerium"))()

local Window = Elerium:Window("Zenith Hub | Blox Fruit")
local MainTab = Window:Tab("Auto Farm")
local StatsTab = Window:Tab("Auto Stats")
local ESPTab = Window:Tab("ESP Visuals")
local TeleportTab = Window:Tab("Teleport")
local DevTab = Window:Tab("Dev Tool")

-- // Core Logic & Variables
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

_G.AutoFarm = false
_G.FastAttack = false
_G.AutoStats = false
_G.SelectStat = "Melee"
_G.ESPPlayer = false
_G.ESPFruit = false

-- // Fungsi TP & Database (Sama seperti sebelumnya agar tetap stabil)
local function TweenTP(targetCFrame)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - targetCFrame.Position).Magnitude / 300, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play() tween.Completed:Wait()
end

-- // Tab: Auto Farm
MainTab:Toggle("Enable Auto Farm (Max 2800)", false, function(s)
    _G.AutoFarm = s
end)

MainTab:Toggle("Enable Fast Attack", false, function(s)
    _G.FastAttack = s
    if s then
        task.spawn(function()
            while _G.FastAttack do task.wait()
                pcall(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end)
            end
        end)
    end
end)

-- // Tab: Auto Stats
StatsTab:Dropdown("Pilih Stat", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, function(s)
    _G.SelectStat = s
end)

StatsTab:Toggle("Auto Upgrade Stats", false, function(s)
    _G.AutoStats = s
    task.spawn(function()
        while _G.AutoStats do task.wait(1)
            pcall(function()
                if Player.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.SelectStat, Player.Data.Points.Value)
                end
            end)
        end
    end)
end)

-- // Tab: ESP
ESPTab:Toggle("ESP Player", false, function(s) _G.ESPPlayer = s end)
ESPTab:Toggle("ESP Devil Fruit", false, function(s) _G.ESPFruit = s end)

-- // Tab: Teleport
TeleportTab:Button("Teleport ke Mansion (Sea 3)", function()
    TweenTP(CFrame.new(-12463, 332, -7523))
end)

-- // Tab: Dev Tool (CFrame Logger)
DevTab:Label("CFrame Logger Tool")
DevTab:Button("Log CFrame NPC (Print ke F9)", function()
    local cf = Player.Character.HumanoidRootPart.CFrame
    print(string.format("QuestGiver = CFrame.new(%.2f, %.2f, %.2f),", cf.X, cf.Y, cf.Z))
end)

DevTab:Button("Log CFrame Mob (Print ke F9)", function()
    local cf = Player.Character.HumanoidRootPart.CFrame
    print(string.format("MobSpawn = CFrame.new(%.2f, %.2f, %.2f)", cf.X, cf.Y, cf.Z))
end)

-- // ESP Engine
RunService.RenderStepped:Connect(function()
    if _G.ESPPlayer then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and not v.Character.Head:FindFirstChild("ESP") then
                local b = Instance.new("BillboardGui", v.Character.Head) b.Name = "ESP" b.AlwaysOnTop = true b.Size = UDim2.new(0, 100, 0, 50)
                local t = Instance.new("TextLabel", b) t.Size = UDim2.new(1,0,1,0) t.Text = v.Name t.TextColor3 = Color3.new(1,0,0)
            end
        end
    else
        for _, v in pairs(game.Players:GetPlayers()) do if v.Character and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("ESP") then v.Character.Head.ESP:Destroy() end end
    end
end)
