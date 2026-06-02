-- [[ ZENITH COMPACT UI LIBRARY 2026 ]] --
local ZenithLib = {}
local CoreGui = game:GetService("CoreGui")

function ZenithLib:CreateWindow(Config)
    if CoreGui:FindFirstChild("Zenith_System") then CoreGui.Zenith_System:Destroy() end

    local UI = Instance.new("ScreenGui", CoreGui)
    UI.Name = "Zenith_System"
    UI.DisplayOrder = 999

    -- Floating Icon (Fix Layer)
    local Float = Instance.new("ImageButton", UI)
    Float.Size = UDim2.new(0, 40, 0, 40)
    Float.Position = UDim2.new(0.9, 0, 0.8, 0)
    Float.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Float.Image = Config.Icon or ""
    Float.Draggable = true
    Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", Float).Color = Color3.fromRGB(0, 255, 130)

    -- Main Frame (Super Compact)
    local Main = Instance.new("Frame", UI)
    Main.Size = UDim2.new(0, 360, 0, 240)
    Main.Position = UDim2.new(0.5, -180, 0.5, -120)
    Main.BackgroundColor3 = Color3.fromRGB(10, 11, 10)
    Main.Visible = false
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 130)

    Float.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

    local TabContainer = Instance.new("ScrollingFrame", Main)
    TabContainer.Size = UDim2.new(1, -20, 1, -40)
    TabContainer.Position = UDim2.new(0, 10, 0, 30)
    TabContainer.BackgroundTransparency = 1
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

    local Obj = {}
    function Obj:CreateTab(Name)
        return {
            CreateToggle = function(self, text, cb)
                local btn = Instance.new("TextButton", TabContainer)
                btn.Size = UDim2.new(1, 0, 0, 25)
                btn.Text = "  " .. text
                btn.TextColor3 = Color3.new(1,1,1)
                btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                local state = false
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    btn.Text = state and "  [ON] " .. text or "  [OFF] " .. text
                    cb(state)
                end)
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            end
        }
    end
    return Obj
end

return ZenithLib
