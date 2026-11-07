--]]
 ____  _                   ____                     _           
| __ )| | _____  ___   _  |  _ \ __ _ _ __ __ _  __| | _____  __
|  _ \| |/ _ \ \/ / | | | | |_) / _` | '__/ _` |/ _` |/ _ \ \/ /
| |_) | | (_) >  <| |_| | |  __/ (_| | | | (_| | (_| | (_) >  < 
|____/|_|\___/_/\_\\__, | |_|   \__,_|_|  \__,_|\__,_|\___/_/\_\
                   |___/                                        
]]
-- [[ BLOXY PARADOX 專案 - 由 YOUTUBE 上的 @MOCCAPAZZA 製作 ]] --

----------------------------------------------------------------------------------------------------
-- [[ 按鈕功能插入區（便於錯誤修復） ]] --
----------------------------------------------------------------------------------------------------
local MyScripts = {
	Topbar_2024         = [[ loadstring(game:HttpGet("https://raw.githubusercontent.com/letsafe/something/refs/heads/main/yea.txt"))() ]], 
	Topbar_2023_FFlags  = [[ loadstring(game:HttpGet("https://gist.githubusercontent.com/eloredo413-hue/4a556148bc45d14ac710a87efef6bcc6/raw/4893deb9647440ba0f9058e0666272fb20e48eba/2023%2520New%2520Gui"))() ]], 
	Topbar_2023_WIP     = [[ loadstring(game:HttpGet("https://raw.githubusercontent.com/letsafe/something/refs/heads/main/2023escmenuv3.lua"))() ]], 
	Topbar_2019         = [[ loadstring(game:HttpGet("https://github.com/Elite-random/2019-topbar/releases/download/idk/2019_topbar.txt"))() ]], 
	Topbar_2017         = [[ loadstring(game:HttpGet("https://github.com/Elite-random/2019-topbar/releases/download/ig/2017_topbar.txt"))() ]], 
	Topbar_2016_A       = [[  -- 無法運作，此項目將被刪除
 ]], 
	Topbar_2016_S       = [[ -- 2016 年頂欄

loadstring(game:HttpGet("https://pastebin.com/raw/uHtNKptM"))() ]], 
	Topbar_2015         = [[ -- 2015 年頂欄

loadstring(game:HttpGet("https://pastebin.com/raw/gvxgVrKD"))() ]], 
	Topbar_2014         = [[ -- 2014 年頂欄

loadstring(game:HttpGet("https://pastebin.com/raw/h5AEhK7N"))() ]],
	Topbar_2013_Mobile  = [[ -- 2012 年對話氣泡
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

-- 停用 Roblox 預設對話設定
pcall(function()
	TextChatService.BubbleChatConfiguration.Enabled = false
end)
pcall(function()
	Chat:SetBubbleChatEnabled(false)
end)

local ZOOM_THRESHOLD = 52 -- 觸發第二階段（"..."）的距離（Studs）
local MAX_VISIBILITY_DISTANCE = 75 -- 氣泡消失前的最大顯示距離
local BUBBLE_LIFETIME = 20 -- 氣泡持續時間：20 秒

local lastProcessedMessages = {}

local function createClassicBubble(head, messageText)
	if not head or not head:IsA("BasePart") then return end
	
	-- 清除頭部上的舊自訂氣泡實體
	for _, child in ipairs(head:GetChildren()) do
		if child.Name == "ClassicBubbleGui" then
			child:Destroy()
		end
	end
	
	local classicFont = Font.new(
		"rbxasset://fonts/families/Arial.json",
		Enum.FontWeight.Regular,
		Enum.FontStyle.Normal
	)
	local fontSize = 20
	local maxTextWidth = 220 
	
	-- 計算文字範圍尺寸
	local absoluteTextSize = TextService:GetTextSize(
		messageText, 
		fontSize, 
		Enum.Font.Arial, 
		Vector2.new(maxTextWidth, 1000)
	)
	
	-- 動態氣泡尺寸
	local normalWidth = math.clamp(absoluteTextSize.X + 24, 42, maxTextWidth + 24)
	local normalHeight = absoluteTextSize.Y + 24 
	local tailHeight = 19
	local tailWidth = 16

	-- 第二階段（"..."）氣泡尺寸
	local smallWidth = 52
	local smallHeight = 38

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ClassicBubbleGui"
	billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
	billboard.Adornee = head
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.SizeOffset = Vector2.new(0, 0.5)
	billboard.AlwaysOnTop = false
	billboard.MaxDistance = MAX_VISIBILITY_DISTANCE
	billboard.ZIndexBehavior = Enum.ZIndexBehavior.Global

	-- 氣泡主體
	local bubbleBody = Instance.new("ImageLabel")
	bubbleBody.Name = "BubbleBody"
	bubbleBody.Image = "rbxassetid://2582470061"
	bubbleBody.BackgroundTransparency = 1
	bubbleBody.ScaleType = Enum.ScaleType.Slice
	bubbleBody.SliceCenter = Rect.new(29, 29, 67, 67)
	bubbleBody.SliceScale = 0.4
	bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight) 
	bubbleBody.ZIndex = 2
	bubbleBody.Parent = billboard

	-- 氣泡尾巴圖像（下移 1 像素至 normalHeight - 6）
	local bubbleTail = Instance.new("ImageLabel")
	bubbleTail.Name = "BubbleTail"
	bubbleTail.Size = UDim2.new(0, tailWidth, 0, tailHeight)
	bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
	bubbleTail.BackgroundTransparency = 1
	bubbleTail.Image = "rbxassetid://2582470060"
	bubbleTail.ZIndex = 4
	bubbleTail.Parent = billboard

	-- 白色連接框
	local connectorBox = Instance.new("Frame")
	connectorBox.Name = "ConnectorBox"
	connectorBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	connectorBox.BorderSizePixel = 0
	connectorBox.ZIndex = 3
	connectorBox.Size = UDim2.new(0, 10, 0, 6)
	connectorBox.Position = UDim2.new(0.5, -5, 0, -4)
	connectorBox.Parent = bubbleTail

	-- 對話文字標籤
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
	textLabel.Position = UDim2.new(0, 8, 0, 12)
	textLabel.BackgroundTransparency = 1
	textLabel.FontFace = classicFont
	textLabel.TextSize = fontSize
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.TextWrapped = true
	textLabel.Text = messageText
	textLabel.ZIndex = 10
	textLabel.Parent = billboard
	
	billboard.Parent = head

	local renderConnection
	renderConnection = RunService.RenderStepped:Connect(function()
		if not billboard or not billboard.Parent or not workspace.CurrentCamera then
			if renderConnection then renderConnection:Disconnect() end
			return
		end
		
		local camPos = workspace.CurrentCamera.CFrame.Position
		local distance = (camPos - head.Position).Magnitude
		
		if distance > ZOOM_THRESHOLD then
			textLabel.Text = "..."
			textLabel.Size = UDim2.new(1, -16, 0, 20)
			textLabel.Position = UDim2.new(0, 8, 0, 9)
			billboard.Size = UDim2.new(0, smallWidth, 0, smallHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, smallHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, smallHeight - 6)
		else
			textLabel.Text = messageText
			textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
			textLabel.Position = UDim2.new(0, 8, 0, 12)
			billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
		end
	end)
	
	task.delay(BUBBLE_LIFETIME, function()
		if renderConnection then renderConnection:Disconnect() end
		if billboard and billboard.Parent then
			billboard:Destroy()
		end
	end)
end

local function handleBubbleSpawn(player, text)
	if not player or not text or text == "" then return end

	local msgKey = player.UserId .. ":" .. text
	if lastProcessedMessages[msgKey] then return end
	lastProcessedMessages[msgKey] = true
	task.delay(0.05, function() lastProcessedMessages[msgKey] = nil end)

	local character = player.Character
	if character then
		local head = character:FindFirstChild("Head")
		if head then
			createClassicBubble(head, text)
		end
	end
end

-- 即時事件觸發器
local function trackPlayer(player)
	player.Chatted:Connect(function(msg)
		handleBubbleSpawn(player, msg)
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	trackPlayer(p)
end
Players.PlayerAdded:Connect(trackPlayer)

TextChatService.MessageReceived:Connect(function(message)
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		handleBubbleSpawn(player, message)
	end
end)

Chat.Chatted:Connect(function(part, message)
	if part and part:IsA("BasePart") then
		local player = Players:GetPlayerFromCharacter(part.Parent) or Players:GetPlayerFromCharacter(part)
		if player then
			handleBubbleSpawn(player, message)
		end
	end
end)

-- 背景清理 Roblox 預設氣泡
if LocalPlayer then
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 2)
	if playerGui then
		playerGui.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("BillboardGui") and descendant.Name ~= "ClassicBubbleGui" then
				descendant:Destroy()
			end
		end)
	end
end


getgenv().LegacySettings = {
    Year = 2013,
    OldGraphics = false,
    HideDisplayName = true,
    SafeChat = false,
    OldConsole = false,
    OldBubbleChat = false
}

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")
local ChatService = game:GetService("Chat")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TOUCH_SHEET = "rbxasset://textures/ui/TouchControlsSheet.png"

-- 在兩個對話引擎上安全停用 Roblox 原生對話氣泡
pcall(function()
    TextChatService.BubbleChatConfiguration.Enabled = false
end)
pcall(function()
    ChatService.BubbleChatEnabled = false
end)

-- 預先載入生命值、對話氣泡與行動裝置 UI 資產
task.spawn(function()
    ContentProvider:PreloadAsync({
        "rbxassetid://35238053",
        "rbxassetid://35238036",
        "rbxassetid://154646431",
        "rbxassetid://34854607",
        "rbxassetid://2582470061",
        "rbxassetid://2582470060",
        TOUCH_SHEET
    })
end)

pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
end)

GuiService.MenuOpened:Connect(function()
    if GuiService.IsMenuOpened then pcall(function() GuiService:SetMenuOpened(false) end) end
end)

local function eliminateNativeMenuCompletely()
    pcall(function()
        if CoreGui:FindFirstChild("TopBarApp") then CoreGui.TopBarApp:Destroy() end
        local robloxGui = CoreGui:FindFirstChild("RobloxGui")
        if robloxGui then
            for _, child in ipairs(robloxGui:GetChildren()) do
                local name = string.lower(child.Name)
                if name == "topbar" or name == "chrome" or name == "unibarleft" or name == "menubutton" then
                    child.Visible = false
                end
            end
        end
        local expChat = CoreGui:FindFirstChild("ExperienceChat")
        if expChat and expChat:FindFirstChild("appLayout") and expChat.appLayout:FindFirstChild("topBar") then
            expChat.appLayout.topBar.Visible = false
        end
    end)
end
eliminateNativeMenuCompletely()

-- 持續隱藏現代觸控 UI（保留背包/物品欄）
task.spawn(function()
    while true do
        local modernTouch = PlayerGui:FindFirstChild("TouchGui")
        if modernTouch and modernTouch.Enabled then 
            modernTouch.Enabled = false 
        end
        task.wait(0.5)
    end
end)

local targetParent = CoreGui
pcall(function() if gethui then targetParent = gethui() end end)

local guiName = "LegacyMobileUI_FunctionalReplacement"
if targetParent:FindFirstChild(guiName) then targetParent[guiName]:Destroy() end
local dialogGuiName = "LegacyMobileUI_Dialog"
if targetParent:FindFirstChild(dialogGuiName) then targetParent[dialogGuiName]:Destroy() end
local touchGuiName = "LegacyTouchControls"
if targetParent:FindFirstChild(touchGuiName) then targetParent[touchGuiName]:Destroy() end
if PlayerGui:FindFirstChild(touchGuiName) then PlayerGui[touchGuiName]:Destroy() end

-- 主 UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = guiName
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999999 
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = targetParent

-- 對話框 UI
local dialogGui = Instance.new("ScreenGui")
dialogGui.Name = dialogGuiName
dialogGui.IgnoreGuiInset = false 
dialogGui.ResetOnSpawn = false
dialogGui.DisplayOrder = 999999999 
dialogGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
dialogGui.Parent = targetParent

-- 觸控控制 UI（附屬至 targetParent 以在重置後保留）
local touchScreenGui = Instance.new("ScreenGui")
touchScreenGui.Name = touchGuiName
touchScreenGui.ResetOnSpawn = false
touchScreenGui.DisplayOrder = 999
touchScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
touchScreenGui.Parent = targetParent


local JoystickFrame = Instance.new("Frame", touchScreenGui)
JoystickFrame.Name = "JoystickFrame"
JoystickFrame.Size = UDim2.new(0, 90, 0, 90)
JoystickFrame.Position = UDim2.new(0, 30, 1, -120)
JoystickFrame.BackgroundTransparency = 1
JoystickFrame.Active = true

local JoystickBase = Instance.new("ImageLabel", JoystickFrame)
JoystickBase.Name = "Base"
JoystickBase.Size = UDim2.new(1, 0, 1, 0)
JoystickBase.Image = TOUCH_SHEET
JoystickBase.ImageRectOffset = Vector2.new(0, 0)
JoystickBase.ImageRectSize = Vector2.new(220, 220)
JoystickBase.BackgroundTransparency = 1

local JoystickStick = Instance.new("ImageLabel", JoystickFrame)
JoystickStick.Name = "Stick"
JoystickStick.Size = UDim2.new(0, 42, 0, 42) 
JoystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
JoystickStick.AnchorPoint = Vector2.new(0.5, 0.5)
JoystickStick.Image = TOUCH_SHEET
JoystickStick.ImageRectOffset = Vector2.new(220, 0)
JoystickStick.ImageRectSize = Vector2.new(111, 111)
JoystickStick.BackgroundTransparency = 1
JoystickStick.ZIndex = 2

local JumpButton = Instance.new("ImageButton", touchScreenGui)
JumpButton.Name = "JumpButton"
JumpButton.Size = UDim2.new(0, 90, 0, 90)
JumpButton.Position = UDim2.new(1, -120, 1, -120)
JumpButton.BackgroundTransparency = 1
JumpButton.Image = TOUCH_SHEET
JumpButton.ImageRectOffset = Vector2.new(176, 222)
JumpButton.ImageRectSize = Vector2.new(174, 174)
JumpButton.Active = true

local moveVector = Vector3.new(0,0,0)
local walkSpeedFactor = 0
local isJumpButtonDown = false
local moveTouchObject = nil
local jumpTouchObject = nil 
local maxRadius = 45 

JoystickFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not moveTouchObject then
        moveTouchObject = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == moveTouchObject then
        local center = JoystickFrame.AbsolutePosition + (JoystickFrame.AbsoluteSize / 2)
        local diff = Vector2.new(input.Position.X, input.Position.Y) - center
        local dist = math.min(diff.Magnitude, maxRadius)
        walkSpeedFactor = dist / maxRadius
        local dir = diff.Magnitude > 0 and diff.Unit or Vector2.new(0,0)
        JoystickStick.Position = UDim2.new(0.5, dir.X * dist, 0.5, dir.Y * dist)
        moveVector = Vector3.new(dir.X, 0, dir.Y)
        
    elseif input == jumpTouchObject then
        local pos = input.Position
        local absPos = JumpButton.AbsolutePosition
        local absSize = JumpButton.AbsoluteSize
        
        local isInside = (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and 
                          pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y)
                          
        if not isInside then
            jumpTouchObject = nil
            isJumpButtonDown = false
            JumpButton.ImageRectOffset = Vector2.new(176, 222)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == moveTouchObject then
        moveTouchObject = nil; moveVector = Vector3.new(0,0,0); walkSpeedFactor = 0
        JoystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end)

JumpButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not jumpTouchObject then
        jumpTouchObject = input
        isJumpButtonDown = true
        JumpButton.ImageRectOffset = Vector2.new(0, 222)
    end
end)

JumpButton.InputEnded:Connect(function(input)
    if input == jumpTouchObject then
        jumpTouchObject = nil
        isJumpButtonDown = false
        JumpButton.ImageRectOffset = Vector2.new(176, 222)
    end
end)

RunService.RenderStepped:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if moveVector.Magnitude > 0 then
        LocalPlayer:Move(moveVector * walkSpeedFactor, true)
    end
    
    if isJumpButtonDown then
        local state = hum:GetState()
        local canJump = (hum.FloorMaterial ~= Enum.Material.Air or hum.Sit or state == Enum.HumanoidStateType.Climbing or state == Enum.HumanoidStateType.Swimming)
        
        if canJump then
            hum.Jump = true
            if state == Enum.HumanoidStateType.Climbing then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)


local HurtOverlay = Instance.new("ImageLabel")
HurtOverlay.Name = "HurtOverlay"
HurtOverlay.BackgroundTransparency = 1
HurtOverlay.Image = "rbxassetid://34854607"
HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
HurtOverlay.Visible = false
HurtOverlay.ZIndex = 1
HurtOverlay.Parent = screenGui

local HealthFrame = Instance.new("Frame")
HealthFrame.Name = "HealthFrame"
HealthFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.Position = UDim2.new(0.5, -85, 1, -22)
HealthFrame.Size = UDim2.new(0, 170, 0, 18)
HealthFrame.ZIndex = 99999
HealthFrame.Parent = screenGui

local HealthBar = Instance.new("ImageLabel")
HealthBar.Name = "HealthBar"
HealthBar.BackgroundTransparency = 1
HealthBar.Image = "rbxassetid://35238053"
HealthBar.Size = UDim2.new(1, 0, 1, 0)
HealthBar.ZIndex = 99999
HealthBar.Parent = HealthFrame

local HealthLabel = Instance.new("TextLabel")
HealthLabel.Name = "HealthLabel"
HealthLabel.Text = "Health  "
HealthLabel.Font = Enum.Font.SourceSansBold
HealthLabel.TextSize = 14
HealthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthLabel.TextStrokeTransparency = 0
HealthLabel.TextXAlignment = Enum.TextXAlignment.Right
HealthLabel.BackgroundTransparency = 1
HealthLabel.Size = UDim2.new(1, 0, 1, 0)
HealthLabel.ZIndex = 99999
HealthLabel.Parent = HealthFrame

local lastHealth = 100
local healthConn, diedConn, charConn

local function AnimateHurtOverlay()
    HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
    HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
    HurtOverlay.Visible = true

    local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(HurtOverlay, tweenInfo, {
        Size = UDim2.new(20, 0, 20, 0),
        Position = UDim2.new(-10, 0, -10, 0)
    })
    
    tween:Play()
    task.delay(10, function() HurtOverlay.Visible = false end)
end

local function UpdateGui(currentHealth, humanoid)
    if not humanoid then return end
    
    local healthPercent = currentHealth / humanoid.MaxHealth
    
    if healthPercent == healthPercent then
        if healthPercent > 0.25 then
            HealthBar.Image = "rbxassetid://35238053"
        else
            HealthBar.Image = "rbxassetid://35238036"
        end
    else
        HealthBar.Image = "rbxassetid://154646431"
    end

    local clampedPercent = math.max(math.min(healthPercent, 1), 0)
    local damageTaken = lastHealth - currentHealth
    lastHealth = currentHealth

    local sizeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local sizeTween = TweenService:Create(HealthBar, sizeTweenInfo, {
        Size = UDim2.new(clampedPercent, 0, 1, 0)
    })
    sizeTween:Play()

    if damageTaken > 0 and (humanoid.MaxHealth * 0.05 <= damageTaken) then
        AnimateHurtOverlay()
    end
end

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    lastHealth = humanoid.Health
    UpdateGui(humanoid.Health, humanoid)

    if healthConn then healthConn:Disconnect() end
    if diedConn then diedConn:Disconnect() end

    healthConn = humanoid.HealthChanged:Connect(function(health) UpdateGui(health, humanoid) end)
    diedConn = humanoid.Died:Connect(function() UpdateGui(0, humanoid) end)
end

if LocalPlayer.Character then task.spawn(function() setupCharacter(LocalPlayer.Character) end) end
charConn = LocalPlayer.CharacterAdded:Connect(setupCharacter)


local container = Instance.new("Frame")
container.Name = "ButtonContainer"
container.Size = UDim2.new(0, 250, 0, 28.999) 
container.Position = UDim2.new(0, 10, 0, 2)
container.BackgroundTransparency = 1
container.ZIndex = 99999
container.Parent = screenGui

local listLayout = Instance.new("UIListLayout", container)
listLayout.FillDirection = Enum.FillDirection.Horizontal
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 0)

local leaveButtonToggleState = false
local updateLeaveButtonVisuals = nil

local leaveDialog = Instance.new("Frame")
leaveDialog.Name = "LeaveDialog"
leaveDialog.Size = UDim2.new(0, 355, 0, 220)
leaveDialog.AnchorPoint = Vector2.new(0.5, 0.5)
leaveDialog.Position = UDim2.new(0.5, 0, 1.5, 0)
leaveDialog.BackgroundColor3 = Color3.fromRGB(115, 115, 115)
leaveDialog.BorderSizePixel = 0
leaveDialog.Visible = false
leaveDialog.ZIndex = 99999
leaveDialog.Parent = dialogGui

Instance.new("UICorner", leaveDialog).CornerRadius = UDim.new(0, 2)
local dialogStroke = Instance.new("UIStroke", leaveDialog)
dialogStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
dialogStroke.Color = Color3.fromRGB(255, 255, 255)
dialogStroke.Thickness = 1

local dialogMessage = Instance.new("TextLabel")
dialogMessage.Size = UDim2.new(1, -30, 0, 110)
dialogMessage.Position = UDim2.new(0, 15, 0, 15)
dialogMessage.BackgroundTransparency = 1
dialogMessage.Font = Enum.Font.SourceSansBold
dialogMessage.Text = "您確定要離開此遊戲嗎？"
dialogMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
dialogMessage.TextSize = 34
dialogMessage.TextWrapped = true
dialogMessage.TextXAlignment = Enum.TextXAlignment.Center
dialogMessage.ZIndex = 999999
dialogMessage.Parent = leaveDialog

local function showLeaveDialog()
    leaveDialog.Position = UDim2.new(0.5, 0, 1.5, 0)
    leaveDialog.Visible = true
    TweenService:Create(leaveDialog, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, -18)}):Play()
end

local function applyButtonPressEffect(btn)
    local isPressed = false
    btn.InputBegan:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            isPressed = true
            TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        end 
    end)
    btn.InputEnded:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            if isPressed then
                isPressed = false
                TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end
        end 
    end)
    btn.MouseLeave:Connect(function()
        if isPressed then
            isPressed = false
            TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end
    end)
end

local cancelBtn = Instance.new("ImageButton")
cancelBtn.Name = "CancelButton"
cancelBtn.Size = UDim2.new(0, 150, 0, 55)
cancelBtn.Position = UDim2.new(0, 20, 1, -75)
cancelBtn.BackgroundTransparency = 1
cancelBtn.Image = "rbxassetid://5698789475"
cancelBtn.ZIndex = 999999
cancelBtn.Parent = leaveDialog

applyButtonPressEffect(cancelBtn)

cancelBtn.Activated:Connect(function()
    leaveButtonToggleState = false
    if updateLeaveButtonVisuals then updateLeaveButtonVisuals(false) end
    local hideTween = TweenService:Create(leaveDialog, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.5, 0)})
    hideTween:Play()
    hideTween.Completed:Connect(function() if not leaveButtonToggleState then leaveDialog.Visible = false end end)
end)

local confirmLeaveBtn = Instance.new("ImageButton")
confirmLeaveBtn.Name = "ConfirmLeaveButton"
confirmLeaveBtn.Size = UDim2.new(0, 150, 0, 55) 
confirmLeaveBtn.Position = UDim2.new(0, 185, 1, -75)
confirmLeaveBtn.BackgroundTransparency = 1
confirmLeaveBtn.Image = "rbxassetid://5698790766"
confirmLeaveBtn.ZIndex = 999999
confirmLeaveBtn.Parent = leaveDialog

applyButtonPressEffect(confirmLeaveBtn)

confirmLeaveBtn.Activated:Connect(function()
    pcall(function() TeleportService:TeleportToPlaceInstance(0, "") end)
    task.wait(0.1)
    pcall(function() game:Shutdown() end)
end)

local function createExactVintageLeaveButton()
    local wrapper = Instance.new("Frame", container)
    wrapper.Name = "LeaveIconWrapper"
    wrapper.BackgroundTransparency = 1
    wrapper.Size = UDim2.new(0, 71, 0, 28.999) 
    wrapper.LayoutOrder = 1

    local btn = Instance.new("ImageButton", wrapper)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Image = "rbxassetid://107261331"
    btn.AutoButtonColor = false
    btn.ZIndex = 999999

    local isPressed, isToggledDark = false, false

    updateLeaveButtonVisuals = function(active)
        isToggledDark = active
        isPressed = false
        TweenService:Create(btn, TweenInfo.new(0.12), {
            ImageColor3 = active and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
        }):Play()
    end

    btn.InputBegan:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            if not isToggledDark then
                isPressed = true
                TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
            end
        end 
    end)
    
    btn.InputEnded:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            if isPressed and not isToggledDark then
                isPressed = false
                TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end
        end 
    end)
    
    btn.MouseLeave:Connect(function()
        if isPressed and not isToggledDark then
            isPressed = false
            TweenService:Create(btn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end
    end)
    
    btn.Activated:Connect(function()
        leaveButtonToggleState = not leaveButtonToggleState
        if leaveButtonToggleState then
            showLeaveDialog()
        else
            local hideTween = TweenService:Create(leaveDialog, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.5, 0)})
            hideTween:Play()
            hideTween.Completed:Connect(function() if not leaveButtonToggleState then leaveDialog.Visible = false end end)
        end
        if updateLeaveButtonVisuals then updateLeaveButtonVisuals(leaveButtonToggleState) end
    end)
end
createExactVintageLeaveButton()


local capturedChatButton = nil

local function hijackLegacyUI(uiElement)
    if not uiElement:IsA("GuiObject") then return end

    pcall(function()
        local current = uiElement
        while current and current ~= game do
            if current.Name == "LegacyMobileUI_FunctionalReplacement" or current.Name == "ClassicBubbleGui" or current.Name == "LegacyTouchControls" then return end
            current = current.Parent
        end

        local name = string.lower(uiElement.Name or "")
        local text = ""
        if uiElement:IsA("TextLabel") or uiElement:IsA("TextButton") then
            text = string.lower(uiElement.Text or "")
        end
        
        if (text == "chat" or string.find(name, "chat") or string.find(name, "chaticon")) and uiElement:IsA("GuiButton") then
            capturedChatButton = uiElement
            capturedChatButton.Parent = container 
            capturedChatButton.LayoutOrder = 2 
            capturedChatButton.Visible = true
            capturedChatButton.ZIndex = 999999

        elseif text == "menu" or string.find(name, "menu") or string.find(name, "settings") then
            uiElement.Position = UDim2.new(9999, 0, 9999, 0)
            uiElement.Visible = false
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if capturedChatButton then
        pcall(function()
            if capturedChatButton.Parent ~= container then capturedChatButton.Parent = container end
            if capturedChatButton.LayoutOrder ~= 2 then capturedChatButton.LayoutOrder = 2 end
        end)
    end
end)

local function setupHijacker(targetContainer)
    if not targetContainer then return end
    for _, element in ipairs(targetContainer:GetDescendants()) do hijackLegacyUI(element) end
    targetContainer.DescendantAdded:Connect(function(element)
        task.defer(function() hijackLegacyUI(element) end)
    end)
end

setupHijacker(CoreGui)
if gethui then setupHijacker(gethui()) end
if LocalPlayer then
    local pGui = LocalPlayer:WaitForChild("PlayerGui", 5)
    setupHijacker(pGui)
end


local success, errorMessage = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yeku/legacy/refs/heads/main/Source.luau"))()
end)

if not success then
    warn("Failed to load payload: " .. tostring(errorMessage))
end


local function createClassicBubble(head, messageText)
    if not head or not head:IsA("BasePart") then return end
    
    local oldBubble = head:FindFirstChild("ClassicBubbleGui")
    if oldBubble then oldBubble:Destroy() end
    
    local classicFont = Font.new(
        "rbxasset://fonts/families/Arial.json",
        Enum.FontWeight.Regular,
        Enum.FontStyle.Normal
    )
    local fontSize = 22
    local maxTextWidth = 220 
    
    local absoluteTextSize = TextService:GetTextSize(
        messageText, 
        fontSize, 
        Enum.Font.Arial, 
        Vector2.new(maxTextWidth, 1000)
    )
    
    local width = math.clamp(absoluteTextSize.X + 36, 75, maxTextWidth + 36)
    local height = absoluteTextSize.Y + 24 + 12 
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ClassicBubbleGui"
    billboard.Size = UDim2.new(0, width, 0, height)
    billboard.Adornee = head
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.AlwaysOnTop = false
    billboard.MaxDistance = 40

    local bubbleBody = Instance.new("ImageLabel")
    bubbleBody.Name = "BubbleBody"
    bubbleBody.Image = "rbxassetid://2582470061"
    bubbleBody.BackgroundTransparency = 1
    bubbleBody.ScaleType = Enum.ScaleType.Slice
    bubbleBody.SliceCenter = Rect.new(29, 29, 67, 67)
    bubbleBody.SliceScale = 0.5
    bubbleBody.Size = UDim2.new(1, 0, 1, -2) 
    bubbleBody.Parent = billboard

    local bubbleTail = Instance.new("ImageLabel")
    bubbleTail.Name = "BubbleTail"
    bubbleTail.Size = UDim2.new(0, 16, 0, 12)
    bubbleTail.Position = UDim2.new(0.5, -8, 1, -9.5)
    bubbleTail.BackgroundTransparency = 1
    bubbleTail.Image = "rbxassetid://2582470060"
    bubbleTail.Parent = billboard

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "BubbleText"
    textLabel.Size = UDim2.new(1, -24, 1, -20)
    textLabel.Position = UDim2.new(0, 12, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.FontFace = classicFont
    textLabel.TextSize = fontSize
    textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextWrapped = true
    textLabel.Text = messageText
    textLabel.Parent = billboard
    
    billboard.Parent = head
    
    task.delay(10, function()
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
    end)
end

local lastProcessedMessage = {}

local function processPlayerChat(player, message)
    if not player or typeof(message) ~= "string" or message == "" then return end
    
    local key = player.UserId
    local now = os.clock()
    if lastProcessedMessage[key] and lastProcessedMessage[key].text == message and (now - lastProcessedMessage[key].time) < 0.25 then
        return
    end
    lastProcessedMessage[key] = { text = message, time = now }

    local character = player.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            createClassicBubble(head, message)
        end
    end
end

local function trackPlayerBubbles(player)
    player.Chatted:Connect(function(message)
        processPlayerChat(player, message)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    trackPlayerBubbles(p)
end
Players.PlayerAdded:Connect(trackPlayerBubbles)

pcall(function()
    TextChatService.MessageReceived:Connect(function(textChatMessage)
        if textChatMessage.TextSource then
            local senderPlayer = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)
            if senderPlayer then
                processPlayerChat(senderPlayer, textChatMessage.Text)
            end
        end
    end)
end)
 ]],
	Topbar_2013         = [[ -- 2012 年對話氣泡 - 完整腳本
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

-- 停用 Roblox 預設對話設定
pcall(function()
	TextChatService.BubbleChatConfiguration.Enabled = false
end)
pcall(function()
	Chat:SetBubbleChatEnabled(false)
end)

local ZOOM_THRESHOLD = 52 -- 觸發第二階段（"..."）的距離（Studs）
local MAX_VISIBILITY_DISTANCE = 75 -- 氣泡消失前的最大顯示距離
local BUBBLE_LIFETIME = 20 -- 氣泡持續時間：20 秒

local lastProcessedMessages = {}

local function createClassicBubble(head, messageText)
	if not head or not head:IsA("BasePart") then return end
	
	-- 清除頭部上的舊自訂氣泡實體
	for _, child in ipairs(head:GetChildren()) do
		if child.Name == "ClassicBubbleGui" then
			child:Destroy()
		end
	end
	
	local classicFont = Font.new(
		"rbxasset://fonts/families/Arial.json",
		Enum.FontWeight.Regular,
		Enum.FontStyle.Normal
	)
	local fontSize = 20
	local maxTextWidth = 220 
	
	-- 計算文字範圍尺寸
	local absoluteTextSize = TextService:GetTextSize(
		messageText, 
		fontSize, 
		Enum.Font.Arial, 
		Vector2.new(maxTextWidth, 1000)
	)
	
	-- 動態氣泡尺寸
	local normalWidth = math.clamp(absoluteTextSize.X + 24, 42, maxTextWidth + 24)
	local normalHeight = absoluteTextSize.Y + 24 
	local tailHeight = 19
	local tailWidth = 16

	-- 第二階段（"..."）氣泡尺寸
	local smallWidth = 52
	local smallHeight = 38

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ClassicBubbleGui"
	billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
	billboard.Adornee = head
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.SizeOffset = Vector2.new(0, 0.5)
	billboard.AlwaysOnTop = false
	billboard.MaxDistance = MAX_VISIBILITY_DISTANCE
	billboard.ZIndexBehavior = Enum.ZIndexBehavior.Global

	-- 氣泡主體
	local bubbleBody = Instance.new("ImageLabel")
	bubbleBody.Name = "BubbleBody"
	bubbleBody.Image = "rbxassetid://2582470061"
	bubbleBody.BackgroundTransparency = 1
	bubbleBody.ScaleType = Enum.ScaleType.Slice
	bubbleBody.SliceCenter = Rect.new(29, 29, 67, 67)
	bubbleBody.SliceScale = 0.4
	bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight) 
	bubbleBody.ZIndex = 2
	bubbleBody.Parent = billboard

	-- 氣泡尾巴圖像（下移 1 像素至 normalHeight - 6）
	local bubbleTail = Instance.new("ImageLabel")
	bubbleTail.Name = "BubbleTail"
	bubbleTail.Size = UDim2.new(0, tailWidth, 0, tailHeight)
	bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
	bubbleTail.BackgroundTransparency = 1
	bubbleTail.Image = "rbxassetid://2582470060"
	bubbleTail.ZIndex = 4
	bubbleTail.Parent = billboard

	-- 白色連接框
	local connectorBox = Instance.new("Frame")
	connectorBox.Name = "ConnectorBox"
	connectorBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	connectorBox.BorderSizePixel = 0
	connectorBox.ZIndex = 3
	connectorBox.Size = UDim2.new(0, 10, 0, 6)
	connectorBox.Position = UDim2.new(0.5, -5, 0, -4)
	connectorBox.Parent = bubbleTail

	-- 對話文字標籤
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
	textLabel.Position = UDim2.new(0, 8, 0, 12)
	textLabel.BackgroundTransparency = 1
	textLabel.FontFace = classicFont
	textLabel.TextSize = fontSize
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.TextWrapped = true
	textLabel.Text = messageText
	textLabel.ZIndex = 10
	textLabel.Parent = billboard
	
	billboard.Parent = head

	local renderConnection
	renderConnection = RunService.RenderStepped:Connect(function()
		if not billboard or not billboard.Parent or not workspace.CurrentCamera then
			if renderConnection then renderConnection:Disconnect() end
			return
		end
		
		local camPos = workspace.CurrentCamera.CFrame.Position
		local distance = (camPos - head.Position).Magnitude
		
		if distance > ZOOM_THRESHOLD then
			textLabel.Text = "..."
			textLabel.Size = UDim2.new(1, -16, 0, 20)
			textLabel.Position = UDim2.new(0, 8, 0, 9)
			billboard.Size = UDim2.new(0, smallWidth, 0, smallHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, smallHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, smallHeight - 6)
		else
			textLabel.Text = messageText
			textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
			textLabel.Position = UDim2.new(0, 8, 0, 12)
			billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
		end
	end)
	
	task.delay(BUBBLE_LIFETIME, function()
		if renderConnection then renderConnection:Disconnect() end
		if billboard and billboard.Parent then
			billboard:Destroy()
		end
	end)
end

local function handleBubbleSpawn(player, text)
	if not player or not text or text == "" then return end

	local msgKey = player.UserId .. ":" .. text
	if lastProcessedMessages[msgKey] then return end
	lastProcessedMessages[msgKey] = true
	task.delay(0.05, function() lastProcessedMessages[msgKey] = nil end)

	local character = player.Character
	if character then
		local head = character:FindFirstChild("Head")
		if head then
			createClassicBubble(head, text)
		end
	end
end

-- 即時事件觸發器
local function trackPlayer(player)
	player.Chatted:Connect(function(msg)
		handleBubbleSpawn(player, msg)
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	trackPlayer(p)
end
Players.PlayerAdded:Connect(trackPlayer)

TextChatService.MessageReceived:Connect(function(message)
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		handleBubbleSpawn(player, message)
	end
end)

Chat.Chatted:Connect(function(part, message)
	if part and part:IsA("BasePart") then
		local player = Players:GetPlayerFromCharacter(part.Parent) or Players:GetPlayerFromCharacter(part)
		if player then
			handleBubbleSpawn(player, message)
		end
	end
end)

-- 背景清理 Roblox 預設氣泡
if LocalPlayer then
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 2)
	if playerGui then
		playerGui.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("BillboardGui") and descendant.Name ~= "ClassicBubbleGui" then
				descendant:Destroy()
			end
		end)
	end
end



-- 2012/2013 年生命值條腳本
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- 預載資產
ContentProvider:PreloadAsync({
    "rbxassetid://35238053",
    "rbxassetid://35238036",
    "rbxassetid://154646431",
    "rbxassetid://34854607"
})

-- 清理舊有 GUI（若存在）
if CoreGui:FindFirstChild("CustomHealthGui") then
    CoreGui.CustomHealthGui:Destroy()
end

-- 建立 ScreenGui 容器
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomHealthGui"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 建立受傷遮罩特效
local HurtOverlay = Instance.new("ImageLabel")
HurtOverlay.Name = "HurtOverlay"
HurtOverlay.BackgroundTransparency = 1
HurtOverlay.Image = "rbxassetid://34854607"
HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
HurtOverlay.Visible = false
HurtOverlay.Parent = ScreenGui

-- 建立生命條外框
local HealthFrame = Instance.new("Frame")
HealthFrame.Name = "HealthFrame"
HealthFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.Position = UDim2.new(0.5, -85, 1, -22)
HealthFrame.Size = UDim2.new(0, 170, 0, 18)
HealthFrame.Parent = ScreenGui

-- 建立生命條圖像
local HealthBar = Instance.new("ImageLabel")
HealthBar.Name = "HealthBar"
HealthBar.BackgroundTransparency = 1
HealthBar.Image = "rbxassetid://35238053"
HealthBar.Size = UDim2.new(1, 0, 1, 0)
HealthBar.Parent = HealthFrame

-- 建立生命值文字標籤
local HealthLabel = Instance.new("TextLabel")
HealthLabel.Name = "HealthLabel"
HealthLabel.Text = "Health  "
HealthLabel.Font = Enum.Font.SourceSansBold
HealthLabel.TextSize = 14
HealthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthLabel.TextStrokeTransparency = 0
HealthLabel.TextXAlignment = Enum.TextXAlignment.Right
HealthLabel.BackgroundTransparency = 1
HealthLabel.Size = UDim2.new(1, 0, 1, 0)
HealthLabel.Parent = HealthFrame

local lastHealth = 100
local healthConn, diedConn, charConn

local function AnimateHurtOverlay()
    -- Reset to normal screen bounds before expanding outward
    HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
    HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
    HurtOverlay.Visible = true

    local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(HurtOverlay, tweenInfo, {
        Size = UDim2.new(20, 0, 20, 0),
        Position = UDim2.new(-10, 0, -10, 0)
    })
    
    tween:Play()
    task.delay(10, function()
        HurtOverlay.Visible = false
    end)
end

local function UpdateGui(currentHealth, humanoid)
    if not humanoid then return end
    
    local healthPercent = currentHealth / humanoid.MaxHealth
    
    -- 修正資產切換：正常 vs 低生命值 (<= 25%)
    if healthPercent == healthPercent then
        if healthPercent > 0.25 then
            HealthBar.Image = "rbxassetid://35238053" -- 正常生命條
        else
            HealthBar.Image = "rbxassetid://35238036" -- 低生命值（紅色）條
        end
    else
        HealthBar.Image = "rbxassetid://154646431"
    end

    local clampedPercent = math.max(math.min(healthPercent, 1), 0)
    local damageTaken = lastHealth - currentHealth
    lastHealth = currentHealth

    -- 平滑調整生命條尺寸
    local sizeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local sizeTween = TweenService:Create(HealthBar, sizeTweenInfo, {
        Size = UDim2.new(clampedPercent, 0, 1, 0)
    })
    sizeTween:Play()

    -- 僅在受到的實際傷害 >= 最大生命值的 5% 時觸發受傷特效
    if damageTaken > 0 and (humanoid.MaxHealth * 0.05 <= damageTaken) then
        AnimateHurtOverlay()
    end
end

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    -- 在生成時乾淨地初始化追蹤變數
    lastHealth = humanoid.Health
    UpdateGui(humanoid.Health, humanoid)

    if healthConn then healthConn:Disconnect() end
    if diedConn then diedConn:Disconnect() end

    healthConn = humanoid.HealthChanged:Connect(function(health)
        UpdateGui(health, humanoid)
    end)

    diedConn = humanoid.Died:Connect(function()
        UpdateGui(0, humanoid)
    end)
end

if LocalPlayer.Character then
    task.spawn(function()
        setupCharacter(LocalPlayer.Character)
    end)
end

charConn = LocalPlayer.CharacterAdded:Connect(function(character)
    setupCharacter(character)
end)

print("經典生命值條載入成功！")

getgenv().LegacySettings = ({
    Year = 2013, -- only 2012 to 2016 allowed (if unavailable, it will be set to 2016 by default)
    OldGraphics = false, -- changes graphics to be more like the 2016 graphics
    HideDisplayName = true, -- changes other users nametags to show their username instead of display name
    SafeChat = false, -- adds the safechat button, only works on 2012, 2013 and 2014
    OldConsole = true, -- adds the old developer console back
    OldBubbleChat = true, -- makes the bubble chat style like the 2016 one
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/yeku/legacy/refs/heads/main/Source.luau"))() ]],
	Topbar_2012         = [[ -- 2012 年對話氣泡 - 完整腳本
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

-- 停用 Roblox 預設對話設定
pcall(function()
	TextChatService.BubbleChatConfiguration.Enabled = false
end)
pcall(function()
	Chat:SetBubbleChatEnabled(false)
end)

local ZOOM_THRESHOLD = 52 -- 觸發第二階段（"..."）的距離（Studs）
local MAX_VISIBILITY_DISTANCE = 75 -- 氣泡消失前的最大顯示距離
local BUBBLE_LIFETIME = 20 -- 氣泡持續時間：20 秒

local lastProcessedMessages = {}

local function createClassicBubble(head, messageText)
	if not head or not head:IsA("BasePart") then return end
	
	-- 清除頭部上的舊自訂氣泡實體
	for _, child in ipairs(head:GetChildren()) do
		if child.Name == "ClassicBubbleGui" then
			child:Destroy()
		end
	end
	
	local classicFont = Font.new(
		"rbxasset://fonts/families/Arial.json",
		Enum.FontWeight.Regular,
		Enum.FontStyle.Normal
	)
	local fontSize = 20
	local maxTextWidth = 220 
	
	-- 計算文字範圍尺寸
	local absoluteTextSize = TextService:GetTextSize(
		messageText, 
		fontSize, 
		Enum.Font.Arial, 
		Vector2.new(maxTextWidth, 1000)
	)
	
	-- 動態氣泡尺寸
	local normalWidth = math.clamp(absoluteTextSize.X + 24, 42, maxTextWidth + 24)
	local normalHeight = absoluteTextSize.Y + 24 
	local tailHeight = 19
	local tailWidth = 16

	-- 第二階段（"..."）氣泡尺寸
	local smallWidth = 52
	local smallHeight = 38

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ClassicBubbleGui"
	billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
	billboard.Adornee = head
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.SizeOffset = Vector2.new(0, 0.5)
	billboard.AlwaysOnTop = false
	billboard.MaxDistance = MAX_VISIBILITY_DISTANCE
	billboard.ZIndexBehavior = Enum.ZIndexBehavior.Global

	-- 氣泡主體
	local bubbleBody = Instance.new("ImageLabel")
	bubbleBody.Name = "BubbleBody"
	bubbleBody.Image = "rbxassetid://2582470061"
	bubbleBody.BackgroundTransparency = 1
	bubbleBody.ScaleType = Enum.ScaleType.Slice
	bubbleBody.SliceCenter = Rect.new(29, 29, 67, 67)
	bubbleBody.SliceScale = 0.4
	bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight) 
	bubbleBody.ZIndex = 2
	bubbleBody.Parent = billboard

	-- 氣泡尾巴圖像（下移 1 像素至 normalHeight - 6）
	local bubbleTail = Instance.new("ImageLabel")
	bubbleTail.Name = "BubbleTail"
	bubbleTail.Size = UDim2.new(0, tailWidth, 0, tailHeight)
	bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
	bubbleTail.BackgroundTransparency = 1
	bubbleTail.Image = "rbxassetid://2582470060"
	bubbleTail.ZIndex = 4
	bubbleTail.Parent = billboard

	-- 白色連接框
	local connectorBox = Instance.new("Frame")
	connectorBox.Name = "ConnectorBox"
	connectorBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	connectorBox.BorderSizePixel = 0
	connectorBox.ZIndex = 3
	connectorBox.Size = UDim2.new(0, 10, 0, 6)
	connectorBox.Position = UDim2.new(0.5, -5, 0, -4)
	connectorBox.Parent = bubbleTail

	-- 對話文字標籤
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
	textLabel.Position = UDim2.new(0, 8, 0, 12)
	textLabel.BackgroundTransparency = 1
	textLabel.FontFace = classicFont
	textLabel.TextSize = fontSize
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.TextWrapped = true
	textLabel.Text = messageText
	textLabel.ZIndex = 10
	textLabel.Parent = billboard
	
	billboard.Parent = head

	local renderConnection
	renderConnection = RunService.RenderStepped:Connect(function()
		if not billboard or not billboard.Parent or not workspace.CurrentCamera then
			if renderConnection then renderConnection:Disconnect() end
			return
		end
		
		local camPos = workspace.CurrentCamera.CFrame.Position
		local distance = (camPos - head.Position).Magnitude
		
		if distance > ZOOM_THRESHOLD then
			textLabel.Text = "..."
			textLabel.Size = UDim2.new(1, -16, 0, 20)
			textLabel.Position = UDim2.new(0, 8, 0, 9)
			billboard.Size = UDim2.new(0, smallWidth, 0, smallHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, smallHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, smallHeight - 6)
		else
			textLabel.Text = messageText
			textLabel.Size = UDim2.new(1, -16, 0, absoluteTextSize.Y)
			textLabel.Position = UDim2.new(0, 8, 0, 12)
			billboard.Size = UDim2.new(0, normalWidth, 0, normalHeight + tailHeight)
			bubbleBody.Size = UDim2.new(1, 0, 0, normalHeight)
			bubbleTail.Position = UDim2.new(0.5, -tailWidth / 2, 0, normalHeight - 6)
		end
	end)
	
	task.delay(BUBBLE_LIFETIME, function()
		if renderConnection then renderConnection:Disconnect() end
		if billboard and billboard.Parent then
			billboard:Destroy()
		end
	end)
end

local function handleBubbleSpawn(player, text)
	if not player or not text or text == "" then return end

	local msgKey = player.UserId .. ":" .. text
	if lastProcessedMessages[msgKey] then return end
	lastProcessedMessages[msgKey] = true
	task.delay(0.05, function() lastProcessedMessages[msgKey] = nil end)

	local character = player.Character
	if character then
		local head = character:FindFirstChild("Head")
		if head then
			createClassicBubble(head, text)
		end
	end
end

-- 即時事件觸發器
local function trackPlayer(player)
	player.Chatted:Connect(function(msg)
		handleBubbleSpawn(player, msg)
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	trackPlayer(p)
end
Players.PlayerAdded:Connect(trackPlayer)

TextChatService.MessageReceived:Connect(function(message)
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		handleBubbleSpawn(player, message)
	end
end)

Chat.Chatted:Connect(function(part, message)
	if part and part:IsA("BasePart") then
		local player = Players:GetPlayerFromCharacter(part.Parent) or Players:GetPlayerFromCharacter(part)
		if player then
			handleBubbleSpawn(player, message)
		end
	end
end)

-- 背景清理 Roblox 預設氣泡
if LocalPlayer then
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 2)
	if playerGui then
		playerGui.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("BillboardGui") and descendant.Name ~= "ClassicBubbleGui" then
				descendant:Destroy()
			end
		end)
	end
end



-- 2012/2013 年生命值條腳本
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- 預載資產
ContentProvider:PreloadAsync({
    "rbxassetid://35238053",
    "rbxassetid://35238036",
    "rbxassetid://154646431",
    "rbxassetid://34854607"
})

-- 清理舊有 GUI（若存在）
if CoreGui:FindFirstChild("CustomHealthGui") then
    CoreGui.CustomHealthGui:Destroy()
end

-- 建立 ScreenGui 容器
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomHealthGui"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 建立受傷遮罩特效
local HurtOverlay = Instance.new("ImageLabel")
HurtOverlay.Name = "HurtOverlay"
HurtOverlay.BackgroundTransparency = 1
HurtOverlay.Image = "rbxassetid://34854607"
HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
HurtOverlay.Visible = false
HurtOverlay.Parent = ScreenGui

-- 建立生命條外框
local HealthFrame = Instance.new("Frame")
HealthFrame.Name = "HealthFrame"
HealthFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HealthFrame.Position = UDim2.new(0.5, -85, 1, -22)
HealthFrame.Size = UDim2.new(0, 170, 0, 18)
HealthFrame.Parent = ScreenGui

-- 建立生命條圖像
local HealthBar = Instance.new("ImageLabel")
HealthBar.Name = "HealthBar"
HealthBar.BackgroundTransparency = 1
HealthBar.Image = "rbxassetid://35238053"
HealthBar.Size = UDim2.new(1, 0, 1, 0)
HealthBar.Parent = HealthFrame

-- 建立生命值文字標籤
local HealthLabel = Instance.new("TextLabel")
HealthLabel.Name = "HealthLabel"
HealthLabel.Text = "Health  "
HealthLabel.Font = Enum.Font.SourceSansBold
HealthLabel.TextSize = 14
HealthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthLabel.TextStrokeTransparency = 0
HealthLabel.TextXAlignment = Enum.TextXAlignment.Right
HealthLabel.BackgroundTransparency = 1
HealthLabel.Size = UDim2.new(1, 0, 1, 0)
HealthLabel.Parent = HealthFrame

local lastHealth = 100
local healthConn, diedConn, charConn

local function AnimateHurtOverlay()
    -- Reset to normal screen bounds before expanding outward
    HurtOverlay.Size = UDim2.new(1, 0, 1, 0)
    HurtOverlay.Position = UDim2.new(0, 0, 0, 0)
    HurtOverlay.Visible = true

    local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(HurtOverlay, tweenInfo, {
        Size = UDim2.new(20, 0, 20, 0),
        Position = UDim2.new(-10, 0, -10, 0)
    })
    
    tween:Play()
    task.delay(10, function()
        HurtOverlay.Visible = false
    end)
end

local function UpdateGui(currentHealth, humanoid)
    if not humanoid then return end
    
    local healthPercent = currentHealth / humanoid.MaxHealth
    
    -- 修正資產切換：正常 vs 低生命值 (<= 25%)
    if healthPercent == healthPercent then
        if healthPercent > 0.25 then
            HealthBar.Image = "rbxassetid://35238053" -- 正常生命條
        else
            HealthBar.Image = "rbxassetid://35238036" -- 低生命值（紅色）條
        end
    else
        HealthBar.Image = "rbxassetid://154646431"
    end

    local clampedPercent = math.max(math.min(healthPercent, 1), 0)
    local damageTaken = lastHealth - currentHealth
    lastHealth = currentHealth

    -- 平滑調整生命條尺寸
    local sizeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local sizeTween = TweenService:Create(HealthBar, sizeTweenInfo, {
        Size = UDim2.new(clampedPercent, 0, 1, 0)
    })
    sizeTween:Play()

    -- 僅在受到的實際傷害 >= 最大生命值的 5% 時觸發受傷特效
    if damageTaken > 0 and (humanoid.MaxHealth * 0.05 <= damageTaken) then
        AnimateHurtOverlay()
    end
end

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    -- 在生成時乾淨地初始化追蹤變數
    lastHealth = humanoid.Health
    UpdateGui(humanoid.Health, humanoid)

    if healthConn then healthConn:Disconnect() end
    if diedConn then diedConn:Disconnect() end

    healthConn = humanoid.HealthChanged:Connect(function(health)
        UpdateGui(health, humanoid)
    end)

    diedConn = humanoid.Died:Connect(function()
        UpdateGui(0, humanoid)
    end)
end

if LocalPlayer.Character then
    task.spawn(function()
        setupCharacter(LocalPlayer.Character)
    end)
end

charConn = LocalPlayer.CharacterAdded:Connect(function(character)
    setupCharacter(character)
end)

print("經典生命值條載入成功！")

getgenv().LegacySettings = ({
    Year = 2012, -- only 2012 to 2016 allowed (if unavailable, it will be set to 2016 by default)
    OldGraphics = false, -- changes graphics to be more like the 2016 graphics
    HideDisplayName = true, -- changes other users nametags to show their username instead of display name
    SafeChat = false, -- adds the safechat button, only works on 2012, 2013 and 2014
    OldConsole = true, -- adds the old developer console back
    OldBubbleChat = true, -- makes the bubble chat style like the 2016 one
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/yeku/legacy/refs/heads/main/Source.luau"))()  ]],
	Topbar_2010         = [[ if _G.CustomHealthESP_Connections then
	for _, conn in pairs(_G.CustomHealthESP_Connections) do
		conn:Disconnect()
	end
end
_G.CustomHealthESP_Connections = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Chat
pcall(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end)

pcall(function()
	local ChatService = game:GetService("Chat")
	ChatService.BubbleChatEnabled = false
end)

if TextChatService then
	pcall(function()
		TextChatService.ChatWindowConfiguration.Enabled = false
		TextChatService.ChatInputBarConfiguration.Enabled = false
		
		local bConfig = TextChatService.BubbleChatConfiguration
		bConfig.Enabled = false
		bConfig.MaxDistance = 0
		bConfig.VerticalStudsOffset = -9999
		bConfig.BackgroundTransparency = 1
		bConfig.TextTransparency = 1
		
		bConfig:GetPropertyChangedSignal("Enabled"):Connect(function()
			bConfig.Enabled = false
		end)
	end)
end

-- Disable legacy player script bubble module if present
if LocalPlayer then
	local pScripts = LocalPlayer:FindFirstChild("PlayerScripts")
	if pScripts then
		local chatScript = pScripts:FindFirstChild("ChatScript")
		if chatScript then
			local bubbleScript = chatScript:FindFirstChild("BubbleChat")
			if bubbleScript then
				bubbleScript.Disabled = true
				bubbleScript:Destroy()
			end
		end
	end
end

-- Deep purge function targeting workspace heads, PlayerGui, and CoreGui
local function purgeNativeBubbles()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			for _, part in ipairs(p.Character:GetChildren()) do
				if part:IsA("BasePart") then
					for _, item in ipairs(part:GetChildren()) do
						if item:IsA("BillboardGui") and item.Name ~= "ClassicBubbleGui" and item.Name ~= "CustomExecutorHealth" then
							item.Enabled = false
							item:Destroy()
						end
					end
				end
			end
		end
		
		local pGui = p:FindFirstChildOfClass("PlayerGui")
		if pGui then
			for _, child in ipairs(pGui:GetChildren()) do
				if child.Name:lower():find("bubble") then
					child:Destroy()
				end
			end
		end
	end

	pcall(function()
		local expChat = CoreGui:FindFirstChild("ExperienceChat") or CoreGui:FindFirstChild("BubbleChat")
		if expChat then
			for _, desc in ipairs(expChat:GetDescendants()) do
				if desc:IsA("BillboardGui") and desc.Name ~= "ClassicBubbleGui" then
					desc.Enabled = false
					desc:Destroy()
				end
			end
		end
	end)
end

purgeNativeBubbles()

-- Continuous background task to ensure standard engine chat bubbles never spawn
local nativeBubblePurgeConn = RunService.RenderStepped:Connect(function()
	purgeNativeBubbles()
end)
table.insert(_G.CustomHealthESP_Connections, nativeBubblePurgeConn)

-- [INSTANCE CREATION] Custom Health ESP Setup
local healthBase = Instance.new("BillboardGui")
healthBase.Name = "CustomExecutorHealth"
healthBase.AlwaysOnTop = true
healthBase.DistanceUpperLimit = -1
healthBase.MaxDistance = math.huge
healthBase.Size = UDim2.new(0, 96, 0, 24)
healthBase.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)
healthBase.ResetOnSpawn = true

local playerName = Instance.new("TextLabel")
playerName.Name = "PlayerName"
playerName.AnchorPoint = Vector2.new(0.5, 0.75)
playerName.BackgroundTransparency = 1
playerName.Font = Enum.Font.SourceSans
playerName.Position = UDim2.new(0.5, 0, 0, 0)
playerName.Size = UDim2.new(10, 0, 1, 0)
playerName.TextScaled = true
playerName.TextSize = 24
playerName.TextStrokeTransparency = 0
playerName.TextColor3 = Color3.new(1, 1, 1)
playerName.TextStrokeColor3 = Color3.new(0, 0, 0)
playerName.TextXAlignment = Enum.TextXAlignment.Center
playerName.TextYAlignment = Enum.TextYAlignment.Top
playerName.Parent = healthBase

local redBar = Instance.new("Frame")
redBar.Name = "RedBar"
redBar.AnchorPoint = Vector2.new(0.5, 0.5)
redBar.BackgroundColor3 = Color3.new(1, 0, 0)
redBar.BorderSizePixel = 0
redBar.Position = UDim2.new(0.5, 0, 0.5, 0)
redBar.Size = UDim2.new(0.6, 0, 0.3, 0)
redBar.Parent = healthBase

local greenBar = Instance.new("Frame")
greenBar.Name = "GreenBar"
greenBar.BackgroundColor3 = Color3.new(0.5058824, 0.7725491, 0.08627451)
greenBar.BorderSizePixel = 0
greenBar.Size = UDim2.new(1, 0, 1, 0)
greenBar.Parent = redBar

local humanoids = {}

local function isFinite(num)
	return num == num and num ~= -1/0 and num ~= 1/0
end

local function setupHumanoid(h)
	local updateCon = nil
	local currentHealth = nil

	local function onAncestryChanged()
		if updateCon then
			updateCon:Disconnect()
			updateCon = nil
		end

		if currentHealth then
			currentHealth:Destroy()
			currentHealth = nil
		end

		local char = h.Parent

		if char then
			task.spawn(function()
				while not char:FindFirstChild("Head") do
					if h.Parent ~= char then 
						break 
					end
					char.ChildAdded:Wait()
				end

				local head = char:FindFirstChild("Head")

				if head then
					local health = healthBase:Clone()
					local pName = health:WaitForChild("PlayerName")
					local rBar = health:WaitForChild("RedBar")
					local gBar = rBar:WaitForChild("GreenBar")
					
					local hPlayer = Players:GetPlayerFromCharacter(char)
					pName.Text = char.Name
					health.Adornee = head
					if hPlayer then
						health.PlayerToHideFrom = hPlayer
					end
					health.Parent = head
					
					local function update()
						if not head or not head.Parent then return end
						
						local dist = (Camera.CFrame.Position - head.Position).Magnitude
						local fontSize = 12

						if dist < 20 then
							fontSize = 24
						elseif dist < 50 then
							fontSize = 18
						end

						local ratio = h.Health / h.MaxHealth
						rBar.Visible = isFinite(ratio)
						rBar.BackgroundTransparency = math.floor(ratio)
						rBar.Size = UDim2.new(0, fontSize * 4, 0, fontSize / 2)
						gBar.Size = UDim2.new(ratio, 0, 1, 0)

						local width = fontSize * 4
						health.Size = UDim2.new(0, width, 0, fontSize)
						health.Enabled = (dist <= 100 and head.Transparency < 1)
						health.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)

						if hPlayer and Teams:FindFirstChildOfClass("Team") then
							pName.TextColor3 = hPlayer.TeamColor.Color
						else
							pName.TextColor3 = Color3.new(1, 1, 1)
						end

						local overWriter = char:FindFirstChild("NameOverwrite")
						if overWriter and overWriter:IsA("StringValue") then
							pName.Text = overWriter.Value
						else
							pName.Text = char.Name
						end
					end

					updateCon = RunService.RenderStepped:Connect(update)
					table.insert(_G.CustomHealthESP_Connections, updateCon)
					currentHealth = health
					h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
			end)
		end
	end

	onAncestryChanged()
	local ancConn = h.AncestryChanged:Connect(onAncestryChanged)
	table.insert(_G.CustomHealthESP_Connections, ancConn)
end

for _, desc in pairs(Workspace:GetDescendants()) do
	if desc:IsA("Humanoid") then
		humanoids[desc] = true
	end
end

for h in pairs(humanoids) do
	humanoids[h] = true
	task.spawn(function()
		setupHumanoid(h)
	end)
end

local function onDescendantAdded(child)
	if child:IsA("Humanoid") then
		humanoids[child] = true
		setupHumanoid(child)
	end
end

local descConn = Workspace.DescendantAdded:Connect(onDescendantAdded)
table.insert(_G.CustomHealthESP_Connections, descConn)

-- Disable TopBarApp if accessible
pcall(function()
	CoreGui.TopBarApp.TopBarApp.Enabled = false
end)

local parentTarget = (gethui and gethui()) or CoreGui

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingGui"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true

local success = pcall(function()
	LoadingGui.Parent = parentTarget
end)

if not success or not LoadingGui.Parent then
	LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 1. Position Camera to view the map
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.new(Vector3.new(0, 30, 80), Vector3.new(0, 10, 0))

-- Hide touch controls during loading
local touchGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("TouchGui")
if touchGui then
	touchGui.Enabled = false
end

-- 2. Collect map parts and store their original Transparency
local mapParts = {}
for _, obj in ipairs(Workspace:GetDescendants()) do
	if obj:IsA("BasePart") and obj.Parent ~= LocalPlayer.Character and not obj:IsDescendantOf(LocalPlayer.Character) then
		table.insert(mapParts, {
			Part = obj,
			OriginalTransparency = obj.Transparency
		})
		obj.Transparency = 1
	end
end

local font = Font.new(
	"rbxasset://fonts/families/Arial.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal
)

-- Connecting Box
local ConnectingFrame = Instance.new("Frame")
ConnectingFrame.Name = "ConnectingFrame"
ConnectingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ConnectingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ConnectingFrame.Size = UDim2.new(0, 500, 0, 160)
ConnectingFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
ConnectingFrame.BackgroundTransparency = 0.5
ConnectingFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
ConnectingFrame.BorderSizePixel = 1
ConnectingFrame.Parent = LoadingGui

local ConnectingText = Instance.new("TextLabel")
ConnectingText.Name = "ConnectingText"
ConnectingText.Size = UDim2.new(1, 0, 1, 0)
ConnectingText.BackgroundTransparency = 1
ConnectingText.FontFace = font
ConnectingText.TextSize = 22
ConnectingText.TextColor3 = Color3.fromRGB(255, 255, 255)
ConnectingText.Text = "正在連線至伺服器..."
ConnectingText.Parent = ConnectingFrame

task.wait(2)

ConnectingFrame:Destroy()

-- Stats Box
local StatsFrame = Instance.new("Frame")
StatsFrame.Name = "StatsFrame"
StatsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
StatsFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
StatsFrame.Size = UDim2.new(0, 500, 0, 160)
StatsFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
StatsFrame.BackgroundTransparency = 0.5
StatsFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
StatsFrame.BorderSizePixel = 3
StatsFrame.Parent = LoadingGui

local StatsText = Instance.new("TextLabel")
StatsText.Name = "StatsText"
StatsText.Size = UDim2.new(1, 0, 1, 0)
StatsText.BackgroundTransparency = 1
StatsText.FontFace = font
StatsText.TextSize = 20
StatsText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsText.Text = "磚塊：0   連接數：0"
StatsText.Parent = StatsFrame

-- 3. Gradually restore original transparency as count increases
local totalBricks = #mapParts
local targetConnectors = #Players:GetPlayers()
local steps = 30
local partsPerStep = math.ceil(totalBricks / steps)
local currentIndex = 1

for i = 1, steps do
	local currentBricks = math.floor((totalBricks / steps) * i)
	local currentConnectors = math.floor((targetConnectors / steps) * i)
	
	for j = 1, partsPerStep do
		if mapParts[currentIndex] then
			local data = mapParts[currentIndex]
			data.Part.Transparency = data.OriginalTransparency
			currentIndex = currentIndex + 1
		end
	end
	
	StatsText.Text = "Bricks: " .. tostring(currentBricks) .. "   Connectors: " .. tostring(currentConnectors)
	task.wait(0.05)
end

for _, data in ipairs(mapParts) do
	data.Part.Transparency = data.OriginalTransparency
end

StatsText.Text = "Bricks: " .. tostring(totalBricks) .. "   Connectors: " .. tostring(targetConnectors)

task.wait(1.5)

Camera.CameraType = Enum.CameraType.Custom
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
	Camera.CameraSubject = LocalPlayer.Character.Humanoid
end

if touchGui then
	touchGui.Enabled = true
end

LoadingGui:Destroy()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Classic2010Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = parentTarget

-- AUTONOMIC UI SCALING
local uiScale = Instance.new("UIScale")
uiScale.Parent = ScreenGui

local function updateUIScale()
	local viewport = Camera.ViewportSize
	if viewport.Y < 800 or viewport.X < 1200 then
		uiScale.Scale = math.clamp(viewport.Y / 900, 0.55, 1)
	else
		uiScale.Scale = 1
	end
end
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateUIScale)
updateUIScale()

-- TOPBAR
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 23)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(144,144,144)
TopBar.BackgroundTransparency = 1
TopBar.Parent = ScreenGui

local function createTopButton(name, text, positionX, isWhiteText)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 100, 0, 20)
	btn.Position = UDim2.new(0, positionX, 0, 1) 
	btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
	btn.BackgroundTransparency = 0.4
	btn.BorderSizePixel = 0
	btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
	btn.Text = text
	
	if isWhiteText then
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextTransparency = 0.75
	else
		btn.TextColor3 = Color3.fromRGB(0,0,0)
		btn.TextTransparency = 0.65
	end
	
	btn.Font = Enum.Font.ArialBold
	btn.TextSize = 14
	btn.Parent = TopBar
	return btn
end

createTopButton("ToolsBtn", "Tools", 0, true)
createTopButton("InsertBtn", "Insert", 100, true)
createTopButton("FullscreenBtn", "Fullscreen", 200, false)
createTopButton("HelpBtn", "Help...", 300, false)
createTopButton("ExitBtn", "Exit", 400, false)

-- PLAYERLIST
local PlayerList = Instance.new("Frame")
PlayerList.Name = "ClassicPlayerList"
PlayerList.AnchorPoint = Vector2.new(1, 0)
PlayerList.Size = UDim2.new(0, 265, 0, 180)
PlayerList.Position = UDim2.new(1, -15, 0, 32) 
PlayerList.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
PlayerList.BackgroundTransparency = 0.6
PlayerList.BorderSizePixel = 0 
local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 4)
ListPadding.PaddingLeft = UDim.new(0, 8)
ListPadding.PaddingRight = UDim.new(0, 8)
ListPadding.Parent = PlayerList
PlayerList.Parent = ScreenGui

local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 22)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = PlayerList

local ListTitle = Instance.new("TextLabel")
ListTitle.Name = "ListTitle"
ListTitle.BackgroundTransparency = 1
ListTitle.Text = "玩家列表"
ListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ListTitle.TextXAlignment = Enum.TextXAlignment.Left
ListTitle.Font = Enum.Font.ArialBold
ListTitle.TextSize = 14
ListTitle.Parent = HeaderFrame

local StatHeaderContainer = Instance.new("Frame")
StatHeaderContainer.Name = "StatHeaderContainer"
StatHeaderContainer.BackgroundTransparency = 1
StatHeaderContainer.Parent = HeaderFrame

local ListScroll = Instance.new("ScrollingFrame")
ListScroll.Name = "ListScroll"
ListScroll.Size = UDim2.new(1, 0, 1, -30)
ListScroll.Position = UDim2.new(0, 0, 0, 24)
ListScroll.BackgroundTransparency = 1
ListScroll.BorderSizePixel = 0
ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0) 
ListScroll.ScrollBarThickness = 4
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
ListScroll.Parent = PlayerList

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 4)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ListScroll

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ListScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

local CLASSIC_CHAT_COLORS = {
	Color3.fromRGB(227, 42, 53),   
	Color3.fromRGB(33, 147, 226),  
	Color3.fromRGB(24, 171, 71),   
	Color3.fromRGB(147, 95, 207),  
	Color3.fromRGB(216, 121, 46),  
	Color3.fromRGB(247, 203, 34),  
	Color3.fromRGB(235, 172, 193), 
	Color3.fromRGB(199, 178, 142)  
}

local function getClassicNameColor(name)
	local count = 0
	for i = 1, #name do
		count = count + string.byte(name, i)
	end
	return CLASSIC_CHAT_COLORS[(count % #CLASSIC_CHAT_COLORS) + 1]
end

local function getPlayerStatObjects(player)
	local stats = {}
	local statsFolder = player:FindFirstChild("leaderstats")
	if statsFolder then
		for _, stat in ipairs(statsFolder:GetChildren()) do
			if stat:IsA("ValueBase") then
				table.insert(stats, stat)
			end
		end
	end
	return stats
end

local function getActiveStatNames()
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local statsFolder = p:FindFirstChild("leaderstats")
		if statsFolder then
			for _, stat in ipairs(statsFolder:GetChildren()) do
				if stat:IsA("ValueBase") and not table.find(names, stat.Name) then
					table.insert(names, stat.Name)
				end
			end
		end
	end
	return names
end

local function resizeLeaderboardLayout(statCount)
	local baseWidth = 180 
	local statColumnWidth = 75 
	local calculatedTotalWidth = baseWidth + (statCount * statColumnWidth)
	
	PlayerList.Size = UDim2.new(0, calculatedTotalWidth, 0, 180)
	
	local nameRatio = baseWidth / calculatedTotalWidth
	local statsRatio = 1 - nameRatio
	
	ListTitle.Size = UDim2.new(nameRatio, 0, 1, 0)
	StatHeaderContainer.Size = UDim2.new(statsRatio, 0, 1, 0)
	StatHeaderContainer.Position = UDim2.new(nameRatio, 0, 0, 0)
	
	return nameRatio, statsRatio
end

local function updateHeaderTitles()
	local activeStats = getActiveStatNames()
	local statCount = #activeStats
	local nameRatio, statsRatio = resizeLeaderboardLayout(statCount)
	local existingHeaders = StatHeaderContainer:GetChildren()
	
	if #existingHeaders ~= statCount then
		for _, child in ipairs(existingHeaders) do child:Destroy() end
		if statCount == 0 then return end
		
		local columnWidth = 1 / statCount
		for i, statName in ipairs(activeStats) do
			local label = Instance.new("TextLabel")
			label.Name = statName
			label.Size = UDim2.new(columnWidth, 0, 1, 0)
			label.Position = UDim2.new((i - 1) * columnWidth, 0, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = statName
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextXAlignment = Enum.TextXAlignment.Center
			label.Font = Enum.Font.ArialBold
			label.TextSize = 14
			label.Parent = StatHeaderContainer
		end
	end
end

local function createOrUpdateRow(rowKey, labelText, statValuesList, textColor, isHeader, paddingSpaces, layoutOrder)
	local rowFrame = ListScroll:FindFirstChild(rowKey)
	local activeStats = getActiveStatNames()
	local statCount = #activeStats
	
	local baseWidth = 180
	local statColumnWidth = 75
	local totalWidth = baseWidth + (statCount * statColumnWidth)
	local nameRatio = baseWidth / totalWidth
	local statsRatio = 1 - nameRatio
	local columnWidth = statCount > 0 and (1 / statCount) or 1
	
	if not rowFrame then
		rowFrame = Instance.new("Frame")
		rowFrame.Name = rowKey
		rowFrame.Size = UDim2.new(1, -5, 0, 18)
		rowFrame.BackgroundTransparency = 1
		
		local leftLabel = Instance.new("TextLabel")
		leftLabel.Name = "LeftLabel"
		leftLabel.BackgroundTransparency = 1
		leftLabel.Font = Enum.Font.ArialBold
		leftLabel.TextXAlignment = Enum.TextXAlignment.Left
		leftLabel.Parent = rowFrame
		
		local statContainer = Instance.new("Frame")
		statContainer.Name = "StatContainer"
		statContainer.BackgroundTransparency = 1
		statContainer.Parent = rowFrame
		
		local underline = Instance.new("Frame")
		underline.Name = "Underline"
		underline.Size = UDim2.new(1, 0, 0, 1)
		underline.Position = UDim2.new(0, 0, 1, -1)
		underline.BorderSizePixel = 0
		underline.Parent = rowFrame
		
		rowFrame.Parent = ListScroll
	end
	
	rowFrame.LayoutOrder = layoutOrder
	
	local leftLabel = rowFrame.LeftLabel
	leftLabel.Size = UDim2.new(nameRatio, 0, 1, 0)
	leftLabel.Text = (paddingSpaces or "") .. labelText
	leftLabel.TextSize = isHeader and 12 or 14
	leftLabel.TextColor3 = textColor
	
	local statContainer = rowFrame.StatContainer
	statContainer.Size = UDim2.new(statsRatio, 0, 1, 0)
	statContainer.Position = UDim2.new(nameRatio, 0, 0, 0)
	
	local underline = rowFrame.Underline
	if isHeader then
		underline.Visible = true
		underline.BackgroundColor3 = textColor
	else
		underline.Visible = false
	end
	
	for i, statName in ipairs(activeStats) do
		local statLabel = statContainer:FindFirstChild(statName)
		if not statLabel then
			statLabel = Instance.new("TextLabel")
			statLabel.Name = statName
			statLabel.BackgroundTransparency = 1
			statLabel.Font = Enum.Font.ArialBold
			statLabel.TextXAlignment = Enum.TextXAlignment.Center
			statLabel.Parent = statContainer
		end
		
		statLabel.Size = UDim2.new(columnWidth, 0, 1, 0)
		statLabel.Position = UDim2.new((i - 1) * columnWidth, 0, 0, 0)
		statLabel.TextSize = isHeader and 16 or 18
		statLabel.TextColor3 = textColor
		
		local valueText = ""
		if statValuesList and statValuesList[statName] then
			valueText = tostring(statValuesList[statName])
		end
		statLabel.Text = valueText
	end
	
	for _, child in ipairs(statContainer:GetChildren()) do
		if not table.find(activeStats, child.Name) then
			child:Destroy()
		end
	end
end

local function updatePlayerList()
	updateHeaderTitles()
	
	local currentTeams = Teams:GetTeams()
	local playersMapped = {}
	local activeStats = getActiveStatNames()
	local orderIndex = 1
	local activeKeys = {}
	
	if #currentTeams > 0 then
		for _, team in ipairs(currentTeams) do
			local teamPlayers = team:GetPlayers()
			if #teamPlayers > 0 then
				local teamScores = {}
				for _, statName in ipairs(activeStats) do teamScores[statName] = 0 end
				
				for _, p in ipairs(teamPlayers) do
					local pStats = getPlayerStatObjects(p)
					for _, stat in ipairs(pStats) do
						if (stat:IsA("IntValue") or stat:IsA("NumberValue")) and teamScores[stat.Name] then
							teamScores[stat.Name] = teamScores[stat.Name] + stat.Value
						end
					end
				end
				
				local teamKey = "Team_" .. team.Name
				table.insert(activeKeys, teamKey)
				createOrUpdateRow(teamKey, team.Name, teamScores, team.TeamColor.Color, true, "", orderIndex)
				orderIndex = orderIndex + 1
				
				for _, p in ipairs(teamPlayers) do
					playersMapped[p] = true
					local pStats = getPlayerStatObjects(p)
					local playerStatMap = {}
					for _, stat in ipairs(pStats) do playerStatMap[stat.Name] = stat.Value end
					
					local playerKey = "Player_" .. p.Name
					table.insert(activeKeys, playerKey)
					createOrUpdateRow(playerKey, p.Name, playerStatMap, team.TeamColor.Color, false, "   ", orderIndex)
					orderIndex = orderIndex + 1
				end
			end
		end
	end
	
	local neutralHeaderCreated = false
	for _, p in ipairs(Players:GetPlayers()) do
		if not playersMapped[p] then
			if #currentTeams > 0 and not neutralHeaderCreated then
				neutralHeaderCreated = true
				local neutralKey = "Team_Neutral"
				table.insert(activeKeys, neutralKey)
				createOrUpdateRow(neutralKey, "Neutral", {}, Color3.fromRGB(230, 230, 230), true, "", orderIndex)
				orderIndex = orderIndex + 1
			end
			
			local rowColor = getClassicNameColor(p.Name)
			local padding = neutralHeaderCreated and "   " or ""
			local pStats = getPlayerStatObjects(p)
			local playerStatMap = {}
			for _, stat in ipairs(pStats) do playerStatMap[stat.Name] = stat.Value end
			
			local playerKey = "Player_" .. p.Name
			table.insert(activeKeys, playerKey)
			createOrUpdateRow(playerKey, p.Name, playerStatMap, rowColor, false, padding, orderIndex)
			orderIndex = orderIndex + 1
		end
	end
	
	for _, child in ipairs(ListScroll:GetChildren()) do
		if (child:IsA("Frame") or child:IsA("TextLabel")) and not table.find(activeKeys, child.Name) then
			child:Destroy()
		end
	end
end

local lastUpdate = 0
local updatePending = false

local function requestListUpdate()
	if updatePending then return end
	local now = os.clock()
	if now - lastUpdate >= 1.5 then
		lastUpdate = now
		updatePlayerList()
	else
		updatePending = true
		task.delay(1.5 - (now - lastUpdate), function()
			updatePending = false
			lastUpdate = os.clock()
			updatePlayerList()
		end)
	end
end

local function connectPlayerStats(p)
	local function hookLeaderstats(folder)
		if folder.Name == "leaderstats" then
			requestListUpdate()
			
			local function listenToStat(val)
				if val:IsA("ValueBase") then
					val.Changed:Connect(function(newValue)
						local playerKey = "Player_" .. p.Name
						local rowFrame = ListScroll:FindFirstChild(playerKey)
						if rowFrame then
							local statContainer = rowFrame:FindFirstChild("StatContainer")
							local statLabel = statContainer and statContainer:FindFirstChild(val.Name)
							if statLabel then
								statLabel.Text = tostring(newValue)
							end
						end
					end)
				end
			end

			folder.ChildAdded:Connect(function(val)
				listenToStat(val)
				requestListUpdate()
			end)
			
			for _, val in ipairs(folder:GetChildren()) do
				listenToStat(val)
			end
		end
	end
	
	p.ChildAdded:Connect(hookLeaderstats)
	local existingStats = p:FindFirstChild("leaderstats")
	if existingStats then hookLeaderstats(existingStats) end
	p:GetPropertyChangedSignal("Team"):Connect(requestListUpdate)
end

Players.PlayerAdded:Connect(function(p)
	connectPlayerStats(p)
	requestListUpdate()
end)
Players.PlayerRemoving:Connect(requestListUpdate)
Teams.ChildAdded:Connect(requestListUpdate)
Teams.ChildRemoved:Connect(requestListUpdate) 

for _, p in ipairs(Players:GetPlayers()) do 
	connectPlayerStats(p) 
end
updatePlayerList()

-- HEALTH BAR
local HealthFrame = Instance.new("Frame")
HealthFrame.Name = "ClassicHealthFrame"
HealthFrame.AnchorPoint = Vector2.new(1, 0.5)
HealthFrame.Size = UDim2.new(0, 14, 0, 200)
HealthFrame.Position = UDim2.new(1, -20, 0.5, 0)
HealthFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
HealthFrame.BorderSizePixel = 0
HealthFrame.Parent = ScreenGui

local HealthBar = Instance.new("Frame")
HealthBar.Name = "Bar"
HealthBar.Size = UDim2.new(1, 0, 1, 0)
HealthBar.Position = UDim2.new(0, 0, 0, 0)
HealthBar.BackgroundColor3 = Color3.new(0.5058824, 0.7725491, 0.08627451)
HealthBar.BorderSizePixel = 0
HealthBar.Parent = HealthFrame

local HealthLabel = Instance.new("TextLabel")
HealthLabel.Size = UDim2.new(0, 50, 0, 15)
HealthLabel.Position = UDim2.new(0, -18, 1, 5)
HealthLabel.BackgroundTransparency = 1
HealthLabel.Text = "Health"
HealthLabel.TextColor3 = Color3.fromRGB(0, 100, 255)
HealthLabel.Font = Enum.Font.ArialBold
HealthLabel.TextSize = 14
HealthLabel.Parent = HealthFrame

local function setupHealthTracking(character)
	local humanoid = character:WaitForChild("Humanoid", 5)
	if humanoid then
		local function updateHealth()
			local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
			HealthBar.Size = UDim2.new(1, 0, healthPercent, 0)
			HealthBar.Position = UDim2.new(0, 0, 1 - healthPercent, 0)
			
			if healthPercent < 0.25 then
				HealthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			else
				HealthBar.BackgroundColor3 = Color3.new(0.5058824, 0.7725491, 0.08627451)
			end
		end
		humanoid.HealthChanged:Connect(updateHealth)
		updateHealth()
	end
end

if LocalPlayer.Character then setupHealthTracking(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupHealthTracking)

-- CHAT SYSTEM
local ChatContainer = ScreenGui:FindFirstChild("ClassicChatLog")
if not ChatContainer then
	ChatContainer = Instance.new("Frame")
	ChatContainer.Name = "ClassicChatLog"
	ChatContainer.Size = UDim2.new(0.4, 0, 0.25, 0)
	ChatContainer.Position = UDim2.new(0, 5, 0, 25) 
	ChatContainer.BackgroundTransparency = 1
	ChatContainer.Parent = ScreenGui 

	local ChatLayout = Instance.new("UIListLayout")
	ChatLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ChatLayout.Padding = UDim.new(0, -3)
	ChatLayout.Parent = ChatContainer
end

local BottomChatBar = Instance.new("Frame")
BottomChatBar.Name = "ClassicBottomChatBar"
BottomChatBar.AnchorPoint = Vector2.new(0, 1)
BottomChatBar.Size = UDim2.new(1, 0, 0, 20)
BottomChatBar.Position = UDim2.new(0, 0, 1, 0)
BottomChatBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BottomChatBar.BorderSizePixel = 0
BottomChatBar.Parent = ScreenGui

local HiddenTextBox = Instance.new("TextBox")
HiddenTextBox.Name = "HiddenTextBox"
HiddenTextBox.Size = UDim2.new(1, -10, 1, 0)
HiddenTextBox.Position = UDim2.new(0, 5, 0, 0)
HiddenTextBox.BackgroundTransparency = 1
HiddenTextBox.Text = ""
HiddenTextBox.TextColor3 = Color3.fromRGB(254, 252, 196)
HiddenTextBox.TextTransparency = 0 
HiddenTextBox.Font = Enum.Font.Arial
HiddenTextBox.TextSize = 13
HiddenTextBox.TextXAlignment = Enum.TextXAlignment.Left
HiddenTextBox.ClearTextOnFocus = true
HiddenTextBox.Parent = BottomChatBar

local ChatPromptLabel = Instance.new("TextLabel")
ChatPromptLabel.Name = "ChatPromptLabel"
ChatPromptLabel.Size = UDim2.new(1, -10, 1, 0)
ChatPromptLabel.Position = UDim2.new(0, 5, 0, 0)
ChatPromptLabel.BackgroundTransparency = 1
ChatPromptLabel.Font = Enum.Font.Arial
ChatPromptLabel.TextSize = 13
ChatPromptLabel.TextColor3 = Color3.fromRGB(254, 252, 196)
ChatPromptLabel.TextXAlignment = Enum.TextXAlignment.Left
ChatPromptLabel.TextYAlignment = Enum.TextYAlignment.Center
ChatPromptLabel.Text = '若要聊天請點擊此處或按下 "/" 鍵'
ChatPromptLabel.Parent = BottomChatBar

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Slash then
		task.wait() 
		HiddenTextBox:CaptureFocus()
	end
end)

HiddenTextBox.Focused:Connect(function()
	ChatPromptLabel.Text = ""
end)

-- Forward declarations for bubble creation and chat logging
local createClassicBubble
local addClassicMessage

HiddenTextBox.FocusLost:Connect(function(enterPressed)
	local text = HiddenTextBox.Text
	if enterPressed and text ~= "" then
		if TextChatService and TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
			if channel then 
				channel:SendAsync(text) 
			end
		else
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			local sayMessageRequest = defaultChatSystemChatEvents and defaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
			if sayMessageRequest then 
				sayMessageRequest:FireServer(text, "All") 
				addClassicMessage(LocalPlayer.Name, text)
				local char = LocalPlayer.Character
				if char and char:FindFirstChild("Head") then
					createClassicBubble(char.Head, text)
				end
			end
		end
	end
	HiddenTextBox.Text = ""
	ChatPromptLabel.Text = '若要聊天請點擊此處或按下 "/" 鍵'
end)

local CLASSIC_COLORS = {
	Color3.fromRGB(227, 42, 53),   
	Color3.fromRGB(33, 147, 226),  
	Color3.fromRGB(24, 171, 71),   
	Color3.fromRGB(147, 95, 207),  
	Color3.fromRGB(216, 121, 46),  
	Color3.fromRGB(247, 203, 34),  
	Color3.fromRGB(235, 172, 193), 
	Color3.fromRGB(199, 178, 142)  
}

local function getChatColor(name)
	local count = 0
	for i = 1, #name do
		count = count + string.byte(name, i)
	end
	return CLASSIC_COLORS[(count % #CLASSIC_COLORS) + 1]
end

addClassicMessage = function(senderName, messageText)
	local currentMessages = ChatContainer:GetChildren()
	local messageFrames = {}
	for _, child in ipairs(currentMessages) do
		if child:IsA("Frame") then
			table.insert(messageFrames, child)
		end
	end
	
	if #messageFrames >= 10 then
		messageFrames[1]:Destroy()
	end

	local nameColor = getChatColor(senderName)
	local colorHex = string.format("#%02X%02X%02X", nameColor.R * 255, nameColor.G * 255, nameColor.B * 255)

	local MsgFrame = Instance.new("Frame")
	MsgFrame.BackgroundColor3 = Color3.fromRGB(154, 154, 154)
	MsgFrame.BackgroundTransparency = 0.45
	MsgFrame.BorderSizePixel = 0
	MsgFrame.AutomaticSize = Enum.AutomaticSize.X 
	MsgFrame.Size = UDim2.new(0, 0, 0, 22)
	MsgFrame.Parent = ChatContainer
	
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 6)
	padding.PaddingRight = UDim.new(0, 6)
	padding.Parent = MsgFrame

	local TextLabel = Instance.new("TextLabel")
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.Arial
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel.RichText = true
	TextLabel.AutomaticSize = Enum.AutomaticSize.X 
	TextLabel.Size = UDim2.new(0, 0, 1, 0)
	TextLabel.Text = string.format('<font color="%s">%s</font>: %s', colorHex, senderName, messageText)
	TextLabel.Parent = MsgFrame
end

local function trackPlayer(player)
	player.Chatted:Connect(function(message)
		addClassicMessage(player.Name, message)
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	trackPlayer(player)
end
Players.PlayerAdded:Connect(trackPlayer)

-- BUBBLE CHAT SYSTEM
createClassicBubble = function(head, messageText)
	if not head or not head:IsA("BasePart") or not messageText or messageText == "" then return end
	
	purgeNativeBubbles()
	
	local oldBubble = head:FindFirstChild("ClassicBubbleGui")
	if oldBubble then oldBubble:Destroy() end
	
	local classicFont = Font.new(
		"rbxasset://fonts/families/Arial.json",
		Enum.FontWeight.Regular,
		Enum.FontStyle.Normal
	)
	local fontSize = 22
	local maxTextWidth = 220 
	
	local absoluteTextSize = TextService:GetTextSize(
		messageText, 
		fontSize, 
		Enum.Font.Arial, 
		Vector2.new(maxTextWidth, 1000)
	)
	
	local width = math.clamp(absoluteTextSize.X + 36, 75, maxTextWidth + 36)
	local height = absoluteTextSize.Y + 24 + 12 
	
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ClassicBubbleGui"
	billboard.Size = UDim2.new(0, width, 0, height)
	billboard.Adornee = head
	billboard.StudsOffset = Vector3.new(0, 3.2, 0)
	billboard.AlwaysOnTop = false
	billboard.MaxDistance = 40
	
	local bubbleBody = Instance.new("ImageLabel")
	bubbleBody.Name = "BubbleBody"
	bubbleBody.Image = "rbxassetid://2582470061"
	bubbleBody.BackgroundTransparency = 1
	bubbleBody.ScaleType = Enum.ScaleType.Slice
	bubbleBody.SliceCenter = Rect.new(29, 29, 67, 67)
	bubbleBody.SliceScale = 0.5
	bubbleBody.Size = UDim2.new(1, 0, 1, -2) 
	bubbleBody.Parent = billboard
	
	local bubbleTail = Instance.new("ImageLabel")
	bubbleTail.Name = "BubbleTail"
	bubbleTail.Size = UDim2.new(0, 16, 0, 12)
	bubbleTail.Position = UDim2.new(0.5, -8, 1, -9.5)
	bubbleTail.BackgroundTransparency = 1
	bubbleTail.Image = "rbxassetid://2582470060"
	bubbleTail.Parent = billboard
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -24, 1, -20)
	textLabel.Position = UDim2.new(0, 12, 0, 10)
	textLabel.BackgroundTransparency = 1
	textLabel.FontFace = classicFont
	textLabel.TextSize = fontSize
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.TextWrapped = true
	textLabel.Text = messageText
	textLabel.Parent = billboard
	
	billboard.Parent = head
	
	task.delay(10, function()
		if billboard and billboard.Parent then
			billboard:Destroy()
		end
	end)
end

local function trackPlayerBubbles(player)
	player.Chatted:Connect(function(message)
		local character = player.Character
		if character then
			local head = character:FindFirstChild("Head")
			if head then
				createClassicBubble(head, message)
			end
		end
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	trackPlayerBubbles(p)
end
Players.PlayerAdded:Connect(trackPlayerBubbles)

-- TextChatService Global Message Listener to safely populate bubbles for all players
if TextChatService and TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
	TextChatService.MessageReceived:Connect(function(textChatMessage)
		if textChatMessage.TextSource then
			local senderPlayer = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)
			if senderPlayer then
				local char = senderPlayer.Character
				if char then
					local head = char:FindFirstChild("Head")
					if head then
						createClassicBubble(head, textChatMessage.Text)
					end
				end
			end
		end
	end)
end

local TopBarRef = ScreenGui:WaitForChild("TopBar", 5)
if TopBarRef then
	local ExitBtn = TopBarRef:WaitForChild("ExitBtn", 5)
	if ExitBtn and ExitBtn:IsA("TextButton") then
		ExitBtn.MouseButton1Click:Connect(function()
			game:Shutdown()
		end)
	end
end

-- RIGHT PALETTE CONTROLS
local RightPalette = Instance.new("Frame")
RightPalette.Name = "RightPalette"
RightPalette.AnchorPoint = Vector2.new(1, 1)
RightPalette.Position = UDim2.new(1, -12, 1, -32)
RightPalette.Size = UDim2.new(0, 48, 0, 124)
RightPalette.BackgroundTransparency = 1
RightPalette.Parent = ScreenGui

local VideoImagePanel = Instance.new("Frame")
VideoImagePanel.Name = "VideoImagePanel"
VideoImagePanel.Position = UDim2.new(0, 0, 0, 36)
VideoImagePanel.Size = UDim2.new(0, 48, 0, 20)
VideoImagePanel.BackgroundTransparency = 1
VideoImagePanel.Parent = RightPalette

local Screenshot = Instance.new("ImageButton")
Screenshot.Name = "Screenshot"
Screenshot.Position = UDim2.new(0.5, -10, 0, 0)
Screenshot.Size = UDim2.new(0, 20, 0, 20)
Screenshot.BackgroundTransparency = 1
Screenshot.Image = "rbxassetid://4456953824"
Screenshot.Parent = VideoImagePanel

local CameraPanel = Instance.new("Frame")
CameraPanel.Name = "CameraPanel"
CameraPanel.Position = UDim2.new(0, 0, 0, 56)
CameraPanel.Size = UDim2.new(0, 48, 0, 48)
CameraPanel.BackgroundTransparency = 1
CameraPanel.Parent = RightPalette

local CameraLeft = Instance.new("Frame")
CameraLeft.Name = "CameraLeft"
CameraLeft.Size = UDim2.new(0, 24, 0, 48)
CameraLeft.BackgroundTransparency = 1
CameraLeft.Parent = CameraPanel

local TiltUp = Instance.new("ImageButton")
TiltUp.Name = "Tilt Up"
TiltUp.Size = UDim2.new(1, 0, 0.5, 0)
TiltUp.BackgroundTransparency = 1
TiltUp.Image = "rbxassetid://598662248"
TiltUp.Parent = CameraLeft

local TiltDown = Instance.new("ImageButton")
TiltDown.Name = "Tilt Down"
TiltDown.Position = UDim2.new(0, 0, 0.5, 0)
TiltDown.Size = UDim2.new(1, 0, 0.5, 0)
TiltDown.BackgroundTransparency = 1
TiltDown.Image = "rbxassetid://598662248"
TiltDown.Rotation = 180
TiltDown.Parent = CameraLeft

local CameraRight = Instance.new("Frame")
CameraRight.Name = "CameraRight"
CameraRight.Position = UDim2.new(0, 24, 0, 0)
CameraRight.Size = UDim2.new(0, 24, 0, 48)
CameraRight.BackgroundTransparency = 1
CameraRight.Parent = CameraPanel

local ZoomIn = Instance.new("ImageButton")
ZoomIn.Name = "Zoom In"
ZoomIn.Size = UDim2.new(1, 0, 0.5, 0)
ZoomIn.BackgroundTransparency = 1
ZoomIn.Image = "rbxassetid://1074548141"
ZoomIn.Parent = CameraRight

local ZoomOut = Instance.new("ImageButton")
ZoomOut.Name = "Zoom Out"
ZoomOut.Position = UDim2.new(0, 0, 0.5, 0)
ZoomOut.Size = UDim2.new(1, 0, 0.5, 0)
ZoomOut.BackgroundTransparency = 1
ZoomOut.Image = "rbxassetid://598665130"
ZoomOut.Parent = CameraRight

local ReportAbuse = Instance.new("ImageButton")
ReportAbuse.Name = "ReportAbuse"
ReportAbuse.Position = UDim2.new(0, 0, 0, -14)
ReportAbuse.Size = UDim2.new(0, 48, 0, 48)
ReportAbuse.BackgroundTransparency = 1
ReportAbuse.Image = "rbxassetid://4539289774"
ReportAbuse.Parent = RightPalette

local STEP_ZOOM = 5
local STEP_TILT = math.rad(5)

ZoomIn.MouseButton1Click:Connect(function()
	if Camera and Camera.CameraMode ~= Enum.CameraMode.LockFirstPerson then
		local currentSubject = Camera.CameraSubject
		if currentSubject then
			LocalPlayer.CameraMinZoomDistance = math.max(0.5, LocalPlayer.CameraMinZoomDistance - STEP_ZOOM)
			LocalPlayer.CameraMaxZoomDistance = math.max(0.5, LocalPlayer.CameraMaxZoomDistance - STEP_ZOOM)
		end
	end
end)

ZoomOut.MouseButton1Click:Connect(function()
	if Camera then
		LocalPlayer.CameraMaxZoomDistance = math.min(400, LocalPlayer.CameraMaxZoomDistance + STEP_ZOOM)
		LocalPlayer.CameraMinZoomDistance = math.min(400, LocalPlayer.CameraMinZoomDistance + STEP_ZOOM)
	end
end)

TiltUp.MouseButton1Click:Connect(function()
	if Camera and Camera.CameraType == Enum.CameraType.Scriptable then
		Camera.CFrame = Camera.CFrame * CFrame.Angles(STEP_TILT, 0, 0)
	elseif Camera then
		Camera.CFrame = Camera.CFrame * CFrame.new(0, 2, 0)
	end
end)

TiltDown.MouseButton1Click:Connect(function()
	if Camera and Camera.CameraType == Enum.CameraType.Scriptable then
		Camera.CFrame = Camera.CFrame * CFrame.Angles(-STEP_TILT, 0, 0)
	elseif Camera then
		Camera.CFrame = Camera.CFrame * CFrame.new(0, -2, 0)
	end
end)

Screenshot.MouseButton1Click:Connect(function()
	StarterGui:SetCore("SendNotification", {
		Title = "經典 Roblox",
		Text = "已觸發截圖操作！",
		Duration = 2
	})
end)

ReportAbuse.MouseButton1Click:Connect(function()
	local GuiService = game:GetService("GuiService")
	pcall(function()
		GuiService:OpenBrowserWindow("https://www.roblox.com/report-abuse")
	end)
end)

-- BACKPACK (Seamless classic style with proper layer order)
local BackpackGui = Instance.new("Frame")
BackpackGui.Name = "ClassicBackpack"
BackpackGui.AnchorPoint = Vector2.new(0, 1)
BackpackGui.Position = UDim2.new(0, 3, 1, -22)
BackpackGui.BackgroundTransparency = 1
BackpackGui.Parent = ScreenGui

local BackpackLayout = Instance.new("UIListLayout")
BackpackLayout.FillDirection = Enum.FillDirection.Horizontal
BackpackLayout.SortOrder = Enum.SortOrder.LayoutOrder
BackpackLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
BackpackLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BackpackLayout.Padding = UDim.new(0, 0)
BackpackLayout.Parent = BackpackGui

local itemSlots = {}
local toolMappings = {} 
local clickDebounce = false
local SLOT_SIZE = 64

for i = 1, 10 do
	local slot = Instance.new("Frame")
	slot.Name = "Slot" .. i
	slot.Size = UDim2.new(0, SLOT_SIZE, 0, SLOT_SIZE)
	slot.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
	slot.BackgroundTransparency = 0.4
	slot.BorderSizePixel = 0
	slot.LayoutOrder = i
	slot.ZIndex = 1
	slot.Visible = false
	
	-- Selection Overlay Frame (Topmost Layer: ZIndex 10 ensures outline renders strictly on top of text/icons)
	local selectionFrame = Instance.new("Frame")
	selectionFrame.Name = "SelectionFrame"
	selectionFrame.Size = UDim2.new(1, 0, 1, 0)
	selectionFrame.BackgroundTransparency = 1
	selectionFrame.ZIndex = 10
	selectionFrame.Parent = slot

	local stroke = Instance.new("UIStroke")
	stroke.Name = "SelectionStroke"
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(0, 255, 0)
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Enabled = false
	stroke.Parent = selectionFrame
	
	-- Number Label (Middle Layer)
	local numberLabel = Instance.new("TextLabel")
	numberLabel.Size = UDim2.new(0, 15, 0, 15)
	numberLabel.Position = UDim2.new(0, 0, 1, -15)
	numberLabel.BackgroundTransparency = 0.25
	numberLabel.Text = tostring(i == 10 and 0 or i)
	numberLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	numberLabel.Font = Enum.Font.ArialBold
	numberLabel.BorderSizePixel = 0
	numberLabel.TextSize = 12
	numberLabel.ZIndex = 3
	numberLabel.Parent = slot
	
	-- Tool Image / Clickable Area (Lower Layer)
	local toolBtn = Instance.new("ImageButton")
	toolBtn.Name = "ToolButton"
	toolBtn.Size = UDim2.new(1, -4, 1, -4)
	toolBtn.Position = UDim2.new(0, 2, 0, 2)
	toolBtn.BackgroundTransparency = 1
	toolBtn.ZIndex = 2
	toolBtn.Parent = slot
	
	local textFallback = Instance.new("TextLabel")
	textFallback.Name = "TextFallback"
	textFallback.Size = UDim2.new(1, 0, 1, 0)
	textFallback.BackgroundTransparency = 1
	textFallback.TextColor3 = Color3.fromRGB(255, 255, 255)
	textFallback.Font = Enum.Font.Arial
	textFallback.TextSize = 10
	textFallback.TextWrapped = true
	textFallback.ZIndex = 2
	textFallback.Parent = toolBtn
	
	toolBtn.Activated:Connect(function()
		if clickDebounce then return end
		local tool = toolMappings[i]
		if not tool or not tool:IsDescendantOf(game) then return end
		
		clickDebounce = true
		local currentCharacter = LocalPlayer.Character
		local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
		
		if currentCharacter and currentCharacter:FindFirstChildOfClass("Humanoid") and backpack then
			if tool.Parent == currentCharacter then
				tool.Parent = backpack
			else
				for _, otherTool in ipairs(currentCharacter:GetChildren()) do
					if otherTool:IsA("Tool") then
						otherTool.Parent = backpack
					end
				end
				tool.Parent = currentCharacter
			end
		end
		task.wait(0.1)
		clickDebounce = false
	end)
	
	slot.Parent = BackpackGui
	itemSlots[i] = slot
end

local function updateBackpack()
	local currentTools = {}
	local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, tool in ipairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then currentTools[tool] = true end
		end
	end
	
	local character = LocalPlayer.Character
	if character then
		for _, tool in ipairs(character:GetChildren()) do
			if tool:IsA("Tool") then currentTools[tool] = true end
		end
	end
	
	for slotIdx, registeredTool in pairs(toolMappings) do
		if not currentTools[registeredTool] then
			toolMappings[slotIdx] = nil
		end
	end
	
	for tool, _ in pairs(currentTools) do
		local alreadySlotted = false
		for slotIdx, registeredTool in pairs(toolMappings) do
			if registeredTool == tool then
				alreadySlotted = true
				break
			end
		end
		
		if not alreadySlotted then
			for i = 1, 10 do
				if not toolMappings[i] then
					toolMappings[i] = tool
					break
				end
			end
		end
	end
	
	local totalVisibleSlots = 0
	for i = 1, 10 do
		if toolMappings[i] then totalVisibleSlots = totalVisibleSlots + 1 end
	end
	BackpackGui.Size = UDim2.new(0, math.max(1, totalVisibleSlots) * SLOT_SIZE, 0, SLOT_SIZE)

	local characterModel = LocalPlayer.Character
	for i = 1, 10 do
		local slot = itemSlots[i]
		local tool = toolMappings[i]
		
		if tool and tool:IsDescendantOf(game) then
			local toolBtn = slot.ToolButton
			local textFallback = toolBtn:FindFirstChild("TextFallback")
			local stroke = slot:FindFirstChild("SelectionStroke", true)
			
			toolBtn.Image = tool.TextureId
			if tool.TextureId == "" then
				if textFallback then textFallback.Text = tool.Name end
			else
				if textFallback then textFallback.Text = "" end
			end
			
			if characterModel and tool.Parent == characterModel then
				if stroke then
					stroke.Enabled = true
				end
			else
				if stroke then
					stroke.Enabled = false
				end
			end
			slot.Visible = true
		else
			slot.Visible = false
		end
	end
end

local function setupBackpackConnections(character)
	local backpack = LocalPlayer:WaitForChild("Backpack")
	backpack.ChildAdded:Connect(updateBackpack)
	backpack.ChildRemoved:Connect(updateBackpack)
	
	if character then
		character.ChildAdded:Connect(updateBackpack)
		character.ChildRemoved:Connect(updateBackpack)
	end
	updateBackpack()
end

LocalPlayer.CharacterAdded:Connect(setupBackpackConnections)
if LocalPlayer.Character then setupBackpackConnections(LocalPlayer.Character) end

 ]], 
	
	SafeChat            = [[ -- hi! keep in mind that this script has almost no support for mobile devices.
                             -- the script is made by mehhovcki. have fun :D

_G.safeChatVersion = "2016" -- 2007/2009/2016
_G.keyToDestroy = Enum.KeyCode.LeftControl -- https://create.roblox.com/docs/reference/engine/enums/KeyCode
if _G.safeChatVersion ~= "2007" and _G.safeChatVersion ~= "2009" and _G.safeChatVersion ~= "2016" then
    return print("[!] safeChatVersion isn't 2007, 2009 or 2016. pls fix :c")
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/mehh0vcki/scripts/refs/heads/main/safechat.lua"))() ]],
	
	-- custom backpacks
	Backpack_S     = [[  --a simple handy 2008 remake of the backpack
loadstring(game:HttpGet("https://peeky.pythonanywhere.com/CustomBackpack"))()]],
	Backpack_A     = [[ --ADVANCED BACKPACK

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Custom-Mobile-Backpack-38376"))() ]],

	
	Anims_R6_2008  = [[ --this is mostly patched btw
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Char2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local h = Char2:FindFirstChildOfClass("Humanoid") or Char2:WaitForChild("Humanoid")

if h.RigType ~= Enum.HumanoidRigType.R6 then return end

LocalPlayer.Character:BreakJoints()
LocalPlayer.Character=nil
repeat task.wait() until LocalPlayer.Character
Char = LocalPlayer.Character
task.wait(.1)
LocalPlayer.Character:BreakJoints()
       
LocalPlayer.CharacterAdded:Connect(function(c)
Char = c
function waitForChild(parent, childName)
local child = parent:FindFirstChild(childName)
if child then return child end
while true do
child = parent.ChildAdded:Wait()
if child.Name == childName then return child end
end
end

waitForChild(Char, "Animate").Disabled = true

task.wait(1)

-- ANIMATION

-- declarations

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Figure = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Torso = waitForChild(Figure, "Torso")
local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local jumpMaxLimbVelocity = 0.75

-- functions

function onRunning(speed)
if speed>0 then
pose = "Running"
else
pose = "Standing"
end
end

function onDied()
pose = "Dead"
end

function onJumping()
pose = "Jumping"
end

function onClimbing()
pose = "Climbing"
end

function onGettingUp()
pose = "GettingUp"
end

function onFreeFall()
pose = "FreeFall"
end

function onFallingDown()
pose = "FallingDown"
end

function onSeated()
pose = "Seated"
end

function onPlatformStanding()
pose = "PlatformStanding"
end

function onSwimming(speed)
if speed>0 then
pose = "Climbing"
else
pose = "Running"
end
end

function moveJump()
RightShoulder.MaxVelocity = 0.5
LeftShoulder.MaxVelocity = 0.5
RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end


-- same as jump for now

function moveFreeFall()
RightShoulder.MaxVelocity = 0.5
LeftShoulder.MaxVelocity = 0.5
RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end

function moveSit()
RightShoulder.MaxVelocity = 0.5
LeftShoulder.MaxVelocity = 0.5
RightShoulder:SetDesiredAngle(3.14 /2)
LeftShoulder:SetDesiredAngle(-3.14 /2)
RightHip:SetDesiredAngle(3.14 /2)
LeftHip:SetDesiredAngle(-3.14 /2)
end

function getTool()
for _, kid in ipairs(Figure:GetChildren()) do
if kid.className == "Tool" then return kid end
end
return nil
end

function getToolAnim(tool)
for _, c in ipairs(tool:GetChildren()) do
if c.Name == "toolanim" and c.className == "StringValue" then
return c
end
end
return nil
end

function animateTool()

if (toolAnim == "None") then
RightShoulder:SetDesiredAngle(1.57)
return
end

if (toolAnim == "Slash") then
RightShoulder.MaxVelocity = 0.5
RightShoulder:SetDesiredAngle(0)
return
end

if (toolAnim == "Lunge") then
RightShoulder.MaxVelocity = 0.5
LeftShoulder.MaxVelocity = 0.5
RightHip.MaxVelocity = 0.5
LeftHip.MaxVelocity = 0.5
RightShoulder:SetDesiredAngle(1.57)
LeftShoulder:SetDesiredAngle(1.0)
RightHip:SetDesiredAngle(1.57)
LeftHip:SetDesiredAngle(1.0)
return
end
end

function move(time)
local amplitude
local frequency

if (pose == "Jumping") then
moveJump()
return
end

if (pose == "FreeFall") then
moveFreeFall()
return
end

if (pose == "Seated") then
moveSit()
return
end

local climbFudge = 0

if (pose == "Running") then
RightShoulder.MaxVelocity = 0.08
LeftShoulder.MaxVelocity = 0.08
amplitude = 0.66
frequency = 8
elseif (pose == "Climbing") then
RightShoulder.MaxVelocity = 0.4
LeftShoulder.MaxVelocity = 0.4
amplitude = 0.66
frequency = 9
climbFudge = 3.14
else
amplitude = 0.07
frequency = 1
end

desiredAngle = amplitude * math.sin(time*frequency)

RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
RightHip:SetDesiredAngle(-desiredAngle)
LeftHip:SetDesiredAngle(-desiredAngle)


local tool = getTool()

if tool then

animStringValueObject = getToolAnim(tool)

if animStringValueObject then
toolAnim = animStringValueObject.Value
-- message recieved, delete StringValue
animStringValueObject.Parent = nil
toolAnimTime = time + .3
end

if time > toolAnimTime then
toolAnimTime = 0
toolAnim = "None"
end

animateTool()

else
toolAnim = "None"
toolAnimTime = 0
end
end


-- connect events

Humanoid.Died:Connect(onDied)
Humanoid.Running:Connect(onRunning)
Humanoid.Jumping:Connect(onJumping)
Humanoid.Climbing:Connect(onClimbing)
Humanoid.GettingUp:Connect(onGettingUp)
Humanoid.FreeFalling:Connect(onFreeFall)
Humanoid.FallingDown:Connect(onFallingDown)
Humanoid.Seated:Connect(onSeated)
Humanoid.PlatformStanding:Connect(onPlatformStanding)
Humanoid.Swimming:Connect(onSwimming)
-- main program

local runService = game:service("RunService");

while Figure.Parent~=nil do
local _, time = wait(0.1)
move(time)
end
end)

 ]],
	Anims_R6_2006  = [[ --copy of r15 script to disable r6 animations

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- [1] Define the Retro Catalog IDs (Movement)
local MOVEMENT_CATALOG_IDS = {
    Idle  = "rbxassetid://107407916979702",
    Walk  = "rbxassetid://103979922296239",
    Run   = "rbxassetid://103979922296239",
    Jump  = "rbxassetid://119095524735341",
    Fall  = "rbxassetid://119095524735341",
    Climb = "rbxassetid://132639392250396"
}

-- Table to store the extracted Raw Asset IDs
local RAW_MOVEMENT_IDS = {}

-- [2] The Extraction Engine
local function ExtractRawIDs(catalogTable, outputTable)
    for name, catalogId in pairs(catalogTable) do
        outputTable[name] = catalogId -- Fallback directly to the provided ID
        
        pcall(function()
            -- game:GetObjects is an executor-level function to pull the asset data
            local objects = game:GetObjects(catalogId)
            for _, obj in ipairs(objects) do
                if obj:IsA("Animation") then
                    outputTable[name] = obj.AnimationId
                else
                    local anim = obj:FindFirstChildWhichIsA("Animation", true)
                    if anim then
                        outputTable[name] = anim.AnimationId
                    end
                end
            end
        end)
    end
end

-- Run extraction asynchronously
task.spawn(function()
    ExtractRawIDs(MOVEMENT_CATALOG_IDS, RAW_MOVEMENT_IDS)
    print("[復古套件]：移動動畫 ID 已擷取。")
end)

-- [3] The Core Injection Function (Movement Only)
local function InjectClassicSuite(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if not humanoid then return end

    local animateScript = character:WaitForChild("Animate", 10)
    if not animateScript then return end

    -- Overwrite base movement targets
    local function overwriteAnimTarget(animName, targetChildName, newId)
        local container = animateScript:FindFirstChild(animName)
        if container then
            local animTarget = container:FindFirstChild(targetChildName)
            if animTarget and animTarget:IsA("Animation") then
                animTarget.AnimationId = newId
            end
        end
    end

    -- Inject the 2007 Retro Movement IDs
    overwriteAnimTarget("idle", "Animation1", RAW_MOVEMENT_IDS.Idle)
    overwriteAnimTarget("idle", "Animation2", RAW_MOVEMENT_IDS.Idle)
    overwriteAnimTarget("walk", "WalkAnim", RAW_MOVEMENT_IDS.Walk)
    overwriteAnimTarget("run", "RunAnim", RAW_MOVEMENT_IDS.Run)
    overwriteAnimTarget("jump", "JumpAnim", RAW_MOVEMENT_IDS.Jump)
    overwriteAnimTarget("fall", "FallAnim", RAW_MOVEMENT_IDS.Fall)
    overwriteAnimTarget("climb", "ClimbAnim", RAW_MOVEMENT_IDS.Climb)

    -- Flush standard tracks
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:Stop(0) 
        end
    end

    -- Forcefully Reboot the Animate Script
    animateScript.Disabled = true
    task.wait(0.05) 
    animateScript.Disabled = false

    print("[復古套件]：基礎移動動畫已注入。")
end

-- [ Initialization & Respawn Handling ] --
task.wait(1)

if LocalPlayer.Character then
    task.spawn(InjectClassicSuite, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.spawn(function()
        task.wait(0.5)
        InjectClassicSuite(newChar)
    end)
end) ]],
	Anims_R6_2014  = [[ --2014 R6 ANIMS
-- Version 25: Hybrid Velocity-Input Wall Collision Router
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local physicsLoop = nil 
local renderLoop = nil

local function setupAnimateEngine(character)
	-- Disconnect old threads upon respawn
	if physicsLoop then physicsLoop:Disconnect(); physicsLoop = nil end
	if renderLoop then renderLoop:Disconnect(); renderLoop = nil end

	local Figure = character
	local Humanoid = Figure:WaitForChild("Humanoid")
	local RootPart = Figure:WaitForChild("HumanoidRootPart")
	local Torso = Figure:WaitForChild("Torso")
	
	local RightShoulder = Torso:WaitForChild("Right Shoulder", 5)
	local RootJoint = RootPart:WaitForChild("RootJoint", 5)

	-- Store base resting matrix safely
	local originalC0 = RightShoulder and RightShoulder.C0 or CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, 0)

	-- Destroy native Roblox animate scripts instantly
	local nativeAnimate = Figure:WaitForChild("Animate", 5)
	if nativeAnimate then
		nativeAnimate.Disabled = true
		nativeAnimate:Destroy()
	end

	-- Clean out any conflicting track structures
	local Animator = Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", Humanoid)
	for _, track in ipairs(Animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end

	-- Initialize clean movement tracks
	local anims = {
		idle = Instance.new("Animation"),
		walk = Instance.new("Animation"),
		jump = Instance.new("Animation"),
		fall = Instance.new("Animation"),
		climb = Instance.new("Animation"),
		swim = Instance.new("Animation"),
		sit = Instance.new("Animation")
	}

	anims.idle.AnimationId = "rbxassetid://161100084"
	anims.walk.AnimationId = "rbxassetid://161210451"
	anims.jump.AnimationId = "rbxassetid://165167557"
	anims.fall.AnimationId = "rbxassetid://165167632"
	anims.climb.AnimationId = "rbxassetid://161235826"
	anims.swim.AnimationId = "rbxassetid://144078604"
	anims.sit.AnimationId = "rbxassetid://178130996"

	local tracks = {}
	for name, anim in pairs(anims) do
		tracks[name] = Animator:LoadAnimation(anim)
		tracks[name].Priority = Enum.AnimationPriority.Action3
	end

	local currentTrack = nil
	local currentPose = "Idle"
	local isHoldingTool = false
	local armLiftProgress = 0
	local jumpTime = 0
	local JUMP_DURATION = 0.31 

	-- Tool Detection
	local function checkToolState()
		local toolFound = false
		for _, child in ipairs(Figure:GetChildren()) do
			if child:IsA("Tool") then
				toolFound = true
				break
			end
		end
		isHoldingTool = toolFound
	end
	checkToolState()

	local toolAddedConn = Figure.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then isHoldingTool = true end
	end)

	local toolRemovedConn = Figure.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") then task.defer(checkToolState) end
	end)

	local function playTrack(name)
		local targetTrack = tracks[name]
		if not targetTrack then return end
		
		if currentTrack ~= targetTrack then
			if currentTrack then currentTrack:Stop(0.1) end
			currentTrack = targetTrack
			
			if name == "walk" or name == "idle" or name == "climb" or name == "swim" or name == "sit" then
				currentTrack.Looped = true
			else
				currentTrack.Looped = false
			end
			currentTrack:Play(0.1)
		else
			if not currentTrack.IsPlaying then currentTrack:Play(0) end
		end
	end

	-- Core Jump Listener
	local stateConn = Humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping then
			currentPose = "Jumping"
			jumpTime = os.clock()
		end
	end)

	-- LOOP 1: Advanced Inverse-Kinematics Torso Lock (Stepped Override)
	renderLoop = RunService.Stepped:Connect(function(_, deltaTime)
		deltaTime = deltaTime or (1/60)
		
		if not Figure or not Figure:IsDescendantOf(workspace) or Humanoid.Health <= 0 then
			if renderLoop then renderLoop:Disconnect(); renderLoop = nil end
			return
		end

		local shouldRaiseArm = isHoldingTool and currentPose ~= "Climbing" and currentPose ~= "Swimming"

		if RightShoulder and RootJoint and Torso and RootPart then
			RightShoulder.Transform = RightShoulder.Transform:Lerp(CFrame.new(), armLiftProgress)

			if shouldRaiseArm then
				armLiftProgress = math.min(1, armLiftProgress + (deltaTime * 7))
				local currentTorsoRotation = (RootPart.CFrame:Inverse() * Torso.CFrame).Rotation
				local counterTwist = currentTorsoRotation:Inverse()
				
				local shoulderPos = CFrame.new(originalC0.Position)
				local shoulderRot = originalC0.Rotation
				local stabilizedC0 = shoulderPos * counterTwist * shoulderRot * CFrame.Angles(0, 0, math.rad(90))
				
				RightShoulder.C0 = originalC0:Lerp(stabilizedC0, armLiftProgress)
			else
				armLiftProgress = math.max(0, armLiftProgress - (deltaTime * 7))
				local targetAngle = math.rad(90) * armLiftProgress
				RightShoulder.C0 = originalC0 * CFrame.Angles(0, 0, targetAngle)
			end
		end
	end)

	-- LOOP 2: Golden Standard State Engine Router
	physicsLoop = RunService.PostSimulation:Connect(function()
		if not Figure or not Figure:IsDescendantOf(workspace) or Humanoid.Health <= 0 then
			if toolAddedConn then toolAddedConn:Disconnect() end
			if toolRemovedConn then toolRemovedConn:Disconnect() end
			if stateConn then stateConn:Disconnect() end
			if physicsLoop then physicsLoop:Disconnect(); physicsLoop = nil end
			return
		end
		
		local currentState = Humanoid:GetState()
		local isMidAir = (Humanoid.FloorMaterial == Enum.Material.Air)
		
		-- FIXED: Calculate actual horizontal physical velocity magnitude (ignoring gravity/Y axis)
		local horizontalVelocity = (RootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
		
		-- FIXED: Must have intent to move AND actually be physically moving through space
		local isMoving = (Humanoid.MoveDirection.Magnitude > 0) and (horizontalVelocity > 0.8)
		
		-- Strictly ordered hierarchy evaluation
		if currentState == Enum.HumanoidStateType.Seated then
			currentPose = "Seated"
		elseif currentState == Enum.HumanoidStateType.Swimming then
			currentPose = "Swimming"
		elseif currentState == Enum.HumanoidStateType.Climbing then
			currentPose = "Climbing"
		elseif currentPose == "Jumping" then
			if os.clock() - jumpTime > JUMP_DURATION then
				currentPose = "FreeFall"
			end
		elseif isMidAir then
			currentPose = "FreeFall"
		else
			-- Explicitly on solid ground
			if isMoving then
				currentPose = "Walk"
			else
				currentPose = "Idle"
			end
		end
		
		-- Track playback engine evaluations
		if currentPose == "Walk" then
			playTrack("walk")
			if currentTrack then currentTrack:AdjustSpeed(Humanoid.WalkSpeed / 16) end
		elseif currentPose == "Idle" then
			playTrack("idle")
		elseif currentPose == "Seated" then
			playTrack("sit")
		elseif currentPose == "Jumping" then
			playTrack("jump")
		elseif currentPose == "FreeFall" then
			playTrack("fall")
		elseif currentPose == "Swimming" then
			playTrack("swim")
			if currentTrack then
				if Torso.AssemblyLinearVelocity.Magnitude > 0.5 then currentTrack:AdjustSpeed(1)
				else currentTrack:AdjustSpeed(0.2) end
			end
		elseif currentPose == "Climbing" then
			playTrack("climb")
			if currentTrack then
				if math.abs(Torso.AssemblyLinearVelocity.Y) > 0.2 then
					currentTrack:AdjustSpeed(1)
				else currentTrack:AdjustSpeed(0) end
			end
		end
	end)
end

if LocalPlayer.Character then
	task.spawn(setupAnimateEngine, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	setupAnimateEngine(newCharacter)
end)
 ]],
	Anims_R15_2008 = [[ --2008 ANIMS FOR R15
local Players = game:GetService("Players")
local AssetService = game:GetService("AssetService")
local LocalPlayer = Players.LocalPlayer

-- Target IDs
local BUNDLE_ID = 154908634122051

-- Catalog IDs to unpack raw animation data from
local CATALOG_ANIMATIONS = {
	Sit  = "rbxassetid://12520993168",
	Idle = "rbxassetid://107407916979702",
	Walk = "rbxassetid://103979922296239",
	Run  = "rbxassetid://103979922296239"
}

-- Table to hold unpacked raw asset IDs
local EXTRACTED_RAW_IDS = {}

-- Unpack catalog asset IDs into raw AnimationId strings
local function extractRawIDs()
	for name, assetId in pairs(CATALOG_ANIMATIONS) do
		EXTRACTED_RAW_IDS[name] = assetId -- Fallback
		
		pcall(function()
			if game.GetObjects then
				local objects = game:GetObjects(assetId)
				for _, obj in ipairs(objects) do
					if obj:IsA("Animation") then
						EXTRACTED_RAW_IDS[name] = obj.AnimationId
					else
						local anim = obj:FindFirstChildWhichIsA("Animation", true)
						if anim then
							EXTRACTED_RAW_IDS[name] = anim.AnimationId
						end
					end
				end
			end
		end)
	end
end

-- Run extraction asynchronously
task.spawn(extractRawIDs)

local function applyAnimations(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	local animateScript = character:WaitForChild("Animate", 10)
	if not humanoid or not animateScript then return end

	-- 1. Fetch Bundle Details (for Jump, Fall, Climb, Swim)
	local success, bundleDetails = pcall(function()
		return AssetService:GetBundleDetailsAsync(BUNDLE_ID)
	end)

	if not success or not bundleDetails or not bundleDetails.Items then
		warn("[Extractor]: Failed to retrieve bundle details.")
		return
	end

	-- 2. Populate HumanoidDescription with bundle IDs for excluded tracks
	local description = Instance.new("HumanoidDescription")
	
	for _, item in ipairs(bundleDetails.Items) do
		if item.Type == "Asset" then
			local name = item.Name:lower()
			if name:find("jump") then description.JumpAnimation = item.Id
			elseif name:find("fall") then description.FallAnimation = item.Id
			elseif name:find("climb") then description.ClimbAnimation = item.Id
			elseif name:find("swim") then description.SwimAnimation = item.Id
			end
		end
	end

	-- 3. Create Dummy Model in Memory to extract raw Jump/Fall/Climb/Swim IDs
	local dummySuccess, dummyModel = pcall(function()
		return Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15)
	end)

	if dummySuccess and dummyModel then
		local dummyAnimate = dummyModel:FindFirstChild("Animate")
		if dummyAnimate then
			local function transferAnimation(folderName, animName, targetFolder, targetAnimName)
				local srcFolder = dummyAnimate:FindFirstChild(folderName)
				local destFolder = animateScript:FindFirstChild(targetFolder or folderName)
				
				if srcFolder and destFolder then
					local srcAnim = srcFolder:FindFirstChild(animName) or srcFolder:FindFirstChildWhichIsA("Animation", true)
					local destAnim = destFolder:FindFirstChild(targetAnimName or animName) or destFolder:FindFirstChildWhichIsA("Animation", true)
					
					if srcAnim and destAnim and srcAnim.AnimationId ~= "" then
						destAnim.AnimationId = srcAnim.AnimationId
					end
				end
			end

			-- Transfer ONLY preserved movement tracks from the bundle
			transferAnimation("jump", "JumpAnim")
			transferAnimation("fall", "FallAnim")
			transferAnimation("climb", "ClimbAnim")
			transferAnimation("swim", "SwimAnim", "swim")
		end

		dummyModel:Destroy()
	else
		warn("[Extractor]: Failed to build dummy model from description.")
	end

	-- 4. Apply Extracted Overrides (Sitting, Idle, Walk, Run)
	local function overwriteAnimTarget(folderName, targetChildName, newId)
		local container = animateScript:FindFirstChild(folderName)
		if container then
			local animTarget = container:FindFirstChild(targetChildName) or container:FindFirstChildWhichIsA("Animation", true)
			if animTarget and animTarget:IsA("Animation") then
				animTarget.AnimationId = newId
			end
		end
	end

	-- Overwrite sitting track
	overwriteAnimTarget("sit", "SitAnim", EXTRACTED_RAW_IDS.Sit or CATALOG_ANIMATIONS.Sit)

	-- Overwrite 2008 base movement
	overwriteAnimTarget("idle", "Animation1", EXTRACTED_RAW_IDS.Idle or CATALOG_ANIMATIONS.Idle)
	overwriteAnimTarget("idle", "Animation2", EXTRACTED_RAW_IDS.Idle or CATALOG_ANIMATIONS.Idle)
	overwriteAnimTarget("walk", "WalkAnim", EXTRACTED_RAW_IDS.Walk or CATALOG_ANIMATIONS.Walk)
	overwriteAnimTarget("run", "RunAnim", EXTRACTED_RAW_IDS.Run or CATALOG_ANIMATIONS.Run)

	-- 5. Flush active tracks & reboot Animate script to force reload
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:Stop(0)
		end
	end

	animateScript.Disabled = true
	task.wait(0.05)
	animateScript.Disabled = false

	print("[動畫套件]：已套用原始坐姿軌跡、2008 待機/行走/跑步，並保留跳躍/掉落/攀爬/游泳！")
end

-- Run on spawn / respawn
if LocalPlayer.Character then
	task.spawn(applyAnimations, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
	task.spawn(function()
		task.wait(0.5)
		applyAnimations(newChar)
	end)
end) ]],
	Anims_R15_2014 = [[ --2014 anims for r15!

local Players = game:GetService("Players")
local AssetService = game:GetService("AssetService")
local LocalPlayer = Players.LocalPlayer

-- Target Bundle & Asset IDs
local BUNDLE_2014_ID = 206375404533286 -- Retro 2014 Animation Pack
local BUNDLE_SWIM_ID = 154908634122051 -- Preserved Swim Pack
local SIT_CATALOG_ID = "rbxassetid://12520993168"

-- Extracted Raw Sitting ID container
local EXTRACTED_SIT_ID = SIT_CATALOG_ID

-- Unpack catalog asset ID for Sitting
task.spawn(function()
	pcall(function()
		if game.GetObjects then
			local objects = game:GetObjects(SIT_CATALOG_ID)
			for _, obj in ipairs(objects) do
				if obj:IsA("Animation") then
					EXTRACTED_SIT_ID = obj.AnimationId
				else
					local anim = obj:FindFirstChildWhichIsA("Animation", true)
					if anim then
						EXTRACTED_SIT_ID = anim.AnimationId
					end
				end
			end
		end
	end)
end)

local function applyAnimations(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	local animateScript = character:WaitForChild("Animate", 10)
	if not humanoid or not animateScript then return end

	-- 1. Fetch 2014 Bundle Details (Idle, Walk, Run, Jump, Fall, Climb)
	local success2014, details2014 = pcall(function()
		return AssetService:GetBundleDetailsAsync(BUNDLE_2014_ID)
	end)

	-- 2. Fetch Swim Bundle Details
	local successSwim, detailsSwim = pcall(function()
		return AssetService:GetBundleDetailsAsync(BUNDLE_SWIM_ID)
	end)

	if not success2014 or not details2014 or not details2014.Items then
		warn("[Extractor]: Failed to retrieve Retro 2014 bundle details.")
		return
	end

	-- Build HumanoidDescription for 2014 Pack
	local desc2014 = Instance.new("HumanoidDescription")
	for _, item in ipairs(details2014.Items) do
		if item.Type == "Asset" then
			local name = item.Name:lower()
			if name:find("idle") then desc2014.IdleAnimation = item.Id
			elseif name:find("walk") then desc2014.WalkAnimation = item.Id
			elseif name:find("run") then desc2014.RunAnimation = item.Id
			elseif name:find("jump") then desc2014.JumpAnimation = item.Id
			elseif name:find("fall") then desc2014.FallAnimation = item.Id
			elseif name:find("climb") then desc2014.ClimbAnimation = item.Id
			end
		end
	end

	-- Build HumanoidDescription for Swimming
	local descSwim = Instance.new("HumanoidDescription")
	if successSwim and detailsSwim and detailsSwim.Items then
		for _, item in ipairs(detailsSwim.Items) do
			if item.Type == "Asset" and item.Name:lower():find("swim") then
				descSwim.SwimAnimation = item.Id
			end
		end
	end

	-- Extract & Transfer 2014 Pack Tracks via Dummy
	local dummySuccess, dummyModel = pcall(function()
		return Players:CreateHumanoidModelFromDescription(desc2014, Enum.HumanoidRigType.R15)
	end)

	if dummySuccess and dummyModel then
		local dummyAnimate = dummyModel:FindFirstChild("Animate")
		if dummyAnimate then
			local function transferAnimation(folderName, animName, targetFolder, targetAnimName)
				local srcFolder = dummyAnimate:FindFirstChild(folderName)
				local destFolder = animateScript:FindFirstChild(targetFolder or folderName)
				
				if srcFolder and destFolder then
					local srcAnim = srcFolder:FindFirstChild(animName) or srcFolder:FindFirstChildWhichIsA("Animation", true)
					local destAnim = destFolder:FindFirstChild(targetAnimName or animName) or destFolder:FindFirstChildWhichIsA("Animation", true)
					
					if srcAnim and destAnim and srcAnim.AnimationId ~= "" then
						destAnim.AnimationId = srcAnim.AnimationId
					end
				end
			end

			-- Transfer 2014 Movement
			transferAnimation("idle", "Animation1")
			transferAnimation("idle", "Animation2")
			transferAnimation("walk", "WalkAnim")
			transferAnimation("run", "RunAnim")
			transferAnimation("jump", "JumpAnim")
			transferAnimation("fall", "FallAnim")
			transferAnimation("climb", "ClimbAnim")
		end
		dummyModel:Destroy()
	else
		warn("[Extractor]: Failed to build 2014 dummy model from description.")
	end

	-- Extract & Transfer Swim Track via Dummy
	local swimSuccess, swimModel = pcall(function()
		return Players:CreateHumanoidModelFromDescription(descSwim, Enum.HumanoidRigType.R15)
	end)

	if swimSuccess and swimModel then
		local dummyAnimate = swimModel:FindFirstChild("Animate")
		if dummyAnimate then
			local srcFolder = dummyAnimate:FindFirstChild("swim")
			local destFolder = animateScript:FindFirstChild("swim")
			if srcFolder and destFolder then
				local srcAnim = srcFolder:FindFirstChildWhichIsA("Animation", true)
				local destAnim = destFolder:FindFirstChildWhichIsA("Animation", true)
				if srcAnim and destAnim and srcAnim.AnimationId ~= "" then
					destAnim.AnimationId = srcAnim.AnimationId
				end
			end
		end
		swimModel:Destroy()
	end

	-- 3. Overwrite Sitting Animation
	local sitFolder = animateScript:FindFirstChild("sit")
	if sitFolder then
		local sitAnim = sitFolder:FindFirstChildWhichIsA("Animation", true)
		if sitAnim then
			sitAnim.AnimationId = EXTRACTED_SIT_ID
		end
	end

	-- 4. Flush active tracks & reboot Animate script to apply changes
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:Stop(0)
		end
	end

	animateScript.Disabled = true
	task.wait(0.05)
	animateScript.Disabled = false

	print("[動畫套件]：已套用 2014 復古包，保留游泳與自訂坐姿！")
end

-- Run on spawn / respawn
if LocalPlayer.Character then
	task.spawn(applyAnimations, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
	task.spawn(function()
		task.wait(0.5)
		applyAnimations(newChar)
	end)
end) ]],
	Anims_R15_Old  = [[ --OLD R15 ANIMATIONS

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Old-R15-Animations-100039"))() ]],
	
	OldSounds      = [[ --OLD SOUNDS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function applyMovementSounds(char)
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- 1. CLEANUP (Exclude the Paradox sounds so they don't double up)
    local modernSoundScript = char:FindFirstChild("Sound")
    if modernSoundScript then modernSoundScript:Destroy() end
    
    for _, s in pairs(hrp:GetChildren()) do
        if s:IsA("Sound") and not string.find(s.Name, "Paradox") then 
            s:Destroy() 
        end
    end

    -- 2. SETUP AUDIO
    local masterStep = Instance.new("Sound", hrp)
    masterStep.Name = "ParadoxStep"
    masterStep.SoundId = "rbxassetid://174960816"
    masterStep.Volume = 0
    masterStep.Looped = true
    masterStep:Play()

    local jumpSound = Instance.new("Sound", hrp)
    jumpSound.Name = "ParadoxJump"
    jumpSound.SoundId = "rbxassetid://2428506580"
    jumpSound.Volume = 1

    local deathSound = Instance.new("Sound", hrp)
    deathSound.Name = "ParadoxDeath"
    deathSound.SoundId = "rbxassetid://17755696142" -- Using the ID from your previous script
    deathSound.Volume = 1

    local climbSound = Instance.new("Sound", hrp)
    climbSound.Name = "ParadoxClimb"
    climbSound.SoundId = "rbxassetid://7593297942"
    climbSound.Volume = 0.8
    climbSound.Looped = true

    -- 3. MOVEMENT LOGIC
    RunService.Heartbeat:Connect(function()
        if not humanoid or humanoid.Health <= 0 then 
            masterStep.Volume = 0
            climbSound:Stop()
            return 
        end
        
        local speed = hrp.Velocity.Magnitude
        local state = humanoid:GetState()

        if state == Enum.HumanoidStateType.Climbing then
            masterStep.Volume = 0
            if not climbSound.IsPlaying then climbSound:Play() end
        elseif speed > 1.5 and state ~= Enum.HumanoidStateType.Freefall then
            climbSound:Stop()
            masterStep.Volume = 0.8
        else
            masterStep.Volume = 0
            climbSound:Stop()
        end
    end)

    -- 4. STATE EVENTS (Jump & Death)
    humanoid.StateChanged:Connect(function(_, new)
        if new == Enum.HumanoidStateType.Jumping then
            masterStep.Volume = 0
            jumpSound:Play()
        end
    end)

    humanoid.Died:Connect(function()
        masterStep.Volume = 0
        climbSound:Stop()
        deathSound:Play()
    end)
end

-- Init
if player.Character then applyMovementSounds(player.Character) end
player.CharacterAdded:Connect(function(char)
    repeat task.wait() until char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid")
    applyMovementSounds(char)
end) ]],
	
	-- Mouse Cursor Scripts
	Mouse_2008_Full    = [[ --FULL 2008 MOUSE
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)

-- Clean up any existing custom cursors to avoid duplicates
if CoreGui:FindFirstChild("Cursor") then 
	CoreGui.Cursor:Destroy() 
end

-- State tracking
local isEscMenuOpen = false
local originalCursorImage = nil
local outOfRangeTexture = "rbxassetid://113797540507637"

-- Load and clone the authentic custom GUI cursor asset
local success, assets = pcall(function()
	return game:GetObjects("rbxassetid://17895536995")
end)

if success and assets and assets[1] then
	local eazywin = assets[1]:Clone()
	
	-- Clean up configuration and match requested specifications
	if eazywin:FindFirstChild("LocalScript") then
		eazywin.LocalScript:Destroy()
	end
	
	eazywin.DisplayOrder = 1999999999
	eazywin.IgnoreGuiInset = true
	eazywin.Y.Value = 6
	eazywin.Parent = CoreGui

	local imageLabel = eazywin:FindFirstChild("ImageLabel")
	local actionLabel = imageLabel and imageLabel:FindFirstChild("action")
	
	-- Save the original texture asset string so we can restore it dynamically
	if imageLabel then
		originalCursorImage = imageLabel.Image
	end
	
	-- Listen to core Esc Menu states to handle automatic hiding
	GuiService.MenuOpened:Connect(function()
		isEscMenuOpen = true
	end)

	GuiService.MenuClosed:Connect(function()
		isEscMenuOpen = false
	end)
	
	-- Helper function to check if the cursor is hovering over a clickable UI element
	local function isHoveringClickableUI(mousePos)
		if not PlayerGui then return false end
		local guiObjects = PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)
		for _, obj in ipairs(guiObjects) do
			if obj:IsA("GuiButton") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
				return true
			end
		end
		return false
	end
	
	-- Frame-by-frame execution loop
	RunService.RenderStepped:Connect(function(step)
		if not eazywin or not eazywin.Parent then return end
		
		local mouse = LocalPlayer:GetMouse()
		local mousePos = Vector2.new(mouse.X, mouse.Y)
		local character = LocalPlayer.Character
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		
		-- 1. Distance Calculation Logic
		local isOutOfRange = false
		if rootPart and mouse.Hit then
			local distance = (rootPart.Position - mouse.Hit.Position).Magnitude
			if distance > 60 then
				isOutOfRange = true
			end
		end
		
		-- Update the texture depending on range limits
		if imageLabel then
			if isOutOfRange and not isHoveringClickableUI(mousePos) and not isEscMenuOpen then
				imageLabel.Image = outOfRangeTexture
			else
				imageLabel.Image = originalCursorImage
			end
		end
		
		-- 2. 3D World Interaction: Hovering over a physical ClickDetector
		local isHoveringWorldClickable = false
		if mouse.Target and mouse.Target:FindFirstChildOfClass("ClickDetector") then
			isHoveringWorldClickable = true
		end
		
		-- 3. 2D Screen Interaction: Hovering over a Clickable UI Button
		local isHoveringUIButton = isHoveringClickableUI(mousePos)
		
		-- Visibility layout switches
		if isEscMenuOpen then
			UserInputService.MouseIconEnabled = true
			if imageLabel then imageLabel.Visible = false end
			if actionLabel then actionLabel.Visible = false end
			
		elseif isHoveringWorldClickable then
			UserInputService.MouseIconEnabled = true
			if imageLabel then imageLabel.Visible = false end
			
		elseif isHoveringUIButton then
			UserInputService.MouseIconEnabled = false
			if imageLabel then imageLabel.Visible = true end
			if actionLabel then actionLabel.Visible = true end
			
		else
			UserInputService.MouseIconEnabled = false
			if imageLabel then imageLabel.Visible = true end
			if actionLabel then actionLabel.Visible = false end
		end
		
		-- perfectly position the custom cursor (shifted down 26 pixels to aling)
		if imageLabel and imageLabel.Visible then
			local targetX = mouse.X - eazywin.X.Value
			local targetY = mouse.Y - eazywin.Y.Value + 26
			
			local tweenInfo = TweenInfo.new(step, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
			local goalProperties = {Position = UDim2.new(0, targetX, 0, targetY)}
			
			TweenService:Create(imageLabel, tweenInfo, goalProperties):Play()
		end
	end)
else
	warn("Failed to fetch custom cursor asset.")
end

-- old click to move, compatible with mobile! :D
--OLD ROBLOX CLICK TO MOVE

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- =========================================================
-- ATTEMPT TO WIPE ROBLOX DEFAULT CLICK-TO-MOVE SYSTEM(doesn't work)
-- =========================================================
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts")

if not StarterPlayerScripts:FindFirstChild("PlayerModule") then
	local fakePlayerModule = Instance.new("Folder")
	fakePlayerModule.Name = "PlayerModule"
	
	local fakeControlModule = Instance.new("Folder")
	fakeControlModule.Name = "ControlModule"
	fakeControlModule.Parent = fakePlayerModule
	
	local fakeCTM = Instance.new("ModuleScript")
	fakeCTM.Name = "ClickToMoveController"
	fakeCTM.Source = "local m = {}; function m:Disconnect() end; return m;"
	fakeCTM.Parent = fakeControlModule
	
	fakePlayerModule.Parent = StarterPlayerScripts
end

pcall(function()
	LocalPlayer.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
	LocalPlayer.DevTouchMovementMode = Enum.DevTouchMovementMode.UserChoice
end)

local oldModel = Workspace:FindFirstChild("MouseFollowerDodecagon")
if oldModel then oldModel:Destroy() end
local oldClone = Workspace:FindFirstChild("DodecagonClone")
if oldClone then oldClone:Destroy() end

local isFollowerVisible = false
local currentClone = nil
local isPathfinding = false
local touchConnection = nil

local activeTouches = {}
local touchStartPositions = {}

local dodecagonModel = Instance.new("Model")
dodecagonModel.Name = "MouseFollowerDodecagon"
dodecagonModel.Parent = Workspace

local cylinderPart = Instance.new("Part")
cylinderPart.Name = "Hitbox"
cylinderPart.Size = Vector3.new(0.25, 2, 2) 
cylinderPart.Shape = Enum.PartType.Cylinder
cylinderPart.Color = Color3.fromRGB(0, 255, 0)
cylinderPart.Material = Enum.Material.SmoothPlastic
cylinderPart.CanCollide = false
cylinderPart.CanTouch = true
cylinderPart.CanQuery = true
cylinderPart.Anchored = true
cylinderPart.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, math.rad(90))
cylinderPart.Parent = dodecagonModel
dodecagonModel.PrimaryPart = cylinderPart

local function isHoldingTool()
	local character = LocalPlayer.Character
	return character and character:FindFirstChildOfClass("Tool") ~= nil
end

local function isHoveringInteractivePart(target)
	if not target then return false end
	if target == cylinderPart or target:IsDescendantOf(dodecagonModel) or (currentClone and target:IsDescendantOf(currentClone)) then return false end
	if target:FindFirstChildOfClass("ClickDetector") or target.Parent:FindFirstChildOfClass("ClickDetector") then return true end
	if target:IsA("Seat") or target:IsA("VehicleSeat") then return true end
	if target:FindFirstChildOfClass("ProximityPrompt") or target.Parent:FindFirstChildOfClass("ProximityPrompt") then return true end
	return false
end

local function isHoveringUIAtPosition(screenPos)
	if not PlayerGui then return false end
	local guiObjects = PlayerGui:GetGuiObjectsAtPosition(screenPos.X, screenPos.Y)
	for _, obj in ipairs(guiObjects) do
		if obj:IsA("GuiButton") or obj:IsA("TextBox") or obj.Active then
			return true
		end
	end
	return false
end

local function removeClone()
	if touchConnection then
		touchConnection:Disconnect()
		touchConnection = nil
	end
	if currentClone then
		currentClone:Destroy()
		currentClone = nil
	end
	isPathfinding = false
end

-- Check if the camera is zoomed completely into the character's head
local function isFirstPerson()
	local character = LocalPlayer.Character
	local head = character and character:FindFirstChild("Head")
	if head and Camera then
		return (Camera.CFrame.Position - head.Position).Magnitude < 1.5
	end
	return false
end

-- Setup character listeners for seat transitions
local function setupCharacter(character)
	removeClone()
	local humanoid = character:WaitForChild("Humanoid", 5)
	local rootPart = character:WaitForChild("HumanoidRootPart", 5)
	
	if humanoid and rootPart then
		humanoid.Seated:Connect(function(isSitting, seat)
			if isSitting then
				removeClone()
				humanoid:MoveTo(rootPart.Position)
			end
		end)
	end
end

if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupCharacter)

local function handlePlacement(targetWorldPos)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	
	-- BLOCK PLACEMENT: Do not allow click destination drop if in first person, moving, or sitting
	if isFirstPerson() or (humanoid and (humanoid.MoveDirection.Magnitude > 0 or humanoid.Sit)) then 
		return 
	end

	removeClone()
	
	dodecagonModel.Archivable = true
	currentClone = dodecagonModel:Clone()
	currentClone.Name = "DodecagonClone"
	currentClone:PivotTo(CFrame.new(targetWorldPos) * CFrame.Angles(0, 0, math.rad(90)))
	
	local cloneHitbox = currentClone:FindFirstChild("Hitbox")
	if cloneHitbox then
		cloneHitbox.CanCollide = false
		touchConnection = cloneHitbox.Touched:Connect(function(hit)
			local character = LocalPlayer.Character
			if character and hit:IsDescendantOf(character) then
				removeClone()
			end
		end)
	end
	
	local cloneCylinder = currentClone:FindFirstChild("Hitbox")
	if cloneCylinder then
		cloneCylinder.LocalTransparencyModifier = 0
	end
	
	currentClone.Parent = Workspace
	isPathfinding = true
end

-- PC Click Input
Mouse.Button1Down:Connect(function()
	if not isFollowerVisible or not dodecagonModel.PrimaryPart then return end
	handlePlacement(dodecagonModel.PrimaryPart.Position)
end)

-- Mobile Touch Processing
UserInputService.TouchStarted:Connect(function(touch, gameProcessedEvent)
	if gameProcessedEvent then return end
	activeTouches[touch] = true
	touchStartPositions[touch] = touch.Position
end)

UserInputService.TouchEnded:Connect(function(touch, gameProcessedEvent)
	local startPos = touchStartPositions[touch]
	activeTouches[touch] = nil
	touchStartPositions[touch] = nil
	
	if gameProcessedEvent then return end
	
	local activeCount = 0
	for _ in pairs(activeTouches) do activeCount = activeCount + 1 end
	if activeCount > 0 then return end
	
	if startPos then
		local dragDistance = (touch.Position - startPos).Magnitude
		if dragDistance > 10 then return end
		
		local touchPos = Vector2.new(touch.Position.X, touch.Position.Y)
		if isHoveringUIAtPosition(touchPos) or isHoldingTool() then return end
		
		local unitRay = Camera:ScreenPointToRay(touchPos.X, touchPos.Y)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, dodecagonModel}
		
		local raycastResult = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, raycastParams)
		
		if raycastResult and not isHoveringInteractivePart(raycastResult.Instance) then
			local character = LocalPlayer.Character
			local rootPart = character and character:FindFirstChild("HumanoidRootPart")
			
			if rootPart then
				local distanceFromPlayer = (rootPart.Position - raycastResult.Position).Magnitude
				if distanceFromPlayer <= 60 then
					handlePlacement(raycastResult.Position)
				end
			end
		end
	end
end)

-- Frame-by-frame execution loop
local connection
connection = RunService.RenderStepped:Connect(function()
	if not dodecagonModel or not dodecagonModel.Parent then
		connection:Disconnect()
		return
	end

	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")

	-- Basic Movement and Cancel Checking (Active clones will continue moving)
	if isPathfinding and currentClone and humanoid and rootPart then
		local horizontalMove = Vector3.new(humanoid.MoveDirection.X, 0, humanoid.MoveDirection.Z)
		
		if horizontalMove.Magnitude > 0 then
			removeClone()
		else
			local clonePos = currentClone.PrimaryPart.Position
			humanoid:MoveTo(clonePos)
			
			if (rootPart.Position - clonePos).Magnitude <= 3 then
				removeClone()
			end
		end
	end

	-- Check if a mouse pointer is being used
	local hasMouse = UserInputService.MouseEnabled
	local shouldShow = false
	
	-- BLOCK MAIN CYLINDER VISIBILITY: Hide if player is moving, sitting, or in first person mode
	if hasMouse and humanoid and (humanoid.MoveDirection.Magnitude == 0 and not humanoid.Sit) and not isFirstPerson() then
		local unitRay = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local ignoreList = {LocalPlayer.Character, dodecagonModel}
		if currentClone then table.insert(ignoreList, currentClone) end
		raycastParams.FilterDescendantsInstances = ignoreList
		
		local raycastResult = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, raycastParams)
		shouldShow = true
		
		if isHoldingTool() or isHoveringUIAtPosition(Vector2.new(Mouse.X, Mouse.Y)) then
			shouldShow = false
		end
		
		if raycastResult and shouldShow then
			if rootPart then
				local distanceFromPlayer = (rootPart.Position - raycastResult.Position).Magnitude
				if distanceFromPlayer > 60 or isHoveringInteractivePart(raycastResult.Instance) then
					shouldShow = false
				else
					dodecagonModel:PivotTo(CFrame.new(raycastResult.Position) * CFrame.Angles(0, 0, math.rad(90)))
				end
			else
				shouldShow = false
			end
		else
			shouldShow = false
		end
	end
	
	isFollowerVisible = shouldShow
	cylinderPart.LocalTransparencyModifier = (hasMouse and shouldShow) and 0 or 1
end) ]],
	Mouse_2008_Aspects = [[ local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)

-- Clean up any existing custom cursors to avoid duplicates
if CoreGui:FindFirstChild("Cursor") then 
	CoreGui.Cursor:Destroy() 
end

-- State tracking for Roblox Core Esc Menu
local isEscMenuOpen = false

-- Load and clone the authentic custom GUI cursor asset
local success, assets = pcall(function()
	return game:GetObjects("rbxassetid://17895536995")
end)

if success and assets and assets[1] then
	local eazywin = assets[1]:Clone()
	
	-- Clean up configuration and match requested specifications
	if eazywin:FindFirstChild("LocalScript") then
		eazywin.LocalScript:Destroy()
	end
	
	eazywin.DisplayOrder = 1999999999
	eazywin.IgnoreGuiInset = true
	eazywin.Y.Value = 6
	eazywin.Parent = CoreGui

	local imageLabel = eazywin:FindFirstChild("ImageLabel")
	local actionLabel = imageLabel and imageLabel:FindFirstChild("action")
	
	-- Listen to core Esc Menu states to handle automatic hiding
	GuiService.MenuOpened:Connect(function()
		isEscMenuOpen = true
	end)

	GuiService.MenuClosed:Connect(function()
		isEscMenuOpen = false
	end)
	
	-- Helper function to check if the cursor is hovering over a clickable UI element
	local function isHoveringClickableUI(mousePos)
		if not PlayerGui then return false end
		local guiObjects = PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)
		for _, obj in ipairs(guiObjects) do
			if obj:IsA("GuiButton") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
				return true
			end
		end
		return false
	end
	
	-- Frame-by-frame execution loop
	RunService.RenderStepped:Connect(function(step)
		if not eazywin or not eazywin.Parent then return end
		
		local mouse = LocalPlayer:GetMouse()
		local mousePos = Vector2.new(mouse.X, mouse.Y)
		
		-- 3D World Interaction: Hovering over a physical ClickDetector
		local isHoveringWorldClickable = false
		if mouse.Target and mouse.Target:FindFirstChildOfClass("ClickDetector") then
			isHoveringWorldClickable = true
		end
		
		-- 2D Screen Interaction: Hovering over a Clickable UI Button
		local isHoveringUIButton = isHoveringClickableUI(mousePos)
		
		-- Visibility logic switchboards including the Esc Menu check
		if isEscMenuOpen then
			-- Context Esc: Menu is open -> Fallback to default Roblox engine pointer, completely hide custom elements
			UserInputService.MouseIconEnabled = true
			if imageLabel then imageLabel.Visible = false end
			if actionLabel then actionLabel.Visible = false end
			
		elseif isHoveringWorldClickable then
			-- Context A: Hovering a 3D ClickDetector -> Default Roblox cursor takes over, hide custom completely
			UserInputService.MouseIconEnabled = true
			if imageLabel then imageLabel.Visible = false end
			
		elseif isHoveringUIButton then
			-- Context B: Hovering an interactable UI Button -> Custom cursor stays visible, show the question mark
			UserInputService.MouseIconEnabled = false
			if imageLabel then imageLabel.Visible = true end
			if actionLabel then actionLabel.Visible = true end
			
		else
			-- Context C: Hovering default space -> Custom cursor stays visible, hide the question mark
			UserInputService.MouseIconEnabled = false
			if imageLabel then imageLabel.Visible = true end
			if actionLabel then actionLabel.Visible = false end
		end
		
		-- Smoothly position the custom cursor (shifted down 26 pixels total)
		if imageLabel and imageLabel.Visible then
			local targetX = mouse.X - eazywin.X.Value
			local targetY = mouse.Y - eazywin.Y.Value + 26
			
			local tweenInfo = TweenInfo.new(step, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
			local goalProperties = {Position = UDim2.new(0, targetX, 0, targetY)}
			
			TweenService:Create(imageLabel, tweenInfo, goalProperties):Play()
		end
	end)
else
	warn("Failed to get custom cursor asset.")
end  ]],
	Mouse_2016         = [[ local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

-- 1. Create the ScreenGui for the custom cursor
local CustomCursorGui = Instance.new("ScreenGui")
CustomCursorGui.Name = "CustomCursorSystem"
CustomCursorGui.DisplayOrder = 9999999 
CustomCursorGui.IgnoreGuiInset = true   

-- 2. Create the ImageLabel for the mouse pointer
local CursorImage = Instance.new("ImageLabel")
CursorImage.Size = UDim2.new(0, 64, 0, 64) 
CursorImage.BackgroundTransparency = 1
CursorImage.ZIndex = 9999999
CursorImage.Parent = CustomCursorGui

-- Secure positioning inside CoreGui or fallback to PlayerGui
local success, _ = pcall(function()
	CustomCursorGui.Parent = game:GetService("CoreGui")
end)
if not success then
	CustomCursorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 3. Built-in classic image paths
local DEFAULT_WHITE_CURSOR = "rbxasset://textures/ArrowFarCursor.png"
local HOVER_BLACK_CURSOR = "rbxasset://textures/ArrowCursor.png"

-- Your perfect alignment offsets
local WHITE_X_OFFSET = -34
local WHITE_Y_OFFSET = 28

local BLACK_X_OFFSET = -35
local BLACK_Y_OFFSET = 30

-- Main Loop running every single frame
RunService.RenderStepped:Connect(function()
	local target = Mouse.Target
	
	-- Check for 3D interactable parts (ClickDetectors)
	local hoveringClickDetector = target and (target:FindFirstChildOfClass("ClickDetector") or target.Parent:FindFirstChildOfClass("ClickDetector"))
	
	-- Check if hovering 2D UI elements (like inventories or buttons)
	local engineIsHovering = (UserInputService.OverrideMouseIconBehavior == Enum.OverrideMouseIconBehavior.ForceHide)
	local hoveringCustomUI = false
	local guiObjects = LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y)
	for _, obj in ipairs(guiObjects) do
		if obj:IsA("GuiButton") or (obj:IsA("GuiObject") and obj.Active) then
			hoveringCustomUI = true
			break
		end
	end

	-- CONDITION UPGRADE: If hovering an interactable 3D part, show default Roblox mouse
	if hoveringClickDetector then
		-- Show the original Roblox cursor
		UserInputService.MouseIconEnabled = true
		Mouse.Icon = "" -- Clears overrides so default Roblox style shows naturally
		
		-- Hide our custom UI cursor
		CursorImage.Visible = false
	else
		-- PERMANENT LOCKDOWN for everywhere else: Hide the hardware mouse
		if UserInputService.MouseIconEnabled then
			UserInputService.MouseIconEnabled = false
		end
		
		-- Bring back our custom UI cursor
		CursorImage.Visible = true
		
		-- If hovering 2D UI/Inventory, show the custom black cursor
		if engineIsHovering or hoveringCustomUI then
			if CursorImage.Image ~= HOVER_BLACK_CURSOR then
				CursorImage.Image = HOVER_BLACK_CURSOR
			end
			CursorImage.Position = UDim2.new(0, Mouse.X + BLACK_X_OFFSET, 0, Mouse.Y + BLACK_Y_OFFSET)
		else
			-- Otherwise, default back to the custom white cursor
			if CursorImage.Image ~= DEFAULT_WHITE_CURSOR then
				CursorImage.Image = DEFAULT_WHITE_CURSOR
			end
			CursorImage.Position = UDim2.new(0, Mouse.X + WHITE_X_OFFSET, 0, Mouse.Y + WHITE_Y_OFFSET)
		end
	end
end) ]],
    
	Textures_2008  = [[ --2008 STUD TEXTURE
local STUDS_PER_TILE_U = 2 -- Controls the Width
local STUDS_PER_TILE_V = 4 -- Controls the Height

local DECAL_IDS = {
	STUDS = "112377592408206",
	INLETS = "130449770819407",
	UNIVERSAL = "14909139961",
	WELD = "139411804389109",
	GLUE = "82609935349620",
}

local FACE_TO_SURFACE_PROP = {
	[Enum.NormalId.Top] = "TopSurface",
	[Enum.NormalId.Bottom] = "BottomSurface",
	[Enum.NormalId.Front] = "FrontSurface",
	[Enum.NormalId.Back] = "BackSurface",
	[Enum.NormalId.Left] = "LeftSurface",
	[Enum.NormalId.Right] = "RightSurface",
}

local Players = game:GetService("Players")
local RESOLVED_TEXTURES = {}
_G.RetroTrackedParts = _G.RetroTrackedParts or setmetatable({}, {__mode = "k"})

-- Helper function to detect if a part belongs to a player's character
local function isPlayerPart(part)
	local ancestor = part.Parent
	while ancestor and ancestor ~= workspace do
		if ancestor:IsA("Model") and Players:GetPlayerFromCharacter(ancestor) then
			return true
		end
		ancestor = ancestor.Parent
	end
	return false
end

local function resolveTextureId(decalId)
	if RESOLVED_TEXTURES[decalId] then
		return RESOLVED_TEXTURES[decalId]
	end

	local finalId = nil
	local success, xml = pcall(function()
		return game:HttpGet("https://assetdelivery.roblox.com/v1/asset?id=" .. decalId)
	end)

	if success and xml then
		local imageId = string.match(xml, "id=(%d+)") or string.match(xml, "rbxassetid://(%d+)")
		if imageId and imageId ~= decalId then
			finalId = "rbxassetid://" .. imageId
		end
	end

	if not finalId then
		finalId = "rbxthumb://type=Asset&id=" .. decalId .. "&w=420&h=420"
	end

	RESOLVED_TEXTURES[decalId] = finalId
	return finalId
end

local function applyCustomTexture(part, face, surfaceType)
	local targetDecalId = nil

	if surfaceType == Enum.SurfaceType.Weld then
		targetDecalId = DECAL_IDS.WELD
	elseif surfaceType == Enum.SurfaceType.Glue then
		targetDecalId = DECAL_IDS.GLUE
	elseif surfaceType == Enum.SurfaceType.Universal then
		targetDecalId = DECAL_IDS.UNIVERSAL
	elseif surfaceType == Enum.SurfaceType.Studs then
		targetDecalId = DECAL_IDS.STUDS
	elseif surfaceType == Enum.SurfaceType.Inlet then
		targetDecalId = DECAL_IDS.INLETS
	end

	local textureName = "RetroTexture_" .. face.Name
	local existingTexture = part:FindFirstChild(textureName)

	if targetDecalId then
		local realTextureId = resolveTextureId(targetDecalId)
		
		if not existingTexture then
			existingTexture = Instance.new("Texture")
			existingTexture.Name = textureName
			existingTexture.Face = face
			existingTexture.Parent = part
		end
		
		existingTexture.Texture = realTextureId
		
		-- Apply our separate aspect ratio settings here
		existingTexture.StudsPerTileU = STUDS_PER_TILE_U
		existingTexture.StudsPerTileV = STUDS_PER_TILE_V
		
		existingTexture.Transparency = part.Transparency
	elseif existingTexture then
		existingTexture:Destroy()
	end
end

local function removeCustomTexture(part, face)
	local existingTexture = part:FindFirstChild("RetroTexture_" .. face.Name)
	if existingTexture then
		existingTexture:Destroy()
	end
end

local function setupPartSurfaces(part)
	if not part:IsA("BasePart") or part:IsA("Terrain") then return end
	if isPlayerPart(part) then return end -- Exclude player character parts
	if _G.RetroTrackedParts[part] then return end
	_G.RetroTrackedParts[part] = true

	for face, propName in pairs(FACE_TO_SURFACE_PROP) do
		-- 1. Check initial state
		local initialSurface = part[propName]
		if initialSurface ~= Enum.SurfaceType.Smooth then
			applyCustomTexture(part, face, initialSurface)
			
			-- Force it to smooth to hide native default studs, bypassing our own listener
			part:SetAttribute("RetroUpdating_" .. propName, true)
			part[propName] = Enum.SurfaceType.Smooth
			part:SetAttribute("RetroUpdating_" .. propName, false)
		end

		-- 2. Listen for BTools changes
		part:GetPropertyChangedSignal(propName):Connect(function()
			-- If our script is the one changing it to smooth, ignore it
			if part:GetAttribute("RetroUpdating_" .. propName) then return end

			local currentSurface = part[propName]
			
			if currentSurface ~= Enum.SurfaceType.Smooth then
				-- BTools changed it to a stud/glue/weld. Apply our texture!
				applyCustomTexture(part, face, currentSurface)
				
				-- Hide the native Roblox studs immediately
				part:SetAttribute("RetroUpdating_" .. propName, true)
				part[propName] = Enum.SurfaceType.Smooth
				part:SetAttribute("RetroUpdating_" .. propName, false)
			else
				-- BTools explicitly changed it to Smooth. Remove our custom texture.
				removeCustomTexture(part, face)
			end
		end)
	end

	-- 3. Match Part Transparency seamlessly
	part:GetPropertyChangedSignal("Transparency"):Connect(function()
		for _, child in pairs(part:GetChildren()) do
			if child:IsA("Texture") and string.find(child.Name, "RetroTexture_") then
				child.Transparency = part.Transparency
			end
		end
	end)
end

for _, descendant in pairs(workspace:GetDescendants()) do
	setupPartSurfaces(descendant)
end

if _G.RetroTextureConnection then
	_G.RetroTextureConnection:Disconnect()
end

-- Hook new parts added to the workspace
_G.RetroTextureConnection = workspace.DescendantAdded:Connect(function(descendant)
	setupPartSurfaces(descendant)
end) ]], 
	Textures_2012  = [[ loadstring(game:HttpGet("https://pastebin.com/raw/pcCGcUgt"))() ]],
	Textures_2016  = [[ --// Setting up graphics to look older
local effectsAfter2016 = {"DepthOfFieldEffect", "Atmosphere"}
local lighting = game:GetService("Lighting")

for _, effect in ipairs(lighting:GetChildren()) do
    for _, not2016effect in ipairs(effectsAfter2016) do
        if effect:IsA(not2016effect) then
            effect:Destroy() 
        end
    end
end

pcall(function()
    sethiddenproperty(lighting, "Technology", Enum.Technology.Compatibility) 
end)

lighting.Brightness = 2

--// Configuration for Stud assets
local STUD_TEXTURE_ID = "rbxassetid://7027211371"

local ALL_SURFACES = {
    {"TopSurface", Enum.NormalId.Top},
    {"BottomSurface", Enum.NormalId.Bottom},
    {"LeftSurface", Enum.NormalId.Left},
    {"RightSurface", Enum.NormalId.Right},
    {"FrontSurface", Enum.NormalId.Front},
    {"BackSurface", Enum.NormalId.Back}
}

--// Direct application function based strictly on your format
local function updateClassicStuds(part)
    if not part:IsA("BasePart") or part.Material ~= Enum.Material.Plastic then return end

    -- Ignore players and NPCs completely
    if part.Parent:FindFirstChildOfClass("Humanoid") or (part.Parent.Parent and part.Parent.Parent:FindFirstChildOfClass("Humanoid")) then 
        return 
    end

    -- Loop through each face independently
    for _, surfaceData in ipairs(ALL_SURFACES) do
        local surfaceName = surfaceData[1]
        local normalId = surfaceData[2]

        -- Check if this specific face has studs
        local success, surfaceType = pcall(function() return part[surfaceName] end)
        if success and surfaceType == Enum.SurfaceType.Studs then
            
            -- Look specifically for our applied texture on this face
            local textureName = surfaceName .. "_ClassicTexture"
            local existingTexture = part:FindFirstChild(textureName)
            
            if not existingTexture then
                local studs = Instance.new("Texture")
                studs.Name = textureName
                studs.Face = normalId
                studs.Texture = STUD_TEXTURE_ID
                -- RESTORED: Removed math.clamp so it multiplies identically to your snippet
                studs.Color3 = Color3.new(part.Color.R * 2, part.Color.G * 2, part.Color.B * 2)
                studs.Transparency = part.Transparency
                studs.StudsPerTileU = 2
                studs.StudsPerTileV = 2
                studs.Parent = part
            else
                -- If it exists, just update it seamlessly
                existingTexture.Color3 = Color3.new(part.Color.R * 2, part.Color.G * 2, part.Color.B * 2)
                existingTexture.Transparency = part.Transparency
            end
        else
            -- If a studio face no longer has a stud property, remove our texture instantly
            local existingTexture = part:FindFirstChild(surfaceName .. "_ClassicTexture")
            if existingTexture then
                existingTexture:Destroy()
            end
        end
    end
end

--// Lightweight, centralized property tracker
local trackedProperties = {
    Color = true, Transparency = true, Material = true,
    TopSurface = true, BottomSurface = true, LeftSurface = true, RightSurface = true, FrontSurface = true, BackSurface = true
}

local function setupTracking(part)
    if not part:IsA("BasePart") then return end
    part.Changed:Connect(function(property)
        if trackedProperties[property] then
            updateClassicStuds(part)
        end
    end)
end

--// Fast initialization loop
for _, descendant in ipairs(workspace:GetDescendants()) do
    if descendant:IsA("BasePart") then
        updateClassicStuds(descendant)
        setupTracking(descendant)
    end
end

--// Handle freshly spawned objects seamlessly
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") then
        task.defer(function()
            updateClassicStuds(descendant)
            setupTracking(descendant)
        end)
    end
end)

task.wait(0.5) ]],
    
	-- Mobile Jump Script
	MobileJump_Old = [[ --OLD JUMP BUTTON

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-old-roblox-jump-button-texture-242015"))() ]],

	Body_2006      = [[ --no bevels

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- The Classic Character package asset ID you provided
local ASSET_ID = "rbxassetid://1112295249"

-- Use game:GetObjects() to download the model (Standard for most script executors)
local success, objects = pcall(function()
	return game:GetObjects(ASSET_ID)
end)

if not success or not objects or #objects == 0 then
	warn("Failed to load the Classic Character package. Check your executor's GetObjects support.")
	return
end

local packageModel = objects[1]

local function applyClassicMeshes(character)
	local humanoid = character:WaitForChild("Humanoid", 5)
	if not humanoid then return end
	
	-- Give local avatar assets a split second to load in
	task.wait(0.5)

	if humanoid.RigType == Enum.HumanoidRigType.R6 then
		
		-- 1. Strip the character of any current rounded CharacterMeshes
		for _, item in ipairs(character:GetChildren()) do
			if item:IsA("CharacterMesh") then
				item:Destroy()
			end
		end
		
		-- Strip any BlockMeshes if another script was running previously
		for _, part in ipairs(character:GetChildren()) do
			if part:IsA("BasePart") then
				for _, child in ipairs(part:GetChildren()) do
					if child:IsA("BlockMesh") then
						child:Destroy()
					end
				end
			end
		end

		-- 2. Inject the sharp CharacterMeshes from the loaded package
		-- This gives the sharp 2006-style look while preserving clothing UV maps
		for _, desc in ipairs(packageModel:GetDescendants()) do
			if desc:IsA("CharacterMesh") then
				desc:Clone().Parent = character
			end
		end
		
		-- 3. Refresh clothing to force the engine to wrap them onto the new meshes
		for _, item in ipairs(character:GetChildren()) do
			if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
				local currentParent = item.Parent
				item.Parent = nil
				item.Parent = currentParent
			end
		end
	end
end

-- 1. Run immediately on your current character
if player.Character then
	task.spawn(function()
		applyClassicMeshes(player.Character)
	end)
end

-- 2. Automatically re-apply every time your character dies and respawns
player.CharacterAdded:Connect(applyClassicMeshes)

 ]], 

	OldMaterials   = [[ --OLD MATERIALS

local MaterialService = game:GetService("MaterialService")
local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop

if sethidden then
    sethidden(MaterialService, "Use2022Materials", true)
else
    -- Fallback attempt in case the property is writable without sethidden
    pcall(function()
        MaterialService.Use2022Materials = true
    end)
end
 ]], 
	
	Forcefield_2008 = [[ --force field r6
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local cycles = 60

local function applyRetroFF(character, ff)
    pcall(function()
        ff.Visible = false
    end)
    
    local boxes = {}
    
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local box = Instance.new("SelectionBox")
            box.Adornee = part
            box.LineThickness = 0.10
            box.SurfaceTransparency = 1
            box.Parent = character
            table.insert(boxes, box)
        end
    end
    
    task.spawn(function()
        local startTime = os.clock()
        
        while ff.Parent and character.Parent do
            local now = os.clock()
            local cycle = math.floor(((now - startTime) * 2) * cycles) % (cycles * 2)
            if cycle > cycles then
                cycle = cycles - (cycle - cycles)
            end

            local invertCycle = cycles - cycle
            local currentColor = Color3.new(cycle / cycles, 0, invertCycle / cycles)

            for _, box in ipairs(boxes) do
                box.Color3 = currentColor
            end
            
            RunService.Heartbeat:Wait()
        end
        
        for _, box in ipairs(boxes) do
            box:Destroy()
        end
    end)
end

local function init()
    local character = player.Character or player.CharacterAdded:Wait()
    
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("ForceField") then
            applyRetroFF(character, child)
        end
    end
    
    character.ChildAdded:Connect(function(child)
        if child:IsA("ForceField") then
            applyRetroFF(character, child)
        end
    end)
end

player.CharacterAdded:Connect(function()
    task.wait(0.2)
    init()
end)

init()
 ]],
	Forcefield_2012 = [[ -- OLD FORCEFIELD

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

local ffFolder = Instance.new("Folder")
ffFolder.Name = "FFCloneHolder"
ffFolder.Parent = workspace

local function getTorso(c)
    return c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso") or c:FindFirstChild("HumanoidRootPart")
end

local function buildFF()
    local model = Instance.new("Model")
    model.Name = "Forcefield2012"
    model.Parent = ffFolder

    -- Main Container
    local main = Instance.new("Part")
    main.Name = "VisualForcefield2012"
    main.Anchored = true
    main.CanCollide = false
    main.CastShadow = false
    main.Transparency = 1
    main.Size = Vector3.new(1,1,1)
    main.Parent = model

    -- Inner Sphere
    local mc = Instance.new("Part")
    mc.Name = "MainCircle"
    mc.Anchored = true
    mc.CanCollide = false
    mc.CastShadow = false
    mc.Color = Color3.fromRGB(0,0,128)
    mc.Material = Enum.Material.Neon
    mc.Transparency = 0.6
    mc.Size = Vector3.new(0.9,0.9,0.9)
    mc.Parent = model
    local mcM = Instance.new("SpecialMesh")
    mcM.MeshType = Enum.MeshType.Sphere
    mcM.Scale = Vector3.new(7,7,7)
    mcM.Parent = mc

    -- Outer Sphere
    local oc = Instance.new("Part")
    oc.Name = "OuterCircle"
    oc.Anchored = true
    oc.CanCollide = false
    oc.CastShadow = false
    oc.Color = Color3.fromRGB(0,0,128)
    oc.Material = Enum.Material.Neon
    oc.Transparency = 0.95
    oc.Size = Vector3.new(0.9,0.9,0.9)
    oc.Parent = model
    local ocM = Instance.new("SpecialMesh")
    ocM.MeshType = Enum.MeshType.Sphere
    ocM.Scale = Vector3.new(7.7,7.7,7.7)
    ocM.Parent = oc

    -- Sparkles Part
    local sp = Instance.new("Part")
    sp.Name = "Sparkles83"
    sp.Anchored = true
    sp.CanCollide = false
    sp.Transparency = 1
    sp.Size = Vector3.new(5,1,5)
    sp.Parent = model

    -- Legacy Particle Style
    local old = Instance.new("ParticleEmitter")
    old.Name = "OldSparkles"
    old.Lifetime = NumberRange.new(3,3)
    old.LightEmission = 1e9
    old.LockedToPart = true
    old.Rate = 7
    old.RotSpeed = NumberRange.new(25,25)
    old.Rotation = NumberRange.new(8,8)
    old.Size = NumberSequence.new(1)
    old.Speed = NumberRange.new(2,4)
    old.Texture = "rbxassetid://6334617852"
    old.Transparency = NumberSequence.new(0.5,1)
    old.Parent = sp

    -- Glow Rays
    local rays = Instance.new("ParticleEmitter")
    rays.Name = "Rays"
    rays.Lifetime = NumberRange.new(1,1)
    rays.LightEmission = 1
    rays.LockedToPart = true
    rays.Rate = 100
    rays.RotSpeed = NumberRange.new(-50,50)
    rays.Rotation = NumberRange.new(-180,180)
    rays.Size = NumberSequence.new(2)
    rays.Speed = NumberRange.new(0,0)
    rays.Texture = "rbxassetid://1084975295"
    rays.Transparency = NumberSequence.new(0.4,1)
    rays.Parent = main

    -- Pulsing Animation
    task.spawn(function()
        while model.Parent do
            TweenService:Create(mc, TweenInfo.new(0.55, Enum.EasingStyle.Sine), {Transparency = 0.95}):Play()
            TweenService:Create(oc, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {Transparency = 0.6}):Play()
            task.wait(0.55)
            TweenService:Create(oc, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Transparency = 0.95}):Play()
            TweenService:Create(mc, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Transparency = 0.6}):Play()
            task.wait(0.35)
        end
    end)

    return model
end

local currentModel = nil
local char = lp.Character or lp.CharacterAdded:Wait()

-- Core Loop: Watch for Forcefields
task.spawn(function()
    while true do
        local ff = char and char:FindFirstChildOfClass("ForceField")
        if ff then
            ff.Visible = false -- Hide the new forcefield
            if not currentModel then 
                currentModel = buildFF() 
            end
        else
            if currentModel then
                currentModel:Destroy()
                currentModel = nil
            end
        end
        task.wait(0.1)
    end
end)

-- Follow Player
RunService.PreRender:Connect(function()
    if not currentModel or not char then return end
    local t = getTorso(char)
    if not t then return end

    local targetCF = t.CFrame
    for _,p in ipairs(currentModel:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CFrame = targetCF
        end
    end
end)

lp.CharacterAdded:Connect(function(newChar)
    char = newChar
    if currentModel then
        currentModel:Destroy()
        currentModel = nil
    end
end)
 ]],
	BetterEmotes   = [[ --EMOTES!

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))() ]],
	
	-- Skybox Script Slot
	Skybox_2008    = [[ --2008 skybox
-- Services
local Lighting = game:GetService("Lighting")

-- Marketplace Asset IDs
local skyboxId = 8199641442
local sunAssetId = 79910545334172
local moonAssetId = 5189246322

-- Helper function to extract the real image texture URL from a decal/model
local function resolveTexture(assetId)
    local success, result = pcall(function()
        local objects = game:GetObjects("rbxassetid://" .. assetId)
        for _, obj in ipairs(objects) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                return obj.Texture
            elseif obj:IsA("Model") or obj:IsA("Folder") then
                for _, desc in ipairs(obj:GetDescendants()) do
                    if desc:IsA("Decal") or desc:IsA("Texture") then
                        return desc.Texture
                    end
                end
            end
        end
    end)
    if success and result and result ~= "" then
        return result
    end
    return "rbxassetid://" .. assetId
end

-- Remove any existing skyboxes to prevent conflicts
for _, child in ipairs(Lighting:GetChildren()) do
    if child:IsA("Sky") then
        child:Destroy()
    end
end

-- Load and apply the skybox, sun, and moon
local success, errorMessage = pcall(function()
    local assets = game:GetObjects("rbxassetid://" .. skyboxId)
    local appliedSky = nil
    
    for _, asset in ipairs(assets) do
        if asset:IsA("Sky") then
            asset.Parent = Lighting
            appliedSky = asset
            break
        elseif asset:IsA("Model") then
            for _, descendant in ipairs(asset:GetDescendants()) do
                if descendant:IsA("Sky") then
                    descendant.Parent = Lighting
                    appliedSky = descendant
                    break
                end
            end
            if appliedSky then break end
        end
    end

    if appliedSky then
        -- Apply resolved textures and sizes
        appliedSky.SunTextureId = resolveTexture(sunAssetId)
        appliedSky.MoonTextureId = resolveTexture(moonAssetId)
        appliedSky.SunAngularSize = 21
        appliedSky.MoonAngularSize = 11
    else
        error("No Sky object found inside the asset.")
    end
end)

if not success then
    warn("Failed to load skybox textures: " .. tostring(errorMessage))
else
    print("舊版 Roblox 天空盒、太陽與月亮套用成功！")
end

 ]],
	
	-- Walking Sound Script
	WalkingSound_2016   = [[ local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local NORMAL_SPEED = 16
local EXPONENT = 0.5

local function setupAudioScaling(player)
	local function onCharacterAdded(character)
		local humanoid = character:WaitForChild("Humanoid")
		local rootPart = character:WaitForChild("HumanoidRootPart")
		
		local runningSound = rootPart:WaitForChild("Running", 5)
		local climbingSound = rootPart:WaitForChild("Climbing", 5)

		local defaultRunPitch = runningSound and runningSound.PlaybackSpeed or 1.85
		if defaultRunPitch <= 0 then defaultRunPitch = 1.85 end

		local defaultClimbPitch = climbingSound and climbingSound.PlaybackSpeed or 1.0
		if defaultClimbPitch <= 0 then defaultClimbPitch = 1.0 end

		local connection
		connection = RunService.RenderStepped:Connect(function()
			if not character:IsDescendantOf(workspace) or humanoid.Health <= 0 then
				connection:Disconnect()
				return 
			end
			
			local velocity = rootPart.AssemblyLinearVelocity
			local currentSpeed = velocity.Magnitude

			if currentSpeed > 0.1 then
				local ratio = currentSpeed / NORMAL_SPEED
				local curvedRatio = math.pow(ratio, EXPONENT)

				if runningSound then
					runningSound.PlaybackSpeed = math.clamp(curvedRatio * defaultRunPitch, 0.4, 3.5)
				end
				if climbingSound then
					climbingSound.PlaybackSpeed = math.clamp(curvedRatio * defaultClimbPitch, 0.4, 3.5)
				end
			else
				if runningSound then runningSound.PlaybackSpeed = defaultRunPitch end
				if climbingSound then climbingSound.PlaybackSpeed = defaultClimbPitch end
			end
		end)
	end

	if player.Character then
		onCharacterAdded(player.Character)
	end
	player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupAudioScaling(player)
end

Players.PlayerAdded:Connect(setupAudioScaling) ]],
}

------------------------------------------------------------
-- SERVICES & FILE PERSISTENCE ENGINE
------------------------------------------------------------
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local CONFIG_FILE_NAME = "BloxyParadoxConfig.json"

local SavedChoices = {}
local isSkipped = false
local isSkyboxEnabled = false
local isWalkingSound2016Enabled = false
local dontShowHidePopup = false
local isConfigMode = false
local setupCompleted = false

-- Function to save current configuration to disc
local function saveConfiguration()
	local dataToSave = {
		isSkipped = isSkipped,
		isSkyboxEnabled = isSkyboxEnabled,
		isWalkingSound2016Enabled = isWalkingSound2016Enabled,
		dontShowHidePopup = dontShowHidePopup,
		Choices = SavedChoices
	}
	if writefile then
		pcall(function()
			writefile(CONFIG_FILE_NAME, HttpService:JSONEncode(dataToSave))
		end)
	end
end

-- Function to load saved configuration from disc
local function loadConfiguration()
	if readfile and isfile and isfile(CONFIG_FILE_NAME) then
		local success, result = pcall(function()
			return HttpService:JSONDecode(readfile(CONFIG_FILE_NAME))
		end)
		if success and type(result) == "table" then
			isSkipped = result.isSkipped or false
			isSkyboxEnabled = result.isSkyboxEnabled or false
			isWalkingSound2016Enabled = result.isWalkingSound2016Enabled or false
			dontShowHidePopup = result.dontShowHidePopup or false
			SavedChoices = result.Choices or {}
		end
	end
end

-- Load saved choices immediately upon execution
loadConfiguration()

-- BUTTON FUNCTIONS ENGINE (DO NOT TOUCH)
local function RunInvincible(code)
	if code == "" or code == " " or code == nil then return end
	task.spawn(function()
		local func, err = loadstring(code)
		if func then 
			local success, runtimeErr = pcall(func)
			if not success then warn("PARADOX RUNTIME ERROR: " .. tostring(runtimeErr)) end
		else 
			warn("PARADOX SYNTAX ERROR: " .. tostring(err)) 
		end
	end)
end

-- Function to close the chat window if open without permanently disabling it
local function closeChatIfOpen()
	pcall(function()
		if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local chatWindow = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
			if chatWindow then
				chatWindow.Enabled = false
				task.defer(function()
					chatWindow.Enabled = true
				end)
			end
		end

		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		task.defer(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		end)
	end)
end

-- Run startup features if enabled
if isSkyboxEnabled then
	RunInvincible(MyScripts.Skybox_2008)
end
if isWalkingSound2016Enabled then
	RunInvincible(MyScripts.WalkingSound_2016)
end

local function ApplySavedChoices()
	if SavedChoices.Topbar then
		closeChatIfOpen()
		if SavedChoices.Topbar == "2024" then RunInvincible(MyScripts.Topbar_2024)
		elseif SavedChoices.Topbar == "2023_FFlags" then RunInvincible(MyScripts.Topbar_2023_FFlags)
		elseif SavedChoices.Topbar == "2023_WIP" then RunInvincible(MyScripts.Topbar_2023_WIP)
		elseif SavedChoices.Topbar == "2019" then RunInvincible(MyScripts.Topbar_2019)
		elseif SavedChoices.Topbar == "2017" then RunInvincible(MyScripts.Topbar_2017)
		elseif SavedChoices.Topbar == "2016_Adv" then RunInvincible(MyScripts.Topbar_2016_A)
		elseif SavedChoices.Topbar == "2016_Simp" then RunInvincible(MyScripts.Topbar_2016_S)
		elseif SavedChoices.Topbar == "2015" then RunInvincible(MyScripts.Topbar_2015) 
		elseif SavedChoices.Topbar == "2014" then RunInvincible(MyScripts.Topbar_2014)
		elseif SavedChoices.Topbar == "2013mobile" then RunInvincible(MyScripts.Topbar_2013_Mobile)
		elseif SavedChoices.Topbar == "2013" then RunInvincible(MyScripts.Topbar_2013)
		elseif SavedChoices.Topbar == "2012" then RunInvincible(MyScripts.Topbar_2012)
		elseif SavedChoices.Topbar == "2010" then RunInvincible(MyScripts.Topbar_2010) end
	end

	if SavedChoices.SafeChat then RunInvincible(MyScripts.SafeChat) end

	if SavedChoices.Backpack == "simple" then RunInvincible(MyScripts.Backpack_S)
	elseif SavedChoices.Backpack == "advanced" then RunInvincible(MyScripts.Backpack_A) end

	if SavedChoices.Anims == "R6_2008" then RunInvincible(MyScripts.Anims_R6_2008)
	elseif SavedChoices.Anims == "R6_2006" then RunInvincible(MyScripts.Anims_R6_2006)
	elseif SavedChoices.Anims == "R6_2014" then RunInvincible(MyScripts.Anims_R6_2014)
	elseif SavedChoices.Anims == "R15_2008" then RunInvincible(MyScripts.Anims_R15_2008)
	elseif SavedChoices.Anims == "R15_2014" then RunInvincible(MyScripts.Anims_R15_2014)
	elseif SavedChoices.Anims == "R15_Old" then RunInvincible(MyScripts.Anims_R15_Old) end

	if SavedChoices.Sounds then RunInvincible(MyScripts.OldSounds) end

	if SavedChoices.Mouse == "2008_full" then RunInvincible(MyScripts.Mouse_2008_Full)
	elseif SavedChoices.Mouse == "2008_aspects" then RunInvincible(MyScripts.Mouse_2008_Aspects)
	elseif SavedChoices.Mouse == "2016" then RunInvincible(MyScripts.Mouse_2016) end

	if SavedChoices.Textures == "2008" then RunInvincible(MyScripts.Textures_2008)
	elseif SavedChoices.Textures == "2012" then RunInvincible(MyScripts.Textures_2012)
	elseif SavedChoices.Textures == "2016" then RunInvincible(MyScripts.Textures_2016) end

	if SavedChoices.MobileJump then RunInvincible(MyScripts.MobileJump_Old) end
	if SavedChoices.Body2006 then RunInvincible(MyScripts.Body_2006) end
	if SavedChoices.Materials then RunInvincible(MyScripts.OldMaterials) end

	if SavedChoices.Forcefield == "2008" then RunInvincible(MyScripts.Forcefield_2008)
	elseif SavedChoices.Forcefield == "2012" then RunInvincible(MyScripts.Forcefield_2012) end

	if SavedChoices.Particles then RunInvincible(MyScripts.OldParticles) end
	if SavedChoices.Emotes then RunInvincible(MyScripts.BetterEmotes) end
end

------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------
local CLICK_ID = "rbxassetid://12221967" 
local HEADER_IMAGE = "rbxthumb://type=Asset&id=131822012703327&w=420&h=420"
local HAMMER_IMAGE = "rbxthumb://type=Asset&id=103350336547520&w=420&h=420"

local plr = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local pg = plr:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui")
sg.Name = "BloxyParadoxProject"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999 
sg.ClipToDeviceSafeArea = false 
sg.Parent = pg

------------------------------------------------------------
-- SOUND SETUP
------------------------------------------------------------
local sfx = Instance.new("Sound")
sfx.SoundId = CLICK_ID
sfx.Volume = 0.6
sfx.Parent = game:GetService("SoundService")

local function playClick()
	sfx:Stop() 
	sfx:Play()
end

------------------------------------------------------------
-- DRAGGABLE ENGINE (MOBILE CAMERA LOCK FIX)
------------------------------------------------------------
local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos

	local function freezeCamera(actionName, inputState, inputObject)
		if dragging then
			return Enum.ContextActionResult.Sink
		end
		return Enum.ContextActionResult.Pass
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			ContextActionService:BindActionAtPriority(
				"DisableCameraDrag",
				freezeCamera,
				false,
				Enum.ContextActionPriority.High.Value,
				Enum.UserInputType.Touch,
				Enum.UserInputType.MouseMovement
			)

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					ContextActionService:UnbindAction("DisableCameraDrag")
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

------------------------------------------------------------
-- HAMMER DECORATION & PANEL
------------------------------------------------------------
local hammer = Instance.new("ImageLabel")
hammer.Name = "DecorativeHammer"
hammer.BackgroundTransparency = 1
hammer.Image = HAMMER_IMAGE
hammer.Size = UDim2.new(0, 80, 0, 80)
hammer.Rotation = -20
hammer.ZIndex = 100 
hammer.Parent = sg

local hammerBtn = Instance.new("TextButton")
hammerBtn.Name = "HammerClicker"
hammerBtn.BackgroundTransparency = 1
hammerBtn.Text = ""
hammerBtn.Size = UDim2.new(1, 0, 1, 0)
hammerBtn.ZIndex = 101
hammerBtn.Parent = hammer

hammer.Position = UDim2.new(1, 40, 0.5, -40)

task.defer(function()
	TweenService:Create(
		hammer, 
		TweenInfo.new(1.0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), 
		{Position = UDim2.new(1, -40, 0.5, -40)}
	):Play()
end)

local fontBold = Font.new(
	"rbxasset://fonts/families/Arial.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal
)

local hammerPanel = Instance.new("Frame")
hammerPanel.Name = "HammerBigPanel"
hammerPanel.AnchorPoint = Vector2.new(0, 0)
hammerPanel.Size = UDim2.new(0.35, 0, 0.88, 60)
hammerPanel.Position = UDim2.new(1, 40, 0, -40)
hammerPanel.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
hammerPanel.BackgroundTransparency = 0.5
hammerPanel.BorderSizePixel = 0
hammerPanel.ZIndex = 95
hammerPanel.Parent = sg

local panelStroke = Instance.new("UIStroke")
panelStroke.Name = "PanelOutline"
panelStroke.Color = Color3.fromRGB(255, 255, 255)
panelStroke.Thickness = 1.5
panelStroke.Transparency = 0
panelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
panelStroke.LineJoinMode = Enum.LineJoinMode.Miter
panelStroke.Parent = hammerPanel

------------------------------------------------------------
-- OUTSIDE INFO POPUP (DYNAMIC TEXT SIZING)
------------------------------------------------------------
local activeHelpType = nil

local infoPanel = Instance.new("Frame")
infoPanel.Name = "SkipInfoPanel"
infoPanel.Size = UDim2.new(0, 360, 0, 200)
infoPanel.Position = UDim2.new(0, -385, 0, 0)
infoPanel.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
infoPanel.BackgroundTransparency = 0.5
infoPanel.BorderSizePixel = 0
infoPanel.ZIndex = 110
infoPanel.Visible = false
infoPanel.Parent = hammerPanel

makeDraggable(infoPanel)

local infoStroke = Instance.new("UIStroke")
infoStroke.Name = "InfoOutline"
infoStroke.Color = Color3.fromRGB(255, 255, 255)
infoStroke.Thickness = 1.5
infoStroke.Transparency = 0
infoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
infoStroke.LineJoinMode = Enum.LineJoinMode.Miter
infoStroke.Parent = infoPanel

local infoText = Instance.new("TextLabel")
infoText.Name = "InfoText"
infoText.Size = UDim2.new(1, -35, 1, -4)
infoText.Position = UDim2.new(0, 10, 0, 2)
infoText.BackgroundTransparency = 1
infoText.FontFace = fontBold
infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Center
infoText.Text = ""
infoText.ZIndex = 111
infoText.Parent = infoPanel

local closeInfoBtn = Instance.new("TextButton")
closeInfoBtn.Name = "CloseInfoButton"
closeInfoBtn.Size = UDim2.new(0, 26, 0, 26)
closeInfoBtn.Position = UDim2.new(1, -28, 0, 2)
closeInfoBtn.BackgroundTransparency = 1
closeInfoBtn.Text = "X"
closeInfoBtn.Font = Enum.Font.SourceSansBold
closeInfoBtn.TextSize = 20
closeInfoBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
closeInfoBtn.ZIndex = 112
closeInfoBtn.Parent = infoPanel

closeInfoBtn.MouseButton1Click:Connect(function()
	playClick()
	infoPanel.Visible = false
	activeHelpType = nil
end)

local SKIP_HELP_TEXT = "啟用此功能後，當您按下自訂設定按鈕時會自動儲存您上次的選擇。這樣您每次執行腳本時就不需要重新設定，意味著您可以直接將其放入自動執行（autoexecute）中！此功能僅在您按下自訂設定按鈕後生效。"
local SKYBOX_HELP_TEXT = "啟用後將套用 2008 年經典天空盒；停用後需要重新加入遊戲才能恢復預設天空盒。"
local WALKING_SOUND_2016_HELP_TEXT = "啟用後，您的行走與攀爬音效聲調將根據移動速度動態改變：速度高於預設的 16 時音調會變高（越快越高），速度較慢時音調會變低。若要停用此功能需重新加入遊戲。"

local function updateDynamicTextSize(targetText)
	local strLength = #targetText
	
	if strLength <= 50 then
		infoText.TextSize = 18
	elseif strLength >= 250 then
		infoText.TextSize = 12
	else
		local scale = (strLength - 50) / (250 - 50)
		infoText.TextSize = math.floor(18 - (scale * (18 - 12)))
	end
end

local function toggleHelpMenu(menuType)
	if infoPanel.Visible and activeHelpType == menuType then
		infoPanel.Visible = false
		activeHelpType = nil
	else
		local txt = (menuType == "Skip") and SKIP_HELP_TEXT or ((menuType == "WalkingSound2016") and WALKING_SOUND_2016_HELP_TEXT or SKYBOX_HELP_TEXT)
		infoText.Text = txt
		updateDynamicTextSize(txt)
		infoPanel.Visible = true
		activeHelpType = menuType
	end
end

------------------------------------------------------------
-- SKIP SETUP TOGGLE & CONTROLS
------------------------------------------------------------
local skipContainer = Instance.new("Frame")
skipContainer.Name = "SkipSetupContainer"
skipContainer.Size = UDim2.new(1, -30, 0, 30)
skipContainer.Position = UDim2.new(0, 15, 0, 40)
skipContainer.BackgroundTransparency = 1
skipContainer.ZIndex = 96
skipContainer.Parent = hammerPanel

local skipLabel = Instance.new("TextLabel")
skipLabel.Name = "SkipLabel"
skipLabel.Size = UDim2.new(0, 80, 1, 0)
skipLabel.Position = UDim2.new(0, 0, 0, 0)
skipLabel.BackgroundTransparency = 1
skipLabel.FontFace = fontBold
skipLabel.TextSize = 16
skipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
skipLabel.TextXAlignment = Enum.TextXAlignment.Left
skipLabel.Text = "跳過設定"
skipLabel.ZIndex = 97
skipLabel.Parent = skipContainer

local skipCheckbox = Instance.new("TextButton")
skipCheckbox.Name = "SkipCheckbox"
skipCheckbox.Size = UDim2.new(0, 16, 0, 16)
skipCheckbox.Position = UDim2.new(0, 85, 0.5, -8)
skipCheckbox.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
skipCheckbox.BackgroundTransparency = 0.5
skipCheckbox.BorderSizePixel = 0
skipCheckbox.Text = isSkipped and "✓" or ""
skipCheckbox.Font = Enum.Font.SourceSansBold
skipCheckbox.TextSize = 18
skipCheckbox.TextColor3 = Color3.fromRGB(0, 220, 0)
skipCheckbox.ZIndex = 97
skipCheckbox.Parent = skipContainer

local boxStroke = Instance.new("UIStroke")
boxStroke.Name = "BoxOutline"
boxStroke.Color = Color3.fromRGB(255, 255, 255)
boxStroke.Thickness = 1.2
boxStroke.Transparency = 0
boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
boxStroke.LineJoinMode = Enum.LineJoinMode.Miter
boxStroke.Parent = skipCheckbox

skipCheckbox.MouseButton1Click:Connect(function()
	playClick()
	isSkipped = not isSkipped
	skipCheckbox.Text = isSkipped and "✓" or ""
	saveConfiguration()
end)

local configureBtn = Instance.new("TextButton")
configureBtn.Name = "ConfigureButton"
configureBtn.Size = UDim2.new(0, 60, 0, 16)
configureBtn.Position = UDim2.new(0, 107, 0.5, -8)
configureBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
configureBtn.BackgroundTransparency = 0.5
configureBtn.BorderSizePixel = 0
configureBtn.Text = "自訂設定"
configureBtn.Font = Enum.Font.Legacy
configureBtn.TextSize = 10
configureBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
configureBtn.ZIndex = 97
configureBtn.Visible = false
configureBtn.Parent = skipContainer

local configStroke = Instance.new("UIStroke")
configStroke.Name = "ConfigOutline"
configStroke.Color = Color3.fromRGB(255, 255, 255)
configStroke.Thickness = 1.2
configStroke.Transparency = 0
configStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
configStroke.LineJoinMode = Enum.LineJoinMode.Miter
configStroke.Parent = configureBtn

local helpBtn = Instance.new("TextButton")
helpBtn.Name = "HelpButton"
helpBtn.Size = UDim2.new(0, 16, 0, 16)
helpBtn.Position = UDim2.new(0, 107, 0.5, -8)
helpBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
helpBtn.BackgroundTransparency = 0.5
helpBtn.BorderSizePixel = 0
helpBtn.Text = "?"
helpBtn.Font = Enum.Font.SourceSansBold
helpBtn.TextSize = 14
helpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
helpBtn.ZIndex = 97
helpBtn.Parent = skipContainer

local helpStroke = Instance.new("UIStroke")
helpStroke.Name = "HelpOutline"
helpStroke.Color = Color3.fromRGB(255, 255, 255)
helpStroke.Thickness = 1.2
helpStroke.Transparency = 0
helpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
helpStroke.LineJoinMode = Enum.LineJoinMode.Miter
helpStroke.Parent = helpBtn

helpBtn.MouseButton1Click:Connect(function()
	playClick()
	toggleHelpMenu("Skip")
end)

------------------------------------------------------------
-- 2008 SKYBOX TOGGLE & CONTROLS
------------------------------------------------------------
local skyboxContainer = Instance.new("Frame")
skyboxContainer.Name = "SkyboxContainer"
skyboxContainer.Size = UDim2.new(1, -30, 0, 30)
skyboxContainer.Position = UDim2.new(0, 15, 0, 80)
skyboxContainer.BackgroundTransparency = 1
skyboxContainer.ZIndex = 96
skyboxContainer.Parent = hammerPanel

local skyboxLabel = Instance.new("TextLabel")
skyboxLabel.Name = "SkyboxLabel"
skyboxLabel.Size = UDim2.new(0, 95, 1, 0)
skyboxLabel.Position = UDim2.new(0, 0, 0, 0)
skyboxLabel.BackgroundTransparency = 1
skyboxLabel.FontFace = fontBold
skyboxLabel.TextSize = 16
skyboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
skyboxLabel.TextXAlignment = Enum.TextXAlignment.Left
skyboxLabel.Text = "2008 天空盒"
skyboxLabel.ZIndex = 97
skyboxLabel.Parent = skyboxContainer

local skyboxCheckbox = Instance.new("TextButton")
skyboxCheckbox.Name = "SkyboxCheckbox"
skyboxCheckbox.Size = UDim2.new(0, 16, 0, 16)
skyboxCheckbox.Position = UDim2.new(0, 100, 0.5, -8)
skyboxCheckbox.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
skyboxCheckbox.BackgroundTransparency = 0.5
skyboxCheckbox.BorderSizePixel = 0
skyboxCheckbox.Text = isSkyboxEnabled and "✓" or ""
skyboxCheckbox.Font = Enum.Font.SourceSansBold
skyboxCheckbox.TextSize = 18
skyboxCheckbox.TextColor3 = Color3.fromRGB(0, 220, 0)
skyboxCheckbox.ZIndex = 97
skyboxCheckbox.Parent = skyboxContainer

local skyboxBoxStroke = Instance.new("UIStroke")
skyboxBoxStroke.Name = "SkyboxBoxOutline"
skyboxBoxStroke.Color = Color3.fromRGB(255, 255, 255)
skyboxBoxStroke.Thickness = 1.2
skyboxBoxStroke.Transparency = 0
skyboxBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
skyboxBoxStroke.LineJoinMode = Enum.LineJoinMode.Miter
skyboxBoxStroke.Parent = skyboxCheckbox

skyboxCheckbox.MouseButton1Click:Connect(function()
	playClick()
	isSkyboxEnabled = not isSkyboxEnabled
	skyboxCheckbox.Text = isSkyboxEnabled and "✓" or ""
	saveConfiguration()
end)

local skyboxHelpBtn = Instance.new("TextButton")
skyboxHelpBtn.Name = "SkyboxHelpButton"
skyboxHelpBtn.Size = UDim2.new(0, 16, 0, 16)
skyboxHelpBtn.Position = UDim2.new(0, 122, 0.5, -8)
skyboxHelpBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
skyboxHelpBtn.BackgroundTransparency = 0.5
skyboxHelpBtn.BorderSizePixel = 0
skyboxHelpBtn.Text = "?"
skyboxHelpBtn.Font = Enum.Font.SourceSansBold
skyboxHelpBtn.TextSize = 14
skyboxHelpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
skyboxHelpBtn.ZIndex = 97
skyboxHelpBtn.Parent = skyboxContainer

local skyboxHelpStroke = Instance.new("UIStroke")
skyboxHelpStroke.Name = "SkyboxHelpOutline"
skyboxHelpStroke.Color = Color3.fromRGB(255, 255, 255)
skyboxHelpStroke.Thickness = 1.2
skyboxHelpStroke.Transparency = 0
skyboxHelpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
skyboxHelpStroke.LineJoinMode = Enum.LineJoinMode.Miter
skyboxHelpStroke.Parent = skyboxHelpBtn

skyboxHelpBtn.MouseButton1Click:Connect(function()
	playClick()
	toggleHelpMenu("Skybox")
end)

------------------------------------------------------------
-- 2016 WALKING SOUND TOGGLE & CONTROLS
------------------------------------------------------------
local walkingSound2016Container = Instance.new("Frame")
walkingSound2016Container.Name = "WalkingSound2016Container"
walkingSound2016Container.Size = UDim2.new(1, -30, 0, 30)
walkingSound2016Container.Position = UDim2.new(0, 15, 0, 120)
walkingSound2016Container.BackgroundTransparency = 1
walkingSound2016Container.ZIndex = 96
walkingSound2016Container.Parent = hammerPanel

local walkingSound2016Label = Instance.new("TextLabel")
walkingSound2016Label.Name = "WalkingSound2016Label"
walkingSound2016Label.Size = UDim2.new(0, 140, 1, 0)
walkingSound2016Label.Position = UDim2.new(0, 0, 0, 0)
walkingSound2016Label.BackgroundTransparency = 1
walkingSound2016Label.FontFace = fontBold
walkingSound2016Label.TextSize = 16
walkingSound2016Label.TextColor3 = Color3.fromRGB(255, 255, 255)
walkingSound2016Label.TextXAlignment = Enum.TextXAlignment.Left
walkingSound2016Label.Text = "2016 行走音效"
walkingSound2016Label.ZIndex = 97
walkingSound2016Label.Parent = walkingSound2016Container

local walkingSound2016Checkbox = Instance.new("TextButton")
walkingSound2016Checkbox.Name = "WalkingSound2016Checkbox"
walkingSound2016Checkbox.Size = UDim2.new(0, 16, 0, 16)
walkingSound2016Checkbox.Position = UDim2.new(0, 145, 0.5, -8)
walkingSound2016Checkbox.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
walkingSound2016Checkbox.BackgroundTransparency = 0.5
walkingSound2016Checkbox.BorderSizePixel = 0
walkingSound2016Checkbox.Text = isWalkingSound2016Enabled and "✓" or ""
walkingSound2016Checkbox.Font = Enum.Font.SourceSansBold
walkingSound2016Checkbox.TextSize = 18
walkingSound2016Checkbox.TextColor3 = Color3.fromRGB(0, 220, 0)
walkingSound2016Checkbox.ZIndex = 97
walkingSound2016Checkbox.Parent = walkingSound2016Container

local walkingSound2016BoxStroke = Instance.new("UIStroke")
walkingSound2016BoxStroke.Name = "WalkingSound2016BoxOutline"
walkingSound2016BoxStroke.Color = Color3.fromRGB(255, 255, 255)
walkingSound2016BoxStroke.Thickness = 1.2
walkingSound2016BoxStroke.Transparency = 0
walkingSound2016BoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
walkingSound2016BoxStroke.LineJoinMode = Enum.LineJoinMode.Miter
walkingSound2016BoxStroke.Parent = walkingSound2016Checkbox

walkingSound2016Checkbox.MouseButton1Click:Connect(function()
	playClick()
	isWalkingSound2016Enabled = not isWalkingSound2016Enabled
	walkingSound2016Checkbox.Text = isWalkingSound2016Enabled and "✓" or ""
	if isWalkingSound2016Enabled then
		RunInvincible(MyScripts.WalkingSound_2016)
	end
	saveConfiguration()
end)

local walkingSound2016HelpBtn = Instance.new("TextButton")
walkingSound2016HelpBtn.Name = "WalkingSound2016HelpButton"
walkingSound2016HelpBtn.Size = UDim2.new(0, 16, 0, 16)
walkingSound2016HelpBtn.Position = UDim2.new(0, 167, 0.5, -8)
walkingSound2016HelpBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
walkingSound2016HelpBtn.BackgroundTransparency = 0.5
walkingSound2016HelpBtn.BorderSizePixel = 0
walkingSound2016HelpBtn.Text = "?"
walkingSound2016HelpBtn.Font = Enum.Font.SourceSansBold
walkingSound2016HelpBtn.TextSize = 14
walkingSound2016HelpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
walkingSound2016HelpBtn.ZIndex = 97
walkingSound2016HelpBtn.Parent = walkingSound2016Container

local walkingSound2016HelpStroke = Instance.new("UIStroke")
walkingSound2016HelpStroke.Name = "WalkingSound2016HelpOutline"
walkingSound2016HelpStroke.Color = Color3.fromRGB(255, 255, 255)
walkingSound2016HelpStroke.Thickness = 1.2
walkingSound2016HelpStroke.Transparency = 0
walkingSound2016HelpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
walkingSound2016HelpStroke.LineJoinMode = Enum.LineJoinMode.Miter
walkingSound2016HelpStroke.Parent = walkingSound2016HelpBtn

walkingSound2016HelpBtn.MouseButton1Click:Connect(function()
	playClick()
	toggleHelpMenu("WalkingSound2016")
end)

------------------------------------------------------------
-- HIDE HAMMER UI BUTTON & NOTIFICATION POPUP
------------------------------------------------------------
local hideContainer = Instance.new("Frame")
hideContainer.Name = "HideContainer"
hideContainer.Size = UDim2.new(1, -30, 0, 30)
hideContainer.Position = UDim2.new(0, 15, 0, 160)
hideContainer.BackgroundTransparency = 1
hideContainer.ZIndex = 96
hideContainer.Parent = hammerPanel

local hideHammerBtn = Instance.new("TextButton")
hideHammerBtn.Name = "HideHammerButton"
hideHammerBtn.Size = UDim2.new(0, 120, 0, 24)
hideHammerBtn.Position = UDim2.new(0, 0, 0.5, -12)
hideHammerBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
hideHammerBtn.BorderSizePixel = 0
hideHammerBtn.Text = "隱藏鐵錘 UI"
hideHammerBtn.FontFace = fontBold
hideHammerBtn.TextSize = 12
hideHammerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideHammerBtn.ZIndex = 97
hideHammerBtn.Parent = hideContainer

local hideBtnStroke = Instance.new("UIStroke")
hideBtnStroke.Name = "HideBtnOutline"
hideBtnStroke.Color = Color3.fromRGB(255, 80, 80)
hideBtnStroke.Thickness = 1.2
hideBtnStroke.Transparency = 0
hideBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
hideBtnStroke.LineJoinMode = Enum.LineJoinMode.Miter
hideBtnStroke.Parent = hideHammerBtn

local function showHiddenNotificationPopup()
	if dontShowHidePopup then return end

	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "鐵錘 UI 已隱藏",
			Text = "重新執行腳本以還原 UI",
			Icon = HAMMER_IMAGE,
			Duration = 5,
			Button1 = "確定",
			Button2 = "不再顯示"
		})
	end)

	task.spawn(function()
		local NotificationFrame
		local searchStartTime = os.clock()
		repeat
			NotificationFrame = CoreGui:FindFirstChild("RobloxGui") and CoreGui.RobloxGui:FindFirstChild("NotificationFrame")
			task.wait(0.1)
		until NotificationFrame or (os.clock() - searchStartTime > 3)

		if not NotificationFrame then return end

		local Button1, Button2
		local buttonStartTime = os.clock()
		repeat
			local notif = NotificationFrame:FindFirstChild("Notification")
			if notif then
				Button1 = notif:FindFirstChild("Button1")
				Button2 = notif:FindFirstChild("Button2")
			end
			task.wait(0.1)
		until (Button1 and Button2) or (os.clock() - buttonStartTime > 3)

		if Button2 then
			Button2.MouseButton1Click:Connect(function()
				dontShowHidePopup = true
				saveConfiguration()
			end)
		end
	end)
end

hideHammerBtn.MouseButton1Click:Connect(function()
	playClick()
	infoPanel.Visible = false
	activeHelpType = nil

	local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	
	local hammerTween = TweenService:Create(hammer, tweenInfo, {Position = UDim2.new(1.3, 0, 0.5, -40)})
	local panelTween = TweenService:Create(hammerPanel, tweenInfo, {Position = UDim2.new(1.3, 0, 0, -40)})

	hammerTween:Play()
	panelTween:Play()

	panelTween.Completed:Connect(function()
		hammer:Destroy()
		hammerPanel:Destroy()
	end)

	showHiddenNotificationPopup()
end)

------------------------------------------------------------
-- HAMMER TOGGLE & PANEL SLIDE LOGIC
------------------------------------------------------------
local hammerPoppedOut = false

hammerBtn.MouseButton1Click:Connect(function()
	playClick()
	hammerPoppedOut = not hammerPoppedOut
	
	infoPanel.Visible = false
	activeHelpType = nil
	
	local targetPos = hammerPoppedOut and UDim2.new(1, -70, 0.5, -40) or UDim2.new(1, -40, 0.5, -40)
	local targetRot = hammerPoppedOut and 5 or -20
	local panelTargetPos = hammerPoppedOut and UDim2.new(0.65, -40, 0, -40) or UDim2.new(1, 40, 0, -40)
	
	TweenService:Create(
		hammer,
		TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{Position = targetPos, Rotation = targetRot}
	):Play()

	TweenService:Create(
		hammerPanel,
		TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{Position = panelTargetPos}
	):Play()
end)

------------------------------------------------------------
-- UI HELPER FUNCTIONS
------------------------------------------------------------

local function attachHeaderImage(parentFrame)
	local img = Instance.new("ImageLabel")
	img.Name = "HeaderImage"
	img.BackgroundTransparency = 1
	img.Image = HEADER_IMAGE
	img.Size = UDim2.new(0, 260, 0, 160) 
	img.Position = UDim2.new(0.5, -130, 0, -111) 
	img.BorderSizePixel = 0
	img.ZIndex = 10 
	img.Parent = parentFrame
	return img
end

local function createStandardButton(text, pos, width, parent)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, width, 0, 32)
	btn.Position = pos
	btn.Text = text
	btn.Font = Enum.Font.Legacy
	btn.TextScaled = true 
	btn.AutoButtonColor = false
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	btn.TextColor3 = Color3.fromRGB(0, 0, 0)
	btn.ZIndex = 5
	btn.Parent = parent
	
	local constraint = Instance.new("UITextSizeConstraint", btn)
	constraint.MaxTextSize = 16
	constraint.MinTextSize = 8

	btn.MouseButton1Click:Connect(function()
		playClick()
	end)

	btn.MouseEnter:Connect(function()
		if btn.Active then
			btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)

	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextColor3 = Color3.fromRGB(0, 0, 0)
		btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	end)

	return btn
end

local function createCyanSliderButton(text, pos, width, parent)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, width, 0, 32)
	btn.Position = pos
	btn.Text = text
	btn.Font = Enum.Font.Legacy
	btn.TextScaled = true 
	btn.AutoButtonColor = false
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	btn.TextColor3 = Color3.fromRGB(0, 0, 0)
	btn.ZIndex = 5
	btn.Parent = parent
	
	local constraint = Instance.new("UITextSizeConstraint", btn)
	constraint.MaxTextSize = 16
	constraint.MinTextSize = 8

	btn.MouseButton1Click:Connect(function()
		playClick()
	end)

	btn.MouseEnter:Connect(function()
		if btn.Active then
			btn.BackgroundColor3 = Color3.fromRGB(44, 179, 255) 
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)       
			btn.BorderColor3 = Color3.fromRGB(0, 0, 0)           
		end
	end)

	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextColor3 = Color3.fromRGB(0, 0, 0)
		btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	end)

	return btn
end

local function genericExit(frame, callback)
	local t = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, frame.Position.X.Offset, 0, -250)})
	t:Play()
	t.Completed:Connect(function()
		frame:Destroy()
		if callback then 
			task.spawn(callback)
		end
	end)
end

local function checkIsR6()
	local character = plr.Character
	local hum = character and character:FindFirstChildOfClass("Humanoid")
	if hum then
		return (hum.RigType == Enum.HumanoidRigType.R6)
	elseif character and character:FindFirstChild("Torso") then
		return true
	end
	return false
end

-- Forward Declaring functions
local startSetupFlow, showSafeChatUI, showBackpackUI, showAnimsUI, showSoundsUI, showMouseUI, showTexturesUI, showMobileJumpUI, showBody2006UI, showMaterialsUI, showForcefieldUI, showParticlesUI, showEmotesUI

------------------------------------------------------------
-- ACTION HOOKS WITH SAVED CHOICES SUPPORT
------------------------------------------------------------
local OnTopbarSelected = function(choice)
	SavedChoices.Topbar = choice
	saveConfiguration()
	
	if not isConfigMode then
		closeChatIfOpen()
		if choice == "2024" then RunInvincible(MyScripts.Topbar_2024)
		elseif choice == "2023_FFlags" then RunInvincible(MyScripts.Topbar_2023_FFlags)
		elseif choice == "2023_WIP" then RunInvincible(MyScripts.Topbar_2023_WIP)
		elseif choice == "2019" then RunInvincible(MyScripts.Topbar_2019)
		elseif choice == "2017" then RunInvincible(MyScripts.Topbar_2017)
		elseif choice == "2016_Adv" then RunInvincible(MyScripts.Topbar_2016_A)
		elseif choice == "2016_Simp" then RunInvincible(MyScripts.Topbar_2016_S)
		elseif choice == "2015" then RunInvincible(MyScripts.Topbar_2015) 
		elseif choice == "2014" then RunInvincible(MyScripts.Topbar_2014)
		elseif choice == "2013mobile" then RunInvincible(MyScripts.Topbar_2013_Mobile)
		elseif choice == "2013" then RunInvincible(MyScripts.Topbar_2013)
		elseif choice == "2012" then RunInvincible(MyScripts.Topbar_2012)
		elseif choice == "2010" then RunInvincible(MyScripts.Topbar_2010) end
	end
end

local OnSafeChatSelected = function(enabled)
	SavedChoices.SafeChat = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.SafeChat) end
end

local OnBackpackSelected = function(choice)
	SavedChoices.Backpack = choice
	saveConfiguration()
	if not isConfigMode then
		if choice == "simple" then RunInvincible(MyScripts.Backpack_S)
		elseif choice == "advanced" then RunInvincible(MyScripts.Backpack_A) end
	end
end

local OnAnimsSelected = function(choice)
	SavedChoices.Anims = choice
	saveConfiguration()
	if not isConfigMode then
		if choice == "R6_2008" then RunInvincible(MyScripts.Anims_R6_2008)
		elseif choice == "R6_2006" then RunInvincible(MyScripts.Anims_R6_2006)
		elseif choice == "R6_2014" then RunInvincible(MyScripts.Anims_R6_2014)
		elseif choice == "R15_2008" then RunInvincible(MyScripts.Anims_R15_2008)
		elseif choice == "R15_2014" then RunInvincible(MyScripts.Anims_R15_2014)
		elseif choice == "R15_Old" then RunInvincible(MyScripts.Anims_R15_Old) end
	end
end

local OnSoundsSelected = function(enabled)
	SavedChoices.Sounds = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.OldSounds) end
end

local OnMouseSelected = function(choice)
	SavedChoices.Mouse = choice
	saveConfiguration()
	if not isConfigMode then
		if choice == "2008_full" then RunInvincible(MyScripts.Mouse_2008_Full)
		elseif choice == "2008_aspects" then RunInvincible(MyScripts.Mouse_2008_Aspects)
		elseif choice == "2016" then RunInvincible(MyScripts.Mouse_2016) end
	end
end

local OnTexturesSelected = function(choice)
	SavedChoices.Textures = choice
	saveConfiguration()
	if not isConfigMode then
		if choice == "2008" then RunInvincible(MyScripts.Textures_2008)
		elseif choice == "2012" then RunInvincible(MyScripts.Textures_2012)
		elseif choice == "2016" then RunInvincible(MyScripts.Textures_2016) end
	end
end

local OnMobileJumpSelected = function(enabled)
	SavedChoices.MobileJump = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.MobileJump_Old) end
end

local OnBody2006Selected = function(enabled)
	SavedChoices.Body2006 = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.Body_2006) end
end

local OnMaterialsSelected = function(enabled)
	SavedChoices.Materials = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.OldMaterials) end
end

local OnForcefieldSelected = function(choice)
	SavedChoices.Forcefield = choice
	saveConfiguration()
	if not isConfigMode then
		if choice == "2008" then RunInvincible(MyScripts.Forcefield_2008)
		elseif choice == "2012" then RunInvincible(MyScripts.Forcefield_2012) end
	end
end

local OnParticlesSelected = function(enabled)
	SavedChoices.Particles = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.OldParticles) end
end

local OnEmotesSelected = function(enabled)
	SavedChoices.Emotes = enabled
	saveConfiguration()
	if enabled and not isConfigMode then RunInvincible(MyScripts.BetterEmotes) end
	
	setupCompleted = true
	isConfigMode = false
	configureBtn.Visible = true
	helpBtn.Position = UDim2.new(0, 172, 0.5, -8)
end

------------------------------------------------------------
-- CONFIGURE BUTTON EVENT
------------------------------------------------------------
configureBtn.MouseButton1Click:Connect(function()
	playClick()
	isConfigMode = true
	configureBtn.Visible = false
	helpBtn.Position = UDim2.new(0, 107, 0.5, -8)
	startSetupFlow()
end)

------------------------------------------------------------
-- MENU DEFINITIONS
------------------------------------------------------------

-- 13. EMOTES
showEmotesUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want better emotes?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f); OnEmotesSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f); OnEmotesSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 12. OLD PARTICLES
showParticlesUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want old particles?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showEmotesUI); OnParticlesSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showEmotesUI); OnParticlesSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 11. FORCEFIELD
showForcefieldUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 450, 0, 95), UDim2.new(0.5, -225, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,35), 1, "choose your forcefield", Enum.Font.Legacy, 14
	
	createStandardButton("2008 (僅限 R6)", UDim2.new(0,10,0,50), 135, f).MouseButton1Click:Connect(function() genericExit(f, showParticlesUI); OnForcefieldSelected("2008") end)
	createStandardButton("2012", UDim2.new(0,155,0,50), 135, f).MouseButton1Click:Connect(function() genericExit(f, showParticlesUI); OnForcefieldSelected("2012") end)
	createStandardButton("預設", UDim2.new(0,300,0,50), 140, f).MouseButton1Click:Connect(function() genericExit(f, showParticlesUI); OnForcefieldSelected("normal") end)
	
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -225, 0.5, -47)}):Play()
end

-- 10. OLD MATERIALS
showMaterialsUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want old materials?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showForcefieldUI); OnMaterialsSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showForcefieldUI); OnMaterialsSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 9. 2006 BODY
showBody2006UI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want the 2006 body?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showMaterialsUI); OnBody2006Selected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showMaterialsUI); OnBody2006Selected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 8. MOBILE JUMP BUTTON
showMobileJumpUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want the old mobile jump button?", Enum.Font.Legacy, 14
	
	local function getNextStep()
		return checkIsR6() and showBody2006UI or showMaterialsUI
	end
	
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, getNextStep()); OnMobileJumpSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, getNextStep()); OnMobileJumpSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 7. TEXTURES
showTexturesUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 560, 0, 95), UDim2.new(0.5, -280, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,35), 1, "What textures do you want to use?", Enum.Font.Legacy, 14
	createStandardButton("2008 材質", UDim2.new(0,10,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showMobileJumpUI); OnTexturesSelected("2008") end)
	createStandardButton("2012 材質", UDim2.new(0,145,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showMobileJumpUI); OnTexturesSelected("2012") end)
	createStandardButton("2016 材質", UDim2.new(0,280,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showMobileJumpUI); OnTexturesSelected("2016") end)
	createStandardButton("預設材質", UDim2.new(0,415,0,50), 135, f).MouseButton1Click:Connect(function() genericExit(f, showMobileJumpUI); OnTexturesSelected("normal") end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -280, 0.5, -47)}):Play()
end

-- 6. MOUSE CURSOR
showMouseUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 560, 0, 95), UDim2.new(0.5, -280, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,35), 1, "Choose your mouse cursor", Enum.Font.Legacy, 14
	createStandardButton("完整 2008 滑鼠", UDim2.new(0,15,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showTexturesUI); OnMouseSelected("2008_full") end)
	createStandardButton("2008 滑鼠樣式", UDim2.new(0,150,0,50), 155, f).MouseButton1Click:Connect(function() genericExit(f, showTexturesUI); OnMouseSelected("2008_aspects") end)
	createStandardButton("2016 滑鼠", UDim2.new(0,315,0,50), 115, f).MouseButton1Click:Connect(function() genericExit(f, showTexturesUI); OnMouseSelected("2016") end)
	createStandardButton("預設", UDim2.new(0,440,0,50), 105, f).MouseButton1Click:Connect(function() genericExit(f, showTexturesUI); OnMouseSelected("normal") end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -280, 0.5, -47)}):Play()
end

-- 5. OLD SOUNDS
showSoundsUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want old sounds?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showMouseUI); OnSoundsSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showMouseUI); OnSoundsSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 4. ANIMATIONS
showAnimsUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 560, 0, 95), UDim2.new(0.5, -280, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Font, t.TextSize = UDim2.new(1,0,0,35), 1, Enum.Font.Legacy, 14
	
	local isR6 = checkIsR6()

	if isR6 then
		t.Text = "選擇您的動作動畫：R6 模式"
		createStandardButton("2008", UDim2.new(0,10,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R6_2008") end)
		createStandardButton("2006", UDim2.new(0,145,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R6_2006") end)
		createStandardButton("2014", UDim2.new(0,280,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R6_2014") end)
		createStandardButton("預設材質", UDim2.new(0,415,0,50), 135, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("normal") end)
	else
		t.Text = "選擇您的動作動畫：R15 模式"
		createStandardButton("2008 FE", UDim2.new(0,10,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R15_2008") end)
		createStandardButton("2014 FE", UDim2.new(0,145,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R15_2014") end)
		createStandardButton("Old R15", UDim2.new(0,280,0,50), 125, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("R15_Old") end)
		createStandardButton("預設材質", UDim2.new(0,415,0,50), 135, f).MouseButton1Click:Connect(function() genericExit(f, showSoundsUI); OnAnimsSelected("normal") end)
	end
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -280, 0.5, -47)}):Play()
end

-- 3. BACKPACK
showBackpackUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 480, 0, 95), UDim2.new(0.5, -240, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,35), 1, "Do you want a custom backpack?", Enum.Font.Legacy, 14
	createStandardButton("否", UDim2.new(0,10,0,50), 90, f).MouseButton1Click:Connect(function() genericExit(f, showAnimsUI); OnBackpackSelected("none") end)
	createStandardButton("2008 簡易重製版", UDim2.new(0,110,0,50), 160, f).MouseButton1Click:Connect(function() genericExit(f, showAnimsUI); OnBackpackSelected("simple") end)
	createStandardButton("進階版", UDim2.new(0,285,0,50), 180, f).MouseButton1Click:Connect(function() genericExit(f, showAnimsUI); OnBackpackSelected("advanced") end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -240, 0.5, -47)}):Play()
end

-- 2. SAFE CHAT
showSafeChatUI = function()
	local f = Instance.new("Frame")
	f.Size, f.Position, f.BackgroundColor3, f.Parent = UDim2.new(0, 360, 0, 85), UDim2.new(0.5, -180, 0, -250), Color3.new(1,1,1), sg
	attachHeaderImage(f)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.Font, t.TextSize = UDim2.new(1,0,0,30), 1, "Do you want the old safe chat?", Enum.Font.Legacy, 14
	createStandardButton("是", UDim2.new(0,15,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showBackpackUI); OnSafeChatSelected(true) end)
	createStandardButton("否", UDim2.new(1,-165,0,45), 150, f).MouseButton1Click:Connect(function() genericExit(f, showBackpackUI); OnSafeChatSelected(false) end)
	TweenService:Create(f, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -180, 0.5, -42)}):Play()
end

-- 1. TOPBAR SELECTION (START)
startSetupFlow = function()
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 310, 0, 130) 
	mainFrame.Position = UDim2.new(0.5, -155, 0, -250)
	mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	mainFrame.ClipsDescendants = false 
	mainFrame.Parent = sg
	attachHeaderImage(mainFrame)

	local mainTitle = Instance.new("TextLabel", mainFrame)
	mainTitle.Size = UDim2.new(1, 0, 0, 35)
	mainTitle.BackgroundTransparency = 1
	mainTitle.Text = "您比較喜歡哪種頂欄？"
	mainTitle.Font = Enum.Font.Legacy
	mainTitle.TextSize = 14

	local currentSelectionId = "none"
	local expanded = false

	local dropdownToggle = createCyanSliderButton("none  ▼", UDim2.new(0.5, -67, 0, 42), 135, mainFrame)

	local slider = Instance.new("ScrollingFrame")
	slider.Size = UDim2.new(0, 135, 0, 120) 
	slider.Position = UDim2.new(0.5, -67, 0, 74)
	slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	slider.CanvasSize = UDim2.new(0, 0, 0, 490) 
	slider.ScrollBarThickness = 0 
	slider.Visible = false
	slider.ZIndex = 20 
	slider.Parent = mainFrame

	local scrollTrack = Instance.new("Frame")
	scrollTrack.Size = UDim2.new(0, 10, 0, 120)
	scrollTrack.Position = UDim2.new(0.5, 68, 0, 74)
	scrollTrack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scrollTrack.BorderColor3 = Color3.fromRGB(0, 0, 0)
	scrollTrack.BorderSizePixel = 1
	scrollTrack.ClipsDescendants = true 
	scrollTrack.ZIndex = 21
	scrollTrack.Visible = false
	scrollTrack.Parent = mainFrame

	local customScrollBar = Instance.new("Frame")
	customScrollBar.Size = UDim2.new(0, 10, 0, 30) 
	customScrollBar.Position = UDim2.new(0, 0, 0, 0) 
	customScrollBar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
	customScrollBar.BorderSizePixel = 0 
	customScrollBar.ZIndex = 22
	customScrollBar.Parent = scrollTrack

	slider:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		local maxScroll = slider.CanvasSize.Y.Offset - slider.Size.Y.Offset
		if maxScroll > 0 then
			local scrollPercent = math.clamp(slider.CanvasPosition.Y / maxScroll, 0, 1)
			local trackLength = scrollTrack.Size.Y.Offset - customScrollBar.Size.Y.Offset
			customScrollBar.Position = UDim2.new(0, 0, 0, scrollPercent * trackLength)
		end
	end)

	local options = {
		{text = "2024",           id = "2024"},
		{text = "2024(fflags)",   id = "2023_FFlags"},
		{text = "2023(w.i.p)",    id = "2023_WIP"},
		{text = "2019",           id = "2019"},
		{text = "2017",           id = "2017"},
		{text = "2016(no chat)",  id = "2016_Adv"},
		{text = "2016",           id = "2016_Simp"},
		{text = "2015",           id = "2015"},
		{text = "2014",           id = "2014"},
		{text = "2013 mobile",    id = "2013mobile"},
		{text = "2013",           id = "2013"},
		{text = "2012",           id = "2012"},
		{text = "2010",           id = "2010"},
		{text = "none",           id = "none"}
	}

	for i, opt in ipairs(options) do
		local optBtn = createCyanSliderButton(opt.text, UDim2.new(0, 0, 0, (i - 1) * 35), 135, slider)
		optBtn.Name = "Topbar" .. opt.id .. "Button"
		optBtn.ZIndex = 21
		optBtn.MouseButton1Click:Connect(function()
			currentSelectionId = opt.id
			dropdownToggle.Text = opt.text .. "  ▼"
			slider.Visible = false
			scrollTrack.Visible = false
			expanded = false
		end)
	end

	dropdownToggle.MouseButton1Click:Connect(function()
		expanded = not expanded
		slider.Visible = expanded
		scrollTrack.Visible = expanded
		local arrow = expanded and "  ▲" or "  ▼"
		local baseText = dropdownToggle.Text:sub(1, -5)
		dropdownToggle.Text = baseText .. arrow
	end)

	local confirmBtn = createStandardButton("確認", UDim2.new(0.5, -67, 0, 80), 135, mainFrame)
	confirmBtn.ZIndex = 5
	confirmBtn.MouseButton1Click:Connect(function()
		genericExit(mainFrame, showSafeChatUI)
		if currentSelectionId then
			OnTopbarSelected(currentSelectionId)
		end
	end)

	TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -155, 0.5, -65)}):Play()
end

------------------------------------------------------------
-- INITIAL LAUNCH DECISION ENGINE
------------------------------------------------------------
if isSkipped then
	ApplySavedChoices()
	configureBtn.Visible = true
	helpBtn.Position = UDim2.new(0, 172, 0.5, -8)
else
	startSetupFlow()
end