-- [[ EXAMPLE MENTAHAN IMPLEMENTASI RYOSEN UI V2.6 ]] --

local Config = {
    Name = "RYOSEN HUB",
    Webhook = "" -- Isi url webhook discord di sini kalau mau pakai
}

-- Membuat Window Utama
local Window = RyosenLib:CreateWindow(Config)

-- Membuat Tab-Tab Kosong (Polosan)
local Tab1 = Window:CreateTab("Main Menu")
local Tab2 = Window:CreateTab("Visuals")
local Tab3 = Window:CreateTab("Misc")
local Tab4 = Window:CreateTab("Settings")

-- Contoh nambahin tombol polosan tanpa fungsi berat di Tab 1
Tab1:CreateButton({
    Name = "Test Button 1",
    Callback = function()
        print("Tombol 1 diklik!")
    end
})

Tab1:CreateButton({
    Name = "Test Button 2",
    Callback = function()
        print("Tombol 2 diklik!")
    end
})