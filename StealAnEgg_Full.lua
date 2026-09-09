-- ==============================================
-- 🌟 STEAL AN EGG — VERSI MENU LENGKAP GALANG 🌟
-- 💖 MENU SCROLL • PILIH NAMA • AMBIL LANGSUNG
-- ✈️ FLY • TELEPORT • KECEPATAN • SEMUA AREA
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character, RootPart

-- ==============================================
-- 💖 TAMPILAN AWAL
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalangScriptUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local BgFrame = Instance.new("Frame")
BgFrame.Size = UDim2.new(1,0,1,0)
BgFrame.BackgroundColor3 = Color3.fromHex("#0a0a1a")
BgFrame.Parent = ScreenGui

local StarContainer = Instance.new("Frame")
StarContainer.BackgroundTransparency = 1
StarContainer.Size = UDim2.new(1,0,1,0)
StarContainer.Parent = BgFrame

local Stars = {}
for i = 1, 100 do
    local Star = Instance.new("TextLabel")
    Star.BackgroundTransparency = 1
    Star.Text = "★"
    Star.TextColor3 = Color3.fromRGB(255,215,0)
    Star.Font = Enum.Font.GothamBold
    Star.TextSize = math.random(6, 16)
    Star.Size = UDim2.new(0, 16, 0, 16)
    Star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Star.Parent = StarContainer
    table.insert(Stars, Star)
end

RunService.RenderStepped:Connect(function()
    for _, Star in ipairs(Stars) do
        local X = Star.Position.X.Scale + math.random(-4,4)/10000
        local Y = Star.Position.Y.Scale + math.random(-3,3)/10000
        Star.Position = UDim2.new(
            (X > 1 or X < 0) and math.random() or X, 0,
            (Y > 1 or Y < 0) and math.random() or Y, 0
        )
    end
end)

local LoveFrame = Instance.new("Frame")
LoveFrame.Size = UDim2.new(0, 340, 0, 220)
LoveFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
LoveFrame.BackgroundTransparency = 1
LoveFrame.Parent = ScreenGui

local LoveText = Instance.new("TextLabel")
LoveText.Size = UDim2.new(1,0,1,0)
LoveText.BackgroundTransparency = 1
LoveText.Text = "💖 GALANG COMEND 💖\nSCRIPT STEAL AN EGG\n\n✅ MEMUAT MENU... ⭐"
LoveText.TextColor3 = Color3.fromRGB(255, 60, 120)
LoveText.Font = Enum.Font.GothamBlack
LoveText.TextSize = 30
LoveText.TextWrapped = true
LoveText.Parent = LoveFrame

task.wait(2.5)
LoveText.Text = "💖 SIAP! 💖\n✅ Menu Terbuka\n✈️ [F] Terbang • [U] Naik • [I] Turun"
task.wait(2)
LoveFrame:Destroy()

-- ==============================================
-- 📋 DAFTAR SEMUA PET & AREA
-- ==============================================
local DaftarPet = {
    {Area = "🌲 FOREST", Pet = {
        {Nama = "Chicken", Rarity = "Common"},
        {Nama = "Dog", Rarity = "Common"},
        {Nama = "Bird", Rarity = "Uncommon"},
        {Nama = "Owl", Rarity = "Rare"},
        {Nama = "Raccoon", Rarity = "Rare"},
        {Nama = "Fox", Rarity = "Epic"},
        {Nama = "Bear", Rarity = "Epic"},
        {Nama = "Brr Brr Patapim", Rarity = "Legendary"}
    }},
    {Area = "🏞️ LAKE", Pet = {
        {Nama = "Frog", Rarity = "Common"},
        {Nama = "Catfish", Rarity = "Uncommon"},
        {Nama = "Turtle", Rarity = "Rare"},
        {Nama = "Trulimero Trulicina", Rarity = "Epic"},
        {Nama = "Swan", Rarity = "Epic"},
        {Nama = "Axolotl", Rarity = "Legendary"},
        {Nama = "Leviathan", Rarity = "Cosmic"},
        {Nama = "Kraken", Rarity = "Eternal"}
    }},
    {Area = "🏜️ DESERT", Pet = {
        {Nama = "Jerboa", Rarity = "Common"},
        {Nama = "Lizard", Rarity = "Uncommon"},
        {Nama = "Camel", Rarity = "Rare"},
        {Nama = "Scorpion", Rarity = "Rare"},
        {Nama = "Snake", Rarity = "Epic"},
        {Nama = "Vulture", Rarity = "Epic"},
        {Nama = "Desert Dragon", Rarity = "Mythic"},
        {Nama = "Phoenix", Rarity = "Eternal"}
    }},
    {Area = "❄️ SNOW", Pet = {
        {Nama = "Penguin", Rarity = "Rare"},
        {Nama = "Walrus", Rarity = "Epic"},
        {Nama = "Polar Bear", Rarity = "Legendary"},
        {Nama = "Sabertooth Tiger", Rarity = "Mythic"},
        {Nama = "Mammoth", Rarity = "Mythic"},
        {Nama = "King Mammoth", Rarity = "Cosmic"},
        {Nama = "Yeti", Rarity = "Secret"},
        {Nama = "Ice Dragon", Rarity = "Eternal"}
    }},
    {Area = "🌴 JUNGLE", Pet = {
        {Nama = "Monkey", Rarity = "Common"},
        {Nama = "Parrot", Rarity = "Uncommon"},
        {Nama = "Gecko", Rarity = "Rare"},
        {Nama = "Boa", Rarity = "Rare"},
        {Nama = "Gorilla", Rarity = "Epic"},
        {Nama = "Leopard", Rarity = "Legendary"},
        {Nama = "Tiger", Rarity = "Mythic"},
        {Nama = "Jungle Spirit", Rarity = "Cosmic"}
    }},
    {Area = "🌋 VOLCANO", Pet = {
        {Nama = "Lava Lizard", Rarity = "Epic"},
        {Nama = "Fire Dragon", Rarity = "Legendary"},
        {Nama = "Magma Golem", Rarity = "Mythic"},
        {Nama = "Chillin Chilli", Rarity = "Mythic"},
        {Nama = "Volcano Guardian", Rarity = "Cosmic"},
        {Nama = "Inferno Skeleton", Rarity = "Secret"},
        {Nama = "Thunder Bird", Rarity = "Eternal"},
        {Nama = "Solar Phoenix", Rarity = "Divine"}
    }},
    {Area = "🌌 COSMIC", Pet = {
        {Nama = "Centapede", Rarity = "Epic"},
        {Nama = "Koi", Rarity = "Cosmic"},
        {Nama = "Snowy Owl", Rarity = "Cosmic"},
        {Nama = "Cosmic Dragon", Rarity = "Cosmic"},
        {Nama = "Lunar Dragon", Rarity = "Eternal"},
        {Nama = "Star Beast", Rarity = "Secret"},
        {Nama = "Alien Overlord", Rarity = "Divine"}
    }},
    {Area = "🌸 SAKURA", Pet = {
        {Nama = "Tea Master", Rarity = "Epic"},
        {Nama = "Crane", Rarity = "Legendary"},
        {Nama = "Bamboo Panda", Rarity = "Mythic"},
        {Nama = "Sakura Spirit", Rarity = "Cosmic"},
        {Nama = "Dragon Blossom", Rarity = "Eternal"},
        {Nama = "Oni Tiger", Rarity = "Eternal"},
        {Nama = "Stag", Rarity = "Secret"},
        {Nama = "Kitsune", Rarity = "Divine"}
    }},
    {Area = "🦖 PREHISTORIC", Pet = {
        {Nama = "Ancient Turtle", Rarity = "Epic"},
        {Nama = "Pterodactyl", Rarity = "Legendary"},
        {Nama = "T-Rex", Rarity = "Mythic"},
        {Nama = "Deinosuchus", Rarity = "Mythic"},
        {Nama = "Brontosaurus", Rarity = "Cosmic"},
        {Nama = "Fossil Beast", Rarity = "Secret"},
        {Nama = "Mosasaurus", Rarity = "Eternal"}
    }},
    {Area = "🏛️ TITAN TEMPLE", Pet = {
        {Nama = "Crystal Serpent", Rarity = "Rare"},
        {Nama = "Scorpion King", Rarity = "Epic"},
        {Nama = "Pharaoh Cat", Rarity = "Legendary"},
        {Nama = "Temple Dragon", Rarity = "Mythic"},
        {Nama = "Titan Golem", Rarity = "Cosmic"},
        {Nama = "Guardian Knight", Rarity = "Eternal"},
        {Nama = "Mutant Shark", Rarity = "Secret"},
        {Nama = "Nightflame", Rarity = "Divine"}
    }}
}

-- Warna Kelangkaan
local WarnaRarity = {
    Common = Color3.fromRGB(220,220,220),
    Uncommon = Color3.fromRGB(80,220,80),
    Rare = Color3.fromRGB(80,160,255),
    Epic = Color3.fromRGB(200,80,255),
    Legendary = Color3.fromRGB(255,180,0),
    Mythic = Color3.fromRGB(255,80,220),
    Cosmic = Color3.fromRGB(80,220,255),
    Eternal = Color3.fromRGB(255,50,50),
    Secret = Color3.fromRGB(255,255,80),
    Divine = Color3.fromRGB(255,160,255)
}

-- ==============================================
-- 🖥️ BUAT MENU SCROLL
-- ==============================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 330, 0, 480)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromHex("#1a1a2e")
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromHex("#ff4080")
MainFrame.CornerRadius = UDim.new(0, 12)
MainFrame.Parent = ScreenGui

local Judul = Instance.new("TextLabel")
Judul.Size = UDim2.new(1, 0, 0, 45)
Judul.BackgroundColor3 = Color3.fromHex("#ff2e70")
Judul.Text = "💖 GALANG — PILIH TELUR 💖"
Judul.TextColor3 = Color3.fromRGB(255,255,255)
Judul.Font = Enum.Font.GothamBlack
Judul.TextSize = 18
Judul.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -55)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 50)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarColor3 = Color3.fromHex("#ff4080")
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.Parent = ScrollingFrame

local Dipilih = nil
local FlyActive = false
local Keys = {W=false,A=false,S=false,D=false,U=false,I=false}

-- ==============================================
-- 🔍 CARI TELUR BERDASARKAN NAMA YANG DIPILIH
-- ==============================================
local function CariDanAmbil(NamaPet)
    if not LocalPlayer.Character then return end
    RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return end

    local NamaCari = NamaPet:lower()
    local Ketemu = nil

    local function Scan(Obj)
        if Ketemu then return end
        if Obj:IsA("BasePart") then
            local N = Obj.Name:lower()
            local P = Obj.Parent.Name:lower()
            if N:find(NamaCari) or P:find(NamaCari) or N:find("egg") and N:find(NamaCari) then
                local Click = Obj:FindFirstChild("ClickDetector")
                if Click then
                    Ketemu = {Part=Obj, Click=Click, Pos=Obj.Position}
                end
            end
        end
        for _, C in ipairs(Obj:GetChildren()) do Scan(C) end
    end
    Scan(workspace)

    if not Ketemu then
        print("❌ Tidak ketemu: "..NamaPet)
        return false
    end

    -- Teleport & Ambil
    RootPart.CFrame = CFrame.new(Ketemu.Pos + Vector3.new(0, 2.5, 0))
    task.wait(0.08)
    pcall(function() fireclickdetector(Ketemu.Click) end)
    print("✅ Diambil: "..NamaPet)
    return true
end

-- ==============================================
-- 📋 ISI MENU
-- ==============================================
for _, Grup in ipairs(DaftarPet) do
    local AreaLabel = Instance.new("TextLabel")
    AreaLabel.Size = UDim2.new(1, 0, 0, 32)
    AreaLabel.BackgroundColor3 = Color3.fromHex("#2a2a4e")
    AreaLabel.Text = Grup.Area
    AreaLabel.TextColor3 = Color3.fromRGB(255,215,0)
    AreaLabel.Font = Enum.Font.GothamBold
    AreaLabel.TextSize = 14
    AreaLabel.Parent = ScrollingFrame

    for _, Hewan in ipairs(Grup.Pet) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 38)
        Btn.BackgroundColor3 = Color3.fromHex("#252542")
        Btn.BorderSizePixel = 1
        Btn.BorderColor3 = WarnaRarity[Hewan.Rarity]
        Btn.Text = "🥚 "..Hewan.Nama.."  •  "..Hewan.Rarity
        Btn.TextColor3 = WarnaRarity[Hewan.Rarity]
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 13
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.TextPadding = UDim.new(0, 10)
        Btn.AutoLocalize = false
        Btn.Parent = ScrollingFrame

        Btn.MouseButton1Click:Connect(function()
            Dipilih = Hewan.Nama
            local Sukses = CariDanAmbil(Hewan.Nama)
            Btn.BackgroundColor3 = Sukses and Color3.fromHex("#1a4a2e") or Color3.fromHex("#4a1a2e")
            task.wait(1.5)
            Btn.BackgroundColor3 = Color3.fromHex("#252542")
        end)
    end
end

-- ==============================================
-- ✈️ MODE TERBANG
-- ==============================================
local function ToggleFly()
    FlyActive = not FlyActive
    if not LocalPlayer.Character then return end
    local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
    if Hum then Hum.PlatformStand = FlyActive end
    print(FlyActive and "✈️ FLY ON" or "✈️ FLY OFF")
end

UIS.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.F then ToggleFly() end
    if inp.KeyCode == Enum.KeyCode.W then Keys.W = true end
    if inp.KeyCode == Enum.KeyCode.A then Keys.A = true end
    if inp.KeyCode == Enum.KeyCode.S then Keys.S = true end
    if inp.KeyCode == Enum.KeyCode.D then Keys.D = true end
    if inp.KeyCode == Enum.KeyCode.U then Keys.U = true end
    if inp.KeyCode == Enum.KeyCode.I then Keys.I = true end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.W then Keys.W = false end
    if inp.KeyCode == Enum.KeyCode.A then Keys.A = false end
    if inp.KeyCode == Enum.KeyCode.S then Keys.S = false end
    if inp.KeyCode == Enum.KeyCode.D then Keys.D = false end
    if inp.KeyCode == Enum.KeyCode.U then Keys.U = false end
    if inp.KeyCode == Enum.KeyCode.I then Keys.I = false end
end)

RunService.RenderStepped:Connect(function()
    if not FlyActive or not RootPart then return end
    local Gerak = Vector3.new()
    if Keys.W then Gerak += Vector3.new(0, 0, -1) end
    if Keys.S then Gerak += Vector3.new(0, 0, 1) end
    if Keys.A then Gerak += Vector3.new(-1, 0, 0) end
    if Keys.D then Gerak += Vector3.new(1, 0, 0) end
    if Keys.U then Gerak += Vector3.new(0, 1, 0) end
    if Keys.I then Gerak += Vector3.new(0, -1, 0) end
    if Gerak.Magnitude > 0 then
        RootPart.CFrame += Gerak.Unit * 65
    end
end)

-- ==============================================
-- ✅ SIAP
-- ==============================================
print("💖 SCRIPT GALANG — SIAP DIPAKAI!")
print("📋 Pencet nama telur di menu untuk ambil")
print("✈️ [F] = Terbang • [U] Naik • [I] Turun")
