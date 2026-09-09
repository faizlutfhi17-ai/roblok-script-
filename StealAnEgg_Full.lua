-- ==============================================
-- 🌟 STEAL AN EGG — SCRIPT LENGKAP GALANG 🌟
-- 💖 LOGO CINTA • TELEPORT • FLY • KECEPATAN 1-1000
-- ⭐ LATAR BINTANG BERGERAK • RARITY TERTINGGI
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character, RootPart

-- ==============================================
-- 💖 TAMPILAN AWAL — LOGO CINTA & ANIMASI
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalangScriptUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- LATAR BELAKANG BINTANG BERGERAK ⭐
local BgFrame = Instance.new("Frame")
BgFrame.Name = "StarBackground"
BgFrame.Size = UDim2.new(1,0,1,0)
BgFrame.BackgroundColor3 = Color3.fromHex("#000000")
BgFrame.Parent = ScreenGui

local StarContainer = Instance.new("Frame")
StarContainer.BackgroundTransparency = 1
StarContainer.Size = UDim2.new(1,0,1,0)
StarContainer.Parent = BgFrame

-- Buat bintang bergerak
local Stars = {}
for i = 1, 80 do
    local Star = Instance.new("TextLabel")
    Star.Name = "Star"..i
    Star.BackgroundTransparency = 1
    Star.Text = "★"
    Star.TextColor3 = Color3.fromRGB(255,255,100)
    Star.Font = Enum.Font.GothamBold
    Star.TextSize = math.random(8, 18)
    Star.Size = UDim2.new(0, 20, 0, 20)
    Star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Star.Parent = StarContainer
    table.insert(Stars, Star)
end

-- ANIMASI BINTANG BERGERAK
RunService.RenderStepped:Connect(function()
    for _, Star in ipairs(Stars) do
        local X = Star.Position.X.Scale + math.random(-5,5)/10000
        local Y = Star.Position.Y.Scale + math.random(-3,3)/10000
        Star.Position = UDim2.new(
            (X > 1 or X < 0) and math.random() or X, 0,
            (Y > 1 or Y < 0) and math.random() or Y, 0
        )
    end
end)

-- LOGO CINTA 💖
local LoveFrame = Instance.new("Frame")
LoveFrame.Size = UDim2.new(0, 320, 0, 200)
LoveFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
LoveFrame.BackgroundTransparency = 1
LoveFrame.ZIndex = 100
LoveFrame.Parent = ScreenGui

local LoveText = Instance.new("TextLabel")
LoveText.Size = UDim2.new(1,0,1,0)
LoveText.BackgroundTransparency = 1
LoveText.Text = "💖 GALANG COMEND 💖\nSCRIPT STEAL AN EGG\n\n⭐ MEMUAT... ⭐"
LoveText.TextColor3 = Color3.fromRGB(255, 50, 100)
LoveText.Font = Enum.Font.GothamBlack
LoveText.TextSize = 28
LoveText.TextWrapped = true
LoveText.ZIndex = 101
LoveText.Parent = LoveFrame

-- Muncul perlahan
TweenService:Create(LoveText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(2.5)

-- Ganti jadi SUDAH SIAP
LoveText.Text = "💖 GALANG COMEND 💖\nSCRIPT STEAL AN EGG\n\n✅ SIAP DIGUNAKAN! ✅"
task.wait(1.5)
ScreenGui:Destroy()

-- ==============================================
-- ⚙️ PENGATURAN UTAMA
-- ==============================================
local Settings = {
    Enabled = true,
    Speed = 100,           -- Kecepatan ambil: 1-1000
    TeleportInstant = true,-- Teleport langsung ke telur
    FlyEnabled = false,    -- Mode terbang
    FlySpeed = 80,         -- Kecepatan terbang
    MaxDistance = 9999,    -- Jangkauan tak terbatas
    PreferRarity = true,   -- Ambil yang paling langka duluan
    RarityPriority = {     -- Urutan diambil duluan
        "Divine", "Secret", "Eternal", "Mythic", "Epic", "Rare", "Uncommon", "Common"
    }
}

local RarityOrder = {}
for i, name in ipairs(Settings.RarityPriority) do
    RarityOrder[name] = i
end

local FlyActive = false
local Keys = {W=false,A=false,S=false,D=false,U=false,I=false,O=false}

-- ==============================================
-- 🔍 CARI TELUR DAN URUTKAN BERDASARKAN KELANGKAAN
-- ==============================================
local function GetAllEggs()
    local Eggs = {}
    if not LocalPlayer.Character then return Eggs end
    RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return Eggs end

    for _, Desc in pairs(workspace:GetDescendants()) do
        if Desc:IsA("BasePart") then
            local Name = Desc.Name:lower() .. " " .. (Desc.Parent.Name:lower())
            if Name:find("egg") or Name:find("telur") then
                local Click = Desc:FindFirstChild("ClickDetector")
                if Click then
                    -- Cari kelangkaan
                    local Rarity = "Common"
                    for _, RName in ipairs(Settings.RarityPriority) do
                        if Desc.Name:find(RName:lower()) or Desc.Parent.Name:find(RName) then
                            Rarity = RName
                            break
                        end
                    end
                    table.insert(Eggs, {
                        Part = Desc,
                        Click = Click,
                        Rarity = Rarity,
                        RarityRank = RarityOrder[Rarity] or 999,
                        Distance = (Desc.Position - RootPart.Position).Magnitude
                    })
                end
            end
        end
    end

    -- Urut: Kelangkaan tertinggi duluan, lalu terdekat
    table.sort(Eggs, function(a,b)
        if Settings.PreferRarity and a.RarityRank ~= b.RarityRank then
            return a.RarityRank < b.RarityRank
        end
        return a.Distance < b.Distance
    end)
    return Eggs
end

-- ==============================================
-- ⚡ AMBIL TELUR — TELEPORT INSTAN
-- ==============================================
local function TakeEggInstant(TargetEgg)
    if not RootPart or not TargetEgg.Part then return end
    local Pos = TargetEgg.Part.Position

    -- Teleport langsung ke atas telur
    if Settings.TeleportInstant then
        RootPart.CFrame = CFrame.new(Pos + Vector3.new(0, 3, 0))
        task.wait(0.01)
    end

    -- Klik ambil
    pcall(function()
        fireclickdetector(TargetEgg.Click)
    end)
end

-- ==============================================
-- ✈️ MODE TERBANG INSTAN
-- ==============================================
local function ToggleFly()
    FlyActive = not FlyActive
    if not LocalPlayer.Character then return end
    local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
    if not Hum then return end

    if FlyActive then
        Hum.PlatformStand = true
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        print("✈️ Fly AKTIF")
    else
        Hum.PlatformStand = false
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        print("✈️ Fly MATI")
    end
end

-- Gerakan terbang
UserInputService.InputBegan:Connect(function(Inp)
    if Inp.KeyCode == Enum.KeyCode.W then Keys.W = true end
    if Inp.KeyCode == Enum.KeyCode.A then Keys.A = true end
    if Inp.KeyCode == Enum.KeyCode.S then Keys.S = true end
    if Inp.KeyCode == Enum.KeyCode.D then Keys.D = true end
    if Inp.KeyCode == Enum.KeyCode.U then Keys.U = true end
    if Inp.KeyCode == Enum.KeyCode.I then Keys.I = true end
    if Inp.KeyCode == Enum.KeyCode.O then Keys.O = true end
    if Inp.KeyCode == Enum.KeyCode.F then ToggleFly() end -- Tekan F = Nyalakan/Mati Fly
end)
UserInputService.InputEnded:Connect(function(Inp)
    if Inp.KeyCode == Enum.KeyCode.W then Keys.W = false end
    if Inp.KeyCode == Enum.KeyCode.A then Keys.A = false end
    if Inp.KeyCode == Enum.KeyCode.S then Keys.S = false end
    if Inp.KeyCode == Enum.KeyCode.D then Keys.D = false end
    if Inp.KeyCode == Enum.KeyCode.U then Keys.U = false end
    if Inp.KeyCode == Enum.KeyCode.I then Keys.I = false end
    if Inp.KeyCode == Enum.KeyCode.O then Keys.O = false end
end)

RunService.RenderStepped:Connect(function()
    if not FlyActive or not RootPart then return end
    local Move = Vector3.new()
    if Keys.W then Move += Vector3.new(0, 0, -1) end
    if Keys.S then Move += Vector3.new(0, 0, 1) end
    if Keys.A then Move += Vector3.new(-1, 0, 0) end
    if Keys.D then Move += Vector3.new(1, 0, 0) end
    if Keys.U then Move += Vector3.new(0, 1, 0) end
    if Keys.I then Move += Vector3.new(0, -1, 0) end
    if Move.Magnitude > 0 then
        RootPart.CFrame += Move.Unit * Settings.FlySpeed
    end
end)

-- ==============================================
-- 🔄 LOOP UTAMA — AMBIL TELUR TERUS-MENERUS
-- ==============================================
task.spawn(function()
    while task.wait(1000 / math.max(Settings.Speed, 1)) do
        if not Settings.Enabled then continue end
        LocalPlayer = Players.LocalPlayer
        if not LocalPlayer.Character then continue end
        RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then continue end

        local Eggs = GetAllEggs()
        if #Eggs == 0 then continue end

        -- Ambil telur terbaik
        TakeEggInstant(Eggs[1])
    end
end)

-- ==============================================
-- ✅ INFORMASI PENGGUNAAN
-- ==============================================
print(" ")
print("🌟 STEAL AN EGG — GALANG COMEND 🌟")
print("==================================")
print("✅ TELEPORT INSTAN: AKTIF")
print("✅ AMBIL RARITY TERTINGGI DULU: AKTIF")
print("✅ KECEPATAN AMBIL: "..Settings.Speed.."/1000")
print("✈️  TEKAN [F] = Nyalakan/Mati Fly")
print("   W A S D = Bergerak")
print("   U = Naik, I = Turun")
print("==================================")
print("💖 SEMOGA BERFUNGSI BAIK YA GALANG 💖")
