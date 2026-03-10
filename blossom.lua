local Dui = MachoCreateDui("https://daytonhale1234-beep.github.io/euphoria-menu/menu.html")
local MenuOpen = false
local isTyping = false
local capsLockOn = false
local MenuPosition = {x = 960, y = 540}
local LockedResources = {}
local isRobberyActive = false

local isVehicleBoostEnabled = false
local isPlayerCrasherActive = false
local isVehicleUnlockerActive = false
local espEnabled = false
local idsEnabled = false
local namesEnabled = false
local showSelfSkeleton = false
local crosshairEnabled = false
local fovCircleEnabled = false

local logState = {foundLogs = {}, stoppedLogs = {}}
local logResourceNames = {"JD_logsV3", "JD_logs", "mc9-logs", "discord_logs", "logs", "lmx_logs", "crp_logs", "fusion_logs", "ox_logs", "zs-logging", "qb-logs", "esx_logs", "legacy_logs", "server_logs", "player_logs", "admin_logs", "anticheat_logs", "tracker_logs", "monitor_logs", "custom_logs", "audit_logs", "action_logs", "chat_logs", "event_logs", "game_logs", "debug_logs", "user_logs", "security_logs", "activity_logs", "performance_logs", "system_logs", "connection_logs", "error_logs", "warning_logs", "info_logs", "ox_inventory_logs", "analytics_logs", "report_logs", "transaction_logs", "ban_logs", "kick_logs", "violations_logs", "mod_logs", "script_logs", "resource_logs", "inventory_logs", "xp_logs", "money_logs", "shop_logs", "bank_logs", "vehicle_logs", "job_logs", "gang_logs", "mission_logs", "quest_logs", "combat_logs", "damage_logs", "healing_logs", "item_logs", "weapon_logs", "spawn_logs", "despawn_logs", "npc_logs", "JDlogs", "mission_tracking_logs", "event_tracking_logs"}

local function getClosestPlayerInView(maxDist)
    local camCoords = GetGameplayCamCoord()
    local camRot = GetGameplayCamRot(2)
    local function RotationToDirection(rot)
        local z = math.rad(rot.z)
        local x = math.rad(rot.x)
        local num = math.abs(math.cos(x))
        return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
    end
    local direction = RotationToDirection(camRot)
    local closestPed = nil
    local minDist = maxDist or 15.0
    for _, pid in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(pid)
        if ped ~= PlayerPedId() then
            local pos = GetEntityCoords(ped)
            local toPed = pos - camCoords
            local proj = toPed.x * direction.x + toPed.y * direction.y + toPed.z * direction.z
            if proj > 0 then
                local point = camCoords + direction * proj
                local dist = #(pos - point)
                if dist < 2.0 then
                    local camToPed = #(pos - camCoords)
                    if camToPed < minDist then
                        minDist = camToPed
                        closestPed = ped
                    end
                end
            end
        end
    end
    return closestPed
end

local function toggleVehicleBoost()
    isVehicleBoostEnabled = not isVehicleBoostEnabled
    if isVehicleBoostEnabled then
        MachoMenuNotification("blossom MeNu", "Vehicle boost is ON fucking enjoy it.", 3)
    else
        MachoMenuNotification("blossom MeNu", "Vehicle boost is now OFF.", 3)
    end
end

local function toggleVehicleUnlocker()
    isVehicleUnlockerActive = not isVehicleUnlockerActive
    if isVehicleUnlockerActive then
        MachoMenuNotification("blossom MeNu", "Vehicle Unlocker Enabled. Press E on a vehicle.", 3)
    else
        MachoMenuNotification("blossom MeNu", "Vehicle Unlocker Disabled.", 3)
    end
end

local function inject(code)
    MachoInjectResource("any", code)
end

local function SendToDui(action, data)
    if Dui and MenuOpen then
        MachoSendDuiMessage(Dui, json.encode({action = action, data = data}))
    end
end

local giveItemState = {turn = 1, akIndex = 1}
local specialCharMap = {
    [0xC0] = {normal = "`", shifted = "~"},
    [0x31] = {normal = "1", shifted = "!"},
    [0x32] = {normal = "2", shifted = "@"},
    [0x33] = {normal = "3", shifted = "#"},
    [0x34] = {normal = "4", shifted = "$"},
    [0x35] = {normal = "5", shifted = "%"},
    [0x36] = {normal = "6", shifted = "^"},
    [0x37] = {normal = "7", shifted = "&"},
    [0x38] = {normal = "8", shifted = "*"},
    [0x39] = {normal = "9", shifted = "("},
    [0x30] = {normal = "0", shifted = ")"},
    [0xBD] = {normal = "-", shifted = "_"},
    [0xBB] = {normal = "=", shifted = "+"},
    [0xDB] = {normal = "[", shifted = "{"},
    [0xDD] = {normal = "]", shifted = "}"},
    [0xDC] = {normal = "\\", shifted = "|"},
    [0xBA] = {normal = ";", shifted = ":"},
    [0xDE] = {normal = "'", shifted = '"'},
    [0xBC] = {normal = ",", shifted = "<"},
    [0xBE] = {normal = ".", shifted = ">"},
    [0xBF] = {normal = "/", shifted = "?"}
}

local function safeResourceName(name)
    if not name then
        return "unknown"
    end
    return string.gsub(tostring(name), "[%c\128-\255]", "?")
end

local function handleRobberyAttempt()
    local selfCoords = GetEntityCoords(PlayerPedId())
    for _, player in ipairs(GetActivePlayers()) do
        if player ~= PlayerId() then
            local ped = GetPlayerPed(player)
            if DoesEntityExist(ped) then
                if #(GetEntityCoords(ped) - selfCoords) <= 2.5 then
                    ExecuteCommand("steal")
                    ExecuteCommand("rob")
                    MachoMenuNotification("blossom MeNu", "Robbing Nigga.", 3)
                    return
                end
            end
        end
    end
    MachoMenuNotification("blossom MeNu", "Nigga Nobody Is Near You To Rob.", 3)
end

-- ALL TRIGGER HANDLERS
local triggerHandlers = {
    ak_item = function(itemInput, amountInput, trigger)
        for i = giveItemState.akIndex, #trigger.res + giveItemState.akIndex - 1 do
            local idx = (i - 1) % #trigger.res + 1
            local resName = trigger.res[idx]
            if MachoResourceInjectable(resName) then
                giveItemState.akIndex = (idx % #trigger.res) + 1
                local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                local code = ([[Citizen.CreateThread(function() pcall(function() TriggerServerEvent(%q,%q,{['phone']=0},%d,0) end); DoScreenFadeOut(1);Citizen.Wait(1000);SetEntityCoordsNoOffset(PlayerPedId(),%f,%f,%f,false,false,false);Citizen.Wait(1000);DoScreenFadeIn(1000) end)]]):format(resName .. ":process", itemInput, amountInput, x, y, z)
                inject(code)
                return true
            end
        end
        return false
    end,
    nails_money = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("delivery:giveRewardnails",%d) end)'):format(amountInput))
        return true
    end,
    handbag_money = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("delivery:giveRewardhandbags",%d) end)'):format(amountInput))
        return true
    end,
    sneaker_money = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("delivery:giveRewardShoes",%d) end)'):format(amountInput))
        return true
    end,
    caps_money = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("delivery:giveRewardCaps",%d) end)'):format(amountInput))
        return true
    end,
    generic_money = function(itemInput, amountInput)
        inject(("pcall(function() TriggerServerEvent('ak47_qb_drugmanagerv2:shop:buy', '53.15-1478.79', {['buyprice']=0, ['currency']='cash', ['name']='%s', ['sellprice']=0, ['label']='blossom MeNu On Top Nigga'}, %d) end)"):format(itemInput, amountInput))
        return true
    end,
    hotdog_money = function(itemInput, amountInput)
        inject(("pcall(function() local ped=GetPlayerPed(-1) local pedCoords=GetEntityCoords(ped) local HotdogsForSale=1 local SellingPrice=%d TriggerServerEvent('qb-hotdogjob:server:Sell', pedCoords, HotdogsForSale, SellingPrice) end)"):format(amountInput))
        return true
    end,
    ak47_inventory = function(itemInput, amountInput)
        inject(([[TriggerServerEvent('ak47_inventory:buyItemDrag',{fromInv={identifier=nil,slot=1,slotData={amount=%d,close=true,count=999999999999999,description="CodePlug Found Ts Lol",info={account="cash",buyPrice=0},label="CodePlug Too Good Lol",name="%s",quality=100,slot=1,type="item",weight=0}},toInv={identifier=nil,slot=1,slotData={slot=1}}} )]]):format(amountInput, itemInput))
        return true
    end,
    shop_purchase = function(itemInput, amountInput)
        local randomId = "codeplug" .. math.random(1000, 99999)
        inject(('pcall(function() TriggerServerEvent("shop:purchaseItem2", "%s", "%s", 0) end)'):format(randomId, itemInput))
        return true
    end,
    cl_pizzeria = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("CL-Pizzeria:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    solstice_moonshine = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("SolsticeMoonshineV2:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    tk_smokev2 = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("Tk_smokev2:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    ox_cb_ws_sellshop = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("__ox_cb_ws_sellshop:sellItem", "sellshop", "ws_sellshop:sellItem:17692", { currency = "money", item = "%s", price = 9999999999, quantity = %d }) end)'):format(itemInput, amountInput))
        return true
    end,
    adminplus_selldrugs = function(itemInput, amountInput)
        inject(('pcall(function() TriggerEvent("stasiek_selldrugsv2:findClient",{ ["i"] = 8, ["label"] = "CodePlugFuckedUrCity", ["type"] = "CodePlugFuckedUrCity", ["zone"] = "The Meat Quarter", ["price"] = %d, ["count"] = 0 }) end)'):format(amountInput))
        return true
    end,
    ak47_drugmanager = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak47_drugmanager:pickedupitem","%s","%s",%d) end)'):format(itemInput, itemInput, amountInput))
        return true
    end,
    ak47_drugmanagerv2 = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak47_drugmanagerv2:shop:buy", "-1146.444941.22", { buyprice = 0, currency = "money", label = "codeplug", name = "%s", sellprice = 69696969 }, %d ) end)'):format(itemInput, amountInput))
        return true
    end,
    ak47_prospecting_reward = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak47_prospecting:reward", %d) end)'):format(amountInput))
        return true
    end,
    ak47_prospecting_sell = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak47_prospecting:sell","cash",%d,9999999999) end)'):format(amountInput))
        return true
    end,
    ak4y_fishing = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak4y-advancedFishing:addItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    ak4y_case_opening = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak4y-caseOpening:addGoldCoin", %d) end)'):format(amountInput))
        return true
    end,
    ak4y_playtime_shop = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ak4y-playTimeShop:addCoin", %d) end)'):format(amountInput))
        return true
    end,
    angelicxs_civilian_payment = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("angelicxs-CivilianJobs:Server:Payment", %d) end)'):format(amountInput))
        return true
    end,
    angelicxs_civilian_item = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("angelicxs-CivilianJobs:Server:GainItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    apex_cluckinbell = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("apex_cluckinbell:client:addItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    apex_rexdiner = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("apex_rexdiner:client:addItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    ars_hunting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ars_hunting:sellBuyItem", { item = "%s", price = 1, quantity = %d, buy = true }) end)'):format(itemInput, amountInput))
        return true
    end,
    ars_vvsgrillz = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ars_vvsgrillz_v2:Buyitem", "grillz", { items = {{ id = "%s", quantity = %d, price = 0, stock = 999999, totalPrice = 0 }}, method = "bank", total = 0 }, "bank") end)'):format(itemInput, amountInput))
        return true
    end,
    ars_vvsguns = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ars_vvsguns:Buyitem", "vvsguns", { items = { { id = "%s", image = "codeplug", name = "codeplug", page = 2, price = 0, quantity = %d, stock = 9999999999, totalPrice = 0 } }, method = "cash", total = 0 }, "cash" ) end)'):format(itemInput, amountInput))
        return true
    end,
    ars_vvsjewelry = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ars_vvsjewelry:Buyitem", "vvsjewelry", { items = { { id = "%s", image = "CodePlug", name = "CodePlugRunsUrCity", page = 2, price = 0, quantity = %d, stock = 999999999999999, totalPrice = 0 } }, method = "cash", total = 0 }, "cash" ) end)'):format(itemInput, amountInput))
        return true
    end,
    ars_whitewidow = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ars_whitewidow_v2:Buyitem", { items = { { id = "%s", image = "CodeFinder", name = "CodeFinder", page = 1, price = 500, quantity = %d, stock = 999999999999999, totalPrice = 0 } }, method = "cash", total = 0 }, "cash") end)'):format(itemInput, amountInput))
        return true
    end,
    av_business = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("av_business:addItem", "%s", %d, 9999) end)'):format(itemInput, amountInput))
        return true
    end,
    boii_drugs = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("boii-drugs:sv:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    boii_moneylaunderer = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("boii-moneylaunderer:sv:PayPlayer", %d) end)'):format(amountInput))
        return true
    end,
    boii_pawnshop = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("boii-pawnshop:sv:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    boii_salvage_diving = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("boii-salavagediving:server:JewelleryBag") end)'))
        return true
    end,
    boii_whitewidow = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("boii-whitewidow:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    brutal_hunting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("brutal_hunting:server:AddItem", { { amount = %d, item = "%s", label = "CodePlugRunsYou", price = 0 } }) end)'):format(amountInput, itemInput))
        return true
    end,
    brutal_shop_robbery = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("brutal_shop_robbery:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    cfx_tcd_starter = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("cfx-tcd-starterpack:ClaimStarterpack") end)'))
        return true
    end,
    core_crafting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("core_crafting:itemCrafted", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    d3mba_heroin = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("d3MBA-heroin:server:ShopBuyItem", { Amount = %d, ItemName = "%s", Price = 0 }) end)'):format(amountInput, itemInput))
        return true
    end,
    dcweedroll = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("weedroll:additem","%s",%d) end)'):format(itemInput, amountInput))
        return true
    end,
    dcweedrollnew = function(itemInput, amountInput)
        inject(('pcall(function) TriggerServerEvent("weedroll:additem","%s",%d) end)'):format(itemInput, amountInput))
        return true
    end,
    devcore_needs = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("devcore_needs:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    devcore_smokev2 = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("devcore_smokev2:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    dusa_pets = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("dusa-pets:addItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    dusa_pet_shop = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("__ox_cb_dusa_pets:cb:canBuyItem", "dusa_pet", "dusa_pets:cb:canBuyItem", { ["data"] = { [1] = { ["name"] = "CodePlugRunsU", ["img"] = "bed2.png", ["detail"] = "A nice sleep place for your pet", ["item"] = "%s", ["count"] = %d, ["totalPrice"] = 0, ["price"] = 0, }, }, ["account"] = "cash", }) end)'):format(itemInput, amountInput))
        return true
    end,
    dv_donut_delivery = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("dv-donutdeliveryjob:Payment", %d) end)'):format(amountInput))
        return true
    end,
    esx_weashop = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("esx_weashop:buyItem", "%s", %d, "BlackWeashop") end)'):format(itemInput, amountInput))
        return true
    end,
    ez_lib = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ez_lib:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    fivecode_camping = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("fivecode_camping:callCallback", "fivecode_camping:shopPay", 0, { ["price"] = 0, ["item"] = "%s", ["amount"] = %d, ["label"] = "CODEPLUG RUNS U" }, { ["args"] = { ["payment"] = { ["bank"] = true, ["cash"] = true } }, ["entity"] = 9218, ["distance"] = 0.64, ["hide"] = false, ["type"] = "bank", ["label"] = "Open Shop", ["coords"] = "vector3(-773.2181, 5597.66, 33.97217)", ["name"] = "npcShop" }) end)'):format(itemInput, amountInput))
        return true
    end,
    food_mechanics = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("food_mechanics:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    forge_starter = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("forge-starter:claimReward", "%s") end)'):format(itemInput))
        return true
    end,
    fs_placeables = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("fs_placeables:placeonground","%s",%d) end)'):format(itemInput, amountInput))
        return true
    end,
    fuksus_shops = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("__ox_cb_fuksus-shops:buyItems", "fuksus-shops", "fuksus-shops:buyItems", { ["payment"] = "bank", ["items"] = { [1] = { ["amount"] = %d, ["label"] = "CodePlugOnTop", ["price"] = 0, ["name"] = "%s", }, }, }) end)'):format(amountInput, itemInput))
        return true
    end,
    gardener_job = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("gardenerjob:payment",%d) end)'):format(amountInput))
        return true
    end,
    guatau_consumibles = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("virus_consumibles:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    hg_wheel = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("hg-wheel:server:giveitem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    horizon_payment = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("horizon_paymentsystem:giveItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    complete_hunting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("complete_hunting:server:giveReward", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    inside_fruitpicker = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("inside-fruitpicker:Payout", %d) end)'):format(amountInput))
        return true
    end,
    inverse_consumables = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("inverse-consumables:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    it_lib = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("it-lib:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jg_mechanic = function(itemInput, amountInput)
        inject(('pcall(function() TriggerEvent("jg-mechanic:client:input-shop-purchase-qty", { item = "%s", price = 0, mechanicId = "MECHANIC ID HERE", shopIndex = 1 }) end)'):format(itemInput))
        return true
    end,
    jim_bakery = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-bakery:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_beanmachine = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-beanmachine:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_burgershot = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-burgershot:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_catcafe = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-catcafe:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_consumables = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-consumables:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_mechanic = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-mechanic:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_mining = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-mining:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_pizzathis = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-pizzathis:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_recycle = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-recycle:server:toggleItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    jim_shops_blackmarket = function(itemInput, amountInput)
        inject(('pcall(function() Config.Goodies = { label = "Blackmarket", slots = 1, items = { [1] = { name = "%s", price = 0, amount = %d, info = {}, type = "item", slot = 1 } } } end)'):format(itemInput, amountInput))
        return true
    end,
    jim_shops_open = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("jim-shops:ShopOpen", "shop", "illegalshit", Config.Goodies) end)'))
        return true
    end,
    kaves_drugsv2 = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("kaves_drugsv2:server:giveItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    mt_restaurants = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("mt-restaurants:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    mt_printers = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("__ox_cb_mt_printers:server:itemActions", "mt_printers", "mt_printers:server:itemActions:codeplug", "%s", "add") end)'):format(itemInput))
        return true
    end,
    nx_cayo = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("nx-cayo:server:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    okok_crafting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("okokCrafting:claimAll", "paletogeneral", { ["paletogeneral"] = { [1] = { ["item"] = "%s", ["randomID"] = 431916296, ["recipe"] = { [1] = { [1] = "cash", [2] = 1, [3] = "true", [4] = "false" } }, ["suc"] = true, ["xp"] = 6, ["itemName"] = "Pistol", ["time"] = 0, ["amount"] = %d, ["isPending"] = false, ["isDone"] = true, ["isItem"] = true, ["isDis"] = false, ["sucPC"] = 85 } } }) end)'):format(itemInput, amountInput))
        return true
    end,
    pug_business_creator = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("Pug:server:NewGivBusinessItemAfterHacks", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    pug_chopping = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("Pug:server:GiveChoppingCarPay", %d) end)'):format(amountInput))
        return true
    end,
    pug_fishing = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("Pug:server:GiveFish", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    pug_robbery_creator = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("Pug:server:RobberyGiveItem", true, "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    qb_crafting = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("qb-crafting:server:receiveItem", "%s", {}, %d, 0) end)'):format(itemInput, amountInput))
        return true
    end,
    qb_drugs = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("qb-drugs:server:giveDrugs", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    qb_garbage_job = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("qb-garbagejob:server:PayShift", %d, "") end)'):format(amountInput))
        return true
    end,
    qb_hotdog_job = function(itemInput, amountInput)
        inject(('pcall(function() local ped = GetPlayerPed(-1) local pedCoords = GetEntityCoords(ped) local HotdogsForSale = 1 local SellingPrice = %d TriggerServerEvent("qb-hotdogjob:server:Sell", pedCoords, HotdogsForSale, SellingPrice) end)'):format(amountInput))
        return true
    end,
    qb_recycle_job = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("recycle:giveReward", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    qb_trash_search = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("qb-trashsearch:server:givemoney", math.random(%d, 9999999999999999)) end)'):format(amountInput))
        return true
    end,
    qb_warehouse = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("inside-warehouse:Payout", %d) end)'):format(amountInput))
        return true
    end,
    rm_camperv = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("camperv:server:giveItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    ry_rent = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("ry-vehiclerental:giveMoney", %d) end)'):format(amountInput))
        return true
    end,
    savana_trucker = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("savana-truckerJob:addXpAndMoney", %d, %d) end)'):format(amountInput, amountInput))
        return true
    end,
    sayer_jukebox = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("sayer-jukebox:AddItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    sell_usb = function(itemInput, amountInput)
        inject(('pcall(function() TriggerEvent("sell_usb:findClient", { i = 8, label = "CodePlugRunsYourShit", type = "codeplug", zone = "The Meat Quarter", price = %d, count = 0 }) end)'):format(amountInput))
        return true
    end,
    snipe_boombox = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("snipe-boombox:server:pickup", %d, vector3(0.0, 0.0, 0.0), "%s") end)'):format(amountInput, itemInput))
        return true
    end,
    solos_cashier = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-cashier:server:addmoney", "bank", %d) end)'):format(amountInput))
        return true
    end,
    solos_food = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-food:server:itemadd", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_hookah = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-hookah:server:Buy-Item", "%s", %d, 0) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_jointroll = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-jointroll:server:ItemAdd", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_joints = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-joints:server:itemadd", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_methlab = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-methlab:server:itemadd", "%s", %d, true) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_moneywash = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-moneywash:server:ItemAdd", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    solos_restaurants = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("solos-food:server:itemadd", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    t1ger_gangsystem = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("t1ger_lib:server:addItem", "%s", %d, "codeplugrunsu") end)'):format(itemInput, amountInput))
        return true
    end,
    t1ger_lib = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("t1ger_lib:server:addItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    xmmx_letscookplus = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("xmmx_letscookplus:server:BuyItems", { totalCost = 0, cart = { { name = "%s", quantity = %d } } }, "bank") end)'):format(itemInput, amountInput))
        return true
    end,
    zat_farming = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("zat-farming:server:GiveItem", "%s", %d) end)'):format(itemInput, amountInput))
        return true
    end,
    zat_weed = function(itemInput, amountInput)
        inject(('pcall(function() TriggerServerEvent("zat-weed:server:AddItem", "%s", nil, %d) end)'):format(itemInput, amountInput))
        return true
    end
}

local function RebuildTriggerFinderUI(state)
    local triggerFinderTab
    local tabIdx
    for i, tab in ipairs(state.tabs) do
        if tab.key == "trigger_finder" then
            triggerFinderTab = tab
            tabIdx = i
            break
        end
    end
    if not triggerFinderTab then
        return
    end

    triggerFinderTab.items = {}

    if not triggerFinderTab.selectedTrigger then
        table.insert(triggerFinderTab.items, {
            type = "button",
            label = #triggerFinderTab.foundTriggers > 0 and "Scan For Triggers Again" or "Scan For Triggers",
            action = function(s)
                MachoMenuNotification("blossom MeNu", "Finding Triggers Nigga.", 3)
                Citizen.Wait(250)
                triggerFinderTab.foundTriggers = {}
                local knownTriggers = {
                    {id = "ak_item", name = "Any Item Trigger (SAFE)", type = "item", res = {"ak47_whitewidowv2", "ak47_cannabiscafev2", "ak47_khusland", "ak47_khusbites", "ak47_leafnlatte", "ak47_qb_cannabiscafev2", "ak47_qb_leafnlatte", "ak47_qb_khusland", "ak47_qb_khusbites", "ak47_qb_whitewidowv2"}, all = false},
                    {id = "nails_money", name = "Money Trigger (SAFE)", type = "money", res = {"codewave-nails-phone"}, all = true},
                    {id = "handbag_money", name = "Money Trigger (SAFE)", type = "money", res = {"codewave-handbag-phone"}, all = true},
                    {id = "sneaker_money", name = "Money Trigger (SAFE)", type = "money", res = {"codewave-sneaker-phone"}, all = true},
                    {id = "caps_money", name = "Money Trigger (SAFE)", type = "money", res = {"codewave-caps-client-phone"}, all = true},
                    {id = "generic_money", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ak47_qb_drugmanagerv2", "ak47_drugmanagerv2"}, all = false},
                    {id = "hotdog_money", name = "Money Trigger (Medium Risk)", type = "money", res = {"qb-hotdogjob"}, all = true},
                    {id = "ak47_inventory", name = "Any Item Trigger (SAFE)", type = "item", res = {"ak47_inventory", "ak47_qb_inventory"}, all = false},
                    {id = "shop_purchase", name = "Palm Beach ANY ITEM (SAFE)", type = "item_only", res = {"PalmBeachMiamiMinimap"}, all = true},
                    {id = "cl_pizzeria", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"CL-Pizzeria"}, all = false},
                    {id = "solstice_moonshine", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"SolsticeMoonshineV2"}, all = false},
                    {id = "tk_smokev2", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"Tk_smokev2"}, all = false},
                    {id = "ox_cb_ws_sellshop", name = "Any Item Trigger (High Risk)", type = "item", res = {"__ox_cb_ws_sellshop"}, all = false},
                    {id = "adminplus_selldrugs", name = "Any Event Trigger (High Risk)", type = "event", res = {"adminplus-selldrugs"}, all = false},
                    {id = "ak47_drugmanager", name = "Any Item Trigger (SAFE)", type = "item", res = {"ak47_drugmanager"}, all = false},
                    {id = "ak47_drugmanagerv2", name = "Any Item Trigger (SAFE)", type = "item", res = {"ak47_drugmanagerv2"}, all = false},
                    {id = "ak47_prospecting_reward", name = "Give Scrap Items (SAFE)", type = "money", res = {"ak47_prospecting"}, all = false},
                    {id = "ak47_prospecting_sell", name = "Money Trigger (SAFE)", type = "money", res = {"ak47_prospecting"}, all = false},
                    {id = "ak4y_fishing", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ak4y-advancedFishing"}, all = false},
                    {id = "ak4y_case_opening", name = "Money Trigger (Medium Risk)", type = "money", res = {"ak4y-caseOpening"}, all = false},
                    {id = "ak4y_playtime_shop", name = "Money Trigger (Medium Risk)", type = "money", res = {"ak4y-playTimeShop"}, all = false},
                    {id = "angelicxs_civilian_payment", name = "Money Trigger (SAFE)", type = "money", res = {"angelicxs-civilianjobs"}, all = false},
                    {id = "angelicxs_civilian_item", name = "Any Item Trigger (SAFE)", type = "item", res = {"angelicxs-civilianjobs"}, all = false},
                    {id = "apex_cluckinbell", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"apex_cluckinbell"}, all = false},
                    {id = "apex_rexdiner", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"apex_rexdiner"}, all = false},
                    {id = "ars_hunting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ars_hunting"}, all = false},
                    {id = "ars_vvsgrillz", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ars_vvsgrillz_v2"}, all = false},
                    {id = "ars_vvsguns", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ars_vvsguns"}, all = false},
                    {id = "ars_vvsjewelry", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ars_vvsjewelry"}, all = false},
                    {id = "ars_whitewidow", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ars_whitewidow_v2"}, all = false},
                    {id = "av_business", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"av_business"}, all = false},
                    {id = "boii_drugs", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"boii-drugs"}, all = false},
                    {id = "boii_moneylaunderer", name = "Money Trigger (Medium Risk)", type = "money", res = {"boii-moneylaunderer"}, all = false},
                    {id = "boii_pawnshop", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"boii-pawnshop"}, all = false},
                    {id = "boii_salvage_diving", name = "Any Event Trigger (Medium Risk)", type = "event", res = {"boii-salavagediving"}, all = false},
                    {id = "boii_whitewidow", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"boii_whitewidow"}, all = false},
                    {id = "brutal_hunting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"brutal_hunting"}, all = false},
                    {id = "brutal_shop_robbery", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"brutal_shop_robbery"}, all = false},
                    {id = "cfx_tcd_starter", name = "Any Event Trigger (Medium Risk)", type = "event", res = {"cfx-tcd-starterpack"}, all = false},
                    {id = "core_crafting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"core_crafting"}, all = false},
                    {id = "d3mba_heroin", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"d3MBA-heroin"}, all = false},
                    {id = "dcweedroll", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"dcweedroll"}, all = false},
                    {id = "dcweedrollnew", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"dcweedrollnew"}, all = false},
                    {id = "devcore_needs", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"devcore_needs"}, all = false},
                    {id = "devcore_smokev2", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"devcore_smokev2"}, all = false},
                    {id = "dusa_pets", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"dusa-pets"}, all = false},
                    {id = "dusa_pet_shop", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"dusa_pet"}, all = false},
                    {id = "dv_donut_delivery", name = "Money Trigger (Medium Risk)", type = "money", res = {"dv-donutdeliveryjob"}, all = false},
                    {id = "esx_weashop", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"esx_weashop"}, all = false},
                    {id = "ez_lib", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"ez_lib"}, all = false},
                    {id = "fivecode_camping", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"fivecode_camping"}, all = false},
                    {id = "food_mechanics", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"food_mechanics"}, all = false},
                    {id = "forge_starter", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"forge-starter"}, all = false},
                    {id = "fs_placeables", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"fs_placeables"}, all = false},
                    {id = "fuksus_shops", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"fuksus-shops"}, all = false},
                    {id = "gardener_job", name = "Money Trigger (Medium Risk)", type = "money", res = {"gardenerjob"}, all = false},
                    {id = "guatau_consumibles", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"guataubaconsumibles"}, all = false},
                    {id = "hg_wheel", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"hg-wheel"}, all = false},
                    {id = "horizon_payment", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"horizon_paymentsystem"}, all = false},
                    {id = "complete_hunting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"hunting"}, all = false},
                    {id = "inside_fruitpicker", name = "Money Trigger (Medium Risk)", type = "money", res = {"inside-fruitpicker"}, all = false},
                    {id = "inverse_consumables", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"inverse-consumables"}, all = false},
                    {id = "it_lib", name = "Any Item Trigger (SAFE)", type = "item", res = {"it-lib"}, all = false},
                    {id = "jg_mechanic", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jg-mechanic"}, all = false},
                    {id = "jim_bakery", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-bakery"}, all = false},
                    {id = "jim_beanmachine", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-beanmachine"}, all = false},
                    {id = "jim_burgershot", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-burgershot"}, all = false},
                    {id = "jim_catcafe", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-catcafe"}, all = false},
                    {id = "jim_consumables", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-consumables"}, all = false},
                    {id = "jim_mechanic", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-mechanic"}, all = false},
                    {id = "jim_mining", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-mining"}, all = false},
                    {id = "jim_pizzathis", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-pizzathis"}, all = false},
                    {id = "jim_recycle", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-recycle"}, all = false},
                    {id = "jim_shops_blackmarket", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-shops"}, all = false},
                    {id = "jim_shops_open", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"jim-shops"}, all = false},
                    {id = "kaves_drugsv2", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"kaves_drugsv2"}, all = false},
                    {id = "mt_restaurants", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"mt-restaurants"}, all = false},
                    {id = "mt_printers", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"mt_printers"}, all = false},
                    {id = "nx_cayo", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"nx-cayo"}, all = false},
                    {id = "okok_crafting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"okokCrafting"}, all = false},
                    {id = "pug_business_creator", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"pug-businesscreator"}, all = false},
                    {id = "pug_chopping", name = "Money Trigger (Medium Risk)", type = "money", res = {"pug-chopping"}, all = false},
                    {id = "pug_fishing", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"pug-fishing"}, all = false},
                    {id = "pug_robbery_creator", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"pug-robberycreator"}, all = false},
                    {id = "qb_crafting", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"qb-crafting"}, all = false},
                    {id = "qb_drugs", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"qb-drugs"}, all = false},
                    {id = "qb_garbage_job", name = "Money Trigger (Medium Risk)", type = "money", res = {"qb-garbagejob"}, all = false},
                    {id = "qb_hotdog_job", name = "Money Trigger (Medium Risk)", type = "money", res = {"qb-hotdogjob"}, all = false},
                    {id = "qb_recycle_job", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"qb-recyclejob"}, all = false},
                    {id = "qb_trash_search", name = "Money Trigger (Medium Risk)", type = "money", res = {"qb-trashsearch"}, all = false},
                    {id = "qb_warehouse", name = "Money Trigger (Medium Risk)", type = "money", res = {"qb-warehouse"}, all = false},
                    {id = "rm_camperv", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"rm_camperv"}, all = false},
                    {id = "ry_rent", name = "Money Trigger (Medium Risk)", type = "money", res = {"ry_rent"}, all = false},
                    {id = "savana_trucker", name = "Money Trigger (Medium Risk)", type = "money", res = {"savana-truckerjob"}, all = false},
                    {id = "sayer_jukebox", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"sayer-jukebox"}, all = false},
                    {id = "sell_usb", name = "Any Event Trigger (Medium Risk)", type = "event", res = {"sell_usb"}, all = false},
                    {id = "snipe_boombox", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"snipe-boombox"}, all = false},
                    {id = "solos_cashier", name = "Money Trigger (Medium Risk)", type = "money", res = {"solos-cashier"}, all = false},
                    {id = "solos_food", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"solos-food"}, all = false},
                    {id = "solos_hookah", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"solos-hookah"}, all = false},
                    {id = "solos_jointroll", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"solos-jointroll"}, all = false},
                    {id = "solos_joints", name = "Any Item Trigger (High Risk)", type = "item", res = {"solos-joints"}, all = false},
                    {id = "solos_methlab", name = "Any Item Trigger (High Risk)", type = "item", res = {"solos-methlab"}, all = false},
                    {id = "solos_moneywash", name = "Any Item Trigger (High Risk)", type = "item", res = {"solos-moneywash"}, all = false},
                    {id = "solos_restaurants", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"solos-restaurants"}, all = false},
                    {id = "t1ger_gangsystem", name = "Any Item Trigger (High Risk)", type = "item", res = {"t1ger_gangsystem"}, all = false},
                    {id = "t1ger_lib", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"t1ger_lib"}, all = false},
                    {id = "xmmx_letscookplus", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"xmmx_letscookplus"}, all = false},
                    {id = "zat_farming", name = "Any Item Trigger (Medium Risk)", type = "item", res = {"zat-farming"}, all = false},
                    {id = "zat_weed", name = "Any Item Trigger(High Risk)", type = "item", res = {"zat-weed"}, all = false}
                }
                for _, trigger in ipairs(knownTriggers) do
                    local isAvailable = false
                    if trigger.all then
                        local allFound = true
                        for _, resName in ipairs(trigger.res) do
                            if not MachoResourceInjectable(resName) then
                                allFound = false
                                break
                            end
                        end
                        if allFound then
                            isAvailable = true
                        end
                    else
                        if #trigger.res == 0 then
                            isAvailable = true
                        else
                            for _, resName in ipairs(trigger.res) do
                                if MachoResourceInjectable(resName) then
                                    isAvailable = true
                                    break
                                end
                            end
                        end
                    end
                    if isAvailable then
                        table.insert(triggerFinderTab.foundTriggers, trigger)
                    end
                end
                MachoMenuNotification("blossom MeNu", "There Is " .. #triggerFinderTab.foundTriggers .. " triggers in this mf.", 5)
                RebuildTriggerFinderUI(s)
            end
        })
        for _, trigger in ipairs(triggerFinderTab.foundTriggers) do
            table.insert(triggerFinderTab.items, {
                type = "button",
                label = trigger.name,
                action = function(s)
                    triggerFinderTab.selectedTrigger = trigger
                    RebuildTriggerFinderUI(s)
                end
            })
        end
    else
        local trigger = triggerFinderTab.selectedTrigger
        table.insert(triggerFinderTab.items, {type = "label", label = "Selected: " .. trigger.name})
        if trigger.type == "item" then
            table.insert(triggerFinderTab.items, {type = "input", label = "Item Name", value = "", placeholder = "e.g., weapon_pistol"})
        elseif trigger.type == "item_only" then
            table.insert(triggerFinderTab.items, {type = "input", label = "Item Name", value = "", placeholder = "e.g., weapon_pistol"})
        end
        if trigger.type ~= "item_only" then
            table.insert(triggerFinderTab.items, {type = "input", label = "Amount", value = "", placeholder = "e.g., 100000"})
        end
        table.insert(triggerFinderTab.items, {
            type = "button",
            label = "Execute",
            action = function(s)
                local itemInput, amountInput
                if trigger.type == "item" then
                    itemInput = s.tabs[tabIdx].items[2].value
                    amountInput = tonumber(s.tabs[tabIdx].items[3].value)
                elseif trigger.type == "item_only" then
                    itemInput = s.tabs[tabIdx].items[2].value
                    amountInput = nil
                else
                    itemInput = "money"
                    amountInput = tonumber(s.tabs[tabIdx].items[2].value)
                end

                if (trigger.type == "item" and (not amountInput or amountInput <= 0 or not itemInput or itemInput == "")) or (trigger.type == "item_only" and (not itemInput or itemInput == "")) or (trigger.type ~= "item" and trigger.type ~= "item_only" and (not amountInput or amountInput <= 0)) then
                    MachoMenuNotification("blossom MeNu", "Invalid input or amount.", 5)
                    return
                end

                local handled = false
                local handler = triggerHandlers[trigger.id]
                if handler then
                    handled = handler(itemInput, amountInput, trigger)
                end

                if handled then
                    MachoMenuNotification("blossom MeNu", "Trigger Worked, Enjoy!", 5)
                else
                    MachoMenuNotification("blossom MeNu", "Saved ur ass. don't try ts again, prolly gonna get banned..", 5)
                end
            end
        })
        table.insert(triggerFinderTab.items, {
            type = "button",
            label = "Back",
            action = function(s)
                triggerFinderTab.selectedTrigger = nil
                RebuildTriggerFinderUI(s)
            end
        })
    end
    state.selection.index = 0
end

local function scanForLogs()
    logState.foundLogs = {}
    for _, resName in ipairs(logResourceNames) do
        if MachoResourceInjectable(resName) then
            table.insert(logState.foundLogs, {name = resName, state = GetResourceState(resName)})
        end
    end
end

local function stopScannedLogs()
    logState.stoppedLogs = {}
    for _, log in ipairs(logState.foundLogs) do
        if GetResourceState(log.name) == "started" then
            pcall(function()
                MachoResourceStop(log.name)
            end)
            table.insert(logState.stoppedLogs, log.name)
        end
    end
    scanForLogs()
end

local function RebuildLogsUI(state)
    local logsTab
    for _, tab in ipairs(state.tabs) do
        if tab.key == "check_logs" then
            logsTab = tab
            break
        end
    end
    if not logsTab then
        return
    end

    logsTab.items = {}

    table.insert(logsTab.items, {
        type = "button",
        label = "Scan For Log Resources",
        action = function(s)
            scanForLogs()
            RebuildLogsUI(s)
        end
    })

    if #logState.foundLogs > 0 then
        table.insert(logsTab.items, {
            type = "button",
            label = "Stop All Running Logs",
            action = function(s)
                stopScannedLogs()
                RebuildLogsUI(s)
            end
        })
        table.insert(logsTab.items, {type = "label", label = "--- Found Logs ---"})
        for _, log in ipairs(logState.foundLogs) do
            table.insert(logsTab.items, {type = "label", label = log.name .. " (" .. (GetResourceState(log.name) or "stopped") .. ")"})
        end
    end
    state.selection.index = 0
end

local MenuState = {
    position = MenuPosition,
    activeTab = 0,
    selection = {index = 0},
    isTyping = false,
    isContentPanelOpen = false,
    tabs = {
        {
            key = "servers",
            title = "Servers",
            header = "Server Triggers (Money)",
            type = "grid",
            cols = 2,
            items = {
                {label = "Vinewood LA", action = function()
                    inject([[pcall(function() TriggerServerEvent('delivery:giveRewardnails', 150000) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Atlanta Projects", action = function()
                    inject([[pcall(function() TriggerServerEvent('devkit_bbq:addinv', 'money', 1000000) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "LA PRESION LATINA 2.0", action = function()
                    inject([[pcall(function() TriggerServerEvent('Tk_motores:returnItems', {['money'] = 1000000}) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "La Diabla RP", action = function()
                    inject([[pcall(function() TriggerServerEvent('Tk_motores:returnItems', {['money'] = 1000000}) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Flawda Water RP", action = function()
                    inject([[pcall(function() TriggerServerEvent('delivery:giveRewardhandbags', 1000000) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Full Send RP", action = function()
                    inject([[pcall(function() TriggerServerEvent('Core:triggerServerCallback', "core:addItem", 75, "dollar", 500000, nil) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Palm Beach Miami", action = function()
                    inject([[Citizen.CreateThread(function() for i=1,135 do TriggerServerEvent("shop:purchaseItem2","codeplug"..math.random(1000,999999),"money",0) end end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Redline District", action = function()
                    inject([[pcall(function() TriggerServerEvent("Pug:server:GiveChoppingCarPay", 6969969) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "Raq City", action = function()
                    inject([[pcall(function() TriggerServerEvent('delivery:giveRewardhandbags', 1000000) end)]])
                    MachoMenuNotification("blossom MeNu", "Trigger Executed, Enjoy.", 5)
                end},
                {label = "More Servers Coming Soon", action = function()
                    MachoMenuNotification("blossom MeNu", "More Servers Coming Soon.", 5)
                end}
            }
        },
        {key = "players", title = "Players", header = "Players List", type = "list", items = {}},
        {
            key = "self",
            title = "Self",
            header = "Self Options",
            type = "form",
            items = {
                {type = "button", label = "Set Police Job", action = function()
                    MachoInjectResource("wasabi_multijob", [[
SelectJobMenu({
    job    = 'police',
    grade  = 5,
    label  = 'police',
    boss   = true,
    onDuty = false
})
]])
                    MachoMenuNotification("blossom MeNu", "Police Job Set.", 5)
                end},
                {type = "button", label = "Set Ems Job", action = function()
                    MachoInjectResource("wasabi_multijob", [[
SelectJobMenu({
    job    = 'ambulance',
    grade  = 5,
    label  = 'Ambulance',
    boss   = true,
    onDuty = false
})
]])
                    MachoMenuNotification("blossom MeNu", "EMS Job Set.", 5)
                end},
                {type = "button", label = "Revive", action = function()
                    for _, ev in ipairs({"hospital:client:Revive", "esx_ambulancejob:revive", "crack_ambulance:onPlayerSpawn", "ambulance:revive", "esx_ambulancejob:reviveplayer", "tp:client:revive", "player:revive", "qb-hospital:server:revive", "reviveFunction", "heal:player"}) do
                        inject(("TriggerEvent(%q)"):format(ev))
                        Citizen.Wait(50)
                    end
                    MachoMenuNotification("blossom MeNu", "Revived.", 5)
                end},
                {type = "button", label = "Rob Inventorys", action = function()
                    isRobberyActive = not isRobberyActive
                    MachoMenuNotification("blossom MeNu", isRobberyActive and "Do /steal or /rob to rob niggas." or "You are no longer robbing niggas.", 7)
                    Citizen.CreateThread(function()
                        local dict = "missminuteman_1ig_2"
                        local anim = "handsup_enter"
                        while isRobberyActive do
                            while not HasAnimDictLoaded(dict) do
                                RequestAnimDict(dict)
                                Citizen.Wait(100)
                            end
                            local selfCoords = GetEntityCoords(PlayerPedId())
                            for _, player in ipairs(GetActivePlayers()) do
                                if player ~= PlayerId() then
                                    local ped = GetPlayerPed(player)
                                    if DoesEntityExist(ped) then
                                        if #(GetEntityCoords(ped) - selfCoords) <= 2.5 then
                                            if not IsPedCuffed(ped) then
                                                SetEnableHandcuffs(ped, true)
                                            end
                                            if not IsEntityPlayingAnim(ped, dict, anim, 3) then
                                                TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
                                            end
                                        end
                                    end
                                end
                            end
                            Citizen.Wait(0)
                        end
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local ped = GetPlayerPed(player)
                                if DoesEntityExist(ped) then
                                    ClearPedTasks(ped)
                                    SetEnableHandcuffs(ped, false)
                                end
                            end
                        end
                    end)
                    Citizen.CreateThread(function()
                        while isRobberyActive do
                            Citizen.Wait(0)
                            local selfCoords = GetEntityCoords(PlayerPedId())
                            for _, player in ipairs(GetActivePlayers()) do
                                if player ~= PlayerId() then
                                    local ped = GetPlayerPed(player)
                                    if DoesEntityExist(ped) then
                                        local coords = GetEntityCoords(ped)
                                        if #(coords - selfCoords) <= 10.0 then
                                            local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.0)
                                            if onScreen then
                                                SetTextScale(0.35, 0.35)
                                                SetTextFont(4)
                                                SetTextProportional(1)
                                                SetTextColour(255, 255, 255, 255)
                                                SetTextEntry("STRING")
                                                SetTextCentre(true)
                                                AddTextComponentString("Do /Steal or /Rob")
                                                DrawText(x, y)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end}
            }
        },
        {
            key = "trolling",
            title = "Trolling",
            header = "Trolling Options",
            type = "form",
            items = {{type = "button", label = "Trolling Shit Will Go Here", action = function()
                MachoMenuNotification("blossom MeNu", "Trolling options soon..", 5)
            end}}
        },
        {
            key = "vehicle",
            title = "Vehicle",
            header = "Vehicle Options",
            type = "form",
            items = {
                {type = "button", label = "Repair Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        SetVehicleFixed(veh)
                        SetVehicleDeformationFixed(veh)
                        SetVehicleUndriveable(veh, false)
                        SetVehicleEngineOn(veh, true, true)
                        MachoMenuNotification("blossom MeNu", "Vehicle repaired", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "Max Upgrade Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        SetVehicleModKit(veh, 0)
                        for i = 0, 49 do
                            SetVehicleMod(veh, i, GetNumVehicleMods(veh, i) - 1, false)
                        end
                        ToggleVehicleMod(veh, 18, true)
                        ToggleVehicleMod(veh, 22, true)
                        MachoMenuNotification("blossom MeNu", "Vehicle maxed out", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "Flip Vehicle Upright", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        SetVehicleOnGroundProperly(veh)
                        MachoMenuNotification("blossom MeNu", "Vehicle flipped", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "Delete Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        DeleteEntity(veh)
                        MachoMenuNotification("blossom MeNu", "Vehicle deleted", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "God Mode Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        SetEntityInvincible(veh, true)
                        MachoMenuNotification("blossom MeNu", "Vehicle god mode enabled", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "Max Speed Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        SetVehicleEnginePowerMultiplier(veh, 100.0)
                        SetVehicleEngineTorqueMultiplier(veh, 100.0)
                        MachoMenuNotification("blossom MeNu", "Max speed enabled", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "Rainbow Vehicle", action = function(state)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if veh ~= 0 then
                        Citizen.CreateThread(function()
                            for i = 1, 100 do
                                SetVehicleCustomPrimaryColour(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
                                SetVehicleCustomSecondaryColour(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
                                Citizen.Wait(100)
                            end
                        end)
                        MachoMenuNotification("blossom MeNu", "Rainbow mode activated", 3)
                    else
                        MachoMenuNotification("blossom MeNu", "You're not in a vehicle", 3)
                    end
                end},
                {type = "button", label = "[E] Vehicle Unlocker", action = toggleVehicleUnlocker, state = isVehicleUnlockerActive and "on" or "off"},
                {type = "button", label = "(Shift) Vehicle Boost", action = function(state)
                    toggleVehicleBoost()
                    local boostCode = [[Citizen.CreateThread(function() while true do Citizen.Wait(0) if IsControlPressed(0, 21) then local playerPed = PlayerPedId() if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then local vehicle = GetVehiclePedIsIn(playerPed, false) ApplyForceToEntity(vehicle, 1, 0.0, 4.0, 0.0, 0.0, 0.0, 0, true, true, true, true, true) end end end end)]]
                    inject(boostCode)
                end, state = isVehicleBoostEnabled and "on" or "off"}
            }
        },
        {
            key = "combat",
            title = "Combat Options",
            header = "Combat Settings",
            type = "form",
            items = {
                {type = "button", label = "Toggle ESP Skeletons", action = function()
                    espEnabled = not espEnabled
                    if espEnabled then
                        Citizen.CreateThread(function()
                            local cfg = {color = {r = 155, g = 0, b = 255, a = 255}, selfColor = {r = 255, g = 100, b = 255, a = 255}, pixelSize = 0.002}
                            local function DrawPixel(x, y, size, r, g, b, a) DrawRect(x, y, size, size, r, g, b, a) end
                            local function DrawLine(x1, y1, x2, y2, r, g, b, a, thickness)
                                local dx, dy = x2 - x1, y2 - y1
                                local distance = math.sqrt(dx * dx + dy * dy)
                                if distance < 0.001 then return end
                                local steps = math.ceil(distance * 300)
                                for i = 0, steps do
                                    local t = i / steps
                                    DrawPixel(x1 + t * dx, y1 + t * dy, thickness, r, g, b, a)
                                end
                            end
                            local skeletonBones = {{0x796E, 0x9995}, {0x9995, 0x5C01}, {0x5C01, 0x60F0}, {0x60F0, 0x60F1}, {0x60F1, 0x60F2}, {0x9995, 0xFCD9}, {0xFCD9, 0xB1C5}, {0xB1C5, 0xEEEB}, {0xEEEB, 0x49D9}, {0x9995, 0x29D2}, {0x29D2, 0x9D4D}, {0x9D4D, 0x6E5C}, {0x6E5C, 0xDEAD}, {0x60F2, 0xE39F}, {0xE39F, 0xF9BB}, {0xF9BB, 0x3779}, {0x60F2, 0xCA72}, {0xCA72, 0x9000}, {0x9000, 0xCC4D}}
                            while espEnabled do
                                local myPed = PlayerPedId()
                                for _, playerId in ipairs(GetActivePlayers()) do
                                    local ped = GetPlayerPed(playerId)
                                    if DoesEntityExist(ped) and not IsEntityDead(ped) then
                                        if ped ~= myPed or showSelfSkeleton then
                                            local currentColor = (ped == myPed) and cfg.selfColor or cfg.color
                                            for _, pair in ipairs(skeletonBones) do
                                                local b1 = GetPedBoneCoords(ped, pair[1], 0.0, 0.0, 0.0)
                                                local b2 = GetPedBoneCoords(ped, pair[2], 0.0, 0.0, 0.0)
                                                if b1 and b2 and (math.abs(b1.x) > 0.1 or math.abs(b1.y) > 0.1 or math.abs(b1.z) > 0.1) and (math.abs(b2.x) > 0.1 or math.abs(b2.y) > 0.1 or math.abs(b2.z) > 0.1) then
                                                    local on1, sx1, sy1 = World3dToScreen2d(b1.x, b1.y, b1.z)
                                                    local on2, sx2, sy2 = World3dToScreen2d(b2.x, b2.y, b2.z)
                                                    if on1 and on2 and sx1 > 0 and sx1 < 1 and sy1 > 0 and sy1 < 1 and sx2 > 0 and sx2 < 1 and sy2 > 0 and sy2 < 1 then
                                                        DrawLine(sx1, sy1, sx2, sy2, currentColor.r, currentColor.g, currentColor.b, currentColor.a, cfg.pixelSize)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                Citizen.Wait(0)
                            end
                        end)
                    end
                    MachoMenuNotification("blossom MeNu", "ESP " .. (espEnabled and "on" or "off"), 5)
                end},
                {type = "button", label = "Toggle Self Skeleton", action = function()
                    showSelfSkeleton = not showSelfSkeleton
                    MachoMenuNotification("blossom MeNu", "Self Skeleton " .. (showSelfSkeleton and "ON" or "OFF"), 5)
                end},
                {type = "button", label = "Toggle Player Names", action = function()
                    namesEnabled = not namesEnabled
                    if namesEnabled then
                        Citizen.CreateThread(function()
                            local function DrawText2D(x, y, text, scale, r, g, b, a)
                                SetTextScale(scale, scale)
                                SetTextFont(0)
                                SetTextProportional(1)
                                SetTextCentre(1)
                                SetTextColour(r, g, b, a)
                                SetTextOutline()
                                SetTextEntry("STRING")
                                AddTextComponentString(text)
                                DrawText(x, y)
                            end
                            while namesEnabled do
                                local myPed, myPos = PlayerPedId(), GetEntityCoords(PlayerPedId())
                                for _, playerId in ipairs(GetActivePlayers()) do
                                    local ped = GetPlayerPed(playerId)
                                    if DoesEntityExist(ped) and not IsEntityDead(ped) then
                                        local head = GetPedBoneCoords(ped, 0x796E, 0.0, 0.0, 0.6)
                                        local onScreen, sx, sy = World3dToScreen2d(head.x, head.y, head.z + 0.05)
                                        if onScreen then
                                            local distance = #(GetEntityCoords(ped) - myPos)
                                            local scaleFactor = math.max(0.12, 0.18 * (1.0 - math.min(distance / 100.0, 0.5)))
                                            local name = (ped == myPed) and "[SELF] " .. GetPlayerName(playerId) or GetPlayerName(playerId)
                                            DrawText2D(sx, sy, name, scaleFactor, 255, 255, 255, 255)
                                        end
                                    end
                                end
                                Citizen.Wait(0)
                            end
                        end)
                    end
                    MachoMenuNotification("blossom MeNu", "Player Names " .. (namesEnabled and "ON" or "OFF"), 5)
                end},
                {type = "button", label = "Toggle Player IDs", action = function()
                    idsEnabled = not idsEnabled
                    if idsEnabled then
                        Citizen.CreateThread(function()
                            local function DrawText2D(x, y, text, scale, r, g, b, a)
                                SetTextScale(scale, scale)
                                SetTextFont(0)
                                SetTextProportional(1)
                                SetTextCentre(1)
                                SetTextColour(r, g, b, a)
                                SetTextOutline()
                                SetTextEntry("STRING")
                                AddTextComponentString(text)
                                DrawText(x, y)
                            end
                            while idsEnabled do
                                local myPos = GetEntityCoords(PlayerPedId())
                                for _, playerId in ipairs(GetActivePlayers()) do
                                    local ped = GetPlayerPed(playerId)
                                    if DoesEntityExist(ped) and not IsEntityDead(ped) then
                                        local head = GetPedBoneCoords(ped, 0x796E, 0.0, 0.0, 0.6)
                                        local onScreen, sx, sy = World3dToScreen2d(head.x, head.y, head.z - 0.02)
                                        if onScreen then
                                            local distance = #(GetEntityCoords(ped) - myPos)
                                            local scaleFactor = math.max(0.10, 0.15 * (1.0 - math.min(distance / 100.0, 0.5)))
                                            DrawText2D(sx, sy, ("ID: %d"):format(GetPlayerServerId(playerId)), scaleFactor, 255, 255, 255, 255)
                                        end
                                    end
                                end
                                Citizen.Wait(0)
                            end
                        end)
                    end
                    MachoMenuNotification("blossom MeNu", "Player IDs " .. (idsEnabled and "ON" or "OFF"), 5)
                end},
                {type = "button", label = "Toggle Crosshair", action = function()
                    crosshairEnabled = not crosshairEnabled
                    if crosshairEnabled then
                        Citizen.CreateThread(function()
                            while crosshairEnabled do
                                DrawRect(0.5, 0.5, 0.002, 0.015, 155, 0, 255, 255)
                                DrawRect(0.5, 0.5, 0.015, 0.002, 155, 0, 255, 255)
                                Citizen.Wait(0)
                            end
                        end)
                    end
                    MachoMenuNotification("blossom MeNu", "Crosshair " .. (crosshairEnabled and "ON" or "OFF"), 5)
                end},
                {type = "button", label = "Toggle Aimbot FOV (SOON)", action = function()
                    fovCircleEnabled = not fovCircleEnabled
                    if fovCircleEnabled then
                        Citizen.CreateThread(function()
                            while fovCircleEnabled do
                                local centerX, centerY, radius, segments = 0.5, 0.5, 0.15, 120
                                for i = 0, segments - 1 do
                                    local angle1, angle2 = (i / segments) * 2 * math.pi, ((i + 1) / segments) * 2 * math.pi
                                    local x1, y1 = centerX + math.cos(angle1) * radius, centerY + math.sin(angle1) * radius
                                    local x2, y2 = centerX + math.cos(angle2) * radius, centerY + math.sin(angle2) * radius
                                    local dx, dy = x2 - x1, y2 - y1
                                    local steps = math.ceil(math.sqrt(dx * dx + dy * dy) * 500)
                                    for j = 0, steps do
                                        DrawRect(x1 + (j / steps) * dx, y1 + (j / steps) * dy, 0.0008, 0.0008, 155, 0, 255, 200)
                                    end
                                end
                                DrawRect(centerX, centerY, 0.0015, 0.01, 155, 0, 255, 255)
                                DrawRect(centerX, centerY, 0.01, 0.0015, 155, 0, 255, 255)
                                Citizen.Wait(0)
                            end
                        end)
                    end
                    MachoMenuNotification("blossom MeNu", "Aimbot FOV " .. (fovCircleEnabled and "ON" or "OFF"), 5)
                end}
            }
        },
        {
            key = "trigger_finder",
            title = "Trigger Finder",
            header = "Find & Execute Triggers",
            type = "form",
            foundTriggers = {},
            selectedTrigger = nil,
            items = {{type = "button", label = "Enable Trigger Finder", action = function(state)
                MachoMenuNotification("blossom MeNu", "Enabled, press again to scan.", 7)
                RebuildTriggerFinderUI(state)
            end}}
        },
        {
            key = "executor",
            title = "Executor",
            header = "Executor & Options",
            type = "form",
            items = {
                {type = "input", label = "Event Name", value = "", placeholder = "Event Goes Here"},
                {type = "input", label = "Payload", value = "", placeholder = "Payload Goes Here"},
                {type = "button", label = "Execute Trigger", action = function(state)
                    local eventName = state.tabs[2].items[1].value
                    local payload = state.tabs[2].items[2].value
                    if not eventName or eventName == "" then
                        MachoMenuNotification("blossom MeNu", "The event name cannot be empty.", 5)
                        return
                    end
                    inject(payload and payload ~= "" and ("pcall(function() TriggerServerEvent(%q,%s) end)"):format(eventName, payload) or ("pcall(function() TriggerServerEvent(%q) end)"):format(eventName))
                    MachoMenuNotification("blossom MeNu", "Trigger Executed.", 5)
                end}
            }
        },
        {
            key = "resources",
            title = "Resources",
            header = "Server Resources",
            type = "form",
            items = {{type = "input", label = "Search Resources", value = "", placeholder = "Start typing to filter..."}}
        },
        {
            key = "vip",
            title = "VIP",
            header = "VIP Item Spawner",
            type = "form",
            items = {
                {type = "input", label = "Item Name", value = "", placeholder = "e.g., weapon_pistol"},
                {type = "input", label = "Amount", value = "", placeholder = "e.g., 1"},
                {type = "button", label = "Spawn Item", action = function(state)
                    local vipTab = state.tabs[10]
                    local itemName = vipTab.items[1].value
                    local amount = tonumber(vipTab.items[2].value)
                    
                    if not itemName or itemName == "" then
                        MachoMenuNotification("blossom MeNu", "Please enter an item name.", 3)
                        return
                    end
                    
                    if not amount or amount <= 0 then
                        MachoMenuNotification("blossom MeNu", "Please enter a valid amount.", 3)
                        return
                    end
                    
            -- Build the code to spawn all items in a single injection
            local code = [[
                Citizen.CreateThread(function()
                    for i = 1, ]]..tostring(amount)..[[ do
                        gItem({ item = ']]..itemName..[[', label = 'Free', price = 0 })
                        Citizen.Wait(50)
                    end
                end)
            ]]
            
            MachoInjectResource2(2, "wasabi_ambulance", code)
            MachoMenuNotification("blossom MeNu", "Spawning " .. amount .. " x " .. itemName .. "!", 3)
        end}
    }
}
    }
}

function UpdateAndRender()
    if not MenuOpen then
        return
    end

    local playerTabIndex, resourceTabIndex = -1, -1
    for i, tab in ipairs(MenuState.tabs) do
        if tab.key == "players" then
            playerTabIndex = i
        elseif tab.key == "resources" then
            resourceTabIndex = i
        end
    end

    if playerTabIndex > 0 then
        local currentItems = MenuState.tabs[playerTabIndex].items
        local selectedIndex = MenuState.selection.index
        local selectedPlayerData = nil
        
        if #currentItems > 0 and selectedIndex >= 0 and selectedIndex < #currentItems then
            selectedPlayerData = currentItems[selectedIndex + 1]
        end
        
        MenuState.tabs[playerTabIndex].items = {}
        for i = 0, 255 do
            if NetworkIsPlayerActive(i) then
                local n = GetPlayerName(i)
                local id = GetPlayerServerId(i)
                local showOptions = false
                local selectedOption = 0
                
                if selectedPlayerData and selectedPlayerData.playerId == i then
                    showOptions = selectedPlayerData.showOptions or false
                    selectedOption = selectedPlayerData.selectedOption or 0
                end
                
                table.insert(MenuState.tabs[playerTabIndex].items, {
                    label = ("%s [%d]"):format(n or "Unknown", id or 0),
                    playerId = i,
                    serverPlayerId = id,
                    hasOptions = true,
                    showOptions = showOptions,
                    selectedOption = selectedOption,
                    optionsCount = 10
                })
            end
        end
    end

    if resourceTabIndex > 0 then
        local resourcesTab = MenuState.tabs[resourceTabIndex]
        local searchQuery = resourcesTab.items[1] and resourcesTab.items[1].value:lower() or ""

        local filteredResList = {}
        for i = 0, GetNumResources() - 1 do
            local resName = GetResourceByFindIndex(i)
            if resName then
                local safeName = safeResourceName(resName)
                if searchQuery == "" or safeName:lower():find(searchQuery, 1, true) then
                    table.insert(filteredResList, {
                        label = safeName,
                        state = LockedResources[safeName] and "stopped" or GetResourceState(resName) or "stopped"
                    })
                end
            end
        end
        table.sort(filteredResList, function(a, b)
            return (a.label or "") < (b.label or "")
        end)

        resourcesTab.items = {{
            type = "input",
            label = "Search Resources",
            value = resourcesTab.items[1].value,
            placeholder = "Press Enter To Search."
        }}
        for _, resItem in ipairs(filteredResList) do
            table.insert(resourcesTab.items, resItem)
        end
    end

    -- Update vehicle button states
    for i, tab in ipairs(MenuState.tabs) do
        if tab.key == "vehicle" then
            for _, item in ipairs(tab.items) do
                if item.label == "(Shift) Vehicle Boost" then
                    item.state = isVehicleBoostEnabled and "on" or "off"
                elseif item.label == "[E] Vehicle Unlocker" then
                    item.state = isVehicleUnlockerActive and "on" or "off"
                end
            end
            break
        end
    end

    SendToDui("update", MenuState)
end

function getCharFromKey(key, isShiftPressed, isCapsLockOn)
    local charData = specialCharMap[key]
    if charData then
        if isShiftPressed then
            return charData.shifted
        else
            return charData.normal
        end
    end
    if key >= 0x41 and key <= 0x5A then
        local shouldBeUppercase = (isShiftPressed and not isCapsLockOn) or (not isShiftPressed and capsLockOn)
        if shouldBeUppercase then
            return string.char(key)
        else
            return string.char(key + 32)
        end
    end
    if key == 0x20 then
        return " "
    end
    return nil
end

MachoOnKeyUp(function(key)
    if key == 0x2E then
        MenuOpen = not MenuOpen
        isTyping = false
        MenuState.isTyping = false
        MenuState.isContentPanelOpen = false

        if MenuOpen then
            MachoShowDui(Dui)
            UpdateAndRender()
        else
            MachoHideDui(Dui)
        end
        return
    end

    if key == 0x14 then
        capsLockOn = not capsLockOn
        return
    end

    if not MenuOpen then
        if key == 0x45 then
            if isVehicleUnlockerActive then
                local pos = GetEntityCoords(PlayerPedId())
                local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
                if DoesEntityExist(vehicle) then
                    local locked = GetVehicleDoorLockStatus(vehicle)
                    SetVehicleDoorsLocked(vehicle, locked == 1 and 2 or 1)
                    SetVehicleDoorsLockedForAllPlayers(vehicle, locked == 1)
                    MachoMenuNotification("blossom MeNu", locked == 1 and "Vehicle locked." or "Vehicle unlocked.", 3)
                else
                    MachoMenuNotification("blossom MeNu", "No vehicle nearby, stupid ass.", 3)
                end
            end
            if isRobberyActive then
                handleRobberyAttempt()
            end
        end
        return
    end

    local needsUpdate = false
    local isShiftPressed = IsDisabledControlPressed(0, 21)
    local isCtrlPressed = IsDisabledControlPressed(0, 36)
    local inContentPanel = MenuState.isContentPanelOpen
    local currentTab = MenuState.tabs[MenuState.activeTab + 1]
    local sel = MenuState.selection
    local itemCount = currentTab and #currentTab.items or 0

    if isTyping then
        local item = currentTab.items[sel.index + 1]
        if item and item.type == "input" then
            if isCtrlPressed then
                if key == 0x56 then
                    local clipboardText = MachoGetClipboardText()
                    if clipboardText then
                        item.value = (item.value or "") .. clipboardText
                        needsUpdate = true
                    end
                    return
                elseif key == 0x43 then
                    if item.value and item.value ~= "" then
                        MachoSetClipboardText(item.value)
                        MachoMenuNotification("blossom MeNu", "Copied.", 3)
                    end
                    return
                end
            end

            if key == 0x08 then
                item.value = string.sub(item.value or "", 1, -2)
                needsUpdate = true
            elseif key == 0x0D or key == 0x1B then
                isTyping = false
                MenuState.isTyping = false
                needsUpdate = true
            else
                local char = getCharFromKey(key, isShiftPressed, capsLockOn)
                if char then
                    item.value = (item.value or "") .. char
                    needsUpdate = true
                end
            end
        end
    else
        if not inContentPanel then
            if key == 0x26 then
                MenuState.activeTab = (MenuState.activeTab - 1 + #MenuState.tabs) % #MenuState.tabs
                needsUpdate = true
            elseif key == 0x28 then
                MenuState.activeTab = (MenuState.activeTab + 1) % #MenuState.tabs
                needsUpdate = true
            elseif key == 0x0D then
                MenuState.isContentPanelOpen = true
                MenuState.selection.index = 0
                needsUpdate = true
            end
        else
            local item = currentTab.items[sel.index + 1]
            local inPlayerOptions = currentTab.key == "players" and item and item.showOptions
            
            if inPlayerOptions then
                if key == 0x26 then
                    item.selectedOption = (item.selectedOption - 1 + (item.optionsCount or 10)) % (item.optionsCount or 10)
                    needsUpdate = true
                elseif key == 0x28 then
                    item.selectedOption = (item.selectedOption + 1) % (item.optionsCount or 10)
                    needsUpdate = true
                elseif key == 0x08 or key == 0x1B then
                    item.showOptions = false
                    item.selectedOption = 0
                    needsUpdate = true
                elseif key == 0x0D then
                    local targetPed = GetPlayerPed(item.playerId)
                    
                    if item.selectedOption == 0 then
                        if DoesEntityExist(targetPed) then
                            local coords = GetEntityCoords(targetPed)
                            SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, false)
                            MachoMenuNotification("blossom MeNu", "Teleported to player", 3)
                        end
                    elseif item.selectedOption == 1 then
                        MachoMenuNotification("blossom MeNu", "Cannot bring players (client-side limitation)", 3)
                    elseif item.selectedOption == 2 then
                        MachoMenuNotification("blossom MeNu", "Cannot give weapons to others (client-side)", 3)
                    elseif item.selectedOption == 3 then
                        MachoMenuNotification("blossom MeNu", "Cannot heal others (client-side)", 3)
                    elseif item.selectedOption == 4 then
                        MachoMenuNotification("blossom MeNu", "Cannot kill others (client-side)", 3)
                    elseif item.selectedOption == 5 then
                        if DoesEntityExist(targetPed) then
                            FreezeEntityPosition(targetPed, true)
                            MachoMenuNotification("blossom MeNu", "Player frozen", 3)
                        end
                    elseif item.selectedOption == 6 then
                        if NetworkIsInSpectatorMode() then
                            NetworkSetInSpectatorMode(false, PlayerPedId())
                            MachoMenuNotification("blossom MeNu", "Stopped spectating", 3)
                        elseif DoesEntityExist(targetPed) then
                            NetworkSetInSpectatorMode(true, targetPed)
                            MachoMenuNotification("blossom MeNu", "Spectating player (press again to stop)", 3)
                        end
                    elseif item.selectedOption == 7 then
                        if DoesEntityExist(targetPed) then
                            local coords = GetEntityCoords(targetPed)
                            AddExplosion(coords.x, coords.y, coords.z, 2, 100.0, true, false, 1.0)
                            MachoMenuNotification("blossom MeNu", "Exploded player", 3)
                        end
                    elseif item.selectedOption == 8 then
                        MachoMenuNotification("blossom MeNu", "Cannot kick players (requires admin)", 3)
                    elseif item.selectedOption == 9 then
                        MachoMenuNotification("blossom MeNu", "Cannot ban players (requires admin)", 3)
                    end
                    needsUpdate = true
                end
            else
                if key == 0x26 then
                    sel.index = (sel.index - 1 + itemCount) % itemCount
                    needsUpdate = true
                elseif key == 0x28 then
                    sel.index = (sel.index + 1) % itemCount
                    needsUpdate = true
                elseif key == 0x08 or key == 0x1B then
                    MenuState.isContentPanelOpen = false
                    needsUpdate = true
                elseif key == 0x0D then
                    if item then
                        if item.type == "input" then
                            isTyping = true
                            MenuState.isTyping = true
                            MachoMenuNotification("Typing", "Press enter or esc to stop.", 3)
                            needsUpdate = true
                        else
                            if currentTab.key == "players" and item.playerId then
                                item.showOptions = true
                                item.selectedOption = 0
                                needsUpdate = true
                            elseif currentTab.key == "resources" then
                                local resLabel = item.label
                                if resLabel then
                                    if LockedResources[resLabel] then
                                        LockedResources[resLabel] = nil
                                        pcall(function()
                                            MachoResourceStart(resLabel)
                                        end)
                                        MachoMenuNotification("blossom MeNu", "Resource Started: " .. (resLabel or "Unknown"), 5)
                                    else
                                        LockedResources[resLabel] = true
                                        MachoMenuNotification("blossom MeNu", "Resource Stopped: " .. (resLabel or "Unknown"), 5)
                                    end
                                    Citizen.Wait(150)
                                end
                                needsUpdate = true
                            elseif item.action then
                                pcall(function()
                                    item.action(MenuState)
                                end)
                                needsUpdate = true
                            end
                        end
                    end
                end
            end
        end
    end

    if needsUpdate then
        UpdateAndRender()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if MenuOpen then
            DisableAllControlActions(0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local refreshed = false
        for resName, _ in pairs(LockedResources) do
            if GetResourceState(resName) == "started" then
                pcall(function()
                    MachoResourceStop(resName)
                end)
                refreshed = true
            end
        end
        if MenuOpen and refreshed then
            UpdateAndRender()
        end
    end
end)

Citizen.CreateThread(function()
    MachoLockLogger(0)
    local stoppedLogs = {}
    for _, resName in ipairs(logResourceNames) do
        if MachoResourceInjectable(resName) then
            MachoResourceStop(resName)
            table.insert(stoppedLogs, resName)
        end
    end
    if #stoppedLogs > 0 then
        MachoMenuNotification("LOGS STOPPED", "Log Name: " .. table.concat(stoppedLogs, ", "), 7)
        Citizen.Wait(4000)
    end
    MachoMenuNotification("Cooked.lua", "Enjoy blossom Menu.", 5)
end)
