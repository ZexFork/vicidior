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

-- Menggunakan Event System bawaan Lucifer API v2.86
addEvent(Event.variantlist, function(variant, net_id)
    -- Memeriksa apakah fitur mirror emote aktif dan variant index 1 adalah "OnAction"
    if mirror_emote and variant[1] == "OnAction" then
        local emote = tostring(variant[2] or "")
        
        if validEmotes[emote] and not emoteCooldown then
            emoteCooldown = true
            
            print("Emote detected: " .. emote)
            
            -- Mengirim paket pesan/emote ke server
            bot:say(emote)
            
            -- Menggunakan runThread dan sleep bawaan Lucifer untuk penanganan cooldown secara asynchronous
            runThread(function()
                sleep(3000)
                emoteCooldown = false
            end)
        end
    end
end)

-- Mendengarkan event secara terus-menerus
while true do
    listenEvents(1)
    sleep(10)
end
