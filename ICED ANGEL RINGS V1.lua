--// ICED'S ANGEL RINGS V1
--// ICE GUI
--// WHITE / CYAN / BLUE
--// RESPAWN PATCHED VERSION

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- COLORS
--==================================================

local WHITE = Color3.fromRGB(255,255,255)
local BLACK = Color3.fromRGB(15,15,18)

local CYAN = Color3.fromRGB(0,220,255)
local LIGHT_CYAN = Color3.fromRGB(185,250,255)
local PALE_CYAN = Color3.fromRGB(225,252,255)
local BLUE = Color3.fromRGB(40,110,255)

--==================================================
-- HELPERS
--==================================================

local function corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = object
    return c
end

local function gradient(object, c1, c2, c3, rotation)
    local g = Instance.new("UIGradient")

    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, c1),
        ColorSequenceKeypoint.new(0.5, c2),
        ColorSequenceKeypoint.new(1, c3)
    })

    g.Rotation = rotation or 90
    g.Parent = object

    return g
end

local function clickableOutline(object, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Name = "ClickableOutline"
    stroke.Color = BLACK
    stroke.Thickness = thickness or 1.2
    stroke.Transparency = 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = object
    return stroke
end

local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(id)
    sound.Volume = 0.7
    sound.Parent = SoundService

    pcall(function()
        sound:Play()
    end)

    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function notify(title,text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end)
end

--==================================================
-- CHARACTER
--==================================================

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local character = getCharacter()
    return character:FindFirstChildOfClass("Humanoid")
end

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IcedAngelRingsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- OUTER GLOW
--==================================================

local Glow = Instance.new("Frame")
Glow.Name = "OuterGlow"
Glow.Size = UDim2.new(0,348,0,548)
Glow.Position = UDim2.new(0.5,-174,0.5,-274)
Glow.BackgroundColor3 = CYAN
Glow.BackgroundTransparency = 0.78
Glow.BorderSizePixel = 0
Glow.Parent = ScreenGui

corner(Glow,22)

local GlowGradient = gradient(
    Glow,
    CYAN,
    BLUE,
    CYAN,
    0
)

--==================================================
-- MAIN FRAME
--==================================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0,340,0,540)
MainFrame.Position = UDim2.new(0.5,-170,0.5,-270)
MainFrame.BackgroundColor3 = WHITE
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

corner(MainFrame,20)

local BackgroundGradient = gradient(
    MainFrame,
    WHITE,
    LIGHT_CYAN,
    CYAN,
    135
)

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1,-16,0,58)
TopBar.Position = UDim2.new(0,8,0,8)
TopBar.BackgroundTransparency = 1
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1,-55,0,30)
Title.Position = UDim2.new(0,12,0,3)
Title.BackgroundTransparency = 1
Title.Text = "Iced's Angel Ring V1"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 19
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1,-24,0,18)
Subtitle.Position = UDim2.new(0,12,0,34)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Made By Iced"
Subtitle.TextColor3 = WHITE
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

--==================================================
-- CREDIT GRADIENT
--==================================================

local TitleGradient = Instance.new("UIGradient")

TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CYAN),
    ColorSequenceKeypoint.new(0.5, WHITE),
    ColorSequenceKeypoint.new(1, CYAN)
})

TitleGradient.Offset = Vector2.new(-1,0)
TitleGradient.Parent = Title

local SubtitleGradient = Instance.new("UIGradient")

SubtitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CYAN),
    ColorSequenceKeypoint.new(0.5, WHITE),
    ColorSequenceKeypoint.new(1, CYAN)
})

SubtitleGradient.Offset = Vector2.new(-1,0)
SubtitleGradient.Parent = Subtitle

--==================================================
-- MINIMIZE
--==================================================

local MinimizeButton = Instance.new("TextButton")

MinimizeButton.Name = "Minimize"
MinimizeButton.Size = UDim2.new(0,34,0,34)
MinimizeButton.Position = UDim2.new(1,-42,0,12)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = BLACK
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.Gotham
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.BorderSizePixel = 0
MinimizeButton.AutoButtonColor = false
MinimizeButton.Parent = TopBar

corner(MinimizeButton,10)
clickableOutline(MinimizeButton,1.2)

--==================================================
-- MAIN RING TOGGLE
--==================================================

local ToggleButton = Instance.new("TextButton")

ToggleButton.Name = "RingToggle"
ToggleButton.Size = UDim2.new(1,-40,0,43)
ToggleButton.Position = UDim2.new(0,20,0,78)
ToggleButton.Text = "❄  Ring Off"
ToggleButton.TextColor3 = BLACK
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 16
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = MainFrame

corner(ToggleButton,12)
clickableOutline(ToggleButton,1.4)

--==================================================
-- CONFIG
--==================================================

local config = {
    radius = 50,
    height = 100,
    rotationSpeed = 10,
    attractionStrength = 1000
}

--==================================================
-- RING PART SYSTEM
--==================================================

local ringPartsEnabled = false
local parts = {}

-- Prevent duplicate respawn scans
local scanInProgress = false

local function isValidRingPart(part)

    if not part then
        return false
    end

    if not part:IsA("BasePart") then
        return false
    end

    if part.Anchored then
        return false
    end

    if not part:IsDescendantOf(Workspace) then
        return false
    end

    local character = LocalPlayer.Character

    if character and part:IsDescendantOf(character) then
        return false
    end

    local model = part:FindFirstAncestorOfClass("Model")

    if model and model:FindFirstChildOfClass("Humanoid") then
        return false
    end

    return true
end

--==================================================
-- PREPARE PART
--==================================================

local function preparePart(part)

    if not isValidRingPart(part) then
        return false
    end

    pcall(function()

        part.CustomPhysicalProperties =
            PhysicalProperties.new(
                0,
                0,
                0,
                0,
                0
            )

        part.CanCollide = false

        -- RESET PHYSICS AFTER RESPAWN
        part.AssemblyAngularVelocity = Vector3.zero
        part.AssemblyLinearVelocity = Vector3.zero

    end)

    return true
end

--==================================================
-- ADD PART
--==================================================

local function addPart(part)

    if not preparePart(part) then
        return false
    end

    if not table.find(parts,part) then
        table.insert(parts,part)
    end

    return true
end

--==================================================
-- REMOVE PART
--==================================================

local function removePart(part)

    local index = table.find(parts,part)

    if index then
        table.remove(parts,index)
    end
end

--==================================================
-- RESCAN RING PARTS
--==================================================

local function rescanRingParts()

    if scanInProgress then
        return
    end

    scanInProgress = true

    -- Remove invalid/stale references first
    for i = #parts,1,-1 do

        local part = parts[i]

        if not part
            or not part.Parent
            or not part:IsDescendantOf(Workspace)
            or part.Anchored
            or not isValidRingPart(part) then

            table.remove(parts,i)

        end
    end

    -- Re-scan workspace
    for _,part in ipairs(Workspace:GetDescendants()) do

        if isValidRingPart(part) then
            addPart(part)
        end

    end

    scanInProgress = false
end

--==================================================
-- INITIAL SCAN
--==================================================

rescanRingParts()

Workspace.DescendantAdded:Connect(function(part)

    task.defer(function()

        if isValidRingPart(part) then
            addPart(part)
        end

    end)

end)

Workspace.DescendantRemoving:Connect(function(part)
    removePart(part)
end)

--==================================================
-- RESPAWN / RESET PATCH
--==================================================
-- This is the important part.
--
-- When the player dies Roblox creates a completely new
-- character and HumanoidRootPart. The ring system now
-- waits for the new character and rebuilds its references.
--==================================================

LocalPlayer.CharacterAdded:Connect(function(newCharacter)

    task.spawn(function()

        -- Wait for the new character to actually load
        local root =
            newCharacter:WaitForChild(
                "HumanoidRootPart",
                10
            )

        newCharacter:WaitForChild(
            "Humanoid",
            10
        )

        if not root then
            return
        end

        -- Give Roblox a moment to finish spawning
        task.wait(0.25)

        -- Rebuild the ring part list
        rescanRingParts()

        -- Reset all valid ring physics
        for i = #parts,1,-1 do

            local part = parts[i]

            if isValidRingPart(part) then

                pcall(function()

                    part.AssemblyLinearVelocity =
                        Vector3.zero

                    part.AssemblyAngularVelocity =
                        Vector3.zero

                    part.CanCollide = false

                end)

            else

                table.remove(parts,i)

            end

        end

        -- Keep the ring state enabled after reset
        if ringPartsEnabled then

            ToggleButton.Text =
                "❄  Ring On"

            ToggleButton.TextColor3 =
                CYAN

        end

    end)

end)

--==================================================
-- FIXED RING PHYSICS
--==================================================

RunService.Heartbeat:Connect(function(delta)

    if not ringPartsEnabled then
        return
    end

    local character = LocalPlayer.Character

    if not character then
        return
    end

    local root =
        character:FindFirstChild("HumanoidRootPart")

    if not root then
        return
    end

    local center = root.Position

    --------------------------------------------------
    -- SAFE VALUES
    --------------------------------------------------

    local radius =
        math.clamp(
            tonumber(config.radius) or 50,
            1,
            500
        )

    local height =
        math.clamp(
            tonumber(config.height) or 100,
            0,
            500
        )

    local rotationSpeed =
        math.clamp(
            tonumber(config.rotationSpeed) or 10,
            0,
            360
        )

    local attraction =
        math.clamp(
            tonumber(config.attractionStrength) or 1000,
            0,
            10000
        )

    --------------------------------------------------
    -- ROTATION
    --------------------------------------------------

    local rotationStep =
        math.rad(rotationSpeed) * delta

    --------------------------------------------------
    -- PARTS
    --------------------------------------------------

    for i = #parts,1,-1 do

        local part = parts[i]

        if not part
            or not part.Parent
            or not part:IsDescendantOf(Workspace)
            or part.Anchored
            or not isValidRingPart(part) then

            table.remove(parts,i)

            continue
        end

        --------------------------------------------------
        -- OFFSET FROM PLAYER
        --------------------------------------------------

        local offset =
            part.Position - center

        local flatX = offset.X
        local flatZ = offset.Z

        local distance =
            math.sqrt(
                flatX * flatX +
                flatZ * flatZ
            )

        if distance < 0.05 then
            distance = 0.05
        end

        --------------------------------------------------
        -- CURRENT ANGLE
        --------------------------------------------------

        local angle =
            math.atan2(
                flatZ,
                flatX
            )

        --------------------------------------------------
        -- ROTATE
        --------------------------------------------------

        angle += rotationStep

        --------------------------------------------------
        -- RADIUS
        --------------------------------------------------

        local targetX =
            center.X +
            math.cos(angle) * radius

        local targetZ =
            center.Z +
            math.sin(angle) * radius

        --------------------------------------------------
        -- HEIGHT
        --------------------------------------------------

        local relativeY =
            part.Position.Y - center.Y

        local targetY =
            center.Y +
            math.clamp(
                relativeY,
                -height,
                height
            )

        --------------------------------------------------
        -- TARGET
        --------------------------------------------------

        local targetPosition =
            Vector3.new(
                targetX,
                targetY,
                targetZ
            )

        --------------------------------------------------
        -- MOVE
        --------------------------------------------------

        local difference =
            targetPosition -
            part.Position

        local targetDistance =
            difference.Magnitude

        if targetDistance > 0.05
            and attraction > 0 then

            local direction =
                difference.Unit

            local desiredVelocity =
                direction *
                attraction

            local maxVelocity =
                math.clamp(
                    attraction,
                    50,
                    10000
                )

            if desiredVelocity.Magnitude >
                maxVelocity then

                desiredVelocity =
                    desiredVelocity.Unit *
                    maxVelocity

            end

            pcall(function()

                part.AssemblyLinearVelocity =
                    part.AssemblyLinearVelocity:Lerp(
                        desiredVelocity,
                        math.clamp(
                            delta * 10,
                            0,
                            1
                        )
                    )

            end)

        elseif attraction <= 0 then

            pcall(function()

                part.AssemblyLinearVelocity =
                    part.AssemblyLinearVelocity:Lerp(
                        Vector3.zero,
                        math.clamp(
                            delta * 10,
                            0,
                            1
                        )
                    )

            end)

        end

    end
end)

--==================================================
-- RING TOGGLE
--==================================================

ToggleButton.MouseButton1Click:Connect(function()

    ringPartsEnabled =
        not ringPartsEnabled

    if ringPartsEnabled then

        -- Immediately rebuild the list when enabled
        rescanRingParts()

        ToggleButton.Text =
            "❄  Ring On"

        ToggleButton.TextColor3 =
            CYAN

        notify(
            "Iced's Angel Rings",
            "Ring system enabled"
        )

    else

        ToggleButton.Text =
            "❄  Ring Off"

        ToggleButton.TextColor3 =
            BLACK

        notify(
            "Iced's Angel Rings",
            "Ring system disabled"
        )

    end

    playSound("12221967")
end)

--==================================================
-- CONTROL CREATOR
--==================================================

local function createControl(
    positionY,
    labelText,
    defaultValue,
    callback
)

    local DecreaseButton =
        Instance.new("TextButton")

    DecreaseButton.Name =
        labelText .. "_Decrease"

    DecreaseButton.Size =
        UDim2.new(0,52,0,36)

    DecreaseButton.Position =
        UDim2.new(0,20,0,positionY)

    DecreaseButton.Text = "−"
    DecreaseButton.TextColor3 = BLACK
    DecreaseButton.TextSize = 20
    DecreaseButton.Font = Enum.Font.Gotham

    DecreaseButton.BackgroundTransparency = 1
    DecreaseButton.BorderSizePixel = 0
    DecreaseButton.AutoButtonColor = false

    DecreaseButton.Parent =
        MainFrame

    corner(DecreaseButton,10)
    clickableOutline(DecreaseButton,1.2)

    --------------------------------------------------

    local Display =
        Instance.new("TextLabel")

    Display.Name =
        labelText .. "_Display"

    Display.Size =
        UDim2.new(0,174,0,36)

    Display.Position =
        UDim2.new(0,83,0,positionY)

    Display.Text =
        labelText .. ": " .. defaultValue

    Display.TextColor3 =
        BLACK

    Display.TextSize = 12
    Display.Font = Enum.Font.Gotham

    Display.BackgroundTransparency = 1
    Display.BorderSizePixel = 0

    Display.Parent =
        MainFrame

    corner(Display,10)
    clickableOutline(Display,1)

    --------------------------------------------------

    local IncreaseButton =
        Instance.new("TextButton")

    IncreaseButton.Name =
        labelText .. "_Increase"

    IncreaseButton.Size =
        UDim2.new(0,52,0,36)

    IncreaseButton.Position =
        UDim2.new(1,-72,0,positionY)

    IncreaseButton.Text = "+"
    IncreaseButton.TextColor3 = BLACK
    IncreaseButton.TextSize = 20
    IncreaseButton.Font = Enum.Font.Gotham

    IncreaseButton.BackgroundTransparency = 1
    IncreaseButton.BorderSizePixel = 0
    IncreaseButton.AutoButtonColor = false

    IncreaseButton.Parent =
        MainFrame

    corner(IncreaseButton,10)
    clickableOutline(IncreaseButton,1.2)

    --------------------------------------------------

    local TextBox =
        Instance.new("TextBox")

    TextBox.Name =
        labelText .. "_Input"

    TextBox.Size =
        UDim2.new(1,-40,0,28)

    TextBox.Position =
        UDim2.new(0,20,0,positionY + 40)

    TextBox.PlaceholderText =
        "Enter " .. labelText

    TextBox.PlaceholderColor3 =
        Color3.fromRGB(100,100,100)

    TextBox.Text = ""
    TextBox.TextColor3 = BLACK
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 12

    TextBox.BackgroundTransparency = 1
    TextBox.BorderSizePixel = 0

    TextBox.Parent =
        MainFrame

    corner(TextBox,9)
    clickableOutline(TextBox,1.2)

    --------------------------------------------------

    local currentValue =
        tonumber(defaultValue) or 0

    local function getLimits()

        if labelText == "Radius" then
            return 1,500

        elseif labelText == "Height" then
            return 0,500

        elseif labelText == "Rotation Speed" then
            return 0,360

        elseif labelText == "Attraction" then
            return 0,10000
        end

        return 0,10000
    end

    local function update(value)

        value = tonumber(value)

        if not value then
            return
        end

        value = math.floor(value)

        local minimum, maximum =
            getLimits()

        currentValue =
            math.clamp(
                value,
                minimum,
                maximum
            )

        Display.Text =
            labelText .. ": " .. currentValue

        callback(currentValue)

    end

    DecreaseButton.MouseButton1Click:Connect(function()

        update(currentValue - 10)

        playSound("12221967")

    end)

    IncreaseButton.MouseButton1Click:Connect(function()

        update(currentValue + 10)

        playSound("12221967")

    end)

    TextBox.FocusLost:Connect(function(enterPressed)

        if not enterPressed then
            return
        end

        local value =
            tonumber(TextBox.Text)

        if value then

            update(value)

            playSound("12221967")

        end

        TextBox.Text = ""

    end)

end

--==================================================
-- CONTROLS
--==================================================

createControl(
    132,
    "Radius",
    config.radius,
    function(value)
        config.radius = value
    end
)

createControl(
    201,
    "Height",
    config.height,
    function(value)
        config.height = value
    end
)

createControl(
    270,
    "Rotation Speed",
    config.rotationSpeed,
    function(value)
        config.rotationSpeed = value
    end
)

createControl(
    339,
    "Attraction",
    config.attractionStrength,
    function(value)
        config.attractionStrength = value
    end
)

--==================================================
-- UTILITY FRAME
--==================================================

local UtilityFrame =
    Instance.new("Frame")

UtilityFrame.Name =
    "UtilityButtons"

UtilityFrame.Size =
    UDim2.new(1,-40,0,82)

UtilityFrame.Position =
    UDim2.new(0,20,1,-94)

UtilityFrame.BackgroundTransparency = 1
UtilityFrame.Parent = MainFrame

local Grid =
    Instance.new("UIGridLayout")

Grid.CellSize =
    UDim2.new(0,70,0,36)

Grid.CellPadding =
    UDim2.new(0,6,0,8)

Grid.HorizontalAlignment =
    Enum.HorizontalAlignment.Center

Grid.VerticalAlignment =
    Enum.VerticalAlignment.Center

Grid.Parent =
    UtilityFrame

--==================================================
-- UTILITY BUTTON
--==================================================

local function createUtilityButton(name,text)

    local Button =
        Instance.new("TextButton")

    Button.Name = name
    Button.Text = text
    Button.TextColor3 = BLACK
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 10

    Button.BackgroundTransparency = 1
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false

    Button.Parent =
        UtilityFrame

    corner(Button,9)
    clickableOutline(Button,1.2)

    Button.MouseEnter:Connect(function()
        Button.TextColor3 = CYAN
    end)

    Button.MouseLeave:Connect(function()

        if not Button.Text:find("✓") then
            Button.TextColor3 = BLACK
        end

    end)

    return Button
end

local FlyButton =
    createUtilityButton("Fly","FLY")

local FallButton =
    createUtilityButton("NoFall","NO FALL")

local NoclipButton =
    createUtilityButton("Noclip","NOCLIP")

local JumpButton =
    createUtilityButton("InfiniteJump","INF JUMP")

local YieldButton =
    createUtilityButton("InfiniteYield","INF YIELD")

local AdminButton =
    createUtilityButton("Nameless","NAMELESS")

local FPSButton =
    createUtilityButton("FPS","FPS")

--==================================================
-- EXTERNAL SCRIPT LOADER
--==================================================

local function executeUrl(url,name)

    task.spawn(function()

        local success,result =
            pcall(function()

                local source =
                    game:HttpGet(url)

                if not source or source == "" then
                    error("Empty response")
                end

                local fn,compileError =
                    loadstring(source)

                if not fn then
                    error(compileError)
                end

                return fn()
            end)

        if success then

            notify(
                "Iced Hub",
                name .. " loaded"
            )

        else

            warn(
                "[Iced Hub] " ..
                name ..
                " failed:",
                result
            )

            notify(
                "Iced Hub",
                name ..
                " failed to load"
            )

        end

    end)

end

--==================================================
-- FLY
--==================================================

local flyEnabled = false

FlyButton.MouseButton1Click:Connect(function()

    flyEnabled = not flyEnabled

    if flyEnabled then

        FlyButton.Text = "FLY ✓"
        FlyButton.TextColor3 = CYAN

        executeUrl(
            "https://pastebin.com/raw/YSL3xKYU",
            "Fly"
        )

    else

        FlyButton.Text = "FLY"
        FlyButton.TextColor3 = BLACK

    end

    playSound("12221967")

end)

--==================================================
-- NO FALL
--==================================================

local noFallEnabled = false
local noFallConnection = nil

local function setNoFall(enabled)

    noFallEnabled = enabled

    if noFallConnection then
        noFallConnection:Disconnect()
        noFallConnection = nil
    end

    if not enabled then
        return
    end

    noFallConnection =
        RunService.Heartbeat:Connect(function()

            local character =
                LocalPlayer.Character

            if not character then
                return
            end

            local root =
                character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if not root then
                return
            end

            local velocity =
                root.AssemblyLinearVelocity

            if velocity.Y < -50 then

                root.AssemblyLinearVelocity =
                    Vector3.new(
                        velocity.X,
                        -5,
                        velocity.Z
                    )

            end

        end)

end

FallButton.MouseButton1Click:Connect(function()

    setNoFall(not noFallEnabled)

    FallButton.Text =
        noFallEnabled
        and "NO FALL ✓"
        or "NO FALL"

    FallButton.TextColor3 =
        noFallEnabled
        and CYAN
        or BLACK

    playSound("12221967")

end)

--==================================================
-- NOCLIP
--==================================================

local noclipEnabled = false
local noclipConnection = nil

local function setNoclip(enabled)

    noclipEnabled = enabled

    if noclipConnection then

        noclipConnection:Disconnect()
        noclipConnection = nil

    end

    if not enabled then

        local character =
            LocalPlayer.Character

        if character then

            for _,v in ipairs(
                character:GetDescendants()
            ) do

                if v:IsA("BasePart") then
                    v.CanCollide = true
                end

            end

        end

        return
    end

    noclipConnection =
        RunService.Stepped:Connect(function()

            local character =
                LocalPlayer.Character

            if not character then
                return
            end

            for _,v in ipairs(
                character:GetDescendants()
            ) do

                if v:IsA("BasePart") then
                    v.CanCollide = false
                end

            end

        end)

end

NoclipButton.MouseButton1Click:Connect(function()

    setNoclip(not noclipEnabled)

    NoclipButton.Text =
        noclipEnabled
        and "NOCLIP ✓"
        or "NOCLIP"

    NoclipButton.TextColor3 =
        noclipEnabled
        and CYAN
        or BLACK

    playSound("12221967")

end)

--==================================================
-- INFINITE JUMP
--==================================================

local infiniteJumpEnabled = false
local jumpConnection = nil

local function setInfiniteJump(enabled)

    infiniteJumpEnabled = enabled

    if jumpConnection then

        jumpConnection:Disconnect()
        jumpConnection = nil

    end

    if not enabled then
        return
    end

    jumpConnection =
        UserInputService.JumpRequest:Connect(function()

            if not infiniteJumpEnabled then
                return
            end

            local humanoid =
                getHumanoid()

            if humanoid then

                humanoid:ChangeState(
                    Enum.HumanoidStateType.Jumping
                )

            end

        end)

end

JumpButton.MouseButton1Click:Connect(function()

    setInfiniteJump(
        not infiniteJumpEnabled
    )

    JumpButton.Text =
        infiniteJumpEnabled
        and "INF JUMP ✓"
        or "INF JUMP"

    JumpButton.TextColor3 =
        infiniteJumpEnabled
        and CYAN
        or BLACK

    playSound("12221967")

end)

--==================================================
-- INFINITE YIELD
--==================================================

local infiniteYieldLoaded = false

YieldButton.MouseButton1Click:Connect(function()

    if infiniteYieldLoaded then

        notify(
            "Iced Hub",
            "Infinite Yield is already loaded"
        )

        return
    end

    infiniteYieldLoaded = true

    YieldButton.Text =
        "INF YIELD ✓"

    YieldButton.TextColor3 =
        CYAN

    executeUrl(
        "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
        "Infinite Yield"
    )

    playSound("12221967")

end)

--==================================================
-- NAMELESS ADMIN
--==================================================

local namelessLoaded = false

AdminButton.MouseButton1Click:Connect(function()

    if namelessLoaded then

        notify(
            "Iced Hub",
            "Nameless Admin is already loaded"
        )

        return
    end

    namelessLoaded = true

    AdminButton.Text =
        "NAMELESS ✓"

    AdminButton.TextColor3 =
        CYAN

    executeUrl(
        "https://scriptblox.com/raw/Universal-Script-Nameless-Admin-FE-11243",
        "Nameless Admin"
    )

    playSound("12221967")

end)

--==================================================
-- FPS
--==================================================

local fpsLoaded = false

FPSButton.MouseButton1Click:Connect(function()

    if fpsLoaded then

        notify(
            "Iced Hub",
            "FPS script is already loaded"
        )

        return
    end

    fpsLoaded = true

    FPSButton.Text =
        "FPS ✓"

    FPSButton.TextColor3 =
        CYAN

    executeUrl(
        "https://pastebin.com/raw/ySHJdZpb",
        "FPS"
    )

    playSound("12221967")

end)

--==================================================
-- MINIMIZE
--==================================================

local minimized = false

MinimizeButton.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        MainFrame:TweenSize(
            UDim2.new(0,340,0,74),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.25,
            true
        )

        Glow:TweenSize(
            UDim2.new(0,348,0,82),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.25,
            true
        )

        MinimizeButton.Text = "+"

        for _,object in ipairs(
            MainFrame:GetChildren()
        ) do

            if object ~= TopBar
                and object:IsA("GuiObject") then

                object.Visible = false

            end

        end

        TopBar.Visible = true

    else

        MainFrame:TweenSize(
            UDim2.new(0,340,0,540),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.25,
            true
        )

        Glow:TweenSize(
            UDim2.new(0,348,0,548),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.25,
            true
        )

        MinimizeButton.Text = "−"

        for _,object in ipairs(
            MainFrame:GetChildren()
        ) do

            if object:IsA("GuiObject") then
                object.Visible = true
            end

        end

    end

    playSound("12221967")

end)

--==================================================
-- DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

MainFrame.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = true

        dragStart =
            input.Position

        startPosition =
            MainFrame.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                dragging = false

            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        local delta =
            input.Position -
            dragStart

        MainFrame.Position =
            UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        Glow.Position =
            UDim2.new(
                MainFrame.Position.X.Scale,
                MainFrame.Position.X.Offset - 4,
                MainFrame.Position.Y.Scale,
                MainFrame.Position.Y.Offset - 4
            )

    end

end)

--==================================================
-- ANIMATIONS
--==================================================

local gradientOffset = -1
local pulse = 0

RunService.Heartbeat:Connect(function(delta)

    gradientOffset += delta * 0.45

    if gradientOffset > 1 then
        gradientOffset = -1
    end

    TitleGradient.Offset =
        Vector2.new(
            gradientOffset,
            0
        )

    SubtitleGradient.Offset =
        Vector2.new(
            gradientOffset,
            0
        )

    pulse += delta * 2

    local glowPulse =
        (math.sin(pulse) + 1) / 2

    Glow.BackgroundTransparency =
        0.72 +
        glowPulse * 0.10

    GlowGradient.Rotation =
        (
            GlowGradient.Rotation +
            delta * 25
        ) % 360

end)

--==================================================
-- STARTUP
--==================================================

task.spawn(function()

    task.wait(1)

    notify(
        "Iced's Angel Rings V1",
        "Loaded successfully!"
    )

end)
