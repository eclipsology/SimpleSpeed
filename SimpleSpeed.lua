_G.Enabled = true -- change to false then execute again to turn off
_G.Speed = 100 -- change speed to the number you want

local players = game:GetService("Players")

local function bypassWalkSpeed()
    if getgenv().executed then
        print("WS Already Bypassed")
        if not _G.Enabled then
            return
        end
    else
        getgenv().executed = true
        print("WS Bypassed")

        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local oldindex = mt.__index
        mt.__index = newcclosure(function(self, b)
            if b == 'WalkSpeed' then
                return 16
            end
            return oldindex(self, b)
        end)
    end
end

bypassWalkSpeed()

players.LocalPlayer.CharacterAdded:Connect(function(char)
    bypassWalkSpeed()
    char:WaitForChild("Humanoid").WalkSpeed = _G.Speed
end)

while _G.Enabled and wait() do
    players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = _G.Speed
end
