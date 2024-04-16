local WEBHOOK_URL = "https://discord.com/api/webhooks/1229825527351738398/NWJth9Ih4YcpOnJ8RJj_ulv-E6L2jbl8WTiU7BaiDioVuZvpDX9oLgo3NDMi_y6FIjO5"

local validHWIDs = {
    ["e59fce32de94e12f4f33bd6fdc2d315a86166c2d8d78909d54e78dd66e07d840"] = true,
    ["b054af7e743b2b61498a0df50113aa1667aa69e8593b6532216b5e83c334d685"] = true,
    ["9a19913de17a802619f693204119b3302309eda57b44020739b8b6c85168b072"] = true,
    ["e4bfdd088b6ddb1af69fafc029a71d869336ea52d33882dcf2648af38228e138"] = true,
    ["f9871b302aa172fa4b1743880840dbd3de11d2da27c55e7e3eadfbc61245dc9a"] = true,
}

local function kickUser(player)
    player:Kick("Unauthorized access detected.")
end

local function sendDiscordMessage(username, userID, hwID, injectionTime, authorized)
    local color = authorized and 0x00FF00 or 0xFF0000
    local status = authorized and "Authorized" or "Unauthorized"
    local testWebhookData = {
        ["embeds"] = {{
            ["title"] = "**Injection Detected**",
            ["description"] = string.format("**Username:** %s\n**UserID:** %s\n**HWID:** %s\n**Injection Time:** %s\n**Status:** %s",
                username, userID, hwID, injectionTime, status),
            ["type"] = "rich",
            ["color"] = color,
        }}
    }
    local jsonData = game:GetService("HttpService"):JSONEncode(testWebhookData)
    local httpHeaders = {["content-type"] = "application/json"}
    local httpRequest = http_request or request or HttpPost or syn.request
    local postRequest = {Url = WEBHOOK_URL, Body = jsonData, Method = "POST", Headers = httpHeaders}
    httpRequest(postRequest)
end

local function isUserAuthorized(player)
    local hwID = gethwid() 
    local injectionTime = os.date("%c")
    local authorized = validHWIDs[hwID]
    sendDiscordMessage(player.Name, player.UserId, hwID, injectionTime, authorized)  
    if not authorized then
        kickUser(player) 
    end
end

local functions = {
    rconsoleprint,
    print,
    setclipboard,
    rconsoleerr,
    rconsolewarn,
    warn,
    error
}

for _, v in ipairs(functions) do
    local old = hookfunction(v, newcclosure(function(...)
        local args = {...}
        for _, arg in ipairs(args) do
            if type(arg) == "string" and (arg:find("https://") or arg:find("http://")) then
                return
            end
        end
        return old(...)
    end))
end

setmetatable(_G, {
    __newindex = function(t, i, v)
        if tostring(i) == "ID" or tostring(v) == "ID" then
            return
        end
        rawset(t, i, v)
    end
})

local player = game.Players.LocalPlayer 
isUserAuthorized(player)






local notificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/xaxas-notification/src.lua"))();
local notifications = notificationLibrary.new({            
    NotificationLifetime = 3, 
    NotificationPosition = "Middle",
    
    TextFont = Enum.Font.Code,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextSize = 15,
    
    TextStrokeTransparency = 0, 
    TextStrokeColor = Color3.fromRGB(0, 0, 0)
});

notifications:BuildNotificationUI();

print("Beginning authentication.")
notifications:Notify("Beginning authentication.");
wait(3)

print("Please Login.")
notifications:Notify("Please Login.");
wait(1)



-- Define UI elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UsernameTextBox = Instance.new("TextBox")
local PasswordTextBox = Instance.new("TextBox")
local LoginButton = Instance.new("TextButton")
local StatusText = Instance.new("TextLabel")

-- Set properties
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderColor3 = Color3.fromRGB(80, 80, 80) -- Adjusted border color
Frame.BorderSizePixel = 2 -- Increased border size
Frame.Position = UDim2.new(0.5, -115, 0.5, -120) -- Adjusted position
Frame.Size = UDim2.new(0, 230, 0, 240) -- Adjusted size

UsernameTextBox.Parent = Frame
UsernameTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
UsernameTextBox.BorderColor3 = Color3.fromRGB(120, 120, 120)
UsernameTextBox.Position = UDim2.new(0.5, -75, 0.25, -10) -- Adjusted position to center
UsernameTextBox.Size = UDim2.new(0, 150, 0, 20) -- Adjusted size
UsernameTextBox.PlaceholderText = "Username"
UsernameTextBox.TextColor3 = Color3.new(1, 1, 1) -- Text color when typing
UsernameTextBox.TextXAlignment = Enum.TextXAlignment.Center
UsernameTextBox.Text = "" -- Default username

PasswordTextBox.Parent = Frame
PasswordTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PasswordTextBox.BorderColor3 = Color3.fromRGB(120, 120, 120)
PasswordTextBox.Position = UDim2.new(0.5, -75, 0.4, -10) -- Adjusted position to center
PasswordTextBox.Size = UDim2.new(0, 150, 0, 20) -- Adjusted size
PasswordTextBox.PlaceholderText = "Password"
PasswordTextBox.Text = "" -- Default password
PasswordTextBox.TextColor3 = Color3.new(1, 1, 1) -- Text color when typing
PasswordTextBox.TextWrapped = true
PasswordTextBox.TextXAlignment = Enum.TextXAlignment.Center

LoginButton.Parent = Frame
LoginButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Darker color
LoginButton.BorderColor3 = Color3.fromRGB(120, 120, 120)
LoginButton.Position = UDim2.new(0.5, -75, 0.65, -15) -- Adjusted position
LoginButton.Size = UDim2.new(0, 150, 0, 30)
LoginButton.Text = "Login"
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)

StatusText.Parent = Frame
StatusText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0, 0, 0.85, -10) -- Adjusted position
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Font = Enum.Font.SourceSans
StatusText.Text = "Status: "
StatusText.TextColor3 = Color3.new(1, 1, 1)
StatusText.TextSize = 14
StatusText.TextXAlignment = Enum.TextXAlignment.Center

-- Define function to play audio
local function playAudio()
    local audioId = "3642623722" -- Audio ID of the desired audio
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId
    sound.Volume = 10
    sound.Parent = game.Workspace -- Play audio in Workspace
    sound:Play()
end


-- Load users data from third-party URL
local Users = loadstring(game:HttpGet('https://raw.githubusercontent.com/tearfulsoul/users/main/userdata.lua'))()


-- Function to authenticate user based on username, password, and HWID
local function authenticateUser(username, password, hwid)
    if Users then
        -- Check if the provided username exists
        if Users[username] then
            local user = Users[username]
            -- Check if the provided password matches the stored password
            if user.password == password then
                -- Check if the provided HWID matches the stored HWID, if available
                if user.hwid == "" or user.hwid == hwid then
                    return true, "Authentication successful"
                else
                    game.Players.LocalPlayer:Kick("[bit.tech]: HWID mismatch")
                    return false, "HWID mismatch"
                end
            else
                return false, "Incorrect password"
            end
        else
            return false, "User not found"
        end
    else
        return false, "Failed to load user data"
    end
end

-- Function to handle login button click event
local function onLoginButtonClicked()
    local username = UsernameTextBox.Text
    local password = PasswordTextBox.Text
    local hwid = gethwid() -- Assuming gethwid() is a built-in function

    -- Call the authentication function
    local authenticated, message = authenticateUser(username, password, hwid)

    -- Update the status message based on authentication result
    StatusText.Text = "Status: " .. message
    print("[bit.tech]: " .. message)
    
    -- If authentication successful, destroy the UI and play audio
    if authenticated then
        playAudio()
        wait(2)
        ScreenGui:Destroy()

        if game.PlaceId == 2788229376 or game.PlaceId == 7213786345 or game.PlaceId == 16033173781 then


    --anticheat bypass
repeat wait() until game:IsLoaded()

game:GetService("CorePackages").Packages:Destroy()

assert(getrawmetatable)
grm = getrawmetatable(game)
setreadonly(grm, false)
old = grm.__namecall
grm.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(args[1]) == "TeleportDetect" then
        return
    elseif tostring(args[1]) == "CHECKER_1" then
        return
    elseif tostring(args[1]) == "CHECKER" then
        return
    elseif tostring(args[1]) == "GUI_CHECK" then
        return
    elseif tostring(args[1]) == "OneMoreTime" then
        return
    elseif tostring(args[1]) == "checkingSPEED" then
        print('bypassing[3/4]..')
        return
    elseif tostring(args[1]) == "BANREMOTE" then
        return
    elseif tostring(args[1]) == "PERMAIDBAN" then
        return
    elseif tostring(args[1]) == "KICKREMOTE" then
        return
    elseif tostring(args[1]) == "BR_KICKPC" then
        return
    elseif tostring(args[1]) == "BR_KICKMOBILE" then
        return
    end
    return old(self, ...)
end)



--start of welcome
local imageID = "rbxassetid://17158409136"
local blurImageID = "rbxassetid://13353669965" -- New image ID for blurring

-- Create a ScreenGui for the intro
local introGui = Instance.new("ScreenGui")
introGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Function to play the intro sound
local function playIntroSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6580172940"
    sound.Volume = 10
    sound.Parent = game.Players.LocalPlayer
    sound:Play()
    return sound
end

wait(1)

-- Function to create and display the welcome text and image
local function showWelcome(introSound)
    -- Create a BlurEffect to blur the screen
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 20 -- Increase the size to cover the whole screen
    blurEffect.Parent = game.Lighting
    
    -- Create an ImageLabel for the blurred background
    local blurImageLabel = Instance.new("ImageLabel")
    blurImageLabel.Size = UDim2.new(1, 0, 1, 0)
    blurImageLabel.Position = UDim2.new(0, 0, 0, 0)
    blurImageLabel.BackgroundTransparency = 1
    blurImageLabel.Image = blurImageID
    blurImageLabel.Parent = introGui
    
    -- Create an ImageLabel for the intro image
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 150, 0, 150)
    imageLabel.Position = UDim2.new(0.51, 0, 0.15, -5)
    imageLabel.AnchorPoint = Vector2.new(0.5, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = imageID
    imageLabel.Parent = introGui
    
    -- Create a TextLabel for the intro text
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "{     bit.technology     }"
    textLabel.Size = UDim2.new(1, 20, 0.2, 20)
    textLabel.Position = UDim2.new(0, 0, 0.2, 0)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 36
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0.3
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = introGui

    -- Function to fade out the text and image
    local function fadeOut()
        for transparency = 0, 1, 0.05 do
            textLabel.TextTransparency = transparency
            imageLabel.ImageTransparency = transparency
            wait(0.05)
        end
        blurEffect:Destroy() -- Destroy the blur effect after fading out
        blurImageLabel:Destroy() -- Destroy the blurred background after fading out
        textLabel:Destroy() -- Destroy the text label after fading out
        imageLabel:Destroy() -- Destroy the image label after fading out
    end
    
    -- Wait until the sound finishes playing
    introSound.Ended:Wait()
    
    -- Fade out the text and image after the sound ends
    fadeOut()
end

-- Play the intro sound and get a reference to the sound object
local introSound = playIntroSound()

-- Show the welcome text and image
showWelcome(introSound)






getgenv().velocitydisplay = false

--< Velocity Stats >--

local Stats = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TopLine = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ClientStatsLabel = Instance.new("Frame")
local Index = Instance.new("TextLabel")
local Stats_Velocity = Instance.new("Frame")
local Index_2 = Instance.new("TextLabel")
local Value = Instance.new("TextLabel")

Stats.Name = "Stats"
Stats.Parent = game.CoreGui
Stats.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Stats
Frame.AnchorPoint = Vector2.new(1, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0
Frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
Frame.BorderSizePixel = 1
Frame.Position = UDim2.new(1, -15, 0.40109877, 0)
Frame.Size = UDim2.new(0, 200, 0,  45)

TopLine.Parent = Stats
TopLine.AnchorPoint = Vector2.new(1, 0.5)
TopLine.BackgroundColor3 = Color3.fromRGB(218, 91, 206)
TopLine.BackgroundTransparency = 0
TopLine.BorderColor3 = Color3.fromRGB(21, 18, 23)
TopLine.BorderSizePixel = 0
TopLine.Position = UDim2.new(1, -15, 0.4, 0)
TopLine.Size = UDim2.new(0, 200, 0, 1)

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

ClientStatsLabel.Name = "ClientStatsLabel"
ClientStatsLabel.Parent = Frame
ClientStatsLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ClientStatsLabel.BackgroundTransparency = 0
ClientStatsLabel.BorderColor3 = Color3.fromRGB(60, 60, 60)
ClientStatsLabel.BorderSizePixel = 0
ClientStatsLabel.Size = UDim2.new(1, 0, 0, 22)

Index.Name = "Index"
Index.Parent = ClientStatsLabel
Index.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Index.BackgroundTransparency = 0
Index.BorderColor3 = Color3.fromRGB(60, 60, 60)
Index.BorderSizePixel = 0
Index.Position = UDim2.new(0, 5, 0, 0)
Index.Size = UDim2.new(1, -10, 1, 0)
Index.Font = Enum.Font.SourceSansBold
Index.Text = "{     bit.tech     }"
Index.TextColor3 = Color3.fromRGB(255, 255, 255)
Index.TextSize = 17
Index.TextStrokeTransparency = 0.000

Stats_Velocity.Name = "Stats_Velocity"
Stats_Velocity.Parent = Frame
Stats_Velocity.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Stats_Velocity.BackgroundTransparency = 0
Stats_Velocity.BorderColor3 = Color3.fromRGB(60, 60, 60)
Stats_Velocity.BorderSizePixel = 0
Stats_Velocity.Size = UDim2.new(1, 0, 0, 22)

Index_2.Name = "Index"
Index_2.Parent = Stats_Velocity
Index_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Index_2.BackgroundTransparency = 0
Index_2.BorderColor3 = Color3.fromRGB(60, 60, 60)
Index_2.BorderSizePixel = 0
Index_2.Position = UDim2.new(0, 5, 0, 0)
Index_2.Size = UDim2.new(1, -10, 1, 0)
Index_2.Font = Enum.Font.SourceSans
Index_2.Text = "Velocity"
Index_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Index_2.TextSize = 13.000
Index_2.TextStrokeTransparency = 0.000
Index_2.TextXAlignment = Enum.TextXAlignment.Left

Value.Name = "Value"
Value.Parent = Stats_Velocity
Value.AnchorPoint = Vector2.new(1, 0)
Value.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Value.BackgroundTransparency = 0
Value.BorderColor3 = Color3.fromRGB(60, 60, 60)
Value.BorderSizePixel = 0
Value.Position = UDim2.new(1, -5, 0, 0)
Value.Size = UDim2.new(0, 70, 1, 0)
Value.Font = Enum.Font.SourceSans
game:GetService("RunService").heartbeat:Connect(
    function()
        local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        Value.Text = "{ " .. tostring(math.round(velocity.X)) .. ", " .. tostring(math.round(velocity.Y)) .. ", " .. tostring(math.round(velocity.Z)) .. " }"
    end
)
Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Value.TextSize = 13.000
Value.TextStrokeTransparency = 0.000
Value.TextXAlignment = Enum.TextXAlignment.Right

game:GetService("RunService").Heartbeat:Connect(
    function()
        TopLine.Visible = getgenv().velocitydisplay
        Frame.Visible = getgenv().velocitydisplay
    end
)








--start of network anti aim
local Network = {
    ['Enabled'] = false,
    ['Key'] = Enum.KeyCode.Z,
    ['Notification'] = true,
    ['Method'] = 'Physics Sender Rate',
    ['Network Delay'] = 0,
}

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");


local EnablePhysicSenderRate = false;

local Players = game.Players
local Client = Players.LocalPlayer

local defaultPhysicsSenderRate = 60;
local defaultPhysicsSenderMaxBandwidthBps = 1e8;

local function PhysicSenderRate()
    if EnablePhysicSenderRate then
        EnablePhysicSenderRate = false
    else
        EnablePhysicSenderRate = true
    end

    if  Network.Notification then
        local notificationText = EnablePhysicSenderRate and "Network Sleep ;  true" or "Network Sleep  ;  false"
        game.StarterGui:SetCore("SendNotification",{
            Title = "{ bit.tech }",
            Text = notificationText,
            Icon = "rbxassetid://17158409136",
            Duration = 1
        })
    end
end

UserInputService.InputBegan:Connect(function(i, t)
    if not t and i.KeyCode ==  Network.Key and  Network.Enabled == true then
        if  Network.Method == "Physics Sender Rate" then
            PhysicSenderRate()
        end
    end
end)

RunService.Heartbeat:Connect(function(Delta)
    if Network.Enabled then
        if EnablePhysicSenderRate then
            setfflag("S2PhysicsSenderRate", 2)
            setfflag("PhysicsSenderMaxBandwidthBps", (math.pi * Delta))
        else
            setfflag("S2PhysicsSenderRate", defaultPhysicsSenderRate)
            setfflag("PhysicsSenderMaxBandwidthBps", defaultPhysicsSenderMaxBandwidthBps)
        end
    end
end)


--end of network anti aim


-- start of Velocity AntiAim

getgenv().VeloAnti = {
    ['Enabled'] = false,
    ['X'] = 0,
    ['Y'] = 0,
    ['Z'] = 0
}

game:GetService("RunService").Heartbeat:Connect(function()
    if VeloAnti['Enabled'] == true then
        local renderstepped = game:GetService("RunService").RenderStepped
        local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        local cfram = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(getgenv().VeloAnti['X'], getgenv().VeloAnti['Y'], getgenv().VeloAnti['Z'])
        renderstepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cfram
    end
end)


-- end of Velocity AntiAim




-- start of Prediction Multiplier

getgenv().PredMultiplier = {
    ['Enabled'] = false,
    ['Amount'] = 0
}

game:GetService("RunService").Heartbeat:Connect(function()
    local renderstepped = game:GetService("RunService").RenderStepped
        if getgenv().PredMultiplier['Enabled'] == true then
            local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity * getgenv().PredMultiplier['Amount']
            renderstepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
    end
end)


--- end of prediction multiplier



getgenv().PredDivider = {
    ['Enabled'] = false,
    ['Amount'] = 0
}


game:GetService("RunService").Heartbeat:Connect(function()
    local renderstepped = game:GetService("RunService").RenderStepped
        if getgenv().PredDivider['Enabled'] == true then
            local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity * -getgenv().PredDivider['Amount']
            renderstepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
    end
end)








--- Visualize aa
local PastPositionDelay = 1 -- Delay for the trail parts to show the past position (1 second)
local TrailParts = {} -- Store the trail parts
local TrailEnabled = false -- Initially disabled

local visualizeAAColor = {
    PastTrailColor = Color3.new(1, 1, 1)
}

local TorsoSize = Vector3.new(2, 2, 1)
local ArmSize = Vector3.new(1, 2, 1)
local LegSize = Vector3.new(1, 2, 1)

-- Function to create a trail part
local function createTrailPart(position, size)
    local part = Instance.new("Part")
    part.Size = size
    part.Color = visualizeAAColor.PastTrailColor
    part.Material = Enum.Material.Neon
    part.Transparency = 0.5
    part.Anchored = true
    part.CanCollide = false
    part.Position = position
    part.Parent = game.Workspace
    return part
end

-- Function to update the trail with the player's past positions
local function updateTrail(player)
    while true do
        if TrailEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pastPosition = player.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Velocity * PastPositionDelay
            
            -- Get player's look direction
            local lookDirection = player.Character.HumanoidRootPart.CFrame.lookVector
            
            local lastPartPosition = pastPosition
            
            -- Create or update trail parts
            if not TrailParts[1] or not TrailParts[1].Parent then
                TrailParts[1] = createTrailPart(pastPosition, TorsoSize) -- Torso
            else
                TrailParts[1].CFrame = CFrame.new(pastPosition, pastPosition + lookDirection) * CFrame.new(0, 0, -TorsoSize.Z / 2)
                lastPartPosition = pastPosition
            end
            
            if not TrailParts[2] or not TrailParts[2].Parent then
                -- Left Arm
                local leftArmPosition = lastPartPosition + Vector3.new(-1.5, 0, 0) -- Adjusted X-coordinate
                TrailParts[2] = createTrailPart(leftArmPosition, ArmSize)
                TrailParts[2].CFrame = TrailParts[1].CFrame * CFrame.new(-1.5, 0, 0) -- Adjusted position relative to torso
            else
                TrailParts[2].CFrame = TrailParts[1].CFrame * CFrame.new(-1.5, 0, 0) -- Adjusted position relative to torso
            end
            
            if not TrailParts[3] or not TrailParts[3].Parent then
                -- Right Arm
                local rightArmPosition = lastPartPosition + Vector3.new(1.5, 0, 0) -- Adjusted X-coordinate
                TrailParts[3] = createTrailPart(rightArmPosition, ArmSize)
                TrailParts[3].CFrame = TrailParts[1].CFrame * CFrame.new(1.5, 0, 0) -- Adjusted position relative to torso
            else
                TrailParts[3].CFrame = TrailParts[1].CFrame * CFrame.new(1.5, 0, 0) -- Adjusted position relative to torso
            end
            
            if not TrailParts[4] or not TrailParts[4].Parent then
                -- Left Leg
                local leftLegPosition = lastPartPosition + Vector3.new(-0.5, -2, 0)
                TrailParts[4] = createTrailPart(leftLegPosition, LegSize)
                TrailParts[4].CFrame = TrailParts[1].CFrame * CFrame.new(-0.5, -2, 0) -- Adjusted position relative to torso
            else
                TrailParts[4].CFrame = TrailParts[1].CFrame * CFrame.new(-0.5, -2, 0) -- Adjusted position relative to torso
            end
            
            if not TrailParts[5] or not TrailParts[5].Parent then
                -- Right Leg
                local rightLegPosition = lastPartPosition + Vector3.new(0.5, -2, 0)
                TrailParts[5] = createTrailPart(rightLegPosition, LegSize)
                TrailParts[5].CFrame = TrailParts[1].CFrame * CFrame.new(0.5, -2, 0) -- Adjusted position relative to torso
            else
                TrailParts[5].CFrame = TrailParts[1].CFrame * CFrame.new(0.5, -2, 0) -- Adjusted position relative to torso
            end
        end
        wait(0.2) -- Adjust the update frequency for the trail
    end
end

-- Function to toggle the trail on and off
local function toggleTrail()
    TrailEnabled = not TrailEnabled
    if not TrailEnabled then
        -- Clear the trail parts when disabled
        for _, part in ipairs(TrailParts) do
            if part then
                part:Destroy()
            end
        end
        TrailParts = {}
    end
end


-- Function to create the trail for the local player
local function createTrailForLocalPlayer()
    local player = game.Players.LocalPlayer
    updateTrail(player)
end


--- end of visualize aa


-- Game services
local Mouse = game.Players.LocalPlayer:GetMouse()
local colorcorrection = Instance.new("ColorCorrectionEffect")
colorcorrection.Parent = game.Lighting





local worldvis = {
    WorldVisuals = {
        MapBrightness = 0,
        MapContrast = 0,
        MapTintColor = Color3.new(1, 1, 1),

    }
}
game:GetService("RunService").RenderStepped:Connect(function()

    if colorcorrection.Brightness ~= worldvis.WorldVisuals.MapBrightness then
        colorcorrection.Brightness = worldvis.WorldVisuals.MapBrightness
    end

    if colorcorrection.Contrast ~= worldvis.WorldVisuals.MapContrast then
        colorcorrection.Contrast = worldvis.WorldVisuals.MapContrast
    end

    if colorcorrection.TintColor ~= worldvis.WorldVisuals.MapTintColor then
        colorcorrection.TintColor = worldvis.WorldVisuals.MapTintColor
    end
end)


---- Dahod moderator ids
local dickface = {
    1830168970,
    29242182,
    4690110040,
    439942262,
    3944434729,
    67819707,
    4545223,
    155627580,
    3520967,
    89473551,
    2395613299,
    244844600,
    808962546,
    201454243,
    28357488,
    822999,
    93101606,
    163721789,
    8195210,
  
 
}


-- BOOTING ESP
local Sense = loadstring(game:HttpGet('https://sirius.menu/sense'))()



--LOAD ESP 
Sense.Load()

bitTriggerBot = {
    Enabled = false,
    DelayAmount = 0
}


----HEADLESS SPOOF
local Storage = {
    Idle = game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId,
    Run = game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId,
    Walk = game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId,
    Face = nil,
    HeadMeshID = game.Players.LocalPlayer.Character.Head.MeshId,
    RightFootMeshID = game.Players.LocalPlayer.Character.RightFoot.MeshId,
    RightLowerLegMeshID = game.Players.LocalPlayer.Character.RightLowerLeg.MeshId,
    RightUpperLegMeshID = game.Players.LocalPlayer.Character.RightUpperLeg.MeshId,
    RightFootTransparency = game.Players.LocalPlayer.Character.RightUpperLeg.TextureID,
    RightLowerLegTransparency = game.Players.LocalPlayer.Character.RightLowerLeg.Transparency
}
pcall(
    function()
        if (game.Players.LocalPlayer.Character.Head.face.Texture ~= nil) then
            Storage.Face = game.Players.LocalPlayer.Character.Head.face.Texture
        end
    end
)


------------- start of silent aim

local new = { 
    main = { 
        bittechTargetLock = false,
        Prediction = 0.129,
        Part = "HumanoidRootPart", -- Head, UpperTorso, HumanoidRootPart, LowerTorso, RightFoot, LeftFoot, RightArm, LeftArm 
        Key = Enum.KeyCode.Q, -- Using Enum.KeyCode for key
        Notifications = false,
        AirshotFunc = false,
        Orbit = false, -- Added orbit feature
        OrbitDistance = 10, -- Default orbit distance
        OrbitSpeed = 50, -- Default orbit speed (in degrees per second)
        OrbitHeight = 5, -- Default orbit height
        RandomizeTeleport = false, -- Enable/disable random teleport feature
        MinTeleportRange = 5, -- Minimum range of studs for random teleport
        MaxTeleportRange = 15, -- Maximum range of studs for random teleport
        Spectate = false, -- Enable/disable spectate feature
        hitsounds = {
            Bubble = "rbxassetid://6534947588",
            Pick = "rbxassetid://1347140027",
            DrainYaw = "rbxassetid://17167743337",
            Pop = "rbxassetid://198598793",
            Rust = "rbxassetid://1255040462",
            Sans = "rbxassetid://3188795283",
            Fart = "rbxassetid://130833677",
            Big = "rbxassetid://5332005053",
            Vine = "rbxassetid://5332680810",
            UwU = "rbxassetid://8679659744",
            Bruh = "rbxassetid://4578740568",
            Skeet = "rbxassetid://5633695679",
            Neverlose = "rbxassetid://6534948092",
            Fatality = "rbxassetid://6534947869",
            Bonk = "rbxassetid://5766898159"
        },
        selectedHitSound = "rbxassetid://5766898159", -- Default hitsound
        hitsoundsEnabled = false, -- Hitsounds enabled by default
        hitsoundVolume = 5, -- Default volume for hitsounds
    },
    Tracer = { 
        TracerEnabled = false, -- Toggle for tracer
        TracerThickness = 1,
        TracerTransparency = 1,
        TracerColor = Color3.fromRGB(255, 255, 255) -- Default color for tracer
    },
    Dot = { -- New section for dot
        DotEnabled = false, -- Toggle for dot
        DotRadius = 2, -- Radius of the dot
        DotColor = Color3.fromRGB(255, 255, 255) -- Default color for dot
    }
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CurrentCamera = game.Workspace.CurrentCamera
local Plr = Players.LocalPlayer
local Line = Drawing.new("Line")
local Dot = Drawing.new("Circle") -- Creating a circle for the dot
local Inset = game:GetService("GuiService"):GetGuiInset().Y
local lNotification = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua", true))()

local Spectating = false
local Camera = game.Workspace.CurrentCamera

local lockedTarget = nil

local function SpectateTarget(target)
    if target and target.Character then
        Spectating = true
        local humanoidRootPart = target.Character:WaitForChild("HumanoidRootPart")
        Camera.CameraSubject = humanoidRootPart
        Camera.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, new.main.OrbitHeight, -new.main.OrbitDistance), humanoidRootPart.Position)
    end
end

local function StopSpectating()
    Spectating = false
    Camera.CameraSubject = Plr.Character
end

local function SpinAroundTarget(target)
    local targetPosition = target.Character.HumanoidRootPart.Position
    local spinRadius = new.main.OrbitDistance
    local spinSpeed = new.main.OrbitSpeed

    local angle = math.rad(workspace.DistributedGameTime * spinSpeed)
    local offsetX = math.cos(angle) * spinRadius
    local offsetZ = math.sin(angle) * spinRadius

    local newPosition = targetPosition + Vector3.new(offsetX, 0, offsetZ)
    local lookAt = (targetPosition - newPosition).unit
    local rotation = CFrame.new(newPosition, newPosition + lookAt)

    Plr.Character.HumanoidRootPart.CFrame = rotation
end



local function RandomizeTeleportAroundTarget(target)
    local targetPosition = target.Character.HumanoidRootPart.Position
    local maxRange = new.main.MaxTeleportRange

    local offsetX = math.random(-maxRange, maxRange)
    local offsetY = math.random(-maxRange, maxRange)  -- Include height
    local offsetZ = math.random(-maxRange, maxRange)

    local newPosition = targetPosition + Vector3.new(offsetX, offsetY, offsetZ)
    Plr.Character:SetPrimaryPartCFrame(CFrame.new(newPosition))
end


local function PlayHitSound()
    if new.main.hitsoundsEnabled then
        -- Play the selected hitsound
        local sound = Instance.new("Sound")
        sound.SoundId = new.main.selectedHitSound
        sound.Volume = new.main.hitsoundVolume  -- Adjust volume
        sound.Parent = game.Workspace
        sound:Play()

        -- Clean up the sound after it finishes playing
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end


local function MonitorHealth()
    while new.main.bittechTargetLock and lockedTarget do
        local lastHealth = lockedTarget.Character.Humanoid.Health
        repeat
            wait(0.001)
            if lockedTarget.Character.Humanoid.Health < lastHealth then
                if new.main.hitsoundsEnabled == true then
                    PlayHitSound()
                    local damageAmount = math.floor(lastHealth - lockedTarget.Character.Humanoid.Health) -- Round down to the nearest whole number
                    warn("[bit.tech] You hit", lockedTarget, "for", damageAmount, " [ Targetted Part:", new.main.Part, "]")
                end
                lastHealth = lockedTarget.Character.Humanoid.Health
            end
        until lockedTarget.Character.Humanoid.Health >= lastHealth
    end
end




local function FindClosestUser()
    local closestPlayer
    local shortestDistance = math.huge

    -- If there's a locked target, prioritize it
    if new.main.bittechTargetLock == true and lockedTarget then
        return lockedTarget
    end

    -- Otherwise, find the closest player
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Plr and player.Character and player.Character:FindFirstChild("Humanoid") and
            player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CurrentCamera:WorldToViewportPoint(player.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = player
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == new.main.Key then
        if new.main.bittechTargetLock == true then
            new.main.bittechTargetLock = false
            if new.main.Notifications == true then
                lNotification:Notify("bit.tech","Unlocked.",0.5)
            end
            StopSpectating()
        else
            local target = FindClosestUser()
            if target then
                lockedTarget = target
                new.main.bittechTargetLock = true
                if new.main.Notifications == true then
                    lNotification:Notify("bit.tech","Currently Locked OnTo: " .. tostring(lockedTarget.Character.Humanoid.DisplayName),0.9)
                end
                if new.main.Spectate == true then
                    SpectateTarget(lockedTarget)
                end

                -- Start monitoring target's health
                spawn(MonitorHealth)
            end
        end
    end
end)


RunService.Stepped:Connect(function()
    if new.main.bittechTargetLock == true and lockedTarget then
        if new.main.Orbit == true then
            SpinAroundTarget(lockedTarget)
        end

        if new.main.RandomizeTeleport == true then
            RandomizeTeleportAroundTarget(lockedTarget)
        end

        if new.Tracer.TracerEnabled == true then -- Check if tracer is enabled
            local Vector = CurrentCamera:WorldToViewportPoint(lockedTarget.Character[new.main.Part].Position +
                                                            (lockedTarget.Character.HumanoidRootPart.Velocity *
                                                                new.main.Prediction))
            Line.Color = new.Tracer.TracerColor
            Line.Thickness = new.Tracer.TracerThickness
            Line.Transparency = new.Tracer.TracerTransparency

            Line.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y + Inset)
            Line.To = Vector2.new(Vector.X, Vector.Y)
            Line.Visible = true
        else
            Line.Visible = false
        end

        if new.Dot.DotEnabled == true then -- Check if dot is enabled
            local dotVector = CurrentCamera:WorldToViewportPoint(lockedTarget.Character[new.main.Part].Position +
                                                            (lockedTarget.Character.HumanoidRootPart.Velocity *
                                                                new.main.Prediction))
            Dot.Color = new.Dot.DotColor
            Dot.Radius = new.Dot.DotRadius
            Dot.Position = Vector2.new(dotVector.X, dotVector.Y)
            Dot.Visible = true
        else
            Dot.Visible = false
        end
    else
        Line.Visible = false
        Dot.Visible = false
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if new.main.bittechTargetLock and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = lockedTarget.Character[new.main.Part].Position +
                      (lockedTarget.Character[new.main.Part].Velocity * new.main.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

if new.main.AirshotFunc == true then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        new.main.Part = "RightFoot"
    else
        Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall then
                new.main.Part = "RightFoot"
            else
                new.main.Part = "LowerTorso"
            end
        end)
    end
end


----end of silent aim











----- ANTI SLOW Table
getgenv().SlowSettings = {
    AntiSlowEnabled = nil,
}


---ANTI AFK LOAD

getgenv().isAntiAFKEnabled = false
local bb = game:GetService('VirtualUser')
local idledConnection

local function enableAntiAFK()
    if getgenv().isAntiAFKEnabled then return end
    getgenv().isAntiAFKEnabled = true
    idledConnection = game:GetService('Players').LocalPlayer.Idled:Connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
        wait(2)
    end)
end

local function disableAntiAFK()
    if not getgenv().isAntiAFKEnabled then return end
    getgenv().isAntiAFKEnabled = false
    if idledConnection then
        idledConnection:Disconnect()
    end
end

local function toggleAntiAFK()
    if getgenv().isAntiAFKEnabled then
        disableAntiAFK()
    else
        enableAntiAFK()
    end
end



--LOCAL chams toggle
getgenv().LOCALCHAM = {
    Chams = {
        Enabled = false, -- Whether the chams effect is enabled
        Rainbow = false, -- Whether the chams effect color is rainbow
        Material = Enum.Material.ForceField, -- Default material for chams effect
        Color = Color3.fromRGB(255, 105, 180) -- Default color for chams effect (pink)
    }
}






getgenv().monkeyNJC = {
    RemoveJumpCooldown = false
}

local TimeTick
TimeTick =
    hookfunction(
    wait,
    function(JumpCooldown)
        if JumpCooldown == 1.5 and getgenv().monkeyNJC.RemoveJumpCooldown then
            return TimeTick()
        end
        return TimeTick(JumpCooldown)
    end
)


local bittechSpeed = {
    CframeSpeed = {
		Enabled = false,
		Bhop = false,
		Keybind = Enum.KeyCode.C,
		Speed = 1
    }
}





---crosshair initialization
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local crosshair_cfg = {
    Visible = false,
    Size = 50,  -- This represents the length of the crosshair
    SpinSpeed = 1,
    SpinAnimation = true,
    Position = Vector2.new(0, 0),
    Color = Color3.new(1, 0, 1),
    Thickness = 1.5
}

local lineSets = {
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 0, visible = crosshair_cfg.Visible},   -- Bottom
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 90, visible = crosshair_cfg.Visible},  -- Top
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 180, visible = crosshair_cfg.Visible}, -- Right
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 270, visible = crosshair_cfg.Visible}  -- Left
}
local drawings = {}

local watermark = Drawing.new("Text")
watermark.Text = "bit"
watermark.Size = 20
watermark.Color = Color3.new(1, 1, 1) -- White text color
watermark.Center = true
watermark.Outline = true -- Enable outline
watermark.OutlineColor = Color3.new(0, 0, 0) -- Black outline

local extensionText = Drawing.new("Text")
extensionText.Text = ".lua"
extensionText.Size = 20
extensionText.Center = true
extensionText.Outline = true -- Enable outline
extensionText.OutlineColor = Color3.new(0, 0, 0) -- Black outline

local function updateLines(cursorPosition)
    -- Update watermark visibility
    watermark.Visible = crosshair_cfg.Visible
    extensionText.Visible = crosshair_cfg.Visible

    -- Update watermark position below the crosshair
    watermark.Position = Vector2.new(cursorPosition.X, cursorPosition.Y + 20) -- Adjust the Y position as needed
    extensionText.Position = Vector2.new(cursorPosition.X + watermark.TextBounds.X / 2 + extensionText.TextBounds.X / 2 + 2, cursorPosition.Y + 20) -- Adjust the X position based on text bounds

    for setIndex, set in ipairs(lineSets) do
        for i, line in ipairs(drawings[setIndex]) do
            local alpha = 0.1 + (i / set.count) * 0.8 
            local angle = math.rad(set.direction)
            local xOffset = math.cos(angle) * (i * 5)
            local yOffset = math.sin(angle) * (i * 5)    
            local fromX = cursorPosition.X + xOffset + crosshair_cfg.Position.X
            local fromY = cursorPosition.Y + yOffset + crosshair_cfg.Position.Y
            local toX = cursorPosition.X + xOffset * 2 + crosshair_cfg.Position.X
            local toY = cursorPosition.Y + yOffset * 2 + crosshair_cfg.Position.Y
            line.From = Vector2.new(fromX, fromY)
            line.To = Vector2.new(toX, toY)
            line.Color = crosshair_cfg.Color
            line.Thickness = crosshair_cfg.Thickness
            line.Transparency = 1 - alpha
            line.Visible = set.visible
        end
    end
end

for setIndex, set in ipairs(lineSets) do
    drawings[setIndex] = {}
    for i = 1, set.count do
        local line = Drawing.new('Line')
        line.ZIndex = 2
        line.Thickness = set.thickness
        drawings[setIndex][i] = line
    end
end

RunService.RenderStepped:Connect(function()
    if crosshair_cfg.SpinAnimation then 
        for setIndex, set in ipairs(lineSets) do
            set.direction = set.direction + crosshair_cfg.SpinSpeed
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local cursorPosition = UserInputService:GetMouseLocation()
    updateLines(cursorPosition)
end)

local function recenterCrosshair()
    lineSets[1].direction = 0  -- Bottom
    lineSets[2].direction = 90 -- Top
    lineSets[3].direction = 180 -- Right
    lineSets[4].direction = 270 -- Left
end
-- If spin feature is disabled, recenter the crosshair

if not crosshair_cfg.SpinAnimation then
    recenterCrosshair()
end

---crosshair initialization






local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local themthing = "https://raw.githubusercontent.com/tearfulsoul/ptahooktheme/main/"
-- Load necessary libraries
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(themthing .. 'ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Load UI notification library
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

-- Notify injection success
Notification:Notify(
    { Title = "bit.tech", Description = "Successfully Injected" },
    { OutlineColor = Color3.fromRGB(80, 80, 80), Time = 3, Type = "image" },
    { Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84) }
)

-- Create the main window
local Window = Library:CreateWindow({
    Title = '{ bit.tech } { build : private }',
    Center = true,
    AutoShow = true,
    TabPadding = 2,
    MenuFadeTime = 0.2
})

-- Add tabs
local Tabs = {
    Aimbot = Window:AddTab('RageBot'),
    AntiAimTab = Window:AddTab('Anti-Aim'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    ExtraTab = Window:AddTab('Extras'),
    PlayerlistTab = Window:AddTab('PlayerList'),
    ['UI Settings'] = Window:AddTab('Config'),
}


local TargetAim = Tabs.Aimbot:AddLeftGroupbox('TargetAim')


TargetAim:AddLabel('Keybind'):AddKeyPicker('TargetAimKeybind', {
    Default = 'Q', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Target Aim Bind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        new.main.WishAim = Value
        print('[bit.tech] Targetting Status: ', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New) 
        new.main.Key = New
        print('[bit.tech] Targetting Keybind to', New)
    end
})


TargetAim:AddInput('PredictionTextBox', {
    Default = '0.12954',
    Numeric = true, -- true / false, only allows numbers
    Finished = true, -- true / false, only calls callback when you press enter

    Text = 'Prediction Value',
    Tooltip = 'Please Enter A Prediction Value', -- Information shown when you hover over the textbox

    Placeholder = 'Prediction Value', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[bit.tech] You have changed your Prediction: ', Value)
    end
})


TargetAim:AddDropdown('HitboxSelectionDropdown', {
    Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso', 'RightFoot', 'LeftFoot', 'RightArm', 'LeftArm' },
    Default = 3, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Hitbox Selection',
    Tooltip = 'Select a hitbox to Target', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        new.main.Part = Value
        print('[bit.tech] Targetted Hitbox Changed to: ', Value)
    end
})


TargetAim:AddToggle('ResolverToggle', {
    Text = 'Resolver',
    Default = false, 
    Tooltip = 'Resolver',

    Callback = function(Value)
        local originalVelocities = {} -- Store original velocities
        if Value then -- If the toggle is turned on
            RunService.Heartbeat:Connect(function()
                pcall(function()
                    for i,v in pairs(game.Players:GetChildren()) do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            local hrp = v.Character.HumanoidRootPart
                            if not originalVelocities[hrp] then -- Store original velocity if not already stored
                                originalVelocities[hrp] = hrp.Velocity
                            end
                            hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                            hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                        end
                    end
                end)
            end)
        else -- If the toggle is turned off
            while not Value do -- Keep restoring velocities as long as the toggle is off
                for hrp, originalVelocity in pairs(originalVelocities) do
                    hrp.Velocity = originalVelocity -- Restore original velocity
                    hrp.AssemblyLinearVelocity = originalVelocity
                end
                wait(0.5) -- Adjust the delay between restoration attempts as needed
            end
        end
    end
})


TargetAim:AddDivider()

TargetAim:AddToggle('HitsoundsToggle', {
    Text = 'Enable Hitsounds',
    Callback = function(enabled)
        new.main.hitsoundsEnabled = enabled
    end
})


TargetAim:AddSlider('HitsoundVolumeSlider', {
    Text = 'Hitsound Volume',
    Default = 5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.main.hitsoundVolume = Value
    end
})

TargetAim:AddDropdown('HitSoundDropdown', {
    Values = { 'DrainYaw', 'UwU', 'Bubble', 'Pick', 'Pop', 'Rust', 'Sans', 'Fart', 'Big', 'Vine', 'Bruh', 'Skeet', 'Neverlose', 'Fatality', 'Bonk' },
    Default = 13, -- Default to 'Bonk'
    Multi = false,
    Text = 'HitSound',
    Tooltip = 'Select a HitSound',
    Callback = function(value)
        if new.main.hitsounds[value] then
            new.main.selectedHitSound = new.main.hitsounds[value]
        else
            warn("Hitsound not found for value:", value)
        end
    end
})

TargetAim:AddDivider()

TargetAim:AddToggle('SpectateTargetToggle', {
    Text = 'Spectate',
    Default = false, 
    Tooltip = 'Enable/Disable Spectate',

    Callback = function(Value)
        new.main.Spectate = Value
    end
})

TargetAim:AddToggle('NotificationTargetToggle', {
    Text = 'Notification',
    Default = false, 
    Tooltip = 'Enable/Disable notifications',

    Callback = function(Value)
        new.main.Notifications = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

local TargetAimOrbit = Tabs.Aimbot:AddRightGroupbox('Orbit')



TargetAimOrbit:AddToggle('OrbitToggle', {
    Text = 'Orbit',
    Default = false, 
    Tooltip = 'Enable/Disable notifications',

    Callback = function(Value)
        new.main.Orbit = Value
    end
})

TargetAimOrbit:AddDivider()


TargetAimOrbit:AddSlider('OrbitDistanceSlider', {
    Text = 'Orbit Distance',
    Default = 5,
    Min = 0,
    Max = 50,
    Suffix = "stud",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.main.OrbitDistance = Value
    end
})


TargetAimOrbit:AddSlider('OrbitSpeedSlider', {
    Text = 'Orbit Speed',
    Default = 3,
    Min = 0,
    Max = 100,
    Suffix = "°",

    Rounding = 2,
    Compact = true,

    Callback = function(Value)
		new.main.OrbitSpeed = Value * 15
    end
})

local TargetAimRandomTP = Tabs.Aimbot:AddRightGroupbox('Randomized teleportation')

TargetAimRandomTP:AddToggle('RandomTPToggle', {
    Text = 'Randomize Teleportation',
    Default = false, 
    Tooltip = 'Enable/Disable Teleportation',

    Callback = function(Value)
        new.main.RandomizeTeleport = Value
    end
})

TargetAimRandomTP:AddDivider()



TargetAimRandomTP:AddSlider('RandomTPMaxRangeSlider', {
    Text = 'Maximum Range',
    Default = 10,
    Min = 0.1,
    Max = 50,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.main.MaxTeleportRange = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})



local VisualizeTargetAimTab = Tabs.Aimbot:AddRightGroupbox('Visualize')

-- TRACER SECTIon

VisualizeTargetAimTab:AddToggle('TracerToggleTargetAim', {
    Text = 'Tracer',
    Default = false, 
    Tooltip = 'Enable/Disable Tracers',

    Callback = function(Value)
        new.Tracer.TracerEnabled = Value
    end
})


VisualizeTargetAimTab:AddSlider('TargetAimTracerTransparency', {
    Text = 'Tracer Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Suffix = "px",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.Tracer.TracerTransparency = Value
    end
})


VisualizeTargetAimTab:AddSlider('TargetAimTracerThicknessSlider', {
    Text = 'Tracer Thickness',
    Default = 3,
    Min = 1,
    Max = 10,
    Suffix = "px",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.Tracer.TracerThickness = Value
    end
})

VisualizeTargetAimTab:AddLabel('TargetTracer Color'):AddColorPicker('TargetTracerColorSlider', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Tracer Color', 
    Transparency = 0, 

    Callback = function(Value)
        new.Tracer.TracerColor = Value
    end
})


VisualizeTargetAimTab:AddDivider()

--- DOT SECTION

VisualizeTargetAimTab:AddToggle('DotToggleTargetAim', {
    Text = 'Dot',
    Default = false, 
    Tooltip = 'Enable/Disable Tracers',

    Callback = function(Value)
        new.Dot.DotEnabled = Value
    end
})


VisualizeTargetAimTab:AddSlider('DotRadiusSlider', {
    Text = 'Dot Radius',
    Default = 2,
    Min = 0,
    Max = 10,
    Suffix = "px",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.Dot.DotRadius = Value * 10
    end
})


VisualizeTargetAimTab:AddLabel('Dot Color'):AddColorPicker('DotColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Dot Color', 
    Transparency = 0, 

    Callback = function(Value)
        new.Dot.DotColor = Value
    end
})





local TriggerBotSec = Tabs.Aimbot:AddLeftGroupbox('Triggerbot')

TriggerBotSec:AddToggle('TriggerBotToggle', {
    Text = 'Trigger Bot',
    Default = false, 
    Tooltip = 'Triggerbot enabled/disable',

    Callback = function(Value)
		bitTriggerBot.Enabled = Value
    end
})

TriggerBotSec:AddSlider('TriggerBotDelaySlider', {
    Text = 'Triggerboy Delay',
    Default = 50,
    Min = 0,
    Max = 60,
    Suffix = "ms",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		bitTriggerBot.DelayAmount = Value
    end
})
game:GetService("RunService").Heartbeat:Connect(function()
        if bitTriggerBot.Enabled then
        for i, v in next, Players:GetPlayers() do 
            if Alive(v) then 
                if Mouse.Target:IsDescendantOf(v.Character) and bitTriggerBot.Enabled == true then 
                    mouse1press()
                    wait()
                    mouse1release()
                    wait(bitTriggerBot.DelayAmount)
                end 
            end
        end
        end -- tb
    end)


---- START FOR ANTI AIM TAB



--custom velo tab
local VelocityAntiAimTab = Tabs.AntiAimTab:AddLeftGroupbox('Velocity Anti-Aim')


VelocityAntiAimTab:AddToggle('VelocityAntiAimToggle', {
    Text = 'Custom Velocity',
    Default = false, 
    Tooltip = 'Enable/Disable Velocity AA',
    Callback = function(Val)
        VeloAnti['Enabled'] = Val
end
})


VelocityAntiAimTab:AddDivider()

VelocityAntiAimTab:AddSlider('VeloAntiX', {
    Text = 'X axis',
    Default = 0,
    Min = -100,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().VeloAnti['X'] = Value / 4
    end
})

VelocityAntiAimTab:AddSlider('VeloAntiY', {
    Text = 'Y axis',
    Default = 0,
    Min = -100,
    Max =  100,
    Rounding = 1,
    Suffix = "%",
    Compact = false,

    Callback = function(Value)
        getgenv().VeloAnti['Y'] = Value * 160
    end
})


VelocityAntiAimTab:AddSlider('VeloAntiZ', {
    Text = 'Z axis',
    Default = 0,
    Min = -100,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().VeloAnti['Z'] = Value / 4
    end
})



--multipliertab
local PredictionMultiplier = Tabs.AntiAimTab:AddRightGroupbox('Prediction Multiplier')

PredictionMultiplier:AddToggle('MultiplyPredictionToggle', {
    Text = 'Multiply Prediction',
    Default = false, 
    Tooltip = 'Enable/Disable Prediction Multiplier',
    Callback = function(Val)
        getgenv().PredMultiplier['Enabled'] = Val
end
})

PredictionMultiplier:AddSlider('MultiplyPredictionAmount', {
    Text = 'Amount',
    Default = 0,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().PredMultiplier['Amount'] = Value / 62
    end
})


--dividertab
local PredictionDivider = Tabs.AntiAimTab:AddRightGroupbox('Prediction Divider')

PredictionDivider:AddToggle('DividePredictionToggle', {
    Text = 'Divide Prediction',
    Default = false, 
    Tooltip = 'Enable/Disable Prediction Multiplier',
    Callback = function(Val)
        getgenv().PredDivider['Enabled'] = Val
end
})

PredictionDivider:AddSlider('DividePredictionAmount', {
    Text = 'Amount',
    Default = 0,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().PredDivider['Amount'] = Value / 62
    end
})


getgenv().LockBreaker = {
    ['Enabled'] = false,
    ['Mode'] = 'Static' -- Static, Fluctuate
}

--lockbreakerrtab
local LockBreakerTab = Tabs.AntiAimTab:AddLeftGroupbox('Lock Breaker')

LockBreakerTab:AddToggle('LockBreakerToggle', {
    Text = 'Break Lock',
    Default = false, 
    Tooltip = 'Enable/Disable Lock Breaker',
    Callback = function(Val)
        getgenv().LockBreaker['Enabled'] = Val
end
})


LockBreakerTab:AddDropdown('MyDropdown', {
    Values = { 'Static', 'Fluctuate' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Method',
    Tooltip = 'Select a Lock Breaker Mode', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        getgenv().LockBreaker['Mode'] = Value
    end
})

LockBreakerTab:AddLabel('Note:')
LockBreakerTab:AddLabel('Use cframe to move')



game:GetService("RunService").Heartbeat:Connect(function()
    local renderstepped = game:GetService("RunService").RenderStepped

    if getgenv().LockBreaker['Enabled'] == true and getgenv().LockBreaker['Mode'] == 'Fluctuate' then
        local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(1,16384),math.random(1,16384),math.random(1,16384))
        renderstepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity

    elseif getgenv().LockBreaker['Enabled'] == true and getgenv().LockBreaker['Mode'] == 'Static' then
        local velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
     
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity =
            velocity * 0 + Vector3.new(10000000000000000000, 10000000000000000000, 10000000000000000000)
            game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity =
            velocity * 0 + Vector3.new(10000000000000000000, 10000000000000000000, 10000000000000000000)
        renderstepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = velocity
    end
end)






getgenv().PredBreakerMW = {
    ['Enabled'] = false,
    ['Power'] = 0,
}

-- prediction breaker tab
local PredictionBreakerTab = Tabs.AntiAimTab:AddRightGroupbox('Moon Walk')

PredictionBreakerTab:AddToggle('PredBreakerTab', {
    Text = 'Prediction Breaker',
    Default = false, 
    Tooltip = 'Enable/Disable Prediction Multiplier',
    Callback = function(Val)
        getgenv().PredBreakerMW['Enabled'] = Val
end
})

PredictionBreakerTab:AddSlider('DividePredictionAmount', {
    Text = 'Power',
    Default = 0,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().PredBreakerMW['Amount'] = Value / 2
    end
})



game:GetService("RunService").Heartbeat:Connect(function()
    local renderstepped = game:GetService("RunService").RenderStepped
    if getgenv().PredBreakerMW['Enabled'] == true then
        getgenv().mwmult = getgenv().PredBreakerMW['Amount'] /100 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + 
        game.Players.LocalPlayer.Character.Humanoid.MoveDirection * -getgenv().mwmult
    end
end)



--networktab
local NetworkAntiAimTab = Tabs.AntiAimTab:AddLeftGroupbox('Network Anti-Aim')


NetworkAntiAimTab:AddToggle('NetworkDesyncToggle', {
    Text = 'Network Desync',
    Default = false, 
    Tooltip = 'Enable/Disable Network Desync',
    Callback = function(e)
        Network['Enabled'] = e
end
})


NetworkAntiAimTab:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'Z', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Network Desync Bind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        Network['Key'] = New
    end
})

--- visualize antiaim

NetworkAntiAimTab:AddDivider()


NetworkAntiAimTab:AddSlider('NetworkDelaySlider', {
    Text = 'Network Delay',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        Network['Network Delay'] = Value
    end
})




--network2tab

getgenv().Network2 = {
    ['Enabled'] = false,
    ['Power'] = 0
}

local NetworkAntiAim2Tab = Tabs.AntiAimTab:AddLeftGroupbox('Network Anti-Aim')


NetworkAntiAim2Tab:AddToggle('NetworkDesyncToggle', {
    Text = 'Network Desync #2',
    Default = false, 
    Tooltip = 'Enable/Disable Network Desync #2',
    Callback = function(e)
        getgenv().Network2['Enabled'] = e
end
})

NetworkAntiAim2Tab:AddSlider('NetworkDelaySlider', {
    Text = 'Network Sleep Power',
    Default = 0,
    Min = 0,
    Max = 15,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        getgenv().Network2['Power'] = Value
    end
})



--fakelagtab

local FakeLagAntiAimTab = Tabs.AntiAimTab:AddRightGroupbox('FakeLag')

local FakeLag = false

FakeLagAntiAimTab:AddToggle('MyToggle', {
    Text = 'FakeLag',
    Default = false, 
    Tooltip = 'Enable/Disable FakeLag',
    Callback = function(e)
        FakeLag = false
        getgenv().FakeLagSpeed = 0.000001
        if e then
            FakeLag = true
            while FakeLag == true do
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(getgenv().FakeLagSpeed)
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = false
                wait()
            end
        else
            FakeLag = false
        end
end
})


FakeLagAntiAimTab:AddSlider('Size', {
    Text = 'Amount',
    Default = 1,  -- Length of the crosshair
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().FakeLagSpeed = Value / 100
    end
})

local AntiAimVisualizationsTab = Tabs.AntiAimTab:AddRightGroupbox('Anti-Aim Visuals')


AntiAimVisualizationsTab:AddToggle('VisualizeAA', {
    Text = 'Visualize Networked',
    Default = false, 
    Tooltip = 'Enable/Disable Visualization',
    Callback = function(enabled)
        TrailEnabled = enabled
        if TrailEnabled then
            -- Start or resume updating the trail
            createTrailForLocalPlayer()
        else
            -- Disable the trail
            toggleTrail()
            toggleTrail()
        end
    end
})

AntiAimVisualizationsTab:AddLabel('VisualizeAA Color'):AddColorPicker('VisualizeAAColor', {
    Default = Color3.new(0.737254, 0.627450, 0.811764), 
    Title = 'VisualizeAA Color', 
    Transparency = 0,

    Callback = function(Value)
        visualizeAAColor.PastTrailColor = Value
        print('[cb] Color changed!', Value)
    end
})


AntiAimVisualizationsTab:AddDivider()

AntiAimVisualizationsTab:AddToggle('VelocityDisplayIndicator', {
    Text = 'Velocity Indicator',
    Default = false, 
    Tooltip = 'Enable/Disable Velocity AA',
    Callback = function(Val)
        getgenv().velocitydisplay = Val
end
})




--- START FOR VISUALS TAB
local LeftGroupBox = Tabs.Visuals:AddLeftGroupbox('Main')
LeftGroupBox:AddToggle('VisualsMasterKey', {
    Text = 'Enable',
    Default = false, 
    Tooltip = 'ESP MasterKey',

    Callback = function(Value)
		Sense.teamSettings.enemy.enabled = Value
    end
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('NameEspToggle', {
    Text = 'Name',
    Default = false, 
    Tooltip = 'Name', 

    Callback = function(Value)
		Sense.teamSettings.enemy.name = Value
    end
})

LeftGroupBox:AddToggle('NameOutlineEspToggle', {
    Text = 'Name Outline',
    Default = false, 
    Tooltip = 'Name Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.nameOutline = Value
    end
})




LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('BoxEspToggle', {
    Text = 'Box',
    Default = false,
    Tooltip = 'Box', 

    Callback = function(Value)
		Sense.teamSettings.enemy.box = Value
    end
})



LeftGroupBox:AddToggle('BoxOutlineToggle', {
    Text = 'Box Outline',
    Default = false,
    Tooltip = 'Box Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxOutline = Value
    end
})

LeftGroupBox:AddToggle('BoxFillToggle', {
    Text = 'Box Fill',
    Default = false, 
    Tooltip = 'Box Fill', 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxFill = Value
    end
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('HealthBarToggle', {
    Text = 'Health Bar',
    Default = false, 
    Tooltip = 'Health Bar', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthBar = Value
    end
})

LeftGroupBox:AddToggle('HealthBarOutlineToggle', {
    Text = 'Health Bar Outline',
    Default = false,
    Tooltip = 'Health Bar Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthBarOutline = Value
    end
})

LeftGroupBox:AddToggle('HealthBarTextToggle', {
    Text = 'Health Bar Text',
    Default = false, 
    Tooltip = 'Health Bar Text', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthText = Value
    end
})



LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('WeaponsESPToggle', {
    Text = 'Weapons',
    Default = false, 
    Tooltip = 'Weapons', 
    Callback = function(Value)
		Sense.teamSettings.enemy.weapon = Value
    end
})

LeftGroupBox:AddToggle('WeaponsESPOutlineToggle', {
    Text = 'Weapons Outline',
    Default = false, 
    Tooltip = 'Weapons Outline', 
    Callback = function(Value)
		Sense.teamSettings.enemy.weaponOutline = Value
    end
})


LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('DistanceEspToggle', {
    Text = 'Distance',
    Default = false,
    Tooltip = 'Distance', 

    Callback = function(Value)
		Sense.teamSettings.enemy.distance = Value
    end
})


LeftGroupBox:AddToggle('DistanceOutlineEspToggle', {
    Text = 'Distance Outline',
    Default = false,
    Tooltip = 'Distance', 

    Callback = function(Value)
		Sense.teamSettings.enemy.distanceOutline = Value
    end
})


LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('TracerESPToggle', {
    Text = 'Tracers',
    Default = false, 
    Tooltip = 'Tracers', 
    Callback = function(Value)
		Sense.teamSettings.enemy.tracer = Value
    end
})

LeftGroupBox:AddToggle('TracerOutlineESPToggle', {
    Text = 'Tracers Outline',
    Default = false, 
    Tooltip = 'Tracers Outline', 
    Callback = function(Value)
		Sense.teamSettings.enemy.tracerOutline = Value
    end
})


LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Bottom', 'Top' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Tracer Origin',
    Tooltip = 'Select Tracer Origin', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        Sense.teamSettings.enemy.tracerOrigin = Value
    end
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('OutOfSCreenArrows', {
    Text = 'OOF Arrows',
    Default = false,
    Tooltip = 'OOF Arrows', 

    Callback = function(Value)
		Sense.teamSettings.enemy.offScreenArrow = Value
    end
})


LeftGroupBox:AddToggle('OutOfSCreenArrowsOutline', {
    Text = 'OOF Arrows Outline',
    Default = false,
    Tooltip = 'OOF Arrows Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.offScreenArrowOutline = Value
    end
})

LeftGroupBox:AddSlider('OOFArrowSizeSlider', {
    Text = 'OOF Arrows Size',
    Default = 0,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        Sense.teamSettings.enemy.offScreenArrowSize = Value
    end
})
LeftGroupBox:AddSlider('OOFArrowsRadiusSlider', {
    Text = 'OOF Arrows Radius',
    Default = 0,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        Sense.teamSettings.enemy.offScreenArrowRadius = Value * 10
    end
})



LeftGroupBox:AddDivider()


------//// COLOR TAB
local TabBox = Tabs.Visuals:AddRightTabbox()
local Tab1 = TabBox:AddTab('Colors')
local Tab2s = TabBox:AddTab('ESP Settings')



Tab1:AddLabel('Name Color'):AddColorPicker('NameColorPicker', {
    Default = Color3.new(0.670588, 0.592156, 0.905882), 
    Title = 'Name Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.nameColor = { Value, 1 }
    end
})

Tab1:AddLabel('Weapon Color'):AddColorPicker('WeaponColorPicker', {
    Default = Color3.new(0.850980, 0.631372, 0.631372), 
    Title = 'Weapon Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.weaponColor = { Value, 1 }
    end
})

Tab1:AddLabel('OOF Arrow Color'):AddColorPicker('OOFArrowColorPicker', {
    Default = Color3.new(0.929411, 0.733333, 0.956862), 
    Title = 'OOF Arrow Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.offScreenArrowColor = { Value, 1 }
    end
})

Tab1:AddLabel('OOF Arrow Outline Color'):AddColorPicker('OOFArrowOutlineColorPicker', {
    Default = Color3.new(0.172549, 0.168627, 0.176470), 
    Title = 'OOF Arrow Outline Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.offScreenArrowOutlineColor = { Value, 1 }
    end
})


Tab1:AddLabel('Box Color'):AddColorPicker('BoxColorPicker', {
    Default = Color3.new(0.572549, 0.568627, 0.737254), 
    Title = 'Box Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxColor[1] = Value
    end
})

Tab1:AddLabel('Box Fill Color'):AddColorPicker('BoxFillColorPicker', {
    Default = Color3.new(0.490196, 0.596078, 0.694117), -- White
    Title = 'Box Fill Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxFillColor = { Value, 0.5 }
    end
})


Tab1:AddLabel('Tracer Color'):AddColorPicker('ESPTracerColorPicker', {
    Default = Color3.new(1, 0.717647, 0.717647), -- White
    Title = 'Tracer Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.tracerColor = { Value, 0.5 }
    end
})


-- espSETTINGS

Tab2s:AddToggle('EnableLimitESPDistance', {
    Text = 'Limit Distance',
    Default = false,
    Callback = function(Value)
        Sense.sharedSettings.limitDistance = Value
    end
})

Tab2s:AddSlider('ESPMaxDistanceSlider', {
    Text = 'Max Distance',
    Default = 50,  -- Length of the crosshair
    Min = 1,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        Sense.sharedSettings.maxDistance = Value * 50
    end
})

Tab2s:AddDivider()

Tab2s:AddSlider('ESPTextSize', {
    Text = 'Text Size',
    Default = 50,
    Min = 1,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        Sense.sharedSettings.textSize = Value / 2
    end
})





-- custom crosshair


local TabBox2 = Tabs.Visuals:AddRightTabbox()
local Tab2 = TabBox2:AddTab('Custom Crosshair')

Tab2:AddToggle('EnabledCustomCrossHair', {
    Text = 'Enabled',
    Default = crosshair_cfg.Visible,
    Callback = function(Value)
        crosshair_cfg.Visible = Value
        for _, set in ipairs(lineSets) do
            set.visible = Value
        end
    end
})

Tab2:AddLabel('Color'):AddColorPicker('CrosshairColorPicker', {
    Default = Color3.new(0.611764, 0.674509, 0.768627),
    Title = 'Crosshair Color',
    Transparency = 0,
    Callback = function(Value)
        crosshair_cfg.Color = Value
        extensionText.Color = Value
    end
})

Tab2:AddSlider('CrossHairSizeSlider', {
    Text = 'Size',
    Default = crosshair_cfg.Size,  -- Length of the crosshair
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.Size = Value
        -- Update the count of the lineSets according to the new size
        for _, set in ipairs(lineSets) do
            set.count = Value
        end
    end
})

Tab2:AddSlider('CrosshairThicknessSlider', {
    Text = 'Thickness',
    Default = crosshair_cfg.Thickness,
    Min = 0.1,
    Max = 10,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.Thickness = Value
    end
})

Tab2:AddToggle('CrosshairSpinToggle', {
    Text = 'Spin',
    Default = crosshair_cfg.SpinAnimation,
    Callback = function(Value)
        crosshair_cfg.SpinAnimation = Value
    end
})

Tab2:AddSlider('CrosshairSpinSpeedSlider', {
    Text = 'Speed',
    Default = crosshair_cfg.SpinSpeed,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.SpinSpeed = Value
    end
})


local RecenterXHair = Tab2:AddButton({
    Text = 'Recenter Crosshair',
    Func = function()
        recenterCrosshair()
    end,
    DoubleClick = false,
    Tooltip = 'Recenter Crosshair'
})

---
local TabBox2 = Tabs.Visuals:AddLeftTabbox()
local TTab1 = TabBox2:AddTab('Local Chams')
local TTab2 = TabBox2:AddTab('Enemy Chams')
local TTab3 = TabBox2:AddTab('Local Other')


TTab1:AddToggle('LocalChamsToggle', {
    Text = 'Enable Chams',
    Default = false,
    Callback = function(Value)
        getgenv().LOCALCHAM.Chams.Enabled = Value
    end
})

TTab1:AddDivider()
TTab1:AddLabel('Color'):AddColorPicker('LocalChamColorPikcer', {
    Default = Color3.fromRGB(164, 140, 179),
    Title = 'Chams Color',
    Transparency = 0,
    Callback = function(Value)
        getgenv().LOCALCHAM.Chams.Color = Value
    end
})

TTab1:AddToggle('RanbowChamToggle', {
    Text = 'Rainbow Chams',
    Default = crosshair_cfg.Visible,
    Callback = function(Value)
        getgenv().LOCALCHAM.Chams.Rainbow = Value
    end
})



local function toggleChams()
    getgenv().LOCALCHAM.Chams.Enabled = not getgenv().LOCALCHAM.Chams.Enabled
end

local function updateChams()
    while true do
        if getgenv().LOCALCHAM.Chams.Enabled then
            for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if getgenv().LOCALCHAM.Chams.Rainbow then
                        local t = tick() * 6
                        local r = math.sin(t) * 0.5 + 0.5
                        local g = math.sin(t + 2 * math.pi / 3) * 0.5 + 0.5
                        local b = math.sin(t + 4 * math.pi / 3) * 0.5 + 0.5
                        part.Color = Color3.fromRGB(r * 255, g * 255, b * 255)
                    else
                        part.Color = getgenv().LOCALCHAM.Chams.Color
                    end
                    part.Material = getgenv().LOCALCHAM.Chams.Material
                end
            end
        else
            -- If chams are disabled, set material to Plastic and color to white
            for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                    part.Color = Color3.new(1, 1, 1) -- White color
                end
            end
        end
        wait()
    end
end

-- Start the coroutine to update chams
spawn(updateChams)




---start of enemy chams

TTab2:AddToggle('EnemyChamToggle', {
    Text = 'Enable Enemy Chams',
    Default = false,
    Callback = function(Value)
        Sense.teamSettings.enemy.chams = Value
    end
})

TTab2:AddToggle('EnemyChamVisibleOnlyToggle', {
    Text = 'Visible Only',
    Default = false,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsVisibleOnly = Value
    end
})


TTab2:AddDivider()
TTab2:AddLabel('Chams Enemy Outline Color'):AddColorPicker('EnemyChamOutlineColorPicker', {
    Default = Color3.fromRGB(217, 152, 217),
    Title = 'Chams Enemy Outline Color',
    Transparency = 0,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsOutlineColor = { Value, 0 }
    end
})

TTab2:AddLabel('Chams Enemy Fill Color'):AddColorPicker('EnemyChamFillColorPicker', {
    Default = Color3.fromRGB(198, 243, 172),
    Title = 'Chams Enemy Fill Color',
    Transparency = 0,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsFillColor = { Value, 0.5 }
    end
})


---start of Local OTHER

TTab3:AddToggle('Enabled', {
    Text = 'Enable Headless',
    Default = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.Head.MeshId = "rbxassetid://6686307858"
        else
            game.Players.LocalPlayer.Character.Head.MeshId = Storage.HeadMeshID
        end
    end
})

TTab3:AddToggle('Enabled', {
    Text = 'Enable Korblox',
    Default = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.RightFoot.MeshId = "http://www.roblox.com/asset/?id=902942093"
            game.Players.LocalPlayer.Character.RightLowerLeg.MeshId = "http://www.roblox.com/asset/?id=902942093"
            game.Players.LocalPlayer.Character.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
            game.Players.LocalPlayer.Character.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
            game.Players.LocalPlayer.Character.RightFoot.Transparency = 1
            game.Players.LocalPlayer.Character.RightLowerLeg.Transparency = 1
        else
            game.Players.LocalPlayer.Character.RightFoot.MeshId = Storage.RightFootMeshID
            game.Players.LocalPlayer.Character.RightLowerLeg.MeshId = Storage.RightLowerLegMeshID
            game.Players.LocalPlayer.Character.RightUpperLeg.MeshId = Storage.RightUpperLegMeshID
            game.Players.LocalPlayer.Character.RightUpperLeg.TextureID = Storage.RightUpperLegMeshID
            game.Players.LocalPlayer.Character.RightFoot.Transparency = Storage.RightFootTransparency
            game.Players.LocalPlayer.Character.RightLowerLeg.Transparency = Storage.RightLowerLegTransparency
        end
    end
})

TTab3:AddToggle('Enabled', {
    Text = 'Enable Super Super Happy Face',
    Default = false,
    Callback = function(Value)
        if Value then
            pcall(
                function()
                    game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://494290547"
                end
            )
        else
            pcall(
                function()
                    game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
                end
            )
        end
    end
})

TTab3:AddToggle('Enabled', {
    Text = 'Enable Playful Vampire',
    Default = false,
    Callback = function(Value)
        if Value then
            pcall(
                function()
                    game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://2409281591"
                end
            )
        else
            pcall(
                function()
                    game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
                end
            )
        end
    end
})

TTab3:AddDivider()
TTab3:AddDropdown('MyDropdown', {
    Values = { 'Zombie', 'Werewolf', 'Mage', 'Toy' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Idle Animation Spoofer',
    Tooltip = 'Select a Animation to Spoof', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == "Zombie" then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
            game.Players.LocalPlayer.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
        elseif Value == "Werewolf" then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
            game.Players.LocalPlayer.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
        elseif Value == "Mage" then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
            game.Players.LocalPlayer.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
        elseif Value == "Toy" then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
            game.Players.LocalPlayer.Character.Animate.idle.Animation2.AnimationId ="http://www.roblox.com/asset/?id=782841498"
        end
    end
})

TTab3:AddDivider()
TTab3:AddDropdown('MyDropdown', {
    Values = { 'Zombie', 'Werewolf', 'Mage', 'Toy' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Walk Animation Spoofer',
    Tooltip = 'Select a Animation to Spoof', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == "Zombie" then
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        elseif Value == "Werewolf" then
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
        elseif Value == "Mage" then
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
        elseif Value == "Toy" then
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
        end
    end
})



TTab3:AddDivider()
TTab3:AddDropdown('MyDropdown', {
    Values = { 'Zombie', 'Werewolf', 'Mage', 'Toy' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Run Animation Spoofer',
    Tooltip = 'Select a Animation to Spoof', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == "Zombie" then
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        elseif Value == "Werewolf" then
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
        elseif Value == "Ninja" then
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
        elseif Value == "Mage" then
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
        elseif Value == "Toy" then
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
        end
    end
})

TTab3:AddDivider()
TTab3:AddDropdown('MyDropdown', {
    Values = { "Zombie", "Werewolf", "Ninja", "Mage", "Toy", "OldSchool" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Jump Animation Spoofer',
    Tooltip = 'Select a Animation to Spoof', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == "Zombie" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=616161997"
        elseif Value == "Werewolf" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=1083218792"
        elseif Value == "Ninja" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=656117878"
        elseif Value == "Mage" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=707853694"
        elseif Value == "Toy" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=782847020"
        elseif Value == "OldSchool" then
            game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId =
                "http://www.roblox.com/asset/?id=5319841935"
        end
    end
})

TTab3:AddDivider()
TTab3:AddDropdown('MyDropdown', {
    Values = { "Zombie", "Werewolf", "Ninja", "Mage", "Toy", "OldSchool" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Fall Animation Spoofer',
    Tooltip = 'Select a Animation to Spoof', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == "Zombie" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=616157476"
        elseif Value == "Werewolf" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=1083189019"
        elseif Value == "Ninja" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=656115606"
        elseif Value == "Mage" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=707829716"
        elseif Value == "Toy" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=782846423"
        elseif Value == "OldSchool" then
            game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId =
                "http://www.roblox.com/asset/?id=5319839762"
        end
    end
})



-----//// world visual tab

local WorldVisTab = Tabs.Visuals:AddRightGroupbox('World')

WorldVisTab:AddLabel('World Color'):AddColorPicker('WorldColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'World Color', 
    Transparency = 0, 

    Callback = function(Value)
		worldvis.WorldVisuals.MapTintColor = Value
    end
})

WorldVisTab:AddSlider('WorldSaturation', {
    Text = 'Saturation',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        colorcorrection.Saturation = Value
    end
})

WorldVisTab:AddSlider('WorldBrightness', {
    Text = 'Brightness',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        worldvis.WorldVisuals.MapBrightness = Value / 100
    end
})

WorldVisTab:AddSlider('WorldContrast', {
    Text = 'Contrast',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        worldvis.WorldVisuals.MapContrast = Value / 100
    end
})

WorldVisTab:AddDivider()











local RunService = game:GetService("RunService")

local originalSkybox = {
    ["SkyboxBk"] = game.Lighting.Sky.SkyboxBk,
    ["SkyboxDn"] = game.Lighting.Sky.SkyboxDn,
    ["SkyboxFt"] = game.Lighting.Sky.SkyboxFt,
    ["SkyboxLf"] = game.Lighting.Sky.SkyboxLf,
    ["SkyboxRt"] = game.Lighting.Sky.SkyboxRt,
    ["SkyboxUp"] = game.Lighting.Sky.SkyboxUp
}

local Skyboxes = {
    ["Purple Nebula"] = {
        ["SkyboxBk"] = "rbxassetid://159454299",
        ["SkyboxDn"] = "rbxassetid://159454296",
        ["SkyboxFt"] = "rbxassetid://159454293",
        ["SkyboxLf"] = "rbxassetid://159454286",
        ["SkyboxRt"] = "rbxassetid://159454300",
        ["SkyboxUp"] = "rbxassetid://159454288"
    },
    ["Night Sky"] = {
        ["SkyboxBk"] = "rbxassetid://12064107",
        ["SkyboxDn"] = "rbxassetid://12064152",
        ["SkyboxFt"] = "rbxassetid://12064121",
        ["SkyboxLf"] = "rbxassetid://12063984",
        ["SkyboxRt"] = "rbxassetid://12064115",
        ["SkyboxUp"] = "rbxassetid://12064131"
    },
    ["Pink Daylight"] = {
        ["SkyboxBk"] = "rbxassetid://271042516",
        ["SkyboxDn"] = "rbxassetid://271077243",
        ["SkyboxFt"] = "rbxassetid://271042556",
        ["SkyboxLf"] = "rbxassetid://271042310",
        ["SkyboxRt"] = "rbxassetid://271042467",
        ["SkyboxUp"] = "rbxassetid://271077958"
    },
    ["Morning Glow"] = {
        ["SkyboxBk"] = "rbxassetid://1417494030",
        ["SkyboxDn"] = "rbxassetid://1417494146",
        ["SkyboxFt"] = "rbxassetid://1417494253",
        ["SkyboxLf"] = "rbxassetid://1417494402",
        ["SkyboxRt"] = "rbxassetid://1417494499",
        ["SkyboxUp"] = "rbxassetid://1417494643"
    },
    ["Setting Sun"] = {
        ["SkyboxBk"] = "rbxassetid://626460377",
        ["SkyboxDn"] = "rbxassetid://626460216",
        ["SkyboxFt"] = "rbxassetid://626460513",
        ["SkyboxLf"] = "rbxassetid://626473032",
        ["SkyboxRt"] = "rbxassetid://626458639",
        ["SkyboxUp"] = "rbxassetid://626460625"
    },
    ["Fade Blue"] = {
        ["SkyboxBk"] = "rbxassetid://153695414",
        ["SkyboxDn"] = "rbxassetid://153695352",
        ["SkyboxFt"] = "rbxassetid://153695452",
        ["SkyboxLf"] = "rbxassetid://153695320",
        ["SkyboxRt"] = "rbxassetid://153695383",
        ["SkyboxUp"] = "rbxassetid://153695471"
    },
    ["Elegant Morning"] = {
        ["SkyboxBk"] = "rbxassetid://153767241",
        ["SkyboxDn"] = "rbxassetid://153767216",
        ["SkyboxFt"] = "rbxassetid://153767266",
        ["SkyboxLf"] = "rbxassetid://153767200",
        ["SkyboxRt"] = "rbxassetid://153767231",
        ["SkyboxUp"] = "rbxassetid://153767288"
    },
    ["Neptune"] = {
        ["SkyboxBk"] = "rbxassetid://218955819",
        ["SkyboxDn"] = "rbxassetid://218953419",
        ["SkyboxFt"] = "rbxassetid://218954524",
        ["SkyboxLf"] = "rbxassetid://218958493",
        ["SkyboxRt"] = "rbxassetid://218957134",
        ["SkyboxUp"] = "rbxassetid://218950090"
    },
    ["Redshift"] = {
        ["SkyboxBk"] = "rbxassetid://401664839",
        ["SkyboxDn"] = "rbxassetid://401664862",
        ["SkyboxFt"] = "rbxassetid://401664960",
        ["SkyboxLf"] = "rbxassetid://401664881",
        ["SkyboxRt"] = "rbxassetid://401664901",
        ["SkyboxUp"] = "rbxassetid://401664936"
    },
    ["Aesthetic Night"] = {
        ["SkyboxBk"] = "rbxassetid://1045964490",
        ["SkyboxDn"] = "rbxassetid://1045964368",
        ["SkyboxFt"] = "rbxassetid://1045964655",
        ["SkyboxLf"] = "rbxassetid://1045964655",
        ["SkyboxRt"] = "rbxassetid://1045964655",
        ["SkyboxUp"] = "rbxassetid://1045962969"
    }
}
local function RestoreOriginalSkybox()
    local lighting = game:GetService("Lighting")
    for key, value in pairs(originalSkybox) do
        lighting.Sky[key] = value
    end
    print("Original skybox restored")
end

getgenv().SkyboxChanger = {
    ['Enabled'] = true,
    ['SelectedSkybox'] = "Redshift",
}




WorldVisTab:AddToggle('SkyboxChangerToggle', {
    Text = 'Enable Skybox Changer',
    Default = false,
    Tooltip = 'Toggle Skybox Changer',
    Callback = function(value)
        getgenv().SkyboxChanger['Enabled'] = value
    end
})

WorldVisTab:AddDropdown('MyDropdown', {
    Values = { "Purple Nebula", "Night Sky", "Pink Daylight", "Morning Glow", "Setting Sun", "Fade Blue", "Elegant Morning", "Neptune", "Redshift", "Aesthetic Night" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Skybox Changer',
    Tooltip = 'Modify Skybox', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        getgenv().SkyboxChanger["SelectedSkybox"] = Value
    end
})

RunService.Heartbeat:Connect(function()
    if getgenv().SkyboxChanger['Enabled'] then
        local skyboxName = getgenv().SkyboxChanger['SelectedSkybox']
        local skybox = Skyboxes[skyboxName]
        if skybox then
            local lighting = game:GetService("Lighting")
            for key, value in pairs(skybox) do
                lighting.Sky[key] = value
            end
            print("Skybox changed to:", skyboxName)
        else
            warn("Skybox not found:", skyboxName)
        end
    else
        RestoreOriginalSkybox()
    end
end)



WorldVisTab:AddDivider()

---------- start of fog
local fogModifierEnabled = false
local fogStart = 1
local fogEnd = 1
local fogColor = Color3.new(1, 1, 1)

WorldVisTab:AddToggle('FogModifierToggle', {
    Text = 'Enable Fog Modifier',
    Default = false,
    Tooltip = 'Toggle custom fog control',
    Callback = function(value)
        fogModifierEnabled = value
        if fogModifierEnabled then
            -- Apply fog settings
            game.Lighting.FogStart = fogStart
            game.Lighting.FogEnd = fogEnd
            game.Lighting.FogColor = fogColor
        else
            -- Reset fog settings to defaults
            game.Lighting.FogStart = 0
            game.Lighting.FogEnd = 100000
            game.Lighting.FogColor = Color3.new(191/255, 218/255, 1)
        end
    end
})

WorldVisTab:AddSlider('FogStartSlider', {
    Text = 'Fog Start',
    Default = 10,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        fogStart = value * 10
        if fogModifierEnabled then
            game.Lighting.FogStart = fogStart
        end
    end
})

WorldVisTab:AddSlider('FogEndSlider', {
    Text = 'Fog End',
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        fogEnd = value * 10
        if fogModifierEnabled then
            game.Lighting.FogEnd = fogEnd
        end
    end
})

WorldVisTab:AddLabel('Fog Color'):AddColorPicker('FogColorPicker', {
    Default = Color3.new(1, 1, 1),
    Title = 'Fog Color',
    Transparency = 0,
    Callback = function(value)
        fogColor = value
        if fogModifierEnabled then
            game.Lighting.FogColor = fogColor
        end
    end
})


WorldVisTab:AddDivider()


---------- end of fog



-- Define Resolution settings
getgenv().Resolution = {
    Enabled = false,
    AspectRatio = 0.65
}




-- Add UI elements (toggle button and slider)
WorldVisTab:AddToggle('AspectRatioToggle', {
    Text = 'Enable Aspect Ratio Modifier',
    Default = false,
    Tooltip = 'Toggle custom speed control',
    Callback = function(value)
        if value then
            local Camera = workspace.CurrentCamera
            game:GetService("RunService").RenderStepped:Connect(function()
                Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution.AspectRatio, 0, 0, 0, 1)
            end)
        else
            getgenv().Resolution.AspectRatio = 1
        end
end
})

WorldVisTab:AddSlider('AspectRatioSlider', {
    Text = 'Aspect Ratio',
    Default = 0.65,
    Min = 0.1,
    Max = 1,
    Rounding = 5,
    Compact = true,
    Callback = function(value)
        getgenv().Resolution.AspectRatio = value
    end
})


local player = game.Players.LocalPlayer
local flyEnabled = false
local flySpeed = 10
local playerSpeed = 16 -- Default Roblox player speed
local BodyGyro, BodyVelocity
local flyKey = Enum.KeyCode.J -- Default keybind for fly toggle




-- Function to start flying
local function startFly()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    humanoid.PlatformStand = true
    repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local rootPart = player.Character.HumanoidRootPart
    BodyGyro = Instance.new("BodyGyro", rootPart)
    BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = rootPart.CFrame
    BodyVelocity = Instance.new("BodyVelocity", rootPart)
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)

    while flyEnabled == true and flyKey do
        wait()
        local camCFrame = workspace.CurrentCamera.CoordinateFrame
        local direction = Vector3.new(0, 0, 0)

        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (camCFrame.lookVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (camCFrame.lookVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            direction = direction - (camCFrame.rightVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            direction = direction + (camCFrame.rightVector * flySpeed)
        end
        BodyVelocity.Velocity = direction
        BodyGyro.CFrame = camCFrame
    end
end

-- Function to stop flying
local function stopFly()
    if BodyGyro then BodyGyro:Destroy() end
    if BodyVelocity then BodyVelocity:Destroy() end
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character.Humanoid.PlatformStand = false
    end
end





getgenv().CFSpeed = false


-- GUI Setup
local MovementTab = Tabs.Movement:AddLeftGroupbox('Modifiers')

-- Speed Control Toggle
MovementTab:AddToggle('SpeedToggle', {
    Text = 'Enable Custom Speed',
    Default = false,
    Tooltip = 'Toggle custom speed control',
    Callback = function(value)
        bittechSpeed.CframeSpeed.Enabled = value
    end  -- Pass the function directly as the callback
})

-- Speed Slider
MovementTab:AddSlider('SpeedSlider', {
    Text = 'Speed Value',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        bittechSpeed.CframeSpeed.Speed = value
    end
})


MovementTab:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'C', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'CFrame Speed Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New) 
        bittechSpeed.CframeSpeed.Keybind = New
        print('[cb] Keybind changed!', New)
    end
})


game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == bittechSpeed.CframeSpeed.Keybind and bittechSpeed.CframeSpeed.Enabled == true then
		getgenv().CFSpeed = not getgenv().CFSpeed
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
if getgenv().CFSpeed then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * bittechSpeed.CframeSpeed.Speed
end -- cfspeed
end)
    

MovementTab:AddToggle('FlyToggle', {
    Text = 'Enable Fly',
    Default = false,
    Tooltip = 'Enable Fly Modifier',
    Callback = function(value)
        flyEnabled = value
        if flyEnabled == false then
            value = false
        end
        if flyEnabled then
            startFly()
        else
            stopFly()
        end
    end
})

MovementTab:AddSlider('FlySlider', {
    Text = 'Fly Value',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        flySpeed = value * 10
        if flyEnabled then
            -- Update fly speed in real time if already flying
            BodyVelocity.Velocity = BodyVelocity.Velocity.unit * flySpeed
        end
    end
})

MovementTab:AddLabel('Keybind'):AddKeyPicker('FlyToggleKeyPicker', {
    Default = "J",
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Fly Toggle Keybind',
    NoUI = false,
    Callback = function(value)

    end,

    ChangedCallback = function(New)
        flyKey = New
    end
})

-- Function to handle key input for toggling fly
local function handleFlyToggleInput(input)
    if input.KeyCode == flyKey then
        flyEnabled = not flyEnabled
        if flyEnabled then
            startFly() -- Start flying
        else
            stopFly() -- Stop flying
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(handleFlyToggleInput)



-- Add groupbox for player list
local playerlist = Tabs.PlayerlistTab:AddLeftGroupbox('Player Information')

getgenv().SelectedTargetUser = "" -- Initialize the variable to store the selected player

-- Add the dropdown for player selection
local playerDropdown = playerlist:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'Select Player',
    Tooltip = 'Select a player from the list',
    Default = 1,
    Multi = false,
    Callback = function(Value)
        getgenv().SelectedTargetUser = Value -- Update the global variable with the selected player
    end
})

-- Function to get player by name
local function GetPlayerByName(playerName)
    return Players:FindFirstChild(playerName)
end

-- Function to update position label with target player's position
local function UpdatePositionLabel(player)
    local positionLabel = playerlist:GetLabelByIndex(#playerlist:GetChildren()) -- Get the last label
    if positionLabel then
        if player then
            local character = player.Character
            if character then
                local primaryPart = character.PrimaryPart
                if primaryPart then
                    positionLabel:SetText(('Position:\nX: %s\nY: %s\nZ: %s'):format(
                        tostring(primaryPart.Position.X),
                        tostring(primaryPart.Position.Y),
                        tostring(primaryPart.Position.Z)
                    ))
                    return
                end
            end
        end
        -- If player or their character is not found, display N/A
        positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
    end
end

-- Function for teleporting to the targeted player
local function TeleportToPlayer()
    local playerName = getgenv().SelectedTargetUser
    if playerName and playerName ~= "" then
        local player = GetPlayerByName(playerName)
        if player then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = player.Character.HumanoidRootPart.CFrame
            UpdatePositionLabel(player) -- Update position label
        else
            print("Player not found:", playerName)
        end
    else
        print("No player selected for teleportation.")
    end
end

-- Function for spectating the targeted player
local function SpectatePlayer()
    local playerName = getgenv().SelectedTargetUser
    if playerName and playerName ~= "" then
        local player = GetPlayerByName(playerName)
        if player then
            if not getgenv().spectating then
                -- Set the flag to indicate that we're spectating
                getgenv().spectating = true
                
                -- Store the original camera CFrame
                getgenv().originalCameraCFrame = game.Workspace.CurrentCamera.CFrame
                
                -- Set the camera to focus on the player
                game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            else
                -- Set the flag to indicate that we're no longer spectating
                getgenv().spectating = false
                
                -- Restore the original camera CFrame
                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            end
            UpdatePositionLabel(player) -- Update position label
        else
            print('Player not found:', playerName)
        end
    else
        print("No player selected for spectating.")
    end
end

-- Variable to track if the player is currently being flung
local isFlinging = false
local Loop
-- Function to start flinging
local function StartFlinging()
    local OldFlingPos = player.Character.HumanoidRootPart.Position
    local Loop
    Loop = game:GetService("RunService").Heartbeat:Connect(function()
        local success, err = pcall(function()
            local FlingEnemy = Players:FindFirstChild(getgenv().SelectedTargetUser)
            if FlingEnemy and player.Character then
                local FlingTorso = FlingEnemy.Character:FindFirstChild("UpperTorso")
                if FlingTorso then
                    local dis = 3.85
                    local increase = 6
                    local xchange, zchange = 0, 0
                    if FlingEnemy.Character.Humanoid.MoveDirection.X < 0 then
                        xchange = -increase
                    elseif FlingEnemy.Character.Humanoid.MoveDirection.X > 0 then
                        xchange = increase
                    end
                    if FlingEnemy.Character.Humanoid.MoveDirection.Z < 0 then
                        zchange = -increase
                    elseif FlingEnemy.Character.Humanoid.MoveDirection.Z > 0 then
                        zchange = increase
                    end
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(FlingTorso.Position.X + math.random(-dis, dis) + xchange, FlingTorso.Position.Y, FlingTorso.Position.Z + math.random(-dis, dis) + zchange) * CFrame.Angles(math.rad(player.Character.HumanoidRootPart.Orientation.X + 350), math.rad(player.Character.HumanoidRootPart.Orientation.Y + 200), math.rad(player.Character.HumanoidRootPart.Orientation.Z + 240))
                    player.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
                end
            end
        end)
        if err then
            print('fling error : ' .. err)
        end
    end)
    getgenv().isFlinging = true
    getgenv().flingLoop = Loop
end

-- Function to stop flinging
local function StopFlinging()
    if getgenv().flingLoop then
        getgenv().flingLoop:Disconnect()
    end
    local vectorZero = Vector3.new(0, 0, 0)
    player.Character.PrimaryPart.Velocity = vectorZero
    player.Character.PrimaryPart.RotVelocity = vectorZero
    getgenv().isFlinging = false
end

-- Function to toggle between flinging and unflinging
local function ToggleFling()
    if getgenv().isFlinging then
        -- If already flinging, stop the fling
        StopFlinging()
    else
        -- If not flinging, start the fling
        StartFlinging()
    end
end




-- Add buttons for actions
playerlist:AddButton({
    Text = 'Teleport',
    DoubleClick = false,
    Tooltip = 'Teleport to the selected player',
    Func = TeleportToPlayer
})

playerlist:AddButton({
    Text = 'Spectate',
    DoubleClick = false,
    Tooltip = 'Spectate the selected player',
    Func = SpectatePlayer
})

playerlist:AddButton({
    Text = 'Fling',
    DoubleClick = false,
    Tooltip = 'Fling the selected player',
    Func = ToggleFling -- Assign the ToggleFling function as the Func parameter
})




-- Add labels for player information
playerlist:AddLabel(' ')
local positionLabel = playerlist:AddLabel('Position:\nX: N/A\nY: N/A\nZ: N/A')
playerlist:AddLabel(' ')

-- Function to get player by name
local function GetPlayerByName(playerName)
    return Players:FindFirstChild(playerName)
end

-- Function to update position label with target player's position
local function UpdatePositionLabel(player)
    if player then
        local character = player.Character
        if character then
            local primaryPart = character.PrimaryPart
            if primaryPart then
                positionLabel:SetText(('Position:\nX: %s\nY: %s\nZ: %s'):format(
                    tostring(primaryPart.Position.X),
                    tostring(primaryPart.Position.Y),
                    tostring(primaryPart.Position.Z)
                ))
                return
            end
        end
    end
    -- If player or their character is not found, display N/A
    positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
end

-- Function to update position label periodically
local function UpdatePositionLabelPeriodically()
    while true do
        local playerName = getgenv().SelectedTargetUser
        local player = GetPlayerByName(playerName)
        if player then
            UpdatePositionLabel(player) -- Update position label for the specified player
        else
            -- If player is not found, clear position label
            positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
        end
        task.wait() -- Wait for 1.5 seconds before checking again
    end
end

coroutine.wrap(UpdatePositionLabelPeriodically)()




local extraTab = Tabs.ExtraTab:AddLeftGroupbox("Teleports")

extraTab:AddButton({
    Text = 'Revolver',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-665.529846, 50.0065956, -141.750793, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev'
})

extraTab:AddButton({
    Text = 'Revolver Mountain',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-696.847717, 167.674957, -41.0118256, 0.626992583, 7.53169349e-09, -0.779025197, -1.29610933e-09, 1, 8.62493632e-09, 0.779025197, -4.39806902e-09, 0.626992583)    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev Mountain'
})

extraTab:AddButton({
    Text = 'Bank Roof',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-428.754517, 39.3525352, -284.244873, -1.13248825e-05, 0.660138607, 0.751143754, 4.29153442e-06, 0.751143813, -0.660138607, -0.99999994, -4.29153442e-06, -1.13248825e-05)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev Bank Roof'
})
extraTab:AddButton({
    Text = 'LMG',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-620.882263, 20.2999878, -305.339264, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to LMG'
})
extraTab:AddButton({
    Text = 'RPG',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.815933, -22.9016266, -136.737762, 0.0339428484, -7.90177737e-08, 0.999423802, -4.7851227e-08, 1, 8.06884728e-08, -0.999423802, -5.0562452e-08, 0.0339428484)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to RPG'
})

extraTab:AddButton({
    Text = 'Drum Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1177.78003, 25.5800095, -530.259949, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Drum Guns'
})

extraTab:AddButton({
    Text = 'Down Hill Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-584.377258, 18.3279209, -724.957031, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to DownHill Guns'
})
extraTab:AddButton({
    Text = 'Up Hill Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(470.412354, 58.0836449, -626.227051, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Uphill Guns'
})
extraTab:AddButton({
    Text = 'Military',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(36.6331787, 27.1796074, -824.074402, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to DownHill Guns'
})
extraTab:AddButton({
    Text = 'Up Hill Taco Roof',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(590.725708, 75.1874542, -513.107605, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Uphill Guns'
})


local extraTab2 = Tabs.ExtraTab:AddRightGroupbox("Shop")


extraTab2:AddDropdown('MyDropdown', {
    Values = { "None", "Revolver", "DB", "AK-47", "LMG", "DrumGun", "Drum-Shotgu", "RPG", "Flamethrower", "Taser" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Guns',
    Tooltip = 'AutoBuy Weapon Of your Choice', -- Information shown when you hover over the dropdown

    Callback = function(State)
        if State == "Revolver" then
            plr = game:GetService "Players".LocalPlayer
            local gunName = "[Revolver] - $1379"
            local k = game.Workspace.Ignored.Shop[gunName]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop[gunName].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop[gunName].ClickDetector)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "DB" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "AK-47" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[AK47] - $2387"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[AK47] - $2387"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[AK47] - $2387"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "LMG" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[LMG] - $3978"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[LMG] - $3978"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[LMG] - $3978"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "DrumGun" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[DrumGun] - $3183"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[DrumGun] - $3183"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[DrumGun] - $3183"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Drum-Shotgun" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "RPG" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[RPG] - $21218"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[RPG] - $21218"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[RPG] - $21218"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Flamethrower" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Flamethrower] - $15914"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Flamethrower] - $15914"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Flamethrower] - $15914"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Taser" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Taser] - $1061"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Taser] - $1061"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Taser] - $1061"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        end
    end
})


local selectedAmmo = "Revolver" -- Default selected ammo

local function OnDropdownChanged(value)
    selectedAmmo = value
end

local function BuyAmmo()
    if selectedAmmo then
        local plr = game:GetService("Players").LocalPlayer
        local ammoShop = game.Workspace.Ignored.Shop
        local ammoName = ""

        -- Determine the ammo name based on the selected type
        if selectedAmmo == "Revolver Ammo" then
            ammoName = "12 [Revolver Ammo] - $80"
        elseif selectedAmmo == "DB Ammo" then
            ammoName = "18 [Double-Barrel SG Ammo] - $53"
        elseif selectedAmmo == "AK-47 Ammo" then
            ammoName = "90 [AK47 Ammo] - $85"
        elseif selectedAmmo == "LMG Ammo" then
            ammoName = "200 [LMG Ammo] - $318"
        elseif selectedAmmo == "DrumGun Ammo" then
            ammoName = "100 [DrumGun Ammo] - $212"
        elseif selectedAmmo == "Drum-Shotgun Ammo" then
            ammoName = "18 [Drum-Shotgun Ammo] - $69"
        elseif selectedAmmo == "RPG Ammo" then
            ammoName = "5 [RPG Ammo] - $1061"
        elseif selectedAmmo == "Flamethrower Ammo" then
            ammoName = "140 [Flamethrower Ammo] - $1644"
        end

        if ammoName ~= "" then
            local ammoClickDetector = ammoShop[ammoName].ClickDetector
            if ammoClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the ammo shop and buy the selected ammo
                plr.Character.HumanoidRootPart.CFrame = ammoShop[ammoName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(ammoClickDetector)
                fireclickdetector(ammoClickDetector)

                -- Restore the original position after buying ammo
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for ammo not found.")
            end
        else
            print("Invalid ammo selection.")
        end
    else
        print("No ammo selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "Revolver Ammo", "DB Ammo", "AK-47 Ammo", "LMG Ammo", "DrumGun Ammo", "Drum-Shotgun Ammo", "RPG Ammo", "Flamethrower Ammo" },
    Default = 1,
    Multi = false,
    Text = 'Ammo',
    Tooltip = 'AutoBuy Ammo Of your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Ammo',
    DoubleClick = false,
    Tooltip = 'Buy Selected Ammo',
    Func = BuyAmmo
})


local selectedFood = "HotDog" -- Default selected food

local function OnDropdownChanged(value)
    selectedFood = value
end

local function BuyFood()
    if selectedFood then
        local plr = game:GetService("Players").LocalPlayer
        local foodShop = game.Workspace.Ignored.Shop

        local foodName = ""
        -- Determine the food name based on the selected type
        if selectedFood == "HotDog" then
            foodName = "[HotDog] - $8"
        elseif selectedFood == "Meat" then
            foodName = "[Meat] - $13"
        elseif selectedFood == "Popcorn" then
            foodName = "[Popcorn] - $7"
        elseif selectedFood == "Pizza" then
            foodName = "[Pizza] - $10"
        elseif selectedFood == "Taco" then
            foodName = "[Taco] - $2"
        else
            print("Invalid food selection.")
            return
        end

        if foodName ~= "" then
            local foodClickDetector = foodShop[foodName].ClickDetector
            if foodClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the food shop and buy the selected food
                plr.Character.HumanoidRootPart.CFrame = foodShop[foodName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(foodClickDetector)
                fireclickdetector(foodClickDetector)

                -- Restore the original position after buying food
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for food not found.")
            end
        else
            print("Invalid food selection.")
        end
    else
        print("No food selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "HotDog", "Meat", "Popcorn", "Pizza", "Taco" },
    Default = 1,
    Multi = false,
    Text = 'Food',
    Tooltip = 'Auto Buy Food Of Your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Food',
    DoubleClick = false,
    Tooltip = 'Buy Selected Food',
    Func = BuyFood
})

local selectedDrink = "[Starblox Latte] - $5" -- Default selected drink

local function OnDropdownChanged(value)
    selectedDrink = value
end

local function BuyDrink()
    if selectedDrink then
        local plr = game:GetService("Players").LocalPlayer
        local drinkShop = game.Workspace.Ignored.Shop

        local drinkName = ""

        -- Determine the drink name based on the selected type
        if selectedDrink == "[Starblox Latte] - $5" then
            drinkName = "[Starblox Latte] - $5"
        elseif selectedDrink == "[CranBerry] - $3" then
            drinkName = drinkShop:GetChildren()[130].Name
        elseif selectedDrink == "[Da Milk] - $7" then
            drinkName = "[Da Milk] - $7"
        end

        if drinkName ~= "" then
            local drinkClickDetector = drinkShop[drinkName].ClickDetector
            if drinkClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the drink shop and buy the selected drink
                plr.Character.HumanoidRootPart.CFrame = drinkShop[drinkName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(drinkClickDetector)
                fireclickdetector(drinkClickDetector)

                -- Restore the original position after buying the drink
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for drink not found.")
            end
        else
            print("Invalid drink selection.")
        end
    else
        print("No drink selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "[Starblox Latte] - $5", "[CranBerry] - $3", "[Da Milk] - $7" },
    Default = 1,
    Multi = false,
    Text = 'Drink',
    Tooltip = 'Auto Buy Drink Of your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Drink',
    DoubleClick = false,
    Tooltip = 'Buy Selected Drink',
    Func = BuyDrink
})




local extraTab3 = Tabs.ExtraTab:AddLeftGroupbox("Automations")
getgenv().autoStompEnabled = false
getgenv().autoArmorEnabled = false
getgenv().autoFireArmorEnabled = false
getgenv().autoPickupCashEnabled = false


local function runAutoStomp()
    coroutine.wrap(function()
        while getgenv().autoStompEnabled do
            game.ReplicatedStorage.MainEvent:FireServer("Stomp")
            wait(0.1)
        end
    end)()
end

local function runAutoArmor()
    coroutine.wrap(function()
        while getgenv().autoArmorEnabled do
             local armorValue = workspace.Players[game.Players.LocalPlayer.Name].BodyEffects.Armor.Value
            if armorValue <= 20 then
                local plr = game.Players.LocalPlayer
                local armorShop = workspace.Ignored.Shop
                local armorClickDetector = armorShop["[High-Medium Armor] - $2440"].ClickDetector

                if armorClickDetector then
                    local savedPosition = plr.Character.HumanoidRootPart.Position
                    plr.Character.HumanoidRootPart.CFrame = armorShop["[High-Medium Armor] - $2440"].Head.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5)
                    fireclickdetector(armorClickDetector)
                    fireclickdetector(armorClickDetector)
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                end
            end
            wait(0.1)
        end
    end)()
end

local function runAutoFireArmor()
    coroutine.wrap(function()
        while getgenv().autoFireArmorEnabled do
            local fireArmorValue = workspace.Players[game.Players.LocalPlayer.Name].BodyEffects.FireArmor.Value
            if fireArmorValue <= 0 then
                local plr = game.Players.LocalPlayer
                local armorShop = workspace.Ignored.Shop
                local armorClickDetector = armorShop["[Fire Armor] - $2546"].ClickDetector

                if armorClickDetector then
                    local savedPosition = plr.Character.HumanoidRootPart.Position
                    plr.Character.HumanoidRootPart.CFrame = armorShop["[Fire Armor] - $2546"].Head.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5)
                    fireclickdetector(armorClickDetector)
                    fireclickdetector(armorClickDetector)
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                end
            end
            wait(0.1)
            wait(0.1)
        end
    end)()
end

local function runAutoPickupCash()
    coroutine.wrap(function()
        while getgenv().autoPickupCashEnabled do
            for _, v in pairs(workspace.Ignored.Drop:GetChildren()) do
                if v.Name == "MoneyDrop" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 25 then
                    fireclickdetector(v.ClickDetector)
                end
            end
            wait(0.1)
        end
    end)()
end



extraTab3:AddToggle('ToggleAutoStomp', {
    Text = 'Auto Stomp',
    Default = false,
    Callback = function(value)
        getgenv().autoStompEnabled = value
        if value then runAutoStomp() end
    end
})

extraTab3:AddToggle('ToggleAutoArmor', {
    Text = 'Auto Armor',
    Default = false,
    Callback = function(value)
        getgenv().autoArmorEnabled = value
        if value then runAutoArmor() end
    end
})

extraTab3:AddToggle('ToggleAutoFireArmor', {
    Text = 'Auto Fire Armor',
    Default = false,
    Callback = function(value)
        getgenv().autoFireArmorEnabled = value
        if value then runAutoFireArmor() end
    end
})



local extraTab4 = Tabs.ExtraTab:AddRightGroupbox("Exploits")


extraTab4:AddToggle('KickOnModJoinToggle', {
    Text = 'Kick on Mod Join',
    Default = false,
    Callback = function(value)
        if value then
        for l, c in pairs(game.Players:GetChildren()) do
            for i, v in pairs(dickface) do
            if c.UserId == v then
            local Vanis = game.Players.LocalPlayer
            Vanis:Kick("Retard Detected")
            end
            end
            end
            game.Players.PlayerAdded:Connect(function(plr)
            for i, v in pairs(dickface) do
            if plr.UserId == v then
            local Vanis = game.Players.LocalPlayer
            Vanis:Kick("Retard Detected")
            end
            end
            end)
        end
        
    end
})

extraTab4:AddToggle('RemoveSeatsToggle', {
    Text = 'Remove Seats',
    Default = false,
    Tooltip = 'Enable or disable anti-AFK',

    Callback = function(Value)
        if Value then
            -- Function to delete all seats in the workspace
            local function deleteAllSeats()
                for _, descendant in ipairs(game.Workspace:GetDescendants()) do
                    if descendant:IsA("Seat") then
                        descendant:Destroy()
                    end
                end
            end

            -- Call the function to delete all seats
            deleteAllSeats()
            print("All seats deleted in the workspace.")
        end
    end
})


extraTab4:AddToggle('AntiAFKToggle', {
    Text = 'Anti-AFK',
    Default = false,
    Tooltip = 'Enable or disable anti-AFK',

    Callback = function(Value)
        getgenv().isAntiAFKEnabled = Value
        if getgenv().isAntiAFKEnabled then
            enableAntiAFK()
            print('Anti-AFK Enabled')
        else
            disableAntiAFK()
            print('Anti-AFK Disabled')
        end
    end
})



extraTab4:AddToggle('NoSlowDownToggle', {
    Text = 'Anti-Slowdown',
    Default = false,
    Tooltip = 'Enable/Disable Anti-Slow',

    Callback = function(Value)
        getgenv().SlowSettings.AntiSlowEnabled = Value
    end
})


getgenv().AutoReload = false -- Set default value to false

local function AutoReloadFunction()
    while true do -- Infinite loop
        task.wait()
        if getgenv().AutoReload and game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
            local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
            if tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 0 then
                game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", tool)
                wait(0.5)
            end
        end
        game:GetService("RunService").Heartbeat:Wait() -- Wait for next heartbeat
    end
end



extraTab4:AddToggle('AutoReloadToggle', {
    Text = 'Auto Reload',
    Default = false,
    Tooltip = 'Enable/Disable Auto Reload',

    Callback = function(Value)
        getgenv().AutoReload = Value -- Update the global variable based on toggle value
        if Value then
            AutoReloadFunction() -- Start or stop the auto-reload function based on toggle value
        end
    end
})


extraTab4:AddToggle('InfStaminaToggle', {
    Text = 'Infinite Stamina',
    Default = false,
    Tooltip = 'Enable/Disable No Jump Cooldown',

    Callback = function(Value)
        getgenv().monkeyNJC.RemoveJumpCooldown = Value
    end
})



local player = game.Players.LocalPlayer
local noclipEnabled = false

-- Function to apply the noclip state
local function ApplyNoclip()
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA('BasePart') then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end

-- Function to toggle noclip
local function ToggleNoclip(value)
    noclipEnabled = value
    ApplyNoclip()
end

-- Continuous check to maintain the noclip state
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        ApplyNoclip()
    end
end)

-- GUI toggle setup
extraTab4:AddToggle('NoclipToggle', {
    Text = 'Noclip',
    Default = false,
    Callback = function(value)
        ToggleNoclip(value)
    end
})



----- booting anti SLOW
local function toggleAntiSlow()
    getgenv().SlowSettings.AntiSlowEnabled = not  getgenv().SlowSettings.AntiSlowEnabled
end

local function handleAntiSlow()
    local deletePart = game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or
                      game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or
                      game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
    if deletePart then
        deletePart:Destroy()
    end
    if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then
        game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if  getgenv().SlowSettings.AntiSlowEnabled then
        handleAntiSlow()
    end
end)





local extraTab5= Tabs.ExtraTab:AddLeftGroupbox("Server")


-- Rejoin Button
extraTab5:AddButton({
    Text = 'Rejoin',
    Func = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
        print('Attempting to rejoin...')
    end,
    Tooltip = 'Click to rejoin the current game'
})

-- Server Hop Button (Standard)
extraTab5:AddButton({
    Text = 'Server Hop',
    Func = function()
        -- This is a naive server hop implementation
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        print('Attempting to server hop...')
    end,
    Tooltip = 'Click to attempt to join a different server'
})

-- Server Hop to Lowest Server Button
extraTab5:AddButton({
    Text = 'Server Hop to Lowest',
    Func = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local _place = game.PlaceId
        local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
        local function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
            return Http:JSONDecode(Raw)
        end
        
        local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
        until Server
        
        if Server then
            TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
            print('Attempting to hop to the lowest server...')
        else
            print('No server found to hop to.')
        end
    end,
    Tooltip = 'Click to hop to the server with the lowest player count'
})



local extraTab6 = Tabs.ExtraTab:AddRightGroupbox("Other")

local TrashTalk = false
local TrashTalkConnection

extraTab6:AddToggle('AutoTrashTalkToggle', {
    Text = 'Trash Talk',
    Default = false,
    Tooltip = 'Enable/Disable No Jump Cooldown',

    Callback = function(Value)
        TrashTalk = Value
        
        -- If TrashTalk is enabled, start trash-talking in a separate coroutine  
        if TrashTalk then
            -- If there's already a connection, disconnect it to avoid multiple connections
            if TrashTalkConnection then
                TrashTalkConnection:Disconnect()
            end
            
            -- Start a new coroutine for trash-talking
            TrashTalkConnection = coroutine.create(function()
                while TrashTalk do
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech RUNS YOU",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech VS THE WORLD",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "You just got Slammed by bit.tech",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech > You",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech 1'd you son",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "On bit.tech injection all dogs bow down",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "nn dogs can't compare to bit.tech",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech desync will not be resolvale.",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "on bit.tech injection all resolvers are fried.",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "bit.tech rules over you.",
                        "All"
                    )
                end
            end)
            
            -- Resume the coroutine
            coroutine.resume(TrashTalkConnection)
        else
            -- If TrashTalk is disabled, disconnect the connection if it exists
            if TrashTalkConnection then
                TrashTalkConnection:Disconnect()
            end
        end
    end
})


extraTab6:AddToggle('RemoveEFXToggle', {
    Text = 'Remove Effects',
    Default = false,
    Tooltip = 'Enable/Disable Effects',

    Callback = function(Value)
        if Value then
            player.PlayerGui.Framework.FBAnimation.Name = 'yea'
            local Loop
            local loopFunction = function()
                local Particle = player.Character.UpperTorso:FindFirstChild('ElectricuteParticle') or player.Character.UpperTorso:FindFirstChild('FlamethrowerFireParticle')
                if Particle then Particle:Destroy() end
                for i,v in pairs(player.Character:FindFirstChildWhichIsA('Humanoid'):GetPlayingAnimationTracks()) do
                    if v.Animation.AnimationId == 'rbxassetid://5641749824' then
                    v:Stop() 
                    end
                end
            end;
            local Start = function()
                Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
            end;
            local Pause = function()
                Loop:Disconnect()
            end;
            Start()	
            repeat wait() until Value == false
            Pause()
        end
    end
})



-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    Library:SetWatermark(('{ bit.tech } { build : private } { delay : %s ms }'):format(
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)




-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')


-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })


Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu



-- Addons:
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('bit.tech')
SaveManager:SetFolder('bit.tech/DahoodCfg')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
        end
    end
end

-- Bind button click event to login function
LoginButton.MouseButton1Click:Connect(onLoginButtonClicked)
