local bot = getBot()[cite: 1]

if bot == nil then
    print("Script ini membutuhkan context bot.")[cite: 1]
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

-- Menambahkan Event listener variantlist
addEvent(Event.variantlist, function(variant, net_id)[cite: 1]
    -- Memeriksa apakah fitur mirror_emote aktif dan variant index 1 adalah "OnAction"
    if mirror_emote and variant[1] == "OnAction" then
        local emote = tostring(variant[2] or "")
        
        if validEmotes[emote] and not emoteCooldown then
            emoteCooldown = true
            
            print("Emote detected: " .. emote)
            
            -- Mengirim emote / chat menggunakan bot:say()
            bot:say(emote)[cite: 1]
            
            -- Menjalankan cooldown 3 detik menggunakan thread bawaan Lucifer
            runThread(function()[cite: 1]
                sleep(3000)[cite: 1]
                emoteCooldown = false
            end)
        end
    end
end)

-- SOLUSI ERROR exit_mode:
-- Gunakan nilai timeout besar pada listenEvents tanpa dibungkus while loop & sleep manual.
listenEvents(86400) -- Script akan mendengarkan event selama 24 jam berturut-turut
