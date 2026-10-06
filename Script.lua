-- 建立動態天空盒動畫與i單曲音樂播放器 (Server Script 版本)

-- 定義天空盒貼圖 ID
local imageOne = "rbxassetid://169585459"
local imageTwo = "rbxassetid://169585475"
local imageThree = "rbxassetid://169585485"
local imageFour = "rbxassetid://169585502"
local imageFive = "rbxassetid://169585515"
local imageSix = "rbxassetid://169585502"
local imageSeven = "rbxassetid://169585485"
local imageEight = "rbxassetid://169585475"

-- 建立背景音樂
local s = Instance.new("Sound")
s.Parent = workspace
s.SoundId = "rbxassetid://138081566"
s.Volume = 1
s.PlaybackSpeed = 1
s.RollOffMaxDistance = 100000
s.Looped = true -- 設定為 true 讓音樂自動循環播放

-- 非同步播放單曲音樂
task.spawn(function()
    -- 如果音效還沒載入完成，等待它載入
    if not s.IsLoaded then
        s.Loaded:Wait()
    end
    
    s:Play()
end)

-- 建立或取得 Lighting 中的 Sky 物件
local Sky = game.Lighting:FindFirstChildOfClass("Sky")
if not Sky then
    Sky = Instance.new("Sky")
    Sky.Parent = game.Lighting
end

-- 動態切換天空盒動畫迴圈
task.spawn(function()
    local frames = { imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight }
    while true do
        for _, img in ipairs(frames) do
            Sky.SkyboxBk, Sky.SkyboxDn, Sky.SkyboxFt, Sky.SkyboxLf, Sky.SkyboxRt, Sky.SkyboxUp = img, img, img, img, img, img
            task.wait(0.15)
        end
    end
end)