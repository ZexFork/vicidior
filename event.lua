local bot = getBot()

if bot == nil then
    print("Script ini membutuhkan context bot.")
    return
end

local validEmotes = {
    ["/no"] = true,
    ["/yes"] = true,
    ["/love"] = true,
    ["/furious"] = true,
    ["/idk"] = true,
    ["/sleep"] = true,
    ["/rolleyes"] = true,
    ["/fp"] = true,
    ["/wave"] = true,
    ["/omg"] = true,
    ["/dance"] = true,
    ["/fold"] = true
}

local mirror_emote = true
local emoteCooldown = false

-- Callback penanganan variant list
function onVariant(varlist, netid)
    -- Membaca Variant Index 0 untuk mengecek aksi "OnAction"
    if mirror_emote and varlist:get(0):getString() == "OnAction" then
        -- Membaca Variant Index 1 untuk mendapatkan isi string emote
        local emote = varlist:get(1):getString()
        
        if validEmotes[emote] and not emoteCooldown then
            emoteCooldown = true
            
            print("Emote detected: " .. emote)
            
            -- Mengirim emote ke server via bot:say()
            bot:say(emote)
            
            -- Cooldown 3 detik di thread terpisah agar tidak memblokir listener
            runThread(function()
                sleep(3000)
                emoteCooldown = false
            end)
        end
    end
end

-- Menambahkan event listener ke sistem Lucifer
addEvent(Event.variantlist, onVariant)

-- Menjalankan event listener selama 24 jam (86400 detik)
listenEvents(86400)
