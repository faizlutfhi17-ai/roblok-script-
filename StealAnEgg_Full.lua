-- ==============================================
-- 🌟 GL SCRIPT — STEAL AN EGG 🌟
-- 💖 VERSI NO KEY • LANGSUNG JALAN!
-- 💖 Gaya BigFoot • Event Terbaru • Fitur Lengkap
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character, RootPart

-- ==============================================
-- 💖 TAMPILAN AWAL — NO KEY SYSTEM!
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GL_Script_UI"
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
LoveFrame.Size = UDim2.new(0, 380, 0, 260)
LoveFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
LoveFrame.BackgroundTransparency = 1
LoveFrame.Parent = ScreenGui

local LoveText = Instance.new("TextLabel")
LoveText.Size = UDim2.new(1,0,1,0)
LoveText.BackgroundTransparency = 1
LoveText.Text = "🌟 GL SCRIPT 🌟\nSTEAL AN EGG\n\n🔓 VERSI NO KEY!\n✅ LANGSUNG JALAN!"
LoveText.TextColor3 = Color3.fromRGB(0, 255, 180)
LoveText.Font = Enum.Font.GothamBlack
LoveText.TextSize = 30
LoveText.TextWrapped = true
LoveText.Parent = LoveFrame

task.wait(2.5)
LoveText.Text = "💖 GL SIAP! 💖\n✅ Menu Terbuka\n✈️ [F] Terbang • [U] Naik • [I] Turun"
task.wait(2)
LoveFrame:Destroy()

-- ==============================================
-- ⚙️ PENGATURAN
-- ==============================================
local Settings = {
    AutoSteal = false,
    AutoCollect = false,
    Teleport = true,
    FlySpeed = 80,
    StealSpeed = 100,
    PreferRarity = true,
    AutoEvent = false
}

local FlyActive = false
local Keys = {W=false,A=false,S=false,D=false,U=false,I=false}

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
-- 📋 DAFTAR AREA & PET
-- ==============================================
local DaftarArea = {
    {Nama = "🌲 FOREST", Pet = {
        {Nama = "Chicken", Rarity = "Common"},
        {Nama = "Dog", Rarity = "Common"},
        {Nama = "Bird", Rarity = "Uncommon"},
        {Nama = "Owl", Rarity = "Rare"},
        {Nama = "Raccoon", Rarity = "Rare"},
        {Nama = "Fox", Rarity = "Epic"},
        {Nama = "Bear", Rarity = "Epic"},
        {Nama = "Brr Brr Patapim", Rarity = "Legendary"}
    }},
    {Nama = "🏞️ LAKE", Pet = {
        {Nama = "Frog", Rarity = "Common"},
        {Nama = "Catfish", Rarity = "Uncommon"},
        {Nama = "Turtle", Rarity = "Rare"},
        {Nama = "Trulimero Trulicina", Rarity = "Epic"},
        {Nama = "Swan", Rarity = "Epic"},
        {Nama = "Axolotl", Rarity = "Legendary"},
        {Nama = "Leviathan", Rarity = "Cosmic"},
        {Nama = "Kraken", Rarity = "Eternal"}
    }},
    {Nama = "🏜️ DESERT", Pet = {
        {Nama = "Jerboa", Rarity = "Common"},
        {Nama = "Lizard", Rarity = "Uncommon"},
        {Nama = "Camel", Rarity = "Rare"},
        {Nama = "Scorpion", Rarity = "Rare"},
        {Nama = "Snake", Rarity = "Epic"},
        {Nama = "Vulture", Rarity = "Epic"},
        {Nama = "Desert Dragon", Rarity = "Mythic"},
        {Nama = "Phoenix", Rarity = "Eternal"}
    }},
    {Nama = "❄️ SNOW", Pet = {
        {Nama = "Penguin", Rarity = "Rare"},
        {Nama = "Walrus", Rarity = "Epic"},
        {Nama = "Polar Bear", Rarity = "Legendary"},
        {Nama = "Sabertooth Tiger", Rarity = "Mythic"},
        {Nama = "Mammoth", Rarity = "Mythic"},
        {Nama = "King Mammoth", Rarity = "Cosmic"},
        {Nama = "Yeti", Rarity = "Secret"},
        {Nama = "Ice Dragon", Rarity = "Eternal"}
    }},
    {Nama = "🌴 JUNGLE", Pet = {
        {Nama = "Monkey", Rarity = "Common"},
        {Nama = "Parrot", Rarity = "Uncommon"},
        {Nama = "Gecko", Rarity = "Rare"},
        {Nama = "Boa", Rarity = "Rare"},
        {Nama = "Gorilla", Rarity = "Epic"},
        {Nama = "Leopard", Rarity = "Legendary"},
        {Nama = "Tiger", Rarity = "Mythic"},
        {Nama = "Jungle Spirit", Rarity = "Cosmic"}
    }},
    {Nama = "🌋 VOLCANO", Pet = {
        {Nama = "Lava Lizard", Rarity = "Epic"},
        {Nama = "Fire Dragon", Rarity = "Legendary"},
        {Nama = "Magma Golem", Rarity = "Mythic"},
        {Nama = "Chillin Chilli", Rarity = "Mythic"},
        {Nama = "Volcano Guardian", Rarity = "Cosmic"},
        {Nama = "Inferno Skeleton", Rarity = "Secret"},
        {Nama = "Thunder Bird", Rarity = "Eternal"},
        {Nama = "Solar Phoenix", Rarity = "Divine"}
    }},
    {Nama = "🌌 COSMIC", Pet = {
        {Nama = "Centapede", Rarity = "Epic"},
        {Nama = "Koi", Rarity = "Cosmic"},
        {Nama = "Snowy Owl", Rarity = "Cosmic"},
        {Nama = "Cosmic Dragon", Rarity = "Cosmic"},
        {Nama = "Lunar Dragon", Rarity = "Eternal"},
        {Nama = "Star Beast", Rarity = "Secret"},
        {Nama = "Alien Overlord", Rarity = "Divine"}
    }},
    {Nama = "🌸 SAKURA", Pet = {
        {Nama = "Tea Master", Rarity = "Epic"},
        {Nama = "Crane", Rarity = "Legendary"},
        {Nama = "Bamboo Panda", Rarity = "Mythic"},
        {Nama = "Sakura Spirit", Rarity = "Cosmic"},
        {Nama = "Dragon Blossom", Rarity = "Eternal"},
        {Nama = "Oni Tiger", Rarity = "Eternal"},
        {Nama = "Stag", Rarity = "Secret"},
        {Nama = "Kitsune", Rarity = "Divine"}
    }},
    {Nama = "🦖 PREHISTORIC", Pet = {
        {Nama = "Ancient Turtle", Rarity = "Epic"},
        {Nama = "Pterodactyl", Rarity = "Legendary"},
        {Nama = "T-Rex", Rarity = "Mythic"},
        {Nama = "Deinosuchus", Rarity = "Mythic"},
        {Nama = "Brontosaurus", Rarity = "Cosmic"},
        {Nama = "Fossil Beast", Rarity = "Secret"},
        {Nama = "Mosasaurus", Rarity = "Eternal"}
    }},
    {Nama = "🏛️ TITAN TEMPLE", Pet = {
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

-- ==============================================
-- 🎁 DAFTAR EVENT TERBARU
-- ==============================================
local DaftarEvent = {
    {
        Nama = "👹 HUNGRY MONSTER EVENT",
        Deskripsi = "Cari Infested Egg → kasih ke Hungry Monster → dapat Monster Chest!",
        Item = {
            {Nama = "Infested Egg", Ket = "Telur terinfeksi di semua area"},
            {Nama = "Monstrous Egg", Ket = "Dari Monster Chest"},
            {Nama = "Scorpio", Ket = "Legendary • 39%"},
            {Nama = "Froggo", Ket = "Mythic • 24%"},
            {Nama = "Crawler", Ket = "Cosmic • 18%"},
            {Nama = "Crocodon", Ket = "Secret • 11%"},
            {Nama = "Krakenoid", Ket = "Eternal • 6.5%"},
            {Nama = "Dreadscale", Ket = "Dreadscale • 0.5%"}
        }
    },
    {
        Nama = "🌀 RIFT EVENT (TERBARU!)",
        Deskripsi = "Boss Abyss Overlord setiap 30 menit • Dapat Boss Token & Rift Egg!",
        Item = {
            {Nama = "Riftborn Egg", Ket = "Dari Banner Rift"},
            {Nama = "Shattered Rift Egg", Ket = "Dari Boss"},
            {Nama = "Abyss Overlord", Ket = "Boss Fight"},
            {Nama = "Boss Token", Ket = "Mata uang event"},
            {Nama = "Rift Machine", Ket = "Mesin tukar telur"}
        }
    },
    {
        Nama = "🐲 MONSTER UPDATE",
        Deskripsi = "Area Titan Temple • Pet Monster baru!",
        Item = {
            {Nama = "Spideron", Ket = "Legendary • $95K/s"},
            {Nama = "Bladehide", Ket = "Mythic • $750K/s"},
            {Nama = "Mantaris", Ket = "Cosmic • $11M/s"},
            {Nama = "Rhinotaur", Ket = "Cosmic • $17.5M/s"},
            {Nama = "Mutant Shark", Ket = "Secret • $215M/s"},
            {Nama = "Gorilla King", Ket = "Eternal • $880M/s"},
            {Nama = "Nightflame", Ket = "Divine • TERBAIK!"}
        }
    }
}

-- ==============================================
-- 🔍 FUNGSI CARI & AMBIL TELUR
-- ==============================================
local function CariDanAmbil(NamaCari)
    if not LocalPlayer.Character then return false end
    RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return false end

    local NamaKecil = NamaCari:lower()
    local Ketemu = nil

    local function Scan(Obj)
        if Ketemu then return end
        if Obj:IsA("BasePart") then
            local N = Obj.Name:lower()
            local P = Obj.Parent.Name:lower()
            if N:find(NamaKecil) or P:find(NamaKecil) or (N:find("egg") and N:find(NamaKecil)) then
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
        print("❌ Tidak ketemu: "..NamaCari)
        return false
    end

    if Settings.Teleport then
        RootPart.CFrame = CFrame.new(Ketemu.Pos + Vector3.new(0, 2.5, 0))
        task.wait(0.08)
    end
    pcall(function() fireclickdetector(Ketemu.Click) end)
    print("✅ Diambil: "..NamaCari)
    return true
end

-- ==============================================
-- 🖥️ BUAT UI UTAMA — GAYA BIGFOOT • NO KEY
-- ==============================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 520)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromHex("#12121f")
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromHex("#00ff9d")
MainFrame.CornerRadius = UDim.new(0, 10)
MainFrame.Parent = ScreenGui

-- HEADER DENGAN LABEL NO KEY
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromHex("#00ff9d")
Header.CornerRadius = UDim.new(0, 8)
Header.Parent = MainFrame

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0.75, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "🌟 GL SCRIPT 🌟\nSTEAL AN EGG"
Logo.TextColor3 = Color3.fromHex("#0a0a1a")
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 18
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.TextPadding = UDim.new(0, 12)
Logo.Parent = Header

local NoKeyLabel = Instance.new("TextLabel")
NoKeyLabel.Size = UDim2.new(0.25, 0, 0, 22)
NoKeyLabel.Position = UDim2.new(0.73, 0, 0.5, -11)
NoKeyLabel.BackgroundColor3 = Color3.fromHex("#ff2266")
NoKeyLabel.Text = "🔓 NO KEY"
NoKeyLabel.TextColor3 = Color3.fromRGB(255,255,255)
NoKeyLabel.Font = Enum.Font.GothamBlack
NoKeyLabel.TextSize = 12
NoKeyLabel.CornerRadius = UDim.new(0, 5)
NoKeyLabel.Parent = Header

-- TAB MENU
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 38)
TabFrame.Position = UDim2.new(0, 0, 0, 58)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 4)
TabList.Parent = TabFrame

local TabNames = {"⚙️ MAIN", "🥚 EGGS", "🐾 PETS", "🎁 EVENTS", "✈️ MISC", "⚡ SPEED"}
local TabContents = {}
local TabButtons = {}
local TabAktif = "⚙️ MAIN"

for _, NamaTab in ipairs(TabNames) do
    local BtnTab = Instance.new("TextButton")
    BtnTab.Size = UDim2.new(0, 62, 1, 0)
    BtnTab.BackgroundColor3 = NamaTab == TabAktif and Color3.fromHex("#00ff9d") or Color3.fromHex("#1e1e35")
    BtnTab.Text = NamaTab
    BtnTab.TextColor3 = NamaTab == TabAktif and Color3.fromHex("#0a0a1a") or Color3.fromRGB(255,255,255)
    BtnTab.Font = Enum.Font.GothamBold
    BtnTab.TextSize = 11
    BtnTab.CornerRadius = UDim.new(0, 6)
    BtnTab.AutoLocalize = false
    BtnTab.Parent = TabFrame
    TabButtons[NamaTab] = BtnTab

    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, -10, 1, -105)
    Content.Position = UDim2.new(0, 5, 0, 100)
    Content.BackgroundTransparency = 1
    Content.ScrollBarThickness = 5
    Content.ScrollBarColor3 = Color3.fromHex("#00ff9d")
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.Visible = NamaTab == TabAktif
    Content.Parent = MainFrame
    TabContents[NamaTab] = Content

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 5)
    List.Parent = Content

    BtnTab.MouseButton1Click:Connect(function()
        TabAktif = NamaTab
        for T, B in pairs(TabButtons) do
            B.BackgroundColor3 = T == NamaTab and Color3.fromHex("#00ff9d") or Color3.fromHex("#1e1e35")
            B.TextColor3 = T == NamaTab and Color3.fromHex("#0a0a1a") or Color3.fromRGB(255,255,255)
        end
        for T, C in pairs(TabContents) do
            C.Visible = T == NamaTab
        end
    end)
end

-- ==============================================
-- 📄 FUNGSI BUAT TOMBOL & TOGGLE
-- ==============================================
local function BuatTombol(Parent, Teks, Fungsi)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromHex("#1e1e35")
    Btn.BorderSizePixel = 1
    Btn.BorderColor3 = Color3.fromHex("#00ff9d")
    Btn.Text = Teks
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.CornerRadius = UDim.new(0, 6)
    Btn.AutoLocalize = false
    Btn.Parent = Parent
    Btn.MouseButton1Click:Connect(Fungsi)
    return Btn
end

local function BuatToggle(Parent, Teks, Awal, Fungsi)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromHex("#1e1e35")
    Frame.BorderSizePixel = 1
    Frame.BorderColor3 = Color3.fromHex("#00ff9d")
    Frame.CornerRadius = UDim.new(0, 6)
    Frame.Parent = Parent

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.7, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = Teks
    Lbl.TextColor3 = Color3.fromRGB(255,255,255)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextPadding = UDim.new(0, 12)
    Lbl.Parent = Frame

    local Status = Awal
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 70, 0, 26)
    ToggleBtn.Position = UDim2.new(0.78, 0, 0.5, -13)
    ToggleBtn.BackgroundColor3 = Status and Color3.fromHex("#00ff9d") or Color3.fromHex("#ff4444")
    ToggleBtn.Text = Status and "ON" or "OFF"
    ToggleBtn.TextColor3 = Color3.fromHex("#0a0a1a")
    ToggleBtn.Font = Enum.Font.GothamBlack
    ToggleBtn.TextSize = 12
    ToggleBtn.CornerRadius = UDim.new(0, 5)
    ToggleBtn.AutoLocalize = false
    ToggleBtn.Parent = Frame

    ToggleBtn.MouseButton1Click:Connect(function()
        Status = not Status
        ToggleBtn.BackgroundColor3 = Status and Color3.fromHex("#00ff9d") or Color3.fromHex("#ff4444")
        ToggleBtn.Text = Status and "ON" or "OFF"
        Fungsi(Status)
    end)
    return Frame
end

-- ==============================================
-- 📄 ISI TAB ⚙️ MAIN
-- ==============================================
BuatToggle(TabContents["⚙️ MAIN"], "🤖 Auto Steal Telur", Settings.AutoSteal, function(v) Settings.AutoSteal = v end)
BuatToggle(TabContents["⚙️ MAIN"], "📦 Auto Collect", Settings.AutoCollect, function(v) Settings.AutoCollect = v end)
BuatToggle(TabContents["⚙️ MAIN"], "⚡ Teleport Instan", Settings.Teleport, function(v) Settings.Teleport = v end)
BuatToggle(TabContents["⚙️ MAIN"], "🏆 Prioritas Rarity", Settings.PreferRarity, function(v) Settings.PreferRarity = v end)
BuatToggle(TabContents["⚙️ MAIN"], "🎁 Auto Event", Settings.AutoEvent, function(v) Settings.AutoEvent = v end)

BuatTombol(TabContents["⚙️ MAIN"], "🎯 Ambil Telur Terdekat", function()
    local Daftar = {}
    if not LocalPlayer.Character then return end
    RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return end
    for _, O in pairs(workspace:GetDescendants()) do
        if O:IsA("BasePart") and O:FindFirstChild("ClickDetector") then
            local N = O.Name:lower()..O.Parent.Name:lower()
            if N:find("egg") then
                table.insert(Daftar, {P=O, D=(O.Position-RootPart.Position).Magnitude})
            end
        end
    end
    table.sort(Daftar, function(a,b) return a.D < b.D end)
    if #Daftar > 0 then
        if Settings.Teleport then RootPart.CFrame = CFrame.new(Daftar[1].P.Position+Vector3.new(0,2.5,0)) task.wait(0.08) end
        pcall(function() fireclickdetector(Daftar[1].P.ClickDetector) end)
        print("✅ Diambil!")
    end
end)

BuatTombol(TabContents["⚙️ MAIN"], "✈️ Nyalakan/Mati Terbang", function()
    FlyActive = not FlyActive
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.PlatformStand = FlyActive end
    end
    print(FlyActive and "✈️ FLY ON" or "✈️ FLY OFF")
end)

BuatTombol(TabContents["⚙️ MAIN"], "🗺️ Teleport ke Lobby", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 10, 0))
    end
end)

-- ==============================================
-- 📄 ISI TAB 🥚 EGGS
-- ==============================================
for _, Grup in ipairs(DaftarArea) do
    local AreaLbl = Instance.new("TextLabel")
    AreaLbl.Size = UDim2.new(1, 0, 0, 30)
    AreaLbl.BackgroundColor3 = Color3.fromHex("#00ff9d")
    AreaLbl.Text = Grup.Nama
    AreaLbl.TextColor3 = Color3.fromHex("#0a0a1a")
    AreaLbl.Font = Enum.Font.GothamBlack
    AreaLbl.TextSize = 13
    AreaLbl.CornerRadius = UDim.new(0, 5)
    AreaLbl.Parent = TabContents["🥚 EGGS"]

    for _, Hewan in ipairs(Grup.Pet) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 36)
        Btn.BackgroundColor3 = Color3.fromHex("#1e1e35")
        Btn.BorderSizePixel = 1
        Btn.BorderColor3 = WarnaRarity[Hewan.Rarity]
        Btn.Text = "🥚 "..Hewan.Nama.."  •  "..Hewan.Rarity
        Btn.TextColor3 = WarnaRarity[Hewan.Rarity]
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.TextPadding = UDim.new(0, 10)
        Btn.CornerRadius = UDim.new(0, 5)
        Btn.AutoLocalize = false
        Btn.Parent = TabContents["🥚 EGGS"]

        Btn.MouseButton1Click:Connect(function()
            local S = CariDanAmbil(Hewan.Nama)
            Btn.BackgroundColor3 = S and Color3.fromHex("#1a4a2e") or Color3.fromHex("#4a1a2e")
            task.wait(1.2)
            Btn.BackgroundColor3 = Color3.fromHex("#1e1e35")
        end)
    end
end

-- ==============================================
-- 📄 ISI TAB 🐾 PETS
-- ==============================================
for _, Grup in ipairs(DaftarArea) do
    local AreaLbl = Instance.new("TextLabel")
    AreaLbl.Size = UDim2.new(1, 0, 0, 30)
    AreaLbl.BackgroundColor3 = Color3.fromHex("#8844ff")
    AreaLbl.Text = Grup.Nama
    AreaLbl.TextColor3 = Color3.fromRGB(255,255,255)
    AreaLbl.Font = Enum.Font.GothamBlack
    AreaLbl.TextSize = 13
    AreaLbl.CornerRadius = UDim.new(0, 5)
    AreaLbl.Parent = TabContents["🐾 PETS"]

    for _, Hewan in ipairs(Grup.Pet) do
        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1, 0, 0, 32)
        Lbl.BackgroundColor3 = Color3.fromHex("#1e1e35")
        Lbl.BorderSizePixel = 1
        Lbl.BorderColor3 = WarnaRarity[Hewan.Rarity]
        Lbl.Text = "🐾 "..Hewan.Nama.."  •  "..Hewan.Rarity
        Lbl.TextColor3 = WarnaRarity[Hewan.Rarity]
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.TextPadding = UDim.new(0, 10)
        Lbl.CornerRadius = UDim.new(0, 5)
        Lbl.Parent = TabContents["🐾 PETS"]
    end
end

-- ==============================================
-- 📄 ISI TAB 🎁 EVENTS
-- ==============================================
for _, Event in ipairs(DaftarEvent) do
    local EventLbl = Instance.new("TextLabel")
    EventLbl.Size = UDim2.new(1, 0, 0, 32)
    EventLbl.BackgroundColor3 = Color3.fromHex("#ff4488")
    EventLbl.Text = Event.Nama
    EventLbl.TextColor3 = Color3.fromRGB(255,255,255)
    EventLbl.Font = Enum.Font.GothamBlack
    EventLbl.TextSize = 13
    EventLbl.CornerRadius = UDim.new(0, 5)
    EventLbl.Parent = TabContents["🎁 EVENTS"]

    local Desk = Instance.new("TextLabel")
    Desk.Size = UDim2.new(1, 0, 0, 30)
    Desk.BackgroundColor3 = Color3.fromHex("#2a1a3a")
    Desk.Text = "📝 "..Event.Deskripsi
    Desk.TextColor3 = Color3.fromRGB(200,200,255)
    Desk.Font = Enum.Font.Gotham
    Desk.TextSize = 11
    Desk.TextWrapped = true
    Desk.CornerRadius = UDim.new(0, 5)
    Desk.Parent = TabContents["🎁 EVENTS"]

    for _, Item in ipairs(Event.Item) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 34)
        Btn.BackgroundColor3 = Color3.fromHex("#1e1e35")
        Btn.BorderSizePixel = 1
        Btn.BorderColor3 = Color3.fromHex("#ff4488")
        Btn.Text = "🎁 "..Item.Nama.."  |  "..Item.Ket
        Btn.TextColor3 = Color3.fromRGB(255,200,230)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 11
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.TextPadding = UDim.new(0, 10)
        Btn.CornerRadius = UDim.new(0, 5)
        Btn.AutoLocalize = false
        Btn.Parent = TabContents["🎁 EVENTS"]

        Btn.MouseButton1Click:Connect(function()
            local S = CariDanAmbil(Item.Nama)
            Btn.BackgroundColor3 = S and Color3.fromHex("#1a4a2e") or Color3.fromHex("#4a1a2e")
            task.wait(1.2)
            Btn.BackgroundColor3 = Color3.fromHex("#1e1e35")
        end)
    end
end

-- ==============================================
-- 📄 ISI TAB ✈️ MISC
-- ==============================================
BuatTombol(TabContents["✈️ MISC"], "✈️ Nyalakan Terbang (FLY)", function()
    FlyActive = true
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.PlatformStand = true end
    end
    print("✈️ FLY ON")
end)

BuatTombol(TabContents["✈️ MISC"], "🛑 Matikan Terbang", function()
    FlyActive = false
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.PlatformStand = false end
    end
    print("✈️ FLY OFF")
end)

BuatTombol(TabContents["✈️ MISC"], "⚡ Kecepatan Maksimal", function()
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.WalkSpeed = 200 end
    end
    print("⚡ SPEED MAX!")
end)

BuatTombol(TabContents["✈️ MISC"], "🚶 Kembali Normal", function()
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.WalkSpeed = 16 end
    end
    print("🚶 Normal")
end)

BuatTombol(TabContents["✈️ MISC"], "🌀 Lompat Tinggi", function()
    if LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.JumpPower = 150 end
    end
    print("🌀 JUMP TINGGI!")
end)

BuatTombol(TabContents["✈️ MISC"], "👁️ Tidak Terlihat (Noclip)", function()
    if LocalPlayer.Character then
        for _, P in pairs(LocalPlayer.Character:GetDescendants()) do
            if P:IsA("BasePart") then P.CanCollide = false end
        end
    end
    print("👁️ NOCLIP ON")
end)

BuatTombol(TabContents["✈️ MISC"], "🧱 Kembali Padat", function()
    if LocalPlayer.Character then
        for _, P in pairs(LocalPlayer.Character:GetDescendants()) do
            if P:IsA("BasePart") then P.CanCollide = true end
        end
    end
    print("🧱 NORMAL")
end)

BuatTombol(TabContents["✈️ MISC"], "🔄 Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

-- ==============================================
-- 📄 ISI TAB ⚡ SPEED
-- ==============================================
local LblSpeed = Instance.new("TextLabel")
LblSpeed.Size = UDim2.new(1, 0, 0, 30)
LblSpeed.BackgroundColor3 = Color3.fromHex("#ffaa00")
LblSpeed.Text = "⚡ KECEPATAN AMBIL TELUR: "..Settings.StealSpeed
LblSpeed.TextColor3 = Color3.fromHex("#0a0a1a")
LblSpeed.Font = Enum.Font.GothamBlack
LblSpeed.TextSize = 13
LblSpeed.CornerRadius = UDim.new(0, 5)
LblSpeed.Parent = TabContents["⚡ SPEED"]

local KecepatanPilihan = {10, 50, 100, 200, 500, 1000}
for _, V in ipairs(KecepatanPilihan) do
    BuatTombol(TabContents["⚡ SPEED"], "⚡ Set Kecepatan: "..V, function()
        Settings.StealSpeed = V
        LblSpeed.Text = "⚡ KECEPATAN AMBIL TELUR: "..V
        print("⚡ Kecepatan diatur: "..V)
    end)
end

local LblFly = Instance.new("TextLabel")
LblFly.Size = UDim2.new(1, 0, 0, 30)
LblFly.BackgroundColor3 = Color3.fromHex("#00ccff")
LblFly.Text = "✈️ KECEPATAN TERBANG: "..Settings.FlySpeed
LblFly.TextColor3 = Color3.fromHex("#0a0a1a")
LblFly.Font = Enum.Font.GothamBlack
LblFly.TextSize = 13
LblFly.CornerRadius = UDim.new(0, 5)
LblFly.Parent = TabContents["⚡ SPEED"]

local FlyPilihan = {40, 60, 80, 100, 150, 200}
for _, V in ipairs(FlyPilihan) do
    BuatTombol(TabContents["⚡ SPEED"], "✈️ Set Fly Speed: "..V, function()
        Settings.FlySpeed = V
        LblFly.Text = "✈️ KECEPATAN TERBANG: "..V
        print("✈️ Fly Speed: "..V)
    end)
end

-- ==============================================
-- ✈️ KONTROL TERBANG
-- ==============================================
UIS.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.F then
        FlyActive = not FlyActive
        if LocalPlayer.Character then
            local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if Hum then Hum.PlatformStand = FlyActive end
        end
        print(FlyActive and "✈️ FLY ON" or "✈️ FLY OFF")
    end
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
    if not FlyActive or not LocalPlayer.Character then return end
    RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return end
    local Gerak = Vector3.new()
    if Keys.W then Gerak += Vector3.new(0, 0, -1) end
    if Keys.S then Gerak += Vector3.new(0, 0, 1) end
    if Keys.A then Gerak += Vector3.new(-1, 0, 0) end
    if Keys.D then Gerak += Vector3.new(1, 0, 0) end
    if Keys.U then Gerak += Vector3.new(0, 1, 0) end
    if Keys.I then Gerak += Vector3.new(0, -1, 0) end
    if Gerak.Magnitude > 0 then
        RootPart.CFrame += Gerak.Unit * Settings.FlySpeed
    end
end)

-- ==============================================
-- 🔄 AUTO STEAL LOOP
-- ==============================================
task.spawn(function()
    while task.wait(1000 / math.max(Settings.StealSpeed, 1)) do
        if not Settings.AutoSteal then continue end
        if not LocalPlayer.Character then continue end
        RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then continue end

        local Daftar = {}
        for _, O in pairs(workspace:GetDescendants()) do
            if O:IsA("BasePart") and O:FindFirstChild("ClickDetector") then
                local N = O.Name:lower()..O.Parent.Name:lower()
                if N:find("egg") then
                    table.insert(Daftar, {P=O, D=(O.Position-RootPart.Position).Magnitude})
                end
            end
        end
        table.sort(Daftar, function(a,b) return a.D < b.D end)
        if #Daftar > 0 then
            if Settings.Teleport then
                RootPart.CFrame = CFrame.new(Daftar[1].P.Position+Vector3.new(0,2.5,0))
                task.wait(0.05)
            end
            pcall(function() fireclickdetector(Daftar[1].P.ClickDetector) end)
        end
    end
end)

-- ==============================================
-- ✅ SIAP — NO KEY SYSTEM!
-- ==============================================
print(" ")
print("🌟 GL SCRIPT — STEAL AN EGG 🌟")
print("================================")
print("🔓 VERSI NO KEY • LANGSUNG JALAN!")
print("✅ Tab: MAIN • EGGS • PETS • EVENTS • MISC • SPEED")
print("✈️ [F] = Terbang • [U] Naik • [I] Turun")
print("🎁 Event: Hungry Monster • Rift • Monster Update")
print("💖 Semoga beruntung ya Galang! 💖")
print("================================")
