-- Menu Builder
local MenuSize = vec2(650, 500)
local MenuStartCoords = vec2(500, 500)

local TabsBarWidth = 150
local SectionsPadding = 10
local MachoPanelGap = 15

local SectionChildWidth = MenuSize.x - TabsBarWidth
local SectionChildHeight = MenuSize.y - (2 * SectionsPadding)

local ColumnWidth = (SectionChildWidth - (SectionsPadding * 3)) / 2
local HalfHeight = (SectionChildHeight - (SectionsPadding * 3)) / 2

local MenuWindow = MachoMenuTabbedWindow("blossom", MenuStartCoords.x, MenuStartCoords.y, MenuSize.x, MenuSize.y, TabsBarWidth)
MachoMenuSetKeybind(MenuWindow, 0x14)
MachoMenuSetAccent(MenuWindow, 255, 61, 255)

MachoMenuText(MenuWindow, "0.V1")
-- Tabs
local SelfTab      = MachoMenuAddTab(MenuWindow, "Self")
local ServerTab    = MachoMenuAddTab(MenuWindow, "Server")
local WeaponTab    = MachoMenuAddTab(MenuWindow, "Weapons")
local VehicleTab   = MachoMenuAddTab(MenuWindow, "Vehicle")
local TeleportTab  = MachoMenuAddTab(MenuWindow, "Teleport")
local AnimTab      = MachoMenuAddTab(MenuWindow, "Animations")
local TriggersTab  = MachoMenuAddTab(MenuWindow, "Triggers")
local VipTab       = MachoMenuAddTab(MenuWindow, "Vip")
local SettingTab   = MachoMenuAddTab(MenuWindow, ".gg/blossoma")
-- Tab Layouts
local function SingleSection(tab, name)
    local x = TabsBarWidth + SectionsPadding
    local y = SectionsPadding + MachoPanelGap
    return MachoMenuGroup(tab, name, x, y, x + SectionChildWidth - (SectionsPadding * 2), y + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
end

-- Self: two columns — Toggles (left, tall) | Model + Functions (right, stacked)
local function SelfTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local my = ty + HalfHeight + SectionsPadding
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Toggles",    lx, ty, lx + ColumnWidth, ty + (HalfHeight * 2) + SectionsPadding)
    local S2 = MachoMenuGroup(tab, "Model",       rx, ty, rx + ColumnWidth, ty + HalfHeight)
    local S3 = MachoMenuGroup(tab, "Functions",   rx, my, rx + ColumnWidth, my + HalfHeight)
    return S1, S2, S3
end

-- Weapons: two columns — Mods (left) | Spawner (right)
local function WeaponTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Mods",    lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Spawner", rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Vehicle: two columns — Mods (left) | Actions (right)
local function VehicleTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Mods",    lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Actions", rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Server: two columns — Player (left) | Everyone (right)
local function ServerTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Player",   lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Everyone", rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Teleport: two columns — Locations (left) | Custom (right)
local function TeleportTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Locations", lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Other",     rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Animations: two columns — Force Emotes (left) | Emote List (right)
local function AnimTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Force Emotes", lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Emote List",   rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Triggers: two columns — Items/Money (left) | Exploits (right)
local function TriggersTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local my = ty + HalfHeight + SectionsPadding
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Item Spawner",  lx, ty, lx + ColumnWidth, ty + HalfHeight)
    local S2 = MachoMenuGroup(tab, "Money Spawner", lx, my, lx + ColumnWidth, my + HalfHeight)
    local S3 = MachoMenuGroup(tab, "Exploits",      rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2, S3
end

-- VIP: two columns — Items (left) | Dirty Money (right)
local function VipTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Item Spawner", lx, ty, lx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    local S2 = MachoMenuGroup(tab, "Dirty Money",  rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2
end

-- Settings: two columns — General (left) | Server Info (right)
local function SettingTabLayout(tab)
    local lx = TabsBarWidth + SectionsPadding
    local ty = SectionsPadding + MachoPanelGap
    local my = ty + HalfHeight + SectionsPadding
    local rx = lx + ColumnWidth + SectionsPadding
    local S1 = MachoMenuGroup(tab, "Menu",          lx, ty, lx + ColumnWidth, ty + HalfHeight)
    local S2 = MachoMenuGroup(tab, "Design",        lx, my, lx + ColumnWidth, my + HalfHeight)
    local S3 = MachoMenuGroup(tab, "Server Info",   rx, ty, rx + ColumnWidth, ty + SectionChildHeight - (SectionsPadding * 2) - MachoPanelGap)
    return S1, S2, S3
end
-- Section Instances
local Self      = { SelfTabLayout(SelfTab) }
local Server    = { ServerTabLayout(ServerTab) }
local Weapon    = { WeaponTabLayout(WeaponTab) }
local Vehicle   = { VehicleTabLayout(VehicleTab) }
local Teleport  = { TeleportTabLayout(TeleportTab) }
local Anim      = { AnimTabLayout(AnimTab) }
local Triggers  = { TriggersTabLayout(TriggersTab) }
local Vip       = { VipTabLayout(VipTab) }
local Setting   = { SettingTabLayout(SettingTab) }
-- Functions
local function CheckResource(resource)
    return GetResourceState(resource) == "started"
end

-- Key Validation
local PrivateAuthkey = MachoAuthenticationKey()

local function HasValidKey()
    local PrivateURL = "http://185.244.106.161/Private_keys.txt?auth=OWFkNDczNWJmNWMwNDUyNGEwNGQ3ODgzZGMzNmRjYTc"
    local PrivateContent = MachoWebRequest(PrivateURL)

    if not PrivateContent or PrivateContent == "" then
        return false
    end

    for line in string.gmatch(PrivateContent, "[^\r\n]+") do
        if line == PrivateAuthkey then
            return true
        end
    end

    return false
end

local function HasValidStaffKey()
    local StaffURL = "http://185.244.106.161/Staff_keys.txt?auth=OWFkNDczNWJmNWMwNDUyNGEwNGQ3ODgzZGMzNmRjYTc"
    local StaffContent = MachoWebRequest(StaffURL)

    if not StaffContent or StaffContent == "" then
        return false
    end

    for line in string.gmatch(StaffContent, "[^\r\n]+") do
        if line == PrivateAuthkey then
            return true
        end
    end

    return false
end


local function LoadBypasses()
    Wait(1500)

    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Loading Bypasses.")

    local function DetectFiveGuard()
        local function ResourceFileExists(resourceName, fileName)
            local file = LoadResourceFile(resourceName, fileName)
            return file ~= nil
        end

        local fiveGuardFile = "ai_module_fg-obfuscated.lua"
        local numResources = GetNumResources()

        for i = 0, numResources - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if ResourceFileExists(resourceName, fiveGuardFile) then
                return true, resourceName
            end
        end

        return false, nil
    end

    Wait(100)

    local found, resourceName = DetectFiveGuard()
    if found and resourceName then
        MachoResourceStop(resourceName)
    end

    Wait(100)

    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Finalizing.")

    Wait(500)

    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Finished Enjoy.")
end

LoadBypasses()

local targetResource
if GetResourceState("qbx_core") == "started" then
    targetResource = "qbx_core"
elseif GetResourceState("es_extended") == "started" then
    targetResource = "es_extended"
elseif GetResourceState("qb-core") == "started" then
    targetResource = "qb-core"
else
    targetResource = "any"
end

MachoLockLogger()

-- Locals
MachoInjectResource((CheckResource("core") and "core") or (CheckResource("es_extended") and "es_extended") or (CheckResource("qb-core") and "qb-core") or (CheckResource("monitor") and "monitor") or "any", [[
    local xJdRtVpNzQmKyLf = false -- Free Camera
]])

MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
    Unloaded = false
    local aXfPlMnQwErTyUi = false -- Godmode
    local sRtYuIoPaSdFgHj = false -- Invisibility
    local mKjHgFdSaPlMnBv = false -- No Ragdoll
    local uYtReWqAzXcVbNm = false -- Infinite Stamina
    local peqCrVzHDwfkraYZ = false -- Shrink Ped
    local NpYgTbUcXsRoVm = false -- No Clip 
    local xCvBnMqWeRtYuIo = false -- Super Jump
    local nxtBFlQWMMeRLs = false -- Levitation
    local fgawjFmaDjdALaO = false -- Super Strength
    local qWeRtYuIoPlMnBv = false -- Super Punch
    local zXpQwErTyUiPlMn = false -- Throw From Vehicle
    local kJfGhTrEeWqAsDz = false -- Force Third Person
    local zXcVbNmQwErTyUi = false -- Force Driveby
    local yHnvrVNkoOvGMWiS = false -- Anti-Headshot
    local nHgFdSaZxCvBnMq = false -- Anti-Freeze
    local fAwjeldmwjrWkSf = false -- Anti-TP
    local aDjsfmansdjwAEl = false -- Anti-Blackscreen
    local qWpEzXvBtNyLmKj = false -- Crosshair

    local egfjWADmvsjAWf = false -- Spoofed Weapon Spawning
    local LkJgFdSaQwErTy = false -- Infinite Ammo
    local QzWxEdCvTrBnYu = false -- Explosive Ammo
    local RfGtHyUjMiKoLp = false -- One Shot Kill 

    local zXcVbNmQwErTyUi = false -- Vehicle Godmode
    local RNgZCddPoxwFhmBX = false -- Force Vehicle Engine
    local PlAsQwErTyUiOp = false -- Vehicle Auto Repair
    local LzKxWcVbNmQwErTy = false -- Freeze Vehicle
    local NuRqVxEyKiOlZm = false -- Vehicle Hop
    local GxRpVuNzYiTq = false -- Rainbow Vehicle
    local MqTwErYuIoLp = false -- Drift Mode
    local NvGhJkLpOiUy = false -- Easy Handling
    local VkLpOiUyTrEq = false -- Instant Breaks
    local BlNkJmLzXcVb = false -- Unlimited Fuel

    local AsDfGhJkLpZx = false -- Spectate Player
    local aSwDeFgHiJkLoPx = false -- Normal Kill Everyone
    local qWeRtYuIoPlMnAb = false -- Permanent Kill Everyone
    local tUOgshhvIaku = false -- RPG Kill Everyone
    local zXcVbNmQwErTyUi = false -- 
]])


-- ═══════════════════════════════════════════════════════
--  SELF TAB
-- ═══════════════════════════════════════════════════════

-- [ Toggles ]
MachoMenuCheckbox(Self[1], "Godmode (DETECTABLE)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if aXfPlMnQwErTyUi == nil then aXfPlMnQwErTyUi = false end
        aXfPlMnQwErTyUi = true

        local function OxWJ1rY9vB()
            local fLdRtYpLoWqEzXv = CreateThread
            fLdRtYpLoWqEzXv(function()
                while aXfPlMnQwErTyUi and not Unloaded do
                    local dOlNxGzPbTcQ = PlayerPedId()
                    local rKsEyHqBmUiW = PlayerId()

                    if GetResourceState("ReaperV4") == "started" then
                        local kcWsWhJpCwLI = SetPlayerInvincible
                        local ByTqMvSnAzXd = SetEntityInvincible
                        kcWsWhJpCwLI(rKsEyHqBmUiW, true)
                        ByTqMvSnAzXd(dOlNxGzPbTcQ, true)

                    elseif GetResourceState("WaveShield") == "started" then
                        local cvYkmZYIjvQQ = SetEntityCanBeDamaged
                        cvYkmZYIjvQQ(dOlNxGzPbTcQ, false)

                    else
                        local BiIqUJHexRrR = SetEntityCanBeDamaged
                        local UtgGRNyiPhOs = SetEntityProofs
                        local rVuKoDwLsXpC = SetEntityInvincible

                        BiIqUJHexRrR(dOlNxGzPbTcQ, false)
                        UtgGRNyiPhOs(dOlNxGzPbTcQ, true, true, true, false, true, false, false, false)
                        rVuKoDwLsXpC(dOlNxGzPbTcQ, true)
                    end

                    Wait(0)
                end
            end)
        end

        OxWJ1rY9vB()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        aXfPlMnQwErTyUi = false

        local dOlNxGzPbTcQ = PlayerPedId()
        local rKsEyHqBmUiW = PlayerId()

        if GetResourceState("ReaperV4") == "started" then
            local kcWsWhJpCwLI = SetPlayerInvincible
            local ByTqMvSnAzXd = SetEntityInvincible

            kcWsWhJpCwLI(rKsEyHqBmUiW, false)
            ByTqMvSnAzXd(dOlNxGzPbTcQ, false)

        elseif GetResourceState("WaveShield") == "started" then
            local AilJsyZTXnNc = SetEntityCanBeDamaged
            AilJsyZTXnNc(dOlNxGzPbTcQ, true)

        else
            local tBVAZMubUXmO = SetEntityCanBeDamaged
            local yuTiZtxOXVnE = SetEntityProofs
            local rVuKoDwLsXpC = SetEntityInvincible

            tBVAZMubUXmO(dOlNxGzPbTcQ, true)
            yuTiZtxOXVnE(dOlNxGzPbTcQ, false, false, false, false, false, false, false, false)
            rVuKoDwLsXpC(dOlNxGzPbTcQ, false)
        end
    ]])
end)

-- MachoMenuCheckbox(Self[1], "Godmode (DETECTABLE)", function()
--     MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
--         if aXfPlMnQwErTyUi == nil then aXfPlMnQwErTyUi = false end
--         aXfPlMnQwErTyUi = true

--         local function OxWJ1rY9vB()
--             local fLdRtYpLoWqEzXv = CreateThread
--             fLdRtYpLoWqEzXv(function()
--                 while aXfPlMnQwErTyUi and not Unloaded do
--                     if GetResourceState("ReaperV4") == "started" then
--                         local kcWsWhJpCwLI = SetPlayerInvincible
--                         kcWsWhJpCwLI(PlayerPedId(), true)

--                     elseif GetResourceState("WaveShield") == "started" then
--                         local cvYkmZYIjvQQ = SetEntityCanBeDamaged
--                         cvYkmZYIjvQQ(PlayerPedId(), false)

--                     else
--                         local BiIqUJHexRrR = SetEntityCanBeDamaged
--                         local UtgGRNyiPhOs = SetEntityProofs
                                                
--                         BiIqUJHexRrR(PlayerPedId(), false)
--                         UtgGRNyiPhOs(PlayerPedId(), true, true, true, false, true, false, false, false)
--                     end

--                     Wait(0)
--                 end
--             end)
--         end

--         OxWJ1rY9vB()
--     ]])
-- end, function()
--     MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
--         aXfPlMnQwErTyUi = false
--         if GetResourceState("ReaperV4") == "started" then
--             local kcWsWhJpCwLI = SetPlayerInvincible

--             kcWsWhJpCwLI(PlayerPedId(), false)

--         elseif GetResourceState("WaveShield") == "started" then
--             local AilJsyZTXnNc = SetEntityCanBeDamaged

--             AilJsyZTXnNc(PlayerPedId(), true)

--         else
--             local tBVAZMubUXmO = SetEntityCanBeDamaged
--             local yuTiZtxOXVnE = SetEntityProofs

--             tBVAZMubUXmO(PlayerPedId(), true)
--             yuTiZtxOXVnE(PlayerPedId(), false, false, false, false, false, false, false, false)
--         end
--     ]])
-- end)

MachoMenuCheckbox(Self[1], "Invisibility", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if sRtYuIoPaSdFgHj == nil then sRtYuIoPaSdFgHj = false end
        sRtYuIoPaSdFgHj = true

        local function d2NcWoyTfb()
            if sRtYuIoPaSdFgHj == nil then sRtYuIoPaSdFgHj = false end
            sRtYuIoPaSdFgHj = true

            local zXwCeVrBtNuMyLk = CreateThread
            zXwCeVrBtNuMyLk(function()
                while sRtYuIoPaSdFgHj and not Unloaded do
                    local uYiTpLaNmZxCwEq = SetEntityVisible
                    local hGfDrEsWxQaZcVb = PlayerPedId()
                    uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, false, false)
                    Wait(0)
                end

                local uYiTpLaNmZxCwEq = SetEntityVisible
                local hGfDrEsWxQaZcVb = PlayerPedId()
                uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
            end)
        end

        d2NcWoyTfb()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        sRtYuIoPaSdFgHj = false

        local function tBKM4syGJL()
            local uYiTpLaNmZxCwEq = SetEntityVisible
            local hGfDrEsWxQaZcVb = PlayerPedId()
            uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
        end

        tBKM4syGJL()
    ]])
end)

MachoMenuCheckbox(Self[1], "No Ragdoll", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if mKjHgFdSaPlMnBv == nil then mKjHgFdSaPlMnBv = false end
        mKjHgFdSaPlMnBv = true

        local function jP7xUrK9Ao()
            local zVpLyNrTmQxWsEd = CreateThread
            zVpLyNrTmQxWsEd(function()
                while mKjHgFdSaPlMnBv and not Unloaded do
                    local oPaSdFgHiJkLzXc = SetPedCanRagdoll
                    oPaSdFgHiJkLzXc(PlayerPedId(), false)
                    Wait(0)
                end
            end)
        end

        jP7xUrK9Ao()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        mKjHgFdSaPlMnBv = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Infinite Stamina", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if uYtReWqAzXcVbNm == nil then uYtReWqAzXcVbNm = false end
        uYtReWqAzXcVbNm = true

        local function YLvd3pM0tB()
            local tJrGyHnMuQwSaZx = CreateThread
            tJrGyHnMuQwSaZx(function()
                while uYtReWqAzXcVbNm and not Unloaded do
                    local aSdFgHjKlQwErTy = RestorePlayerStamina
                    local rTyUiEaOpAsDfGhJk = PlayerId()
                    aSdFgHjKlQwErTy(rTyUiEaOpAsDfGhJk, 1.0)
                    Wait(0)
                end
            end)
        end

        YLvd3pM0tB()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        uYtReWqAzXcVbNm = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Tiny Ped (DETECTABLE)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if peqCrVzHDwfkraYZ == nil then peqCrVzHDwfkraYZ = false end
        peqCrVzHDwfkraYZ = true

        local function YfeemkaufrQjXTFY()
            local OLZACovzmAvgWPmC = CreateThread
            OLZACovzmAvgWPmC(function()
                while peqCrVzHDwfkraYZ and not Unloaded do
                    local aukLdkvEinBsMWuA = SetPedConfigFlag
                    aukLdkvEinBsMWuA(PlayerPedId(), 223, true)
                    Wait(0)
                end
            end)
        end

        YfeemkaufrQjXTFY()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        peqCrVzHDwfkraYZ = false
        local aukLdkvEinBsMWuA = SetPedConfigFlag
        aukLdkvEinBsMWuA(PlayerPedId(), 223, false)
    ]])
end)

MachoMenuCheckbox(Self[1], "No Clip (DETECTABLE)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if NpYgTbUcXsRoVm == nil then NpYgTbUcXsRoVm = false end
        NpYgTbUcXsRoVm = true

        local function KUQpH7owdz()
            local RvBcNxMzKgUiLo = PlayerPedId
            local EkLpOiUhYtGrFe = GetVehiclePedIsIn
            local CtVbXnMzQaWsEd = GetEntityCoords
            local DrTgYhUjIkOlPm = GetEntityHeading
            local QiWzExRdCtVbNm = GetGameplayCamRelativeHeading
            local AoSdFgHjKlZxCv = GetGameplayCamRelativePitch
            local JkLzXcVbNmAsDf = IsDisabledControlJustPressed
            local TyUiOpAsDfGhJk = IsDisabledControlPressed
            local WqErTyUiOpAsDf = SetEntityCoordsNoOffset
            local PlMnBvCxZaSdFg = SetEntityHeading
            local HnJmKlPoIuYtRe = CreateThread

            local YtReWqAzXsEdCv = false

            HnJmKlPoIuYtRe(function()
                while NpYgTbUcXsRoVm and not Unloaded do
                    Wait(0)

                    if JkLzXcVbNmAsDf(0, 303) then
                        YtReWqAzXsEdCv = not YtReWqAzXsEdCv
                    end

                    if YtReWqAzXsEdCv then
                        local speed = 2.0

                        local p = RvBcNxMzKgUiLo()
                        local v = EkLpOiUhYtGrFe(p, false)
                        local inVeh = v ~= 0 and v ~= nil
                        local ent = inVeh and v or p

                        local pos = CtVbXnMzQaWsEd(ent, true)
                        local head = QiWzExRdCtVbNm() + DrTgYhUjIkOlPm(ent)
                        local pitch = AoSdFgHjKlZxCv()

                        local dx = -math.sin(math.rad(head))
                        local dy = math.cos(math.rad(head))
                        local dz = math.sin(math.rad(pitch))
                        local len = math.sqrt(dx * dx + dy * dy + dz * dz)

                        if len ~= 0 then
                            dx, dy, dz = dx / len, dy / len, dz / len
                        end

                        if TyUiOpAsDfGhJk(0, 21) then speed = speed + 2.5 end
                        if TyUiOpAsDfGhJk(0, 19) then speed = 0.25 end

                        if TyUiOpAsDfGhJk(0, 32) then
                            pos = pos + vector3(dx, dy, dz) * speed
                        end
                        if TyUiOpAsDfGhJk(0, 34) then
                            pos = pos + vector3(-dy, dx, 0.0) * speed
                        end
                        if TyUiOpAsDfGhJk(0, 269) then
                            pos = pos - vector3(dx, dy, dz) * speed
                        end
                        if TyUiOpAsDfGhJk(0, 9) then
                            pos = pos + vector3(dy, -dx, 0.0) * speed
                        end
                        if TyUiOpAsDfGhJk(0, 22) then
                            pos = pos + vector3(0.0, 0.0, speed)
                        end
                        if TyUiOpAsDfGhJk(0, 36) then
                            pos = pos - vector3(0.0, 0.0, speed)
                        end

                        WqErTyUiOpAsDf(ent, pos.x, pos.y, pos.z, true, true, true)
                        PlMnBvCxZaSdFg(ent, head)
                    end
                end
                YtReWqAzXsEdCv = false
            end)
        end

        KUQpH7owdz()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        NpYgTbUcXsRoVm = false
    ]])
end)

-- [ Free Camera — wiped system: TP Cam, Teleport, Shoot, Shoot Car, Spawn Bomb, Blackhole, Kick Veh, Delete Veh, Fuck Veh, RC Control Car ]
-- Controls: WASD = move | Mouse = look | LMB = action | Scroll = cycle features | Shift = speed boost
_G.freecamSpeed = _G.freecamSpeed or 1.2

local function GetFreecamResource()
    if CheckResource("es_extended") then return "es_extended"
    elseif CheckResource("ox_lib") then return "ox_lib"
    elseif CheckResource("qb-core") then return "qb-core"
    elseif CheckResource("oxmysql") then return "oxmysql"
    elseif CheckResource("monitor") then return "monitor"
    else return "any" end
end

local function EnableFreecam()
    local leftControl, rightControl = 174, 175
    local freecamSpeedValue = _G.freecamSpeed or 1.2
    local code = string.format([[
        local function decode(tbl)
            local s = ""
            for i = 1, #tbl do s = s .. string.char(tbl[i]) end
            return s
        end

        local function g(n)
            return _G[decode(n)]
        end

        local function _b(str)
            local t = {}
            for i = 1, #str do t[i] = string.byte(str, i) end
            return t
        end

        local function _g(n)
            return _G[decode(n)]
        end

        local function wait(n)
            return Citizen.Wait(n)
        end

        local FREECAM_LEFT_CONTROL  = %d
        local FREECAM_RIGHT_CONTROL = %d

        local nativeNames = {
            PlayerPedId = {80,108,97,121,101,114,80,101,100,73,100},
            GetEntityCoords = {71,101,116,69,110,116,105,116,121,67,111,111,114,100,115},
            IsVehicleSeatFree = {73,115,86,101,104,105,99,108,101,83,101,97,116,70,114,101,101},
            IsEntityAVehicle = {73,115,69,110,116,105,116,121,65,86,101,104,105,99,108,101},
            SetEntityCoords = {83,101,116,69,110,116,105,116,121,67,111,111,114,100,115},
            GetCamCoord = {71,101,116,67,97,109,67,111,111,114,100},
            GetCamRot = {71,101,116,67,97,109,82,111,116},
            GetControlNormal = {71,101,116,67,111,110,116,114,111,108,78,111,114,109,97,108},
            IsDisabledControlPressed = {73,115,68,105,115,97,98,108,101,100,67,111,110,116,114,111,108,80,114,101,115,115,101,100},
            IsControlJustPressed = {73,115,67,111,110,116,114,111,108,74,117,115,116,80,114,101,115,115,101,100},
            IsDisabledControlJustPressed = {73,115,68,105,115,97,98,108,101,100,67,111,110,116,114,111,108,74,117,115,116,80,114,101,115,115,101,100},
            GetResourceState = {71,101,116,82,101,115,111,117,114,99,101,83,116,97,116,101},
            GetGamePool = {71,101,116,71,97,109,101,80,111,111,108},
            IsPedDeadOrDying = {73,115,80,101,100,68,101,97,100,79,114,68,121,105,110,103},
            IsPedAPlayer = {73,115,80,101,100,65,80,108,97,121,101,114},
            SetEntityAsMissionEntity = {83,101,116,69,110,116,105,116,121,65,115,77,105,115,115,105,111,110,69,110,116,105,116,121},
            SetVehicleEngineOn = {83,101,116,86,101,104,105,99,108,101,69,110,103,105,110,101,79,110},
            DoesEntityExist = {68,111,101,115,69,110,116,105,116,121,69,120,105,115,116},
            CreateThread = {67,114,101,97,116,101,84,104,114,101,97,100},
            DisableControlAction = {68,105,115,97,98,108,101,67,111,110,116,114,111,108,65,99,116,105,111,110},
            EnableControlAction = {69,110,97,98,108,101,67,111,110,116,114,111,108,65,99,116,105,111,110},
            RequestModel = {82,101,113,117,101,115,116,77,111,100,101,108},
            HasModelLoaded = {72,97,115,77,111,100,101,108,76,111,97,100,101,100},
            SetModelAsNoLongerNeeded = {83,101,116,77,111,100,101,108,65,115,78,111,76,111,110,103,101,114,78,101,101,100,101,100},
            GetPedInVehicleSeat = {71,101,116,80,101,100,73,110,86,101,104,105,99,108,101,83,101,97,116},
            TaskLeaveVehicle = {84,97,115,107,76,101,97,118,101,86,101,104,105,99,108,101},
            SetPedCanRagdoll = {83,101,116,80,101,100,67,97,110,82,97,103,100,111,108,108},
            SetPedToRagdoll = {83,101,116,80,101,100,84,111,82,97,103,100,111,108,108},
            NetworkRequestControlOfEntity = {78,101,116,119,111,114,107,82,101,113,117,101,115,116,67,111,110,116,114,111,108,79,102,69,110,116,105,116,121},
            Wait = {87,97,105,116},
            DeleteEntity = {68,101,108,101,116,101,69,110,116,105,116,121},
            DeleteVehicle = {68,101,108,101,116,101,86,101,104,105,99,108,101},
            SetVehicleTyreBurst = {83,101,116,86,101,104,105,99,108,101,84,121,114,101,66,117,114,115,116},
            SetVehicleEngineHealth = {83,101,116,86,101,104,105,99,108,101,69,110,103,105,110,101,72,101,97,108,116,104},
            SetVehicleDoorBroken = {83,101,116,86,101,104,105,99,108,101,68,111,111,114,66,114,111,107,101,110},
            SmashVehicleWindow = {83,109,97,115,104,86,101,104,105,99,108,101,87,105,110,100,111,119},
            StartEntityFire = {83,116,97,114,116,69,110,116,105,116,121,70,105,114,101},
            NetworkExplodeVehicle = {78,101,116,119,111,114,107,69,120,112,108,111,100,101,86,101,104,105,99,108,101},
            CreateObjectNoOffset = {67,114,101,97,116,101,79,98,106,101,99,116,78,111,79,102,102,115,101,116},
            NetworkRegisterEntityAsNetworked = {78,101,116,119,111,114,107,82,101,103,105,115,116,101,114,69,110,116,105,116,121,65,115,78,101,116,119,111,114,107,101,100},
            ObjToNet = {79,98,106,84,111,78,101,116},
            SetNetworkIdExistsOnAllMachines = {83,101,116,78,101,116,119,111,114,107,73,100,69,120,105,115,116,115,79,110,65,108,108,77,97,99,104,105,110,101,115},
            SetNetworkIdCanMigrate = {83,101,116,78,101,116,119,111,114,107,73,100,67,97,110,77,105,103,114,97,116,101},
            PlaceObjectOnGroundProperly = {80,108,97,99,101,79,98,106,101,99,116,79,110,71,114,111,117,110,100,80,114,111,112,101,114,108,121},
            SetEntityVisible = {83,101,116,69,110,116,105,116,121,86,105,115,105,98,108,101},
            SetEntityCollision = {83,101,116,69,110,116,105,116,121,67,111,108,108,105,115,105,111,110},
            FreezeEntityPosition = {70,114,101,101,122,101,69,110,116,105,116,121,80,111,115,105,116,105,111,110},
            DeleteObject = {68,101,108,101,116,101,79,98,106,101,99,116},
            GetGameTimer = {71,101,116,71,97,109,101,84,105,109,101,114},
            CreateCam = {67,114,101,97,116,101,67,97,109},
            AttachCamToEntity = {65,116,116,97,99,104,67,97,109,84,111,69,110,116,105,116,121},
            GetEntitySpeed = {71,101,116,69,110,116,105,116,121,83,112,101,101,100},
            GetEntityHeading = {71,101,116,69,110,116,105,116,121,72,101,97,100,105,110,103},
            SetEntityHeading = {83,101,116,69,110,116,105,116,121,72,101,97,100,105,110,103},
            GetGroundZFor_3dCoord = {71,101,116,71,114,111,117,110,100,90,70,111,114,95,51,100,67,111,111,114,100},
            GetEntityVelocity = {71,101,116,69,110,116,105,116,121,86,101,108,111,99,105,116,121},
            SetVehicleOnGroundProperly = {83,101,116,86,101,104,105,99,108,101,79,110,71,114,111,117,110,100,80,114,111,112,101,114,108,121},
            IsControlPressed = {73,115,67,111,110,116,114,111,108,80,114,101,115,115,101,100},
            SetEntityInvincible = {83,101,116,69,110,116,105,116,121,73,110,118,105,110,99,105,98,108,101},
            SetEntityCanBeDamaged = {83,101,116,69,110,116,105,116,121,67,97,110,66,101,68,97,109,97,103,101,100},
            SetVehicleCanBeVisiblyDamaged = {83,101,116,86,101,104,105,99,108,101,67,97,110,66,101,86,105,115,105,98,108,121,68,97,109,97,103,101,100},
            SetTextFont = {83,101,116,84,101,120,116,70,111,110,116},
            SetTextProportional = {83,101,116,84,101,120,116,80,114,111,112,111,114,116,105,111,110,97,108},
            SetTextScale = {83,101,116,84,101,120,116,83,99,97,108,101},
            SetTextDropshadow = {83,101,116,84,101,120,116,68,114,111,112,115,104,97,100,111,119},
            SetTextEdge = {83,101,116,84,101,120,116,69,100,103,101},
            SetTextOutline = {83,101,116,84,101,120,116,79,117,116,108,105,110,101},
            SetTextCentre = {83,101,116,84,101,120,116,67,101,110,116,114,101},
            SetTextColour = {83,101,116,84,101,120,116,67,111,108,111,117,114},
            BeginTextCommandDisplayText = {66,101,103,105,110,84,101,120,116,67,111,109,109,97,110,100,68,105,115,112,108,97,121,84,101,120,116},
            AddTextComponentSubstringPlayerName = {65,100,100,84,101,120,116,67,111,109,112,111,110,101,110,116,83,117,98,115,116,114,105,110,103,80,108,97,121,101,114,78,97,109,101},
            EndTextCommandDisplayText = {69,110,100,84,101,120,116,67,111,109,109,97,110,100,68,105,115,112,108,97,121,84,101,120,116},
            SetFocusPosAndVel = {83,101,116,70,111,99,117,115,80,111,115,65,110,100,86,101,108},
            SetFocusEntity = {83,101,116,70,111,99,117,115,69,110,116,105,116,121},
            RenderScriptCams = {82,101,110,100,101,114,83,99,114,105,112,116,67,97,109,115},
            SetCamCoord = {83,101,116,67,97,109,67,111,111,114,100},
            SetCamRot = {83,101,116,67,97,109,82,111,116},
            SetCamActive = {83,101,116,67,97,109,65,99,116,105,118,101},
            DestroyCam = {68,101,115,116,114,111,121,67,97,109},
            TaskStandStill = {84,97,115,107,83,116,97,110,100,83,116,105,108,108},
            GiveWeaponToPed = {71,105,118,101,87,101,97,112,111,110,84,111,80,101,100},
            SetCurrentPedWeapon = {83,101,116,67,117,114,114,101,110,116,80,101,100,87,101,97,112,111,110},
            ShootSingleBulletBetweenCoords = {83,104,111,111,116,83,105,110,103,108,101,66,117,108,108,101,116,66,101,116,119,101,101,110,67,111,111,114,100,115},
            GetHashKey = {71,101,116,72,97,115,104,75,101,121},
            StartExpensiveSynchronousShapeTestLosProbe = {83,116,97,114,116,69,120,112,101,110,115,105,118,101,83,121,110,99,104,114,111,110,111,117,115,83,104,97,112,101,84,101,115,116,76,111,115,80,114,111,98,101},
            GetShapeTestResult = {71,101,116,83,104,97,112,101,84,101,115,116,82,101,115,117,108,116},
        }

        if not _G.wipedFreecam then
            _G.wipedFreecam = {
                isToggled = false,
                camera = nil,
                cameraSpeed = %f,
                cameraFeatures = { "TP Camera", "Teleport", "Shoot", "Shoot Car", "Spawn Bomb", "Blackhole", "Kick Vehicle", "Delete Vehicle", "Fuck Vehicle", "RC Control Car" },
                shootFeatures = { ["Shoot"] = true, ["Shoot Car"] = true, ["Spawn Bomb"] = true },
                pistolModels = {
                    { label = "Perm Kill", model = decode({119,101,97,112,111,110,95,116,114,97,110,113,117,105,108,105,122,101,114}) },
                    { label = "Pistol", model = decode({119,101,97,112,111,110,95,112,105,115,116,111,108}) },
                    { label = "Heavy Pistol", model = decode({119,101,97,112,111,110,95,104,101,97,118,121,112,105,115,116,111,108}) },
                    { label = "Combat Pistol", model = decode({119,101,97,112,111,110,95,99,111,109,98,97,116,112,105,115,116,111,108}) },
                    { label = "AP Pistol", model = decode({119,101,97,112,111,110,95,97,112,112,105,115,116,111,108}) },
                    { label = "Stun Gun", model = decode({119,101,97,112,111,110,95,115,116,117,110,103,117,110}) },
                    { label = "Firework Launcher", model = decode({119,101,97,112,111,110,95,102,105,114,101,119,111,114,107}) }
                },
                vehicleModels = {
                    { label = "Nimbus", model = decode({110,105,109,98,117,115}) },
                    { label = "Luxor", model = decode({108,117,120,111,114}) },
                    { label = "Luxor2", model = decode({108,117,120,111,114,50}) },
                    { label = "Elegy", model = decode({101,108,101,103,121}) },
                    { label = "Pounder", model = decode({112,111,117,110,100,101,114}) },
                    { label = "Adder", model = decode({97,100,100,101,114}) },
                    { label = "Zentorno", model = decode({122,101,110,116,111,114,110,111}) },
                    { label = "T20", model = decode({116,50,48}) },
                    { label = "Osiris", model = decode({111,115,105,114,105,115}) },
                    { label = "X80 Proto", model = decode({120,56,48,112,114,111,116,111}) },
                    { label = "Tyrus", model = decode({116,121,114,117,115}) },
                    { label = "Vagner", model = decode({118,97,103,110,101,114}) },
                    { label = "Entity XF", model = decode({101,110,116,105,116,121,120,102}) },
                    { label = "Infernus", model = decode({105,110,102,101,114,110,117,115}) },
                    { label = "Riot2", model = decode({114,105,111,116,50}) },
                    { label = "Kosatka", model = decode({107,111,115,97,116,107,97}) }
                },
                currentFeature = 1,
                currentModelIndex = 1,
                currentVehicleIndex = 1,
                currentExplosionIndex = 1,
                explosionTypes = {
                    { label = "Default", type = "default" },
                    { label = "Car", type = "car" },
                    { label = "Plane", type = "plane" },
                    { label = "Boat", type = "boat" },
                    { label = "Heli", type = "heli" }
                },
                cameraReady = false,
                cachedFeature = "",
                cachedModelLabel = "",
                shutdown = false,
                smoothScrollOffset = 0.0,
                savedFeature = 1,
                blackholePressed = false,
                blackholeFrameCount = 0,
                blackholeControlledVehicles = {}
            }

            function _G.wipedFreecam.tableFind(tbl, val)
                for i, v in ipairs(tbl) do
                    if v == val then return i end
                end
                return nil
            end

            function _G.wipedFreecam.GetEmptySeat(vehicle)
                local seats = { -1, 0, 1, 2 }
                for _, seat in ipairs(seats) do
                    if g(nativeNames.IsVehicleSeatFree)(vehicle, seat) then
                        return seat
                    end
                end
                return -1
            end

            function _G.wipedFreecam.RotationToDirection(rot)
                local radiansZ = math.rad(rot.z)
                local radiansX = math.rad(rot.x)
                local cosX = math.cos(radiansX)
                return vector3(-math.sin(radiansZ) * cosX, math.cos(radiansZ) * cosX, math.sin(radiansX))
            end

            function _G.wipedFreecam.drawCrosshair()
                g(nativeNames.SetTextFont)(0)
                g(nativeNames.SetTextProportional)(1)
                g(nativeNames.SetTextScale)(0.3, 0.3)
                g(nativeNames.SetTextColour)(255, 255, 255, 255)
                g(nativeNames.SetTextCentre)(true)
                g(nativeNames.SetTextOutline)()
                g(nativeNames.BeginTextCommandDisplayText)(decode({83,84,82,73,78,71}))
                g(nativeNames.AddTextComponentSubstringPlayerName)("+")
                g(nativeNames.EndTextCommandDisplayText)(0.5, 0.49)
            end

            function _G.wipedFreecam.lerp(a, b, t)
                return a + (b - a) * t
            end

            function _G.wipedFreecam.drawFeatureList()
                local centerX = 0.5
                local baseY = 0.80
                local lineHeight = 0.025
                local scale = 0.25
                local maxVisible = 7
                local lerpFactor = 0.20

                _G.wipedFreecam.smoothScrollOffset = _G.wipedFreecam.lerp(_G.wipedFreecam.smoothScrollOffset, 0.0, lerpFactor)

                local currentIndex = _G.wipedFreecam.currentFeature
                local startIndex = math.max(1, currentIndex - math.floor(maxVisible / 2))
                local endIndex = math.min(#_G.wipedFreecam.cameraFeatures, startIndex + maxVisible - 1)

                if endIndex - startIndex < maxVisible - 1 then
                    startIndex = math.max(1, endIndex - maxVisible + 1)
                end

                for i = startIndex, endIndex do
                    local feature = _G.wipedFreecam.cameraFeatures[i]
                    local distanceFromSelected = math.abs(i - currentIndex)
                    local yOffset = (i - currentIndex) * lineHeight + _G.wipedFreecam.smoothScrollOffset
                    local yPos = baseY + yOffset

                    g(nativeNames.SetTextFont)(0)
                    g(nativeNames.SetTextProportional)(1)
                    g(nativeNames.SetTextScale)(scale, scale)
                    g(nativeNames.SetTextDropshadow)(0, 0, 0, 0, 255)
                    g(nativeNames.SetTextEdge)(1, 0, 0, 0, 255)
                    g(nativeNames.SetTextOutline)()
                    g(nativeNames.SetTextCentre)(true)

                    local alpha = 255
                    if distanceFromSelected > 2 then
                        alpha = math.max(150, 255 - (distanceFromSelected - 2) * 30)
                    end

                    if i == currentIndex then
                        g(nativeNames.SetTextColour)(255, 0, 0, alpha)
                        local text = "> " .. feature .. " <"
                        if _G.wipedFreecam.shootFeatures[feature] then
                            local currentModel
                            if feature == "Shoot" then
                                currentModel = _G.wipedFreecam.pistolModels[_G.wipedFreecam.currentModelIndex]
                                text = "> " .. feature .. " [" .. currentModel.label .. "] <"
                            elseif feature == "Shoot Car" then
                                currentModel = _G.wipedFreecam.vehicleModels[_G.wipedFreecam.currentVehicleIndex]
                                text = "> " .. feature .. " [" .. currentModel.label .. "] <"
                            elseif feature == "Spawn Bomb" then
                                local explosionType = _G.wipedFreecam.explosionTypes[_G.wipedFreecam.currentExplosionIndex]
                                text = "> " .. feature .. " [" .. explosionType.label .. "] <"
                            end
                        end
                        g(nativeNames.BeginTextCommandDisplayText)(decode({83,84,82,73,78,71}))
                        g(nativeNames.AddTextComponentSubstringPlayerName)(text)
                        g(nativeNames.EndTextCommandDisplayText)(centerX, yPos)
                    else
                        g(nativeNames.SetTextColour)(255, 255, 255, alpha)
                        g(nativeNames.BeginTextCommandDisplayText)(decode({83,84,82,73,78,71}))
                        g(nativeNames.AddTextComponentSubstringPlayerName)(feature)
                        g(nativeNames.EndTextCommandDisplayText)(centerX, yPos)
                    end
                end
            end

            function _G.wipedFreecam.EnterCamera()
                if _G.wipedFreecam.isToggled then return end
                _G.wipedFreecam.isToggled = true

                local playerPed = g(nativeNames.PlayerPedId)()
                local coords = g(nativeNames.GetEntityCoords)(playerPed)
                local heading = g(nativeNames.GetEntityHeading)(playerPed)

                _G.wipedFreecam.camera = g(nativeNames.CreateCam)(decode({68,69,70,65,85,76,84,95,83,67,82,73,80,84,69,68,95,67,65,77,69,82,65}), true)
                g(nativeNames.SetCamCoord)(_G.wipedFreecam.camera, coords.x, coords.y, coords.z + 2.0)
                g(nativeNames.SetCamRot)(_G.wipedFreecam.camera, 0.0, 0.0, heading, 2)
                g(nativeNames.SetCamActive)(_G.wipedFreecam.camera, true)
                g(nativeNames.RenderScriptCams)(true, true, 500, true, true)

                g(nativeNames.CreateThread)(function()
                    while _G.wipedFreecam and _G.wipedFreecam.isToggled and not _G.wipedFreecam.shutdown do
                        wait(0)
                        if not _G.wipedFreecam or not _G.wipedFreecam.camera then break end

                        local camCoords = g(nativeNames.GetCamCoord)(_G.wipedFreecam.camera)
                        local camRot    = g(nativeNames.GetCamRot)(_G.wipedFreecam.camera, 2)
                        local mouseX    = g(nativeNames.GetControlNormal)(0, 1) * 5.0
                        local mouseY    = g(nativeNames.GetControlNormal)(0, 2) * 5.0
                        local newRotX   = camRot.x - mouseY
                        local newRotZ   = camRot.z - mouseX

                        if newRotX >  89.0 then newRotX =  89.0 end
                        if newRotX < -89.0 then newRotX = -89.0 end

                        g(nativeNames.SetCamRot)(_G.wipedFreecam.camera, newRotX, 0.0, newRotZ, 2)

                        local rot = g(nativeNames.GetCamRot)(_G.wipedFreecam.camera, 2)
                        local pitch = math.rad(rot.x)
                        local yaw   = math.rad(rot.z)
                        local direction = vector3(
                            -math.sin(yaw) * math.cos(pitch),
                             math.cos(yaw) * math.cos(pitch),
                             math.sin(pitch)
                        )
                        local right = vector3(direction.y, -direction.x, 0.0)

                        local moveSpeed = _G.wipedFreecam.cameraSpeed
                        if g(nativeNames.IsDisabledControlPressed)(0, 21) then moveSpeed = moveSpeed * 2.5 end

                        if g(nativeNames.IsDisabledControlPressed)(0, 32) then camCoords = camCoords + (direction * moveSpeed) end
                        if g(nativeNames.IsDisabledControlPressed)(0, 33) then camCoords = camCoords - (direction * moveSpeed) end
                        if g(nativeNames.IsDisabledControlPressed)(0, 34) then camCoords = camCoords - (right    * moveSpeed) end
                        if g(nativeNames.IsDisabledControlPressed)(0, 35) then camCoords = camCoords + (right    * moveSpeed) end

                        g(nativeNames.SetFocusPosAndVel)(camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, 0.0)
                        g(nativeNames.SetCamCoord)(_G.wipedFreecam.camera, camCoords.x, camCoords.y, camCoords.z)

                        -- Raycast for targeting
                        local destination = camCoords + direction * 1000.0
                        local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, destination.x, destination.y, destination.z, -1, -1, 0)
                        local _, hit, endCoords, surfaceNormal, entityHit = g(nativeNames.GetShapeTestResult)(rayHandle)
                        local coords = endCoords

                        -- Crosshair
                        _G.wipedFreecam.drawCrosshair()
                        -- Feature list
                        _G.wipedFreecam.drawFeatureList()

                        -- Scroll to cycle features
                        local prevFeature = _G.wipedFreecam.currentFeature
                        if g(nativeNames.IsDisabledControlJustPressed)(0, 242) then
                            _G.wipedFreecam.currentFeature = _G.wipedFreecam.currentFeature + 1
                            if _G.wipedFreecam.currentFeature > #_G.wipedFreecam.cameraFeatures then
                                _G.wipedFreecam.currentFeature = 1
                            end
                            _G.wipedFreecam.savedFeature = _G.wipedFreecam.currentFeature
                        end
                        if g(nativeNames.IsDisabledControlJustPressed)(0, 241) then
                            _G.wipedFreecam.currentFeature = _G.wipedFreecam.currentFeature - 1
                            if _G.wipedFreecam.currentFeature < 1 then
                                _G.wipedFreecam.currentFeature = #_G.wipedFreecam.cameraFeatures
                            end
                            _G.wipedFreecam.savedFeature = _G.wipedFreecam.currentFeature
                        end

                        -- TP Camera
                        if _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "TP Camera" then
                            if hit and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                local currentRot = g(nativeNames.GetCamRot)(_G.wipedFreecam.camera, 2)
                                local distance = math.sqrt((endCoords.x - camCoords.x)^2 + (endCoords.y - camCoords.y)^2 + (endCoords.z - camCoords.z)^2)
                                if distance <= 500.0 then
                                    g(nativeNames.SetCamCoord)(_G.wipedFreecam.camera, endCoords.x, endCoords.y, endCoords.z)
                                    g(nativeNames.SetCamRot)(_G.wipedFreecam.camera, currentRot.x, currentRot.y, currentRot.z, 2)
                                end
                            end
                        -- Teleport
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Teleport" then
                            if hit and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                if entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) then
                                    local seat = _G.wipedFreecam.GetEmptySeat(entityHit)
                                    g(nativeNames.TaskWarpPedIntoVehicle)(g(nativeNames.PlayerPedId)(), entityHit, seat >= 0 and seat or -1)
                                else
                                    g(nativeNames.SetEntityCoords)(g(nativeNames.PlayerPedId)(), endCoords.x, endCoords.y, endCoords.z, false, false, false, false)
                                end
                            end
                        -- Shoot
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Shoot" then
                            if g(nativeNames.IsControlJustPressed)(0, FREECAM_LEFT_CONTROL) then
                                _G.wipedFreecam.currentModelIndex = _G.wipedFreecam.currentModelIndex - 1
                                if _G.wipedFreecam.currentModelIndex < 1 then _G.wipedFreecam.currentModelIndex = #_G.wipedFreecam.pistolModels end
                            elseif g(nativeNames.IsControlJustPressed)(0, FREECAM_RIGHT_CONTROL) then
                                _G.wipedFreecam.currentModelIndex = _G.wipedFreecam.currentModelIndex + 1
                                if _G.wipedFreecam.currentModelIndex > #_G.wipedFreecam.pistolModels then _G.wipedFreecam.currentModelIndex = 1 end
                            end
                            if g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                local playerPed2 = g(nativeNames.PlayerPedId)()
                                local weaponHash = g(nativeNames.GetHashKey)(_G.wipedFreecam.pistolModels[_G.wipedFreecam.currentModelIndex].model)
                                g(nativeNames.GiveWeaponToPed)(playerPed2, weaponHash, 255, false, true)
                                g(nativeNames.SetCurrentPedWeapon)(playerPed2, weaponHash, true)
                                local damage = (_G.wipedFreecam.pistolModels[_G.wipedFreecam.currentModelIndex].model == decode({119,101,97,112,111,110,95,115,116,117,110,103,117,110})) and 0 or 100
                                g(nativeNames.ShootSingleBulletBetweenCoords)(
                                    coords.x, coords.y, coords.z,
                                    coords.x + direction.x * 500.0,
                                    coords.y + direction.y * 500.0,
                                    coords.z + direction.z * 500.0,
                                    damage, true, weaponHash, playerPed2, true, false, 1000.0
                                )
                            end
                        -- Shoot Car
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Shoot Car" then
                            if g(nativeNames.IsControlJustPressed)(0, FREECAM_LEFT_CONTROL) then
                                _G.wipedFreecam.currentVehicleIndex = _G.wipedFreecam.currentVehicleIndex - 1
                                if _G.wipedFreecam.currentVehicleIndex < 1 then _G.wipedFreecam.currentVehicleIndex = #_G.wipedFreecam.vehicleModels end
                            elseif g(nativeNames.IsControlJustPressed)(0, FREECAM_RIGHT_CONTROL) then
                                _G.wipedFreecam.currentVehicleIndex = _G.wipedFreecam.currentVehicleIndex + 1
                                if _G.wipedFreecam.currentVehicleIndex > #_G.wipedFreecam.vehicleModels then _G.wipedFreecam.currentVehicleIndex = 1 end
                            end
                            if g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                local from = g(nativeNames.GetCamCoord)(_G.wipedFreecam.camera)
                                local rot2 = g(nativeNames.GetCamRot)(_G.wipedFreecam.camera, 2)
                                local pitch2 = math.rad(rot2.x)
                                local yaw2 = math.rad(rot2.z)
                                local dir2 = vector3(-math.sin(yaw2)*math.cos(pitch2), math.cos(yaw2)*math.cos(pitch2), math.sin(pitch2))
                                local model = _G.wipedFreecam.vehicleModels[_G.wipedFreecam.currentVehicleIndex].model
                                local modelHash = g(nativeNames.GetHashKey)(model)
                                g(nativeNames.RequestModel)(modelHash)
                                local t2 = 0
                                while not g(nativeNames.HasModelLoaded)(modelHash) and t2 < 100 do wait(10); t2 = t2 + 1 end
                                if g(nativeNames.HasModelLoaded)(modelHash) then
                                    local spawnCoords = from + dir2 * 3.0 + vector3(0, 0, 1.0)
                                    local vehicleEntity = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, rot2.z, true, true)
                                    if vehicleEntity and g(nativeNames.DoesEntityExist)(vehicleEntity) then
                                        g(nativeNames.SetEntityAsMissionEntity)(vehicleEntity, true, true)
                                        g(nativeNames.SetVehicleEngineOn)(vehicleEntity, true, true, false)
                                        local targetPoint = from + dir2 * 500.0
                                        g(nativeNames.CreateThread)(function()
                                            wait(75)
                                            if g(nativeNames.DoesEntityExist)(vehicleEntity) then
                                                local sd = targetPoint - from
                                                local dist = math.max(#sd, 1.0)
                                                local nd = sd / dist
                                                local baseForce = (model == "luxor" or model == "luxor2") and 320.0 or 220.0
                                                local vBoost = (model == "luxor" or model == "luxor2") and 25.0 or 12.5
                                                for i = 1, 3 do
                                                    ApplyForceToEntity(vehicleEntity, 1, nd.x*baseForce, nd.y*baseForce, nd.z*baseForce+vBoost, 0,0,0, 0, false, true, true, false, true)
                                                    wait(0)
                                                end
                                            end
                                        end)
                                        g(nativeNames.SetModelAsNoLongerNeeded)(modelHash)
                                    end
                                end
                            end
                        -- Spawn Bomb
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Spawn Bomb" then
                            if g(nativeNames.IsControlJustPressed)(0, FREECAM_LEFT_CONTROL) then
                                _G.wipedFreecam.currentExplosionIndex = _G.wipedFreecam.currentExplosionIndex - 1
                                if _G.wipedFreecam.currentExplosionIndex < 1 then _G.wipedFreecam.currentExplosionIndex = #_G.wipedFreecam.explosionTypes end
                            elseif g(nativeNames.IsControlJustPressed)(0, FREECAM_RIGHT_CONTROL) then
                                _G.wipedFreecam.currentExplosionIndex = _G.wipedFreecam.currentExplosionIndex + 1
                                if _G.wipedFreecam.currentExplosionIndex > #_G.wipedFreecam.explosionTypes then _G.wipedFreecam.currentExplosionIndex = 1 end
                            end
                            if hit and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                AddExplosion(endCoords.x, endCoords.y, endCoords.z, 6, 10.0, true, false, 1.0)
                            end
                        -- Blackhole
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Blackhole" then
                            if hit then
                                local isPressed = g(nativeNames.IsDisabledControlPressed)(0, 24)
                                if isPressed then
                                    local vehiclePool = g(nativeNames.GetGamePool)("CVehicle")
                                    if vehiclePool then
                                        for _, vehicle in pairs(vehiclePool) do
                                            if vehicle and g(nativeNames.DoesEntityExist)(vehicle) and g(nativeNames.IsEntityAVehicle)(vehicle) then
                                                local vc = g(nativeNames.GetEntityCoords)(vehicle)
                                                local dx, dy, dz = coords.x-vc.x, coords.y-vc.y, coords.z-vc.z
                                                local distSq = dx*dx+dy*dy+dz*dz
                                                if distSq < 40000 then
                                                    local dist = math.sqrt(distSq)
                                                    local pull = math.min(350.0, 600.0/math.max(dist,1.0))
                                                    g(nativeNames.NetworkRequestControlOfEntity)(vehicle)
                                                    ApplyForceToEntity(vehicle, 3, dx/dist*pull, dy/dist*pull, dz/dist*pull, 0,0,0, 0, false, true, true, false, true)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        -- Kick Vehicle
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Kick Vehicle" then
                            if hit and entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                local driver = _g(_b("GetPedInVehicleSeat"))(entityHit, -1)
                                if driver and driver ~= 0 and _g(_b("DoesEntityExist"))(driver) then
                                    _g(_b("TaskLeaveVehicle"))(driver, entityHit, 0)
                                    _g(_b("SetPedCanRagdoll"))(driver, true)
                                    _g(_b("SetPedToRagdoll"))(driver, 1000, 1000, 0, 0, 0, 0)
                                end
                            end
                        -- Delete Vehicle
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Delete Vehicle" then
                            if hit and entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                _g(_b("NetworkRequestControlOfEntity"))(entityHit)
                                _g(_b("Wait"))(100)
                                _g(_b("SetEntityAsMissionEntity"))(entityHit, true, true)
                                _g(_b("DeleteEntity"))(entityHit)
                                _g(_b("DeleteVehicle"))(entityHit)
                            end
                        -- Fuck Vehicle
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "Fuck Vehicle" then
                            if hit and entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                _g(_b("NetworkRequestControlOfEntity"))(entityHit)
                                _g(_b("Wait"))(100)
                                for i = 0, 7 do _g(_b("SetVehicleTyreBurst"))(entityHit, i, true, 1000.0) end
                                _g(_b("SetVehicleEngineHealth"))(entityHit, -4000.0)
                                for i = 0, 5 do _g(_b("SetVehicleDoorBroken"))(entityHit, i, true) end
                                for i = 0, 7 do _g(_b("SmashVehicleWindow"))(entityHit, i) end
                                _g(_b("StartEntityFire"))(entityHit)
                            end
                        -- RC Control Car
                        elseif _G.wipedFreecam.cameraFeatures[_G.wipedFreecam.currentFeature] == "RC Control Car" then
                            if hit and entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) and g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                g(nativeNames.NetworkRequestControlOfEntity)(entityHit)
                                wait(100)
                                if _G.rcCarControlActive then
                                    if _G.rcCameraControl ~= nil then
                                        g(nativeNames.RenderScriptCams)(false, true, 1000, true, true)
                                        g(nativeNames.DestroyCam)(_G.rcCameraControl, false)
                                        _G.rcCameraControl = nil
                                    end
                                    _G.rcCarControlActive = false
                                    _G.rcCarControl = nil
                                end
                                _G.rcCarControl = entityHit
                                _G.rcCarControlActive = true
                                _G.rcCarControlSpeed = 0.0
                                g(nativeNames.SetEntityAsMissionEntity)(entityHit, true, true)
                                g(nativeNames.SetEntityInvincible)(entityHit, true)
                                g(nativeNames.SetVehicleEngineOn)(entityHit, true, true, false)
                                g(nativeNames.FreezeEntityPosition)(entityHit, false)
                                g(nativeNames.SetEntityCollision)(entityHit, true, true)
                                g(nativeNames.SetEntityCanBeDamaged)(entityHit, false)
                                g(nativeNames.SetVehicleCanBeVisiblyDamaged)(entityHit, false)
                                g(nativeNames.SetVehicleOnGroundProperly)(entityHit)
                                _G.rcCameraControl = g(nativeNames.CreateCam)(decode({68,69,70,65,85,76,84,95,83,67,82,73,80,84,69,68,95,67,65,77,69,82,65}), true)
                                g(nativeNames.AttachCamToEntity)(_G.rcCameraControl, entityHit, 0.0, -2.5, 1.5, true)
                                g(nativeNames.SetCamRot)(_G.rcCameraControl, -5.0, 0.0, g(nativeNames.GetEntityHeading)(entityHit), 2)
                                g(nativeNames.SetCamActive)(_G.rcCameraControl, true)
                                g(nativeNames.RenderScriptCams)(true, true, 1000, true, true)
                                if _G.wipedFreecam and _G.wipedFreecam.camera then
                                    g(nativeNames.SetCamActive)(_G.wipedFreecam.camera, false)
                                end
                            end
                            if _G.rcCarControlActive and _G.rcCarControl ~= nil and g(nativeNames.DoesEntityExist)(_G.rcCarControl) then
                                g(nativeNames.SetVehicleEngineOn)(_G.rcCarControl, true, true, false)
                                g(nativeNames.SetEntityInvincible)(_G.rcCarControl, true)
                                g(nativeNames.FreezeEntityPosition)(_G.rcCarControl, false)
                                g(nativeNames.SetEntityHasGravity)(_G.rcCarControl, true)
                                g(nativeNames.SetEntityCollision)(_G.rcCarControl, true, true)
                                local fwd, bk, lt, rt, exit = 71, 72, 63, 64, 73
                                local forward = g(nativeNames.IsControlPressed)(0, fwd) and 1.0 or (g(nativeNames.IsControlPressed)(0, bk) and -1.0 or 0.0)
                                local steer   = g(nativeNames.IsControlPressed)(0, rt) and -1.0 or (g(nativeNames.IsControlPressed)(0, lt) and 1.0 or 0.0)
                                local maxSpeed, acc, dec = 50.0, 2.5, 3.0
                                if forward ~= 0.0 then
                                    local ts = maxSpeed * forward
                                    if forward > 0 then
                                        _G.rcCarControlSpeed = math.min(_G.rcCarControlSpeed + acc, ts)
                                    else
                                        _G.rcCarControlSpeed = math.max(_G.rcCarControlSpeed - dec, ts)
                                    end
                                    SetVehicleForwardSpeed(_G.rcCarControl, _G.rcCarControlSpeed)
                                    if steer ~= 0.0 and math.abs(_G.rcCarControlSpeed) > 1.0 then
                                        local sf = math.min(math.abs(_G.rcCarControlSpeed)/20.0, 1.0)
                                        g(nativeNames.SetEntityHeading)(_G.rcCarControl, g(nativeNames.GetEntityHeading)(_G.rcCarControl) + steer*sf*4.5)
                                    end
                                else
                                    if math.abs(_G.rcCarControlSpeed) > 0.1 then
                                        _G.rcCarControlSpeed = _G.rcCarControlSpeed > 0 and math.max(_G.rcCarControlSpeed-dec,0) or math.min(_G.rcCarControlSpeed+dec,0)
                                        SetVehicleForwardSpeed(_G.rcCarControl, _G.rcCarControlSpeed)
                                    else
                                        _G.rcCarControlSpeed = 0.0
                                    end
                                end
                                if g(nativeNames.IsControlJustPressed)(0, exit) then
                                    if _G.rcCameraControl ~= nil then
                                        g(nativeNames.RenderScriptCams)(false, true, 1000, true, true)
                                        g(nativeNames.DestroyCam)(_G.rcCameraControl, false)
                                        _G.rcCameraControl = nil
                                    end
                                    _G.rcCarControlActive = false
                                    _G.rcCarControl = nil
                                    if _G.wipedFreecam and _G.wipedFreecam.camera then
                                        g(nativeNames.SetCamActive)(_G.wipedFreecam.camera, true)
                                        g(nativeNames.RenderScriptCams)(true, true, 1000, true, true)
                                    end
                                end
                            end
                        end
                    end
                end)
            end

            function _G.wipedFreecam.ExitCamera()
                if not _G.wipedFreecam.isToggled then return end
                _G.wipedFreecam.isToggled = false
                if _G.wipedFreecam.camera then
                    g(nativeNames.SetCamActive)(_G.wipedFreecam.camera, false)
                    g(nativeNames.RenderScriptCams)(false, true, 500, false, false)
                    g(nativeNames.DestroyCam)(_G.wipedFreecam.camera)
                    _G.wipedFreecam.camera = nil
                end
                if _G.rcCarControlActive then
                    if _G.rcCameraControl ~= nil then
                        g(nativeNames.RenderScriptCams)(false, true, 1000, true, true)
                        g(nativeNames.DestroyCam)(_G.rcCameraControl, false)
                        _G.rcCameraControl = nil
                    end
                    _G.rcCarControlActive = false
                    _G.rcCarControl = nil
                end
                g(nativeNames.SetFocusEntity)(g(nativeNames.PlayerPedId)())
                g(nativeNames.EnableControlAction)(0, 14, true)
                g(nativeNames.EnableControlAction)(0, 15, true)
                g(nativeNames.EnableControlAction)(0, 16, true)
                g(nativeNames.EnableControlAction)(0, 17, true)
            end
        end

        -- H key (74) listener — only enters/exits cam, never auto-activates
        g(nativeNames.CreateThread)(function()
            while _G.wipedFreecam and not _G.wipedFreecam.shutdown do
                wait(0)
                if g(nativeNames.IsDisabledControlJustPressed)(0, 74) then
                    if _G.wipedFreecam.isToggled then
                        _G.wipedFreecam.ExitCamera()
                    else
                        _G.wipedFreecam.EnterCamera()
                    end
                end
            end
        end)
    ]], leftControl, rightControl, freecamSpeedValue)

    MachoInjectResource(GetFreecamResource(), code)
end

local function DisableFreecam()
    MachoInjectResource(GetFreecamResource(), [[
        if _G.wipedFreecam then
            _G.wipedFreecam.shutdown = true
            if _G.wipedFreecam.ExitCamera then
                _G.wipedFreecam.ExitCamera()
            else
                if _G.wipedFreecam.camera then
                    SetCamActive(_G.wipedFreecam.camera, false)
                    RenderScriptCams(false, true, 500, false, false)
                    DestroyCam(_G.wipedFreecam.camera)
                    _G.wipedFreecam.camera = nil
                end
                if _G.rcCarControlActive then
                    if _G.rcCameraControl ~= nil then
                        RenderScriptCams(false, true, 1000, true, true)
                        DestroyCam(_G.rcCameraControl, false)
                        _G.rcCameraControl = nil
                    end
                    _G.rcCarControlActive = false
                    _G.rcCarControl = nil
                end
                SetFocusEntity(PlayerPedId())
                EnableControlAction(0, 14, true)
                EnableControlAction(0, 15, true)
                EnableControlAction(0, 16, true)
                EnableControlAction(0, 17, true)
            end
            CreateThread(function()
                Wait(100)
                _G.wipedFreecam = nil
            end)
        end
    ]])
end

MachoMenuCheckbox(Self[1], "Free Camera", function()
    EnableFreecam()
end, function()
    DisableFreecam()
end)

MachoMenuCheckbox(Self[1], "Super Jump", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if xCvBnMqWeRtYuIo == nil then xCvBnMqWeRtYuIo = false end
        xCvBnMqWeRtYuIo = true

        local function JcWT5vYEq1()
            local yLkPwOiUtReAzXc = CreateThread
            yLkPwOiUtReAzXc(function()
                while xCvBnMqWeRtYuIo and not Unloaded do
                    local hGfDsAzXcVbNmQw = SetSuperJumpThisFrame
                    local eRtYuIoPaSdFgHj = PlayerPedId()
                    local oPlMnBvCxZlKjHg = PlayerId()

                    hGfDsAzXcVbNmQw(oPlMnBvCxZlKjHg)
                    Wait(0)
                end
            end)
        end

        JcWT5vYEq1()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        xCvBnMqWeRtYuIo = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Levitation", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        -- make helpers global so other chunks can use them
        function ScaleVector(vect, mult)
            return vector3(vect.x * mult, vect.y * mult, vect.z * mult)
        end

        function AddVectors(vect1, vect2)
            return vector3(vect1.x + vect2.x, vect1.y + vect2.y, vect1.z + vect2.z)
        end

        function ApplyForce(entity, direction)
            local XroXTNEFqxoWfH = ApplyForceToEntity
            XroXTNEFqxoWfH(entity, 3, direction, 0, 0, 0, false, false, true, true, false, true)
        end

        function SubVectors(vect1, vect2)
            return vector3(vect1.x - vect2.x, vect1.y - vect2.y, vect1.z - vect2.z)
        end

        function Oscillate(entity, position, angleFreq, dampRatio)
            local OBaTQqteIpmZVo = GetEntityVelocity
            local pos1 = ScaleVector(SubVectors(position, GetEntityCoords(entity)), (angleFreq * angleFreq))
            local pos2 = AddVectors(ScaleVector(OBaTQqteIpmZVo(entity), (2.0 * angleFreq * dampRatio)), vector3(0.0, 0.0, 0.1))
            local targetPos = SubVectors(pos1, pos2)
            ApplyForce(entity, targetPos)
        end

        function RotationToDirection(rot)
            local radZ = math.rad(rot.z)
            local radX = math.rad(rot.x)
            local cosX = math.cos(radX)
            return vector3(
                -math.sin(radZ) * cosX,
                math.cos(radZ) * cosX,
                math.sin(radX)
            )
        end

        function GetClosestCoordOnLine(startCoords, endCoords, entity)
            local CDGcdMQhosGVCf = GetShapeTestResult
            local UaWIFHgeizhHua = StartShapeTestRay
            local result, hit, hitCoords, surfaceNormal, entityHit =
                CDGcdMQhosGVCf(UaWIFHgeizhHua(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y, endCoords.z, -1, entity, 0))
            return hit == 1, hitCoords
        end

        function GetCameraLookingAtCoord(distance)
            local playerPed = PlayerPedId()
            local camRot = GetGameplayCamRot(2)
            local camCoord = GetGameplayCamCoord()
            local forwardVector = RotationToDirection(camRot)
            local destination = vector3(
                camCoord.x + forwardVector.x * distance,
                camCoord.y + forwardVector.y * distance,
                camCoord.z + forwardVector.z * distance
            )
            local hit, endCoords = GetClosestCoordOnLine(camCoord, destination, playerPed)
            if hit then return endCoords else return destination end
        end
    ]])

    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function awfjawr57awt7f()
            nxtBFlQWMMeRLs = true

            local jIiIfikctHYrlH = CreateThread
            jIiIfikctHYrlH(function()
                while nxtBFlQWMMeRLs and not Unloaded do
                    Wait(0)
                    local ped = PlayerPedId()

                    local SZxuJlyJQmGlZz = SetPedCanRagdoll
                    local valuOZfymjeVaH = IsEntityPlayingAnim
                    local IiHiLVRagMQhrn = RequestAnimDict
                    local mOZOquvggdnbod = HasAnimDictLoaded
                    local UFZdrZNXpLwpjT = TaskPlayAnim
                    local cQPIZtKyyWaVcY = GetCameraLookingAtCoord
                    local OyvuuAMyvjtIzD = GetGameplayCamRot
                    local XKWvPIkCKMXIfR = IsDisabledControlPressed  -- FIXED: missing '='

                    while XKWvPIkCKMXIfR(0, 22) do
                        SZxuJlyJQmGlZz(ped, false)

                        if not valuOZfymjeVaH(ped, "oddjobs@assassinate@construction@", "unarmed_fold_arms", 3) then
                            IiHiLVRagMQhrn("oddjobs@assassinate@construction@")
                            while not mOZOquvggdnbod("oddjobs@assassinate@construction@") do
                                Wait(0)
                            end
                            UFZdrZNXpLwpjT(ped, "oddjobs@assassinate@construction@", "unarmed_fold_arms",
                                8.0, -8.0, -1, 49, 0, false, false, false)
                        end

                        local camRot = OyvuuAMyvjtIzD(2)
                        local camHeading = (camRot.z + 360) % 360
                        local direction = cQPIZtKyyWaVcY(77)

                        SetEntityHeading(ped, camHeading)
                        Oscillate(ped, direction, 0.33, 0.9)

                        Wait(1)
                    end

                    if valuOZfymjeVaH(ped, "oddjobs@assassinate@construction@", "unarmed_fold_arms", 3) then
                        ClearPedTasks(ped)
                    end

                    SZxuJlyJQmGlZz(ped, true)
                end
            end)
        end

        awfjawr57awt7f()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        nxtBFlQWMMeRLs = false
        ClearPedTasks(PlayerPedId())
    ]])
end)

MachoMenuCheckbox(Self[1], "Super Strength", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if fgawjFmaDjdALaO == nil then fgawjFmaDjdALaO = false end
        fgawjFmaDjdALaO = true

        local holdingEntity = false
        local holdingCarEntity = false
        local holdingPed = false
        local heldEntity = nil
        local entityType = nil
        local awfhjawrasfs = CreateThread

        awfhjawrasfs(function()
            while fgawjFmaDjdALaO and not Unloaded do
                Wait(0)
                if holdingEntity and heldEntity then
                    local playerPed = PlayerPedId()
                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                    DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped")
                    
                    if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                        RequestAnimDict('anim@mp_rollarcoaster')
                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                            Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                    elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                        RequestAnimDict('anim@heists@box_carry@')
                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                            Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                    end

                    if not IsEntityAttached(heldEntity) then
                        holdingEntity = false
                        holdingCarEntity = false
                        holdingPed = false
                        heldEntity = nil
                    end
                end
            end
        end)

        awfhjawrasfs(function()
            while fgawjFmaDjdALaO and not Unloaded do
                Wait(0)
                local playerPed = PlayerPedId()
                local camPos = GetGameplayCamCoord()
                local camRot = GetGameplayCamRot(2)
                local direction = RotationToDirection(camRot)
                local dest = vec3(camPos.x + direction.x * 10.0, camPos.y + direction.y * 10.0, camPos.z + direction.z * 10.0)

                local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
                local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
                local validTarget = false

                if hit == 1 then
                    entityType = GetEntityType(entityHit)
                    if entityType == 3 or entityType == 2 or entityType == 1 then
                        validTarget = true
                        local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                        DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[E] Pick Up / [Y] Drop")
                    end
                end

                if IsDisabledControlJustReleased(0, 38) then
                    if validTarget and not holdingEntity then
                        holdingEntity = true
                        heldEntity = entityHit

                        local wfuawruawts = AttachEntityToEntity

                        if entityType == 3 then
                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                        elseif entityType == 2 then
                            holdingCarEntity = true
                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                        elseif entityType == 1 then
                            holdingPed = true
                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                        end
                    end
                elseif IsDisabledControlJustReleased(0, 246) then
                    if holdingEntity then
                        local wgfawhtawrs = DetachEntity
                        local dfgjsdfuwer = ApplyForceToEntity
                        local sdgfhjwserw = ClearPedTasks

                        wgfawhtawrs(heldEntity, true, true)
                        dfgjsdfuwer(heldEntity, 1, direction.x * 500, direction.y * 500, direction.z * 500, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                        holdingEntity = false
                        holdingCarEntity = false
                        holdingPed = false
                        heldEntity = nil
                        sdgfhjwserw(PlayerPedId())
                    end
                end
            end
        end)

        function RotationToDirection(rotation)
            local adjustedRotation = vec3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
            local direction = vec3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
            return direction
        end

        function DrawText3Ds(x, y, z, text)
            local onScreen, _x, _y = World3dToScreen2d(x, y, z)
            local px, py, pz = table.unpack(GetGameplayCamCoords())
            local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2
            local fov = (1 / GetGameplayCamFov()) * 100
            scale = scale * fov

            if onScreen then
                SetTextScale(0.0 * scale, 0.35 * scale)
                SetTextFont(0)
                SetTextProportional(1)
                SetTextColour(255, 255, 255, 215)
                SetTextDropshadow(0, 0, 0, 0, 155)
                SetTextEdge(2, 0, 0, 0, 150)
                SetTextDropShadow()
                -- SetTextOutline()
                SetTextEntry("STRING")
                SetTextCentre(1)
                AddTextComponentString(text)
                DrawText(_x, _y)
            end
        end
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        fgawjFmaDjdALaO = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Super Punch", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if qWeRtYuIoPlMnBv == nil then qWeRtYuIoPlMnBv = false end
        qWeRtYuIoPlMnBv = true

        local function NdaFBuHkvo()
            local uTrEsAzXcVbNmQw = CreateThread
            uTrEsAzXcVbNmQw(function()
                while qWeRtYuIoPlMnBv and not Unloaded do
                    local nBvCxZlKjHgFdSa = SetPlayerMeleeWeaponDamageModifier
                    local cVbNmQwErTyUiOp = SetPlayerVehicleDamageModifier
                    local bNmQwErTyUiOpAs = SetWeaponDamageModifier
                    local sDfGhJkLqWeRtYu = PlayerId()
                    local DamageRateValue = 150.0
                    local WeaponNameForDamage = "WEAPON_UNARMED"


                    nBvCxZlKjHgFdSa(sDfGhJkLqWeRtYu, DamageRateValue)
                    cVbNmQwErTyUiOp(sDfGhJkLqWeRtYu, DamageRateValue)
                    bNmQwErTyUiOpAs(GetHashKey(WeaponNameForDamage), DamageRateValue)

                    Wait(0)
                end
            end)
        end

        NdaFBuHkvo()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local qWeRtYuIoPlMnBv = false
        local nBvCxZlKjHgFdSa = SetPlayerMeleeWeaponDamageModifier
        local cVbNmQwErTyUiOp = SetPlayerVehicleDamageModifier
        local bNmQwErTyUiOpAs = SetWeaponDamageModifier
        local sDfGhJkLqWeRtYu = PlayerId()

        nBvCxZlKjHgFdSa(sDfGhJkLqWeRtYu, 1.0)
        cVbNmQwErTyUiOp(sDfGhJkLqWeRtYu, 1.0)
        bNmQwErTyUiOpAs(GetHashKey("WEAPON_UNARMED"), 1.0)
    ]])
end)

MachoMenuCheckbox(Self[1], "Throw From Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if zXpQwErTyUiPlMn == nil then zXpQwErTyUiPlMn = false end
        zXpQwErTyUiPlMn = true

        local function qXzRP7ytKW()
            local iLkMzXvBnQwSaTr = CreateThread
            iLkMzXvBnQwSaTr(function()
                while zXpQwErTyUiPlMn and not Unloaded do
                    local vBnMaSdFgTrEqWx = SetRelationshipBetweenGroups
                    vBnMaSdFgTrEqWx(5, GetHashKey('PLAYER'), GetHashKey('PLAYER'))
                    Wait(0)
                end
            end)
        end

        qXzRP7ytKW()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        zXpQwErTyUiPlMn = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Force Third Person", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if kJfGhTrEeWqAsDz == nil then kJfGhTrEeWqAsDz = false end
        kJfGhTrEeWqAsDz = true

        local function pqkTRWZ38y()
            local gKdNqLpYxMiV = CreateThread
            gKdNqLpYxMiV(function()
                while kJfGhTrEeWqAsDz and not Unloaded do
                    local qWeRtYuIoPlMnBv = SetFollowPedCamViewMode
                    local aSdFgHjKlQwErTy = SetFollowVehicleCamViewMode

                    qWeRtYuIoPlMnBv(0)
                    aSdFgHjKlQwErTy(0)
                    Wait(0)
                end
            end)
        end

        pqkTRWZ38y()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        kJfGhTrEeWqAsDz = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Force Driveby", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if zXcVbNmQwErTyUi == nil then zXcVbNmQwErTyUi = false end
        zXcVbNmQwErTyUi = true

        local function UEvLBcXqM6()
            local cVbNmAsDfGhJkLz = CreateThread
            cVbNmAsDfGhJkLz(function()
                while zXcVbNmQwErTyUi and not Unloaded do
                    local lKjHgFdSaZxCvBn = SetPlayerCanDoDriveBy
                    local eRtYuIoPaSdFgHi = PlayerPedId()

                    lKjHgFdSaZxCvBn(eRtYuIoPaSdFgHi, true)
                    Wait(0)
                end
            end)
        end

        UEvLBcXqM6()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        zXcVbNmQwErTyUi = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Anti-Headshot", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if yHnvrVNkoOvGMWiS == nil then yHnvrVNkoOvGMWiS = false end
        yHnvrVNkoOvGMWiS = true

        local eeitKYqDwYbPslTW = CreateThread
        local function LIfbdMbeIAeHTnnx()
            eeitKYqDwYbPslTW(function()
                while yHnvrVNkoOvGMWiS and not Unloaded do
                    local fhw72q35d8sfj = SetPedSuffersCriticalHits
                    fhw72q35d8sfj(PlayerPedId(), false)
                    Wait(0)
                end
            end)
        end

        LIfbdMbeIAeHTnnx()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        yHnvrVNkoOvGMWiS = false
        fhw72q35d8sfj(PlayerPedId(), true)
    ]])
end)

MachoMenuCheckbox(Self[1], "Anti-Freeze", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if nHgFdSaZxCvBnMq == nil then nHgFdSaZxCvBnMq = false end
        nHgFdSaZxCvBnMq = true

        local sdfw3w3tsdg = CreateThread
        local function XELa6FJtsB()
            sdfw3w3tsdg(function()
                while nHgFdSaZxCvBnMq and not Unloaded do
                    local fhw72q35d8sfj = FreezeEntityPosition
                    local segfhs347dsgf = ClearPedTasks

                    if IsEntityPositionFrozen(PlayerPedId()) then
                        fhw72q35d8sfj(PlayerPedId(), false)
                        segfhs347dsgf(PlayerPedId())
                    end
                    
                    Wait(0)
                end
            end)
        end

        XELa6FJtsB()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        nHgFdSaZxCvBnMq = false
    ]])
end)

MachoMenuCheckbox(Self[1], "Anti-Blackscreen", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if aDjsfmansdjwAEl == nil then aDjsfmansdjwAEl = false end
        aDjsfmansdjwAEl = true

        local sdfw3w3tsdg = CreateThread
        local function XELWAEDa6FJtsB()
            sdfw3w3tsdg(function()
                while aDjsfmansdjwAEl and not Unloaded do
                    DoScreenFadeIn(0)
                    Wait(0)
                end
            end)
        end

        XELWAEDa6FJtsB()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        aDjsfmansdjwAEl = false
    ]])
end)


-- [ Laser Eyes ]
MachoMenuCheckbox(Self[3], "Laser Eyes (Left Alt)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_LaserEyes == nil then _G.blossom_LaserEyes = false end
        _G.blossom_LaserEyes = true
        CreateThread(function()
            while _G.blossom_LaserEyes and not Unloaded do
                Wait(0)
                if IsControlPressed(0, 19) then -- Left Alt
                    local ped = PlayerPedId()
                    local camCoord = GetGameplayCamCoord()
                    local camRot = GetGameplayCamRot(2)
                    local radZ = math.rad(camRot.z)
                    local radX = math.rad(camRot.x)
                    local dir = vector3(-math.sin(radZ)*math.cos(radX), math.cos(radZ)*math.cos(radX), math.sin(radX))
                    local dest = camCoord + dir * 300.0
                    ShootSingleBulletBetweenCoords(camCoord.x, camCoord.y, camCoord.z, dest.x, dest.y, dest.z, 100.0, true, GetHashKey("weapon_lazer"), ped, true, false, 1000.0)
                end
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_LaserEyes = false
    ]])
end)


-- [ Model Changer ]
local ModelNameHandle = MachoMenuInputbox(Self[2], "Model Name:", "...")

MachoMenuButton(Self[2], "Change Model", function()
    local ModelName = MachoMenuGetInputbox(ModelNameHandle)

    if type(ModelName) == "string" and ModelName ~= "" then
        local Code = string.format([[
            local function GykR8qjWTp()
                local nHgFdSaZxCvBnMq = RequestModel
                local xCvBnMqWeRtYuIo = HasModelLoaded
                local aSdFgHjKlQwErTy = SetPlayerModel
                local oPlMnBvCxZlKjHg = SetPedDefaultComponentVariation

                nHgFdSaZxCvBnMq(GetHashKey("%s"))
                while not xCvBnMqWeRtYuIo(GetHashKey("%s")) do
                    Wait(1)
                end
                
                aSdFgHjKlQwErTy(PlayerId(), GetHashKey("%s"))
                oPlMnBvCxZlKjHg(PlayerPedId())
            end

            GykR8qjWTp()
        ]], ModelName, ModelName, ModelName)

        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", Code)
    end
end)

MachoMenuButton(Self[2], ".gg/blossoma Drip", function()
    function WhiteblossomDrip()
        local ped = PlayerPedId()

        -- Jacket
        SetPedComponentVariation(ped, 11, 109, 0, 2)
        -- Shirt/Undershirt
        SetPedComponentVariation(ped, 8, 15, 0, 2)
        -- Hands
        SetPedComponentVariation(ped, 3, 5, 0, 2)
        -- Legs
        SetPedComponentVariation(ped, 4, 56, 0, 2)
        -- Shoes
        SetPedComponentVariation(ped, 6, 19, 0, 2)
        -- Hat
        SetPedPropIndex(ped, 0, 1, 0, true)
    end

    WhiteblossomDrip()
end)

MachoMenuButton(Self[2], ".gg/blossoma Mafia Drip", function()
    function CAPTCHASMafia()
        local ped = PlayerPedId()

        -- Jacket
        SetPedComponentVariation(ped, 11, 5, 0, 2)
        -- Shirt/Undershirt
        SetPedComponentVariation(ped, 8, 15, 0, 2)
        -- Hands
        SetPedComponentVariation(ped, 3, 5, 0, 2)
        -- Legs
        SetPedComponentVariation(ped, 4, 42, 0, 2)
        -- Shoes
        SetPedComponentVariation(ped, 6, 6, 0, 2)
        -- Hat
        SetPedPropIndex(ped, 0, 26, 0, true)
        -- Glasses
        SetPedPropIndex(ped, 1, 3, 0, true)
    end

    CAPTCHASMafia()
end)


-- [ Animal Peds ]
-- Animal Peds in Model Changer
local blossomAnimalModels = {
    "a_c_boar","a_c_cat_01","a_c_hen","a_c_chimp","a_c_cow","a_c_coyote","a_c_crow",
    "a_c_deer","a_c_dolphin","a_c_fish","a_c_humpback","a_c_husky","a_c_killerwhale",
    "a_c_mtlion","a_c_pig","a_c_pigeon","a_c_poodle","a_c_pug","a_c_rabbit_01",
    "a_c_rat","a_c_retriever","a_c_rhesus","a_c_rottweiler","a_c_seagull",
    "a_c_shepherd","a_c_stingray","a_c_sharktiger","a_c_sharkhammer"
}
local blossomAnimalNames = {
    "Boar","Cat","Chicken","Chimp","Cow","Coyote","Crow","Deer","Dolphin","Fish",
    "Humpback","Husky","Killer Whale","Mountain Lion","Pig","Pigeon","Poodle",
    "Pug","Rabbit","Rat","Retriever","Rhesus Monkey","Rottweiler","Seagull",
    "Shepherd","Stingray","Tiger Shark","Hammerhead Shark"
}

MachoMenuDropDown(Self[2], "Animal Ped", function(index)
    if blossomAnimalModels[index] then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
            local model = "%s"
            local hash = GetHashKey(model)
            RequestModel(hash)
            while not HasModelLoaded(hash) do Wait(100) end
            SetPlayerModel(PlayerId(), hash)
            SetModelAsNoLongerNeeded(hash)
        ]], blossomAnimalModels[index]))
    end
end, table.unpack(blossomAnimalNames))

-- Freemode Models
MachoMenuDropDown(Self[2], "Freemode", function(index)
    local models = {"mp_m_freemode_01", "mp_f_freemode_01"}
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local hash = GetHashKey("%s")
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(100) end
        SetPlayerModel(PlayerId(), hash)
        SetModelAsNoLongerNeeded(hash)
    ]], models[index]))
end, "Freemode Male", "Freemode Female")





-- [ Functions ]
MachoMenuCheckbox(Self[3], "Toggle Player IDs", function()
    MachoInjectResource2(3, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(true, true)
    ]])
end, function()
    MachoInjectResource2(3, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(false, false)
    ]])
end)

MachoMenuButton(Self[3], "Heal", function()
    SetEntityHealth(PlayerPedId(), 200)
end)

MachoMenuButton(Self[3], "Armor", function()
    SetPedArmour(PlayerPedId(), 100)
end)

MachoMenuButton(Self[3], "Fill Hunger", function()
    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function DawrjatjsfAW()
            TriggerEvent('esx_status:set', 'hunger', 1000000)
        end

        DawrjatjsfAW()
    ]])
end)

MachoMenuButton(Self[3], "Fill Thirst", function()
    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function sWj238fsMAw()
            TriggerEvent('esx_status:set', 'thirst', 1000000)
        end

        sWj238fsMAw()
    ]])
end)

MachoMenuButton(Self[3], "Revive", function()
    MachoInjectResource2(3, CheckResource("ox_inventory") and "ox_inventory" or CheckResource("ox_lib") and "ox_lib" or CheckResource("es_extended") and "es_extended" or CheckResource("qb-core") and "qb-core" or CheckResource("wasabi_ambulance") and "wasabi_ambulance" or CheckResource("ak47_ambulancejob") and "ak47_ambulancejob" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function AcjU5NQzKw()
            if GetResourceState('prp-injuries') == 'started' then
                TriggerEvent('prp-injuries:hospitalBedHeal', skipHeal)
                return
            end

            if GetResourceState('es_extended') == 'started' then
                TriggerEvent("esx_ambulancejob:revive")
                return
            end

            if GetResourceState('qb-core') == 'started' then
                TriggerEvent("hospital:client:Revive")
                return
            end

            if GetResourceState('wasabi_ambulance') == 'started' then
                TriggerEvent("wasabi_ambulance:revive")
                return
            end

            if GetResourceState('ak47_ambulancejob') == 'started' then
                TriggerEvent("ak47_ambulancejob:revive")
                return
            end

            NcVbXzQwErTyUiO = GetEntityHeading(PlayerPedId())
            BvCxZlKjHgFdSaP = GetEntityCoords(PlayerPedId())

            RtYuIoPlMnBvCxZ = NetworkResurrectLocalPlayer
            RtYuIoPlMnBvCxZ(BvCxZlKjHgFdSaP.x, BvCxZlKjHgFdSaP.y, BvCxZlKjHgFdSaP.z, NcVbXzQwErTyUiO, false, false, false, 1, 0)
        end

        AcjU5NQzKw()
    ]])
end)

MachoMenuButton(Self[3], "Suicide", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function RGybF0JqEt()
            local aSdFgHjKlQwErTy = SetEntityHealth
            aSdFgHjKlQwErTy(PlayerPedId(), 0)
        end

        RGybF0JqEt()
    ]])
end)

MachoMenuButton(Self[3], "Force Ragdoll", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function awfAEDSADWEf()
            local cWAmdjakwDksFD = SetPedToRagdoll
            cWAmdjakwDksFD(PlayerPedId(), 3000, 3000, 0, false, false, false)
        end

        awfAEDSADWEf()
    ]])
end)

MachoMenuButton(Self[3], "Clear Task", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function iPfT7kN3dU()
            local zXcVbNmAsDfGhJk = ClearPedTasksImmediately
            zXcVbNmAsDfGhJk(PlayerPedId())
        end

        iPfT7kN3dU()
    ]])
end)

MachoMenuButton(Self[3], "Clear Vision", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function MsVqZ29ptY()
            local qWeRtYuIoPlMnBv = ClearTimecycleModifier
            local kJfGhTrEeWqAsDz = ClearExtraTimecycleModifier

            qWeRtYuIoPlMnBv()
            kJfGhTrEeWqAsDz()
        end

        MsVqZ29ptY()
    ]])
end)

MachoMenuButton(Self[3], "Force GPS", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        SetBlipRoute(GetFirstBlipInfoId(8), true)
        StartGpsCustomRoute(0.0, 0.0, 0)
        DisplayPreviousRoutedGpsRoute(true)
    ]])
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "GPS forced.")
end)

-- Custom Outfit Components
local outfitNumbersStr = {}
for i = 1, 200 do table.insert(outfitNumbersStr, tostring(i)) end

MachoMenuDropDown(Self[3], "Hat", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedPropIndex(PlayerPedId(), 0, %d, 0, true)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "Mask", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedComponentVariation(PlayerPedId(), 1, %d, 0, 0)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "Glasses", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedPropIndex(PlayerPedId(), 1, %d, 0, true)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "Torso", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedComponentVariation(PlayerPedId(), 3, %d, 0, 0)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "T-Shirt", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedComponentVariation(PlayerPedId(), 8, %d, 0, 0)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "Pants", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedComponentVariation(PlayerPedId(), 4, %d, 0, 0)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuDropDown(Self[3], "Shoes", function(index)
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        SetPedComponentVariation(PlayerPedId(), 6, %d, 0, 0)
    ]], index - 1))
end, table.unpack(outfitNumbersStr))

MachoMenuButton(Self[3], "Randomize Outfit", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function UxrKYLp378()
            local UwEsDxCfVbGtHy = PlayerPedId
            local FdSaQwErTyUiOp = GetNumberOfPedDrawableVariations
            local QwAzXsEdCrVfBg = SetPedComponentVariation
            local LkJhGfDsAqWeRt = SetPedHeadBlendData
            local MnBgVfCdXsZaQw = SetPedHairColor
            local RtYuIoPlMnBvCx = GetNumHeadOverlayValues
            local TyUiOpAsDfGhJk = SetPedHeadOverlay
            local ErTyUiOpAsDfGh = SetPedHeadOverlayColor
            local DfGhJkLzXcVbNm = ClearPedProp

            local function PqLoMzNkXjWvRu(component, exclude)
                local ped = UwEsDxCfVbGtHy()
                local total = FdSaQwErTyUiOp(ped, component)
                if total <= 1 then return 0 end
                local choice = exclude
                while choice == exclude do
                    choice = math.random(0, total - 1)
                end
                return choice
            end

            local function OxVnBmCxZaSqWe(component)
                local ped = UwEsDxCfVbGtHy()
                local total = FdSaQwErTyUiOp(ped, component)
                return total > 1 and math.random(0, total - 1) or 0
            end

            local ped = UwEsDxCfVbGtHy()

            QwAzXsEdCrVfBg(ped, 11, PqLoMzNkXjWvRu(11, 15), 0, 2)
            QwAzXsEdCrVfBg(ped, 6, PqLoMzNkXjWvRu(6, 15), 0, 2)
            QwAzXsEdCrVfBg(ped, 8, 15, 0, 2)
            QwAzXsEdCrVfBg(ped, 3, 0, 0, 2)
            QwAzXsEdCrVfBg(ped, 4, OxVnBmCxZaSqWe(4), 0, 2)

            local face = math.random(0, 45)
            local skin = math.random(0, 45)
            LkJhGfDsAqWeRt(ped, face, skin, 0, face, skin, 0, 1.0, 1.0, 0.0, false)

            local hairMax = FdSaQwErTyUiOp(ped, 2)
            local hair = hairMax > 1 and math.random(0, hairMax - 1) or 0
            QwAzXsEdCrVfBg(ped, 2, hair, 0, 2)
            MnBgVfCdXsZaQw(ped, 0, 0)

            local brows = RtYuIoPlMnBvCx(2)
            TyUiOpAsDfGhJk(ped, 2, brows > 1 and math.random(0, brows - 1) or 0, 1.0)
            ErTyUiOpAsDfGh(ped, 2, 1, 0, 0)

            DfGhJkLzXcVbNm(ped, 0)
            DfGhJkLzXcVbNm(ped, 1)
        end

        UxrKYLp378()
    ]])
end)





-- ═══════════════════════════════════════════════════════
--  SERVER TAB
-- ═══════════════════════════════════════════════════════

-- [ Player ID Input — shared by all player-targeted features ]
local PlayerIDInputHandle = MachoMenuInputbox(Server[1], "Player ID:", "0")
local LastValidPlayerID = nil

local function GetValidPlayerID()
    local rawInput = MachoMenuGetInputbox(PlayerIDInputHandle)
    if rawInput and rawInput ~= "" then
        local numericOnly = rawInput:gsub("[^0-9]", "")
        local playerID = tonumber(numericOnly)
        if playerID and playerID >= 0 then
            LastValidPlayerID = playerID
            return playerID
        end
    end
    return nil
end

local function GetPlayerIndexFromServerId(serverId)
    if not serverId then return nil end
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            if GetPlayerServerId(i) == serverId then
                return i
            end
        end
    end
    return nil
end

-- ═══════════════════════════════════════════════════════
--  SERVER TAB — PLAYER ACTIONS (uses Player ID input above)
-- ═══════════════════════════════════════════════════════

-- [ Player Actions ]
MachoMenuButton(Server[1], "Teleport To Player", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if not DoesEntityExist(targetPed) then return end
        local coords = GetEntityCoords(targetPed)
        local myPed = PlayerPedId()
        local myVeh = GetVehiclePedIsIn(myPed, false)
        if myVeh and myVeh ~= 0 then
            SetEntityCoordsNoOffset(myVeh, coords.x, coords.y, coords.z, false, false, false)
        else
            SetEntityCoordsNoOffset(myPed, coords.x, coords.y, coords.z + 1.0, false, false, false)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Teleported to player " .. targetId)
end)

MachoMenuButton(Server[1], "Kill Player (Direct)", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            local myPed = PlayerPedId()
            local targetCoords = GetEntityCoords(targetPed)
            ShootSingleBulletBetweenCoords(
                targetCoords.x, targetCoords.y, targetCoords.z + 5.0,
                targetCoords.x, targetCoords.y, targetCoords.z,
                5000.0, true, GetHashKey("weapon_assaultrifle"), myPed, true, false, 9999.0
            )
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Kill sent to player " .. targetId)
end)

MachoMenuButton(Server[1], "Force Hands Up", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            local dict = "missminuteman_1ig_2"
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do Wait(0) end
            TaskPlayAnim(targetPed, dict, "handsup_enter", 8.0, 8.0, -1, 49, 0, false, false, false)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Forced hands up on player " .. targetId)
end)

MachoMenuButton(Server[1], "Steal Outfit", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if not DoesEntityExist(targetPed) then return end
        local playerPed = PlayerPedId()
        for compId = 0, 11 do
            local drawable = GetPedDrawableVariation(targetPed, compId)
            local texture = GetPedTextureVariation(targetPed, compId)
            local palette = GetPedPaletteVariation(targetPed, compId)
            SetPedComponentVariation(playerPed, compId, drawable, texture, palette)
        end
        for propId = 0, 7 do
            local propIndex = GetPedPropIndex(targetPed, propId)
            if propIndex ~= -1 then
                local texture = GetPedPropTextureIndex(targetPed, propId)
                SetPedPropIndex(playerPed, propId, propIndex, texture, true)
            else
                ClearPedProp(playerPed, propId)
            end
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Stole outfit from player " .. targetId)
end)

-- [ Player Vehicle Actions ]
local attachCarVehicles = {"pounder2","pounder","mule","phantom","hauler","mixer","bus","coach","firetruk","trashmaster","benson","stockade","brickade","rhino","insurgent","luxor2"}

MachoMenuDropDown(Vehicle[1], "Attach Car To Player", function(index)
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    local vehicleModel = attachCarVehicles[index]
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if not DoesEntityExist(targetPed) then return end
        local coords = GetEntityCoords(targetPed)
        local model = "%s"
        local hash = GetHashKey(model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(100) end
        local veh = CreateVehicle(hash, coords.x, coords.y, coords.z + 0.5, GetEntityHeading(targetPed), true, true)
        SetVehicleOnGroundProperly(veh)
        AttachEntityToEntity(veh, targetPed, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        SetModelAsNoLongerNeeded(hash)
    ]], targetId, vehicleModel))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Attached " .. vehicleModel .. " to player " .. targetId)
end, table.unpack(attachCarVehicles))

MachoMenuButton(Vehicle[1], "Explode Player Vehicle", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) and IsPedInAnyVehicle(targetPed, false) then
            local vehicle = GetVehiclePedIsIn(targetPed, false)
            if DoesEntityExist(vehicle) then
                local coords = GetEntityCoords(vehicle)
                AddExplosion(coords.x, coords.y, coords.z, 1, 1.0, true, false, 0.5)
            end
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Exploded vehicle of player " .. targetId)
end)

MachoMenuButton(Vehicle[1], "Steal Player Vehicle", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) and IsPedInAnyVehicle(targetPed, false) then
            local vehicle = GetVehiclePedIsIn(targetPed, false)
            if DoesEntityExist(vehicle) then
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 0)
            end
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Stealing vehicle of player " .. targetId)
end)

MachoMenuButton(Vehicle[1], "Kick Player From Vehicle", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) and IsPedInAnyVehicle(targetPed, false) then
            TaskLeaveVehicle(targetPed, GetVehiclePedIsIn(targetPed, false), 64)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Kicked player " .. targetId .. " from vehicle.")
end)

-- [ Player Trolling ]
MachoMenuButton(Server[1], "Send Player To Sky", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            local coords = GetEntityCoords(targetPed)
            SetEntityCoordsNoOffset(targetPed, coords.x, coords.y, coords.z + 500.0, false, false, false)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Sent player " .. targetId .. " to sky.")
end)

MachoMenuButton(Server[1], "Explode Player (Single)", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            local coords = GetEntityCoords(targetPed)
            AddOwnedExplosion(PlayerPedId(), coords.x, coords.y, coords.z, 6, 2.0, true, false, 0.0)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Exploded player " .. targetId)
end)

MachoMenuButton(Server[1], "Launch Player (Single)", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) and not IsPedInAnyVehicle(targetPed, false) then
            ApplyForceToEntity(targetPed, 1, 0.0, 0.0, 100.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Launched player " .. targetId)
end)

MachoMenuButton(Server[1], "Cage Player (Single)", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local pos = GetEntityCoords(GetPlayerPed(targetPlayer))
        RequestModel('prop_gascage01')
        while not HasModelLoaded('prop_gascage01') do Wait(0) end
        if HasModelLoaded('prop_gascage01') then
            local cage = CreateObject(GetHashKey('prop_gascage01'), pos.x, pos.y, pos.z, true, true, true)
            FreezeEntityPosition(cage, true)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Caged player " .. targetId)
end)

MachoMenuButton(Server[1], "Glitch Player (Single)", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            for i = 1, 5 do
                local coords = GetEntityCoords(targetPed)
                SetEntityCoordsNoOffset(targetPed, coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z + 2.0, false, false, false)
                Wait(50)
            end
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Glitched player " .. targetId)
end)

MachoMenuButton(Server[1], "Fling Player", function()
    local targetId = GetValidPlayerID()
    if not targetId then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Enter a valid Player ID.")
        return
    end
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
        local targetPlayer = GetPlayerFromServerId(%d)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            ApplyForceToEntity(targetPed, 1, math.random(-50, 50), math.random(-50, 50), 80.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
        end
    ]], targetId))
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Flung player " .. targetId)
end)

-- [ Player Wardrobe / Model ]
local blossomPedModels = {
    "player_zero","player_one","player_two","ig_lamardavis","ig_jimmydisanto",
    "ig_amandatownley","ig_tracydisanto","ig_ronsch","ig_wade","ig_davenorton",
    "ig_stevehains","ig_devin","ig_floyd","ig_chef","ig_lestercrest",
    "a_c_chop","ig_brad","s_m_y_cop_01","s_f_y_cop_01","s_m_y_swat_01",
    "s_m_y_sheriff_01","s_f_y_sheriff_01","s_m_y_hwaycop_01","s_m_m_fibsec_01",
    "s_m_m_paramedic_01","s_m_y_fireman_01","s_m_m_doctor_01",
    "s_m_y_construct_01","s_m_m_pilot_02","s_f_y_airhostess_01",
    "s_m_y_business_01","s_f_y_business_01",
    "g_m_y_mexgoon_02","g_m_y_ballaorig_01","g_m_y_ballasout_01",
    "g_f_y_ballas_01","g_m_y_ballaeast_01","g_m_y_famca_01","g_m_y_famdnf_01",
    "g_m_y_mexgoon_01","g_m_y_mexgoon_03","g_m_y_lost_01","g_m_y_lost_02",
    "g_f_y_lost_01","s_m_y_marine_01","s_m_y_marine_02","s_m_y_marine_03",
    "s_m_y_prismuscl_01","s_m_m_prisguard_01","s_m_m_ciasec_01","s_m_m_security_01",
    "s_m_m_janitor","a_m_m_tramp_01","a_f_m_tramp_01","s_f_y_hooker_01",
    "s_f_y_hooker_02","a_m_y_beach_01","a_f_y_beach_01","a_m_y_tourist_01",
    "a_f_y_tourist_01","a_m_y_skater_01","a_m_y_hipster_01","a_f_y_hipster_01",
    "s_m_m_bouncer_01","mp_m_shopkeep_01","s_m_y_chef_01","s_m_y_barman_01",
    "s_m_y_waiter_01","s_m_y_xmech_02","s_m_m_trucker_01","s_m_m_gardener_01",
    "a_m_m_farmer_01","s_m_y_dockwork_01","s_m_y_garbage","s_m_m_postal_01",
    "s_m_m_pilot_01","s_m_y_hwaycop_01","s_m_m_ciasec_01","s_f_y_scrubs_01",
    "a_m_m_hillbilly_02","a_m_m_hiker_01","a_f_m_hiker_01",
    "a_m_m_golfer_01","a_f_m_golfer_01","a_m_m_tennis_01","a_f_m_tennis_01"
}
local blossomPedNames = {
    "Michael","Franklin","Trevor","Lamar","Jimmy","Amanda","Tracey","Ron","Wade","Dave Norton",
    "Steve Haines","Devin Weston","Floyd","Chef","Lester","Chop","Brad",
    "Police Male","Police Female","SWAT","Sheriff Male","Sheriff Female",
    "Highway Cop","FIB Male","Paramedic","Firefighter","Doctor",
    "Construction Worker","Pilot Male","Air Hostess","Business Male","Business Female",
    "Street Dealer","Gang 1","Gang 2","Gang Female","Ballas 1","Families 1","Families 2",
    "Vagos 1","Vagos 2","Lost MC 1","Lost MC 2","Lost MC Female",
    "Army 1","Army 2","Army 3","Prisoner","Prison Guard","CIA","Security","Janitor",
    "Hobo Male","Hobo Female","Prostitute 1","Prostitute 2",
    "Beach Male","Beach Female","Tourist Male","Tourist Female","Skater",
    "Hipster Male","Hipster Female","Bouncer","Shopkeeper","Chef","Bartender","Waiter",
    "Mechanic","Trucker","Gardener","Farmer","Dock Worker","Trash Worker",
    "Postal Worker","Pilot","Air Hostess 2","Cop Traffic","Cop 2","Agent 2","Reporter 2",
    "Hunter","Hiker Male","Hiker Female","Golfer Male","Golfer Female","Tennis Male","Tennis Female"
}

MachoMenuDropDown(Server[1], "Ped Models", function(index)
    if blossomPedModels[index] then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
            local hash = GetHashKey("%s")
            RequestModel(hash)
            while not HasModelLoaded(hash) do Wait(100) end
            SetPlayerModel(PlayerId(), hash)
            SetModelAsNoLongerNeeded(hash)
        ]], blossomPedModels[index]))
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Changed to " .. blossomPedNames[index])
    end
end, table.unpack(blossomPedNames))

MachoMenuButton(Server[1], "Copy Appearance", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function AsDfGhJkLqWe()
                local ZxCvBnMqWeRt = %d
                local UiOpAsDfGhJk = GetPlayerPed
                local QwErTyUiOpAs = PlayerPedId
                local DfGhJkLqWeRt = DoesEntityExist
                local ErTyUiOpAsDf = ClonePedToTarget

                local TyUiOpAsDfGh = UiOpAsDfGhJk(ZxCvBnMqWeRt)
                if DfGhJkLqWeRt(TyUiOpAsDfGh) then
                    local YpAsDfGhJkLq = QwErTyUiOpAs()
                    ErTyUiOpAsDf(TyUiOpAsDfGh, YpAsDfGhJkLq)
                end
            end

            AsDfGhJkLqWe()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)



-- ═══════════════════════════════════════════════════════
--  SERVER TAB — PLAYER (by Server ID)
-- ═══════════════════════════════════════════════════════

-- [ Player Actions (continued) ]
MachoMenuButton(Server[1], "Kill Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function UiLpKjHgFdSaTrEq()
                local RvTyUiOpAsDfGhJ = %d

                local dFrTgYhUjIkLoPl = CreateThread
                dFrTgYhUjIkLoPl(function()
                    Wait(0)

                    local ZxCvBnMaSdFgTrEq = GetPlayerPed
                    local TyUiOpAsDfGhJkLz = GetEntityCoords
                    local QwErTyUiOpAsDfGh = ShootSingleBulletBetweenCoords
                    local pEd = ZxCvBnMaSdFgTrEq(RvTyUiOpAsDfGhJ)

                    if not pEd or not DoesEntityExist(pEd) then return end

                    local tArGeT = TyUiOpAsDfGhJkLz(pEd)
                    local oRiGiN = vector3(tArGeT.x, tArGeT.y, tArGeT.z + 2.0)

                    QwErTyUiOpAsDfGh(
                        oRiGiN.x, oRiGiN.y, oRiGiN.z,
                        tArGeT.x, tArGeT.y, tArGeT.z,
                        500.0,
                        true,
                        GetHashKey("WEAPON_ASSAULTRIFLE"),
                        PlayerPedId(),
                        true,
                        false,
                        -1.0
                    )
                end)
            end

            UiLpKjHgFdSaTrEq()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Taze Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function UiLpKjHgFdSaTrEq()
                local RvTyUiOpAsDfGhJ = %d

                local dFrTgYhUjIkLoPl = CreateThread
                dFrTgYhUjIkLoPl(function()
                    Wait(0)

                    local ZxCvBnMaSdFgTrEq = GetPlayerPed
                    local TyUiOpAsDfGhJkLz = GetEntityCoords
                    local QwErTyUiOpAsDfGh = ShootSingleBulletBetweenCoords
                    local pEd = ZxCvBnMaSdFgTrEq(RvTyUiOpAsDfGhJ)

                    if not pEd or not DoesEntityExist(pEd) then return end

                    local tArGeT = TyUiOpAsDfGhJkLz(pEd)
                    local oRiGiN = vector3(tArGeT.x, tArGeT.y, tArGeT.z + 2.0)

                    QwErTyUiOpAsDfGh(
                        oRiGiN.x, oRiGiN.y, oRiGiN.z,
                        tArGeT.x, tArGeT.y, tArGeT.z,
                        0,
                        true,
                        GetHashKey("WEAPON_STUNGUN"),
                        PlayerPedId(),
                        true,
                        false,
                        -1.0
                    )
                end)
            end

            UiLpKjHgFdSaTrEq()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Cage Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function CageSinglePlayer()
                local player = %d
                CreateThread(function()
                    local target = PlayerPedId(player)
                    local pos = GetEntityCoords(GetPlayerPed(player))
                    local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(player), 0, 0, -0.4)
                    
                    RequestModel('prop_gascage01')
                    while not HasModelLoaded('prop_gascage01') do
                        RequestModel('prop_gascage01')
                        Wait(0)
                    end
                    
                    if HasModelLoaded('prop_gascage01') then
                        local cage = CreateObject(GetHashKey('prop_gascage01'), pos.x, pos.y, pos.z, true, true, true)
                        FreezeEntityPosition(cage, true)
                        SetEntityVisible(cage, false, true)
                    end
                end)
            end
            
            CageSinglePlayer()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Explode Player (DETECTABLE)", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function TzYuIoPlMnBvCxZa()
                local iOpAsDfGhJkLzXcV = %d

                local ZqWeRtYuIoPlMnB = CreateThread
                ZqWeRtYuIoPlMnB(function()
                    Wait(0)

                    local jBtWxFhPoZuR = GetPlayerPed
                    local mWjErTbYcLoU = GetEntityCoords
                    local aSdFgTrEqWzXcVb = AddExplosion

                    local pEd = jBtWxFhPoZuR(iOpAsDfGhJkLzXcV)
                    if not pEd or not DoesEntityExist(pEd) then return end

                    local coords = mWjErTbYcLoU(pEd)
                    aSdFgTrEqWzXcVb(coords.x, coords.y, coords.z, 6, 10.0, true, false, 1.0)
                end)
            end

            TzYuIoPlMnBvCxZa()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Give All Nearby Objects", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function TzYuIoPlMnBvCxZa()
                local xWcErTvBnMzLp = %d

                local aGhJkLpOiUyTr = _G.GetPlayerPed
                local bUiOpLkJhGfDs = _G.DoesEntityExist
                local cPzWsXcEdCvBnM = _G.GetEntityCoords
                local dRtYuIoPlMnBgF = _G.SetEntityCoords
                local eAsDfGhJkLqWe = _G.RequestControlOfEntity or RequestCtrlOverEntity
                local fZxCvBnMqWeRt = _G.NetworkRequestControlOfEntity
                local gXcVbNmZqWeRt = _G.SetEntityAsMissionEntity

                local function iRequest(obj)
                    fZxCvBnMqWeRt(obj)
                    eAsDfGhJkLqWe(obj)
                    gXcVbNmZqWeRt(obj, true, true)
                end

                CreateThread(function()
                    Wait(0)

                    local targetPed = aGhJkLpOiUyTr(xWcErTvBnMzLp)
                    if not bUiOpLkJhGfDs(targetPed) then return end
                    local coords = cPzWsXcEdCvBnM(targetPed)

                    for obj in EnumerateObjects() do
                        if bUiOpLkJhGfDs(obj) then
                            iRequest(obj)
                            dRtYuIoPlMnBgF(obj, coords.x, coords.y, coords.z, false, false, false, false)
                        end
                    end
                end)
            end

            TzYuIoPlMnBvCxZa()

        ]]):format(targetPlayer))
    end
end)

MachoMenuButton(Server[1], "Teleport To Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", ([[
            local function GhJkUiOpLzXcVbNm()
                local kJfHuGtFrDeSwQa = %d
                local oXyBkVsNzQuH = GetPlayerPed
                local zXcVbNmQwErTyUi = GetEntityCoords
                local xAsDfGhJkLpOiU = SetEntityCoords

                local myPed = PlayerPedId()
                local targetPed = oXyBkVsNzQuH(kJfHuGtFrDeSwQa)
                local targetCoords = zXcVbNmQwErTyUi(targetPed)

                xAsDfGhJkLpOiU(myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
            end

            GhJkUiOpLzXcVbNm()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Kick From Vehicle", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("oxmysql") and "oxmysql") or (CheckResource("monitor") and "monitor") or "any", ([[
            local function GhJkUiOpLzXcVbNm()
                local kJfHuGtFrDeSwQa = %d
                local oXyBkVsNzQuH = _G.GetPlayerPed
                local yZaSdFgHjKlQ = _G.GetVehiclePedIsIn
                local wQeRtYuIoPlMn = _G.PlayerPedId
                local cVbNmQwErTyUiOp = _G.SetVehicleExclusiveDriver_2
                local ghjawrusdgddsaf = _G.SetPedIntoVehicle

                local targetPed = oXyBkVsNzQuH(kJfHuGtFrDeSwQa)
                local veh = yZaSdFgHjKlQ(targetPed, 0)

                local function nMzXcVbNmQwErTy(func, ...)
                    local _print = print
                    local function errorHandler(ex)
                        -- _print("SCRIPT ERROR: " .. ex)
                    end

                    local argsStr = ""
                    for _, v in ipairs({...}) do
                        if type(v) == "string" then
                            argsStr = argsStr .. "\"" .. v .. "\", "
                        elseif type(v) == "number" or type(v) == "boolean" then
                            argsStr = argsStr .. tostring(v) .. ", "
                        else
                            argsStr = argsStr .. tostring(v) .. ", "
                        end
                    end
                    argsStr = argsStr:sub(1, -3)

                    local script = string.format("return func(%%s)", argsStr)
                    local fn, err = load(script, "@pipboy.lua", "t", { func = func })
                    if not fn then
                        -- _print("Error loading script: " .. err)
                        return nil
                    end

                    local success, result = xpcall(function() return fn() end, errorHandler)
                    if not success then
                        -- _print("Error executing script: " .. result)
                        return nil
                    else
                        return result
                    end
                end

                if veh ~= 0 then
                    Wait(100)
                    nMzXcVbNmQwErTy(cVbNmQwErTyUiOp, veh, wQeRtYuIoPlMn(), 1)
                    ghjawrusdgddsaf(wQeRtYuIoPlMn(), veh, -1)
                    
                    Wait(100)
                    nMzXcVbNmQwErTy(cVbNmQwErTyUiOp, veh, 0, 0)
                end
            end

            GhJkUiOpLzXcVbNm()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Freeze Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("oxmysql") and "oxmysql") or (CheckResource("monitor") and "monitor") or "any", ([[
            local function VtQzAfXyYu()
                local RqTfBnLpZo = %d
                local FgTrLpYwVs = GetPlayerPed
                local EoKdCjXqMg = GetEntityCoords
                local ZbLpVnXwQr = GetClosestVehicle
                local WqErTyUiOp = PlayerPedId
                local AsDfGhJkLz = SetPedIntoVehicle
                local PoLiKjUhYg = ClearPedTasks
                local QwErTyUiOp = NetworkRequestControlOfEntity
                local CxZvBnMaSd = GetGameTimer
                local VcMnBgTrEl = Wait
                local TeAxSpDoMj = AttachEntityToEntityPhysically
                local wfjaw4dtdu = CreateThread
                local tgtPed = FgTrLpYwVs(RqTfBnLpZo)
                local tgtCoords = EoKdCjXqMg(tgtPed)
                local veh = ZbLpVnXwQr(tgtCoords, 150.0, 0, 70)

                if not veh or veh == 0 then
                    print("No vehicle nearby | Aborting.")
                    return
                end

                QwErTyUiOp(veh)
                Wait(100)
                AsDfGhJkLz(WqErTyUiOp(), veh, -1)
                VcMnBgTrEl(200)
                PoLiKjUhYg(WqErTyUiOp())

                wfjaw4dtdu(function()
                    local start = CxZvBnMaSd()
                    while CxZvBnMaSd() - start < 3000 do
                        TeAxSpDoMj(
                            veh,
                            tgtPed,
                            0.0, 0.0, 10.0,
                            10.0, 0.0, 0.0,
                            true, 0, 0,
                            false, false, 0
                        )
                        VcMnBgTrEl(0)
                    end
                end)
            end

            VtQzAfXyYu()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Glitch Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("oxmysql") and "oxmysql") or (CheckResource("monitor") and "monitor") or "any", ([[
            local function TnXmLoPrVq()
                local kPdZoWxNq = %d

                local LsKjHgFdSa = GetPlayerPed
                local ZxCvBnMaQw = GetEntityCoords
                local QtRvBnPoLs = GetClosestVehicle
                local VcBgTrElMn = PlayerPedId
                local KdJfGhTyPl = SetPedIntoVehicle
                local TrLkUyIoPl = ClearPedTasks
                local MwZlQxNsTp = NetworkRequestControlOfEntity
                local AsYtGhUiMn = GetGameTimer
                local WqErTyUiOp = Wait
                local TeAxSpDoMj = AttachEntityToEntityPhysically
                local CrXeTqLpVi = CreateThread

                local xGyPtMdLoB = LsKjHgFdSa(kPdZoWxNq)
                local zUiRpXlAsV = ZxCvBnMaQw(xGyPtMdLoB)
                local jCaBnErYqK = QtRvBnPoLs(zUiRpXlAsV, 150.0, 0, 70)

                if not jCaBnErYqK or jCaBnErYqK == 0 then
                    print("No vehicle nearby | Aborting.")
                    return
                end

                MwZlQxNsTp(veh)
                Wait(100)
                KdJfGhTyPl(VcBgTrElMn(), jCaBnErYqK, -1)
                WqErTyUiOp(200)
                TrLkUyIoPl(VcBgTrElMn())

                CrXeTqLpVi(function()
                    local tGhXpLsMkA = AsYtGhUiMn()
                    local bErXnPoVlC = 3000

                    while AsYtGhUiMn() - tGhXpLsMkA < bErXnPoVlC do
                        TeAxSpDoMj(
                            jCaBnErYqK,
                            xGyPtMdLoB,
                            0, 0, 0,
                            2000.0, 1460.928, 1000.0,
                            10.0, 88.0, 600.0,
                            true, true, true, false, 0
                        )
                        WqErTyUiOp(0)
                    end
                end)
            end

            TnXmLoPrVq()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuButton(Server[1], "Limbo Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("oxmysql") and "oxmysql") or (CheckResource("monitor") and "monitor") or "any", ([[
            local function VyTxQzWsCr()
                local lDxNzVrMpY = %d

                local FgTrLpYwVs = GetPlayerPed
                local EoKdCjXqMg = GetEntityCoords
                local ZbLpVnXwQr = GetClosestVehicle
                local WqErTyUiOp = PlayerPedId
                local AsDfGhJkLz = SetPedIntoVehicle
                local PoLiKjUhYg = ClearPedTasks
                local QwErTyUiOp = NetworkRequestControlOfEntity
                local CxZvBnMaSd = GetGameTimer
                local VcMnBgTrEl = Wait
                local TeAxSpDoMj = AttachEntityToEntityPhysically
                local CrXeTqLpVi = CreateThread

                local vUpYrTnMwE = FgTrLpYwVs(lDxNzVrMpY)
                local xAoPqMnBgR = EoKdCjXqMg(vUpYrTnMwE)
                local cHvBzNtEkQ = ZbLpVnXwQr(xAoPqMnBgR, 150.0, 0, 70)

                if not cHvBzNtEkQ or cHvBzNtEkQ == 0 then
                    print("No vehicle nearby | Aborting.")
                    return
                end

                QwErTyUiOp(veh)
                Wait(100)
                AsDfGhJkLz(WqErTyUiOp(), cHvBzNtEkQ, -1)
                VcMnBgTrEl(200)
                PoLiKjUhYg(WqErTyUiOp())

                CrXeTqLpVi(function()
                    local kYqPmTnVzL = CxZvBnMaSd()
                    local yTbQrXlMwA = 3000
                    local hFrMxWnZuE, dEjKzTsYnL = 180.0, 8888.0

                    while CxZvBnMaSd() - kYqPmTnVzL < yTbQrXlMwA do
                        TeAxSpDoMj(
                            cHvBzNtEkQ,
                            vUpYrTnMwE,
                            0, 0, 0,
                            hFrMxWnZuE, dEjKzTsYnL, 1000.0,
                            true, true, true, true, 0
                        )
                        VcMnBgTrEl(0)
                    end
                end)
            end

            VyTxQzWsCr()
        ]]):format(targetPlayer))
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Player ID or Player Not Found")
    end
end)

MachoMenuCheckbox(Server[1], "Spectate Player", function()
    local targetServerId = GetValidPlayerID()
    local targetPlayer = GetPlayerIndexFromServerId(targetServerId)
    if targetPlayer and targetPlayer >= 0 then
        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", ([[
            if AsDfGhJkLpZx == nil then AsDfGhJkLpZx = false end
            AsDfGhJkLpZx = true

            local function QwErTyUiOpAs()
                if AsDfGhJkLpZx == nil then AsDfGhJkLpZx = false end
                AsDfGhJkLpZx = true

                local a1B2c3D4e5F6 = CreateThread
                a1B2c3D4e5F6(function()
                    local k9L8m7N6b5V4 = GetPlayerPed
                    local x1Y2z3Q4w5E6 = GetEntityCoords
                    local u7I8o9P0a1S2 = RequestAdditionalCollisionAtCoord
                    local f3G4h5J6k7L8 = NetworkSetInSpectatorMode
                    local m9N8b7V6c5X4 = NetworkOverrideCoordsAndHeading
                    local r1T2y3U4i5O6 = Wait
                    local l7P6o5I4u3Y2 = DoesEntityExist

                    while AsDfGhJkLpZx and not Unloaded do
                        local d3F4g5H6j7K8 = %d
                        local v6C5x4Z3a2S1 = k9L8m7N6b5V4(d3F4g5H6j7K8)

                        if v6C5x4Z3a2S1 and l7P6o5I4u3Y2(v6C5x4Z3a2S1) then
                            local b1N2m3K4l5J6 = x1Y2z3Q4w5E6(v6C5x4Z3a2S1, false)
                            u7I8o9P0a1S2(b1N2m3K4l5J6.x, b1N2m3K4l5J6.y, b1N2m3K4l5J6.z)
                            f3G4h5J6k7L8(true, v6C5x4Z3a2S1)
                            m9N8b7V6c5X4(x1Y2z3Q4w5E6(v6C5x4Z3a2S1))
                        end

                        r1T2y3U4i5O6(0)
                    end

                    f3G4h5J6k7L8(false, 0)
                end)
            end

            QwErTyUiOpAs()

        ]]):format(targetPlayer))
    end
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        AsDfGhJkLpZx = false
    ]])
end)

-- MachoMenuButton(Server[2], "Crash Nearby [Don't Spam]", function()
--     MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("FiniAC") and "FiniAC") or (CheckResource("WaveShield") and "WaveShield") or (CheckResource("monitor") and "monitor") or "any", [[
--         local function sfehwq34rw7td()
--             local Nwq7sd2Lkq0pHkfa = CreateThread
--             Nwq7sd2Lkq0pHkfa(function()
--                 local hAx9qTeMnb = CreateThread
--                 local Jf9uZxcTwa = _G.CreatePed
--                 local VmzKo3sRt7 = _G.PlayerPedId
--                 local LuZx8nqTys = _G.GetEntityCoords
--                 local QksL02vPdt = _G.GetEntityHeading
--                 local Tmn1rZxOq8 = _G.SetEntityCoordsNoOffset
--                 local PfQsXoEr6b = _G.GiveWeaponToPed
--                 local WvNay7Zplm = _G.TaskParachute
--                 local DjRq08bKxu = _G.FreezeEntityPosition
--                 local EkLnZmcTya = _G.GetHashKey
--                 local YdWxVoEna3 = _G.RequestModel
--                 local GcvRtPszYp = _G.HasModelLoaded
--                 local MnVc8sQaLp = _G.SetEntityAsMissionEntity
--                 local KrXpTuwq9c = _G.SetModelAsNoLongerNeeded
--                 local VdNzWqbEyf = _G.DoesEntityExist
--                 local AxWtRuLskz = _G.DeleteEntity
--                 local OplKvms9te = _G.Wait
--                 local BnQvKdsLxa = _G.GetGroundZFor_3dCoord
--                 local VmxrLa9Ewt = _G.ApplyForceToEntity
--                 local fwafWAefAg = _G.SetEntityVisible
--                 local awrt325etd = _G.SetBlockingOfNonTemporaryEvents
--                 local awfaw4eraq = _G.SetEntityAlpha

--                 hAx9qTeMnb(function()
--                     local QxoZnmWlae = VmzKo3sRt7()
--                     local EzPwqLtYas = LuZx8nqTys(QxoZnmWlae)
--                     local GzqLpAxdsv = QksL02vPdt(QxoZnmWlae)
--                     local ZtXmqLpEas = EzPwqLtYas.z + 1600.0

--                     Tmn1rZxOq8(QxoZnmWlae, EzPwqLtYas.x, EzPwqLtYas.y, ZtXmqLpEas, false, false, false)

--                     VmxrLa9Ewt(QxoZnmWlae, 1, 0.0, 0.0, 5000.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)

--                     OplKvms9te(250)

--                     DjRq08bKxu(QxoZnmWlae, true)

--                     PfQsXoEr6b(QxoZnmWlae, `gadget_parachute`, 1, false, true)
--                     WvNay7Zplm(QxoZnmWlae, false)

--                     DjRq08bKxu(QxoZnmWlae, true)

--                     local UixZpvLoa9 = EkLnZmcTya("player_one")
--                     YdWxVoEna3(UixZpvLoa9)
--                     while not GcvRtPszYp(UixZpvLoa9) do OplKvms9te(0) end

--                     local TzsPlcxQam = {}
--                     for K9wo = 1, 130 do
--                         local IuxErv7Pqa = Jf9uZxcTwa(28, UixZpvLoa9, EzPwqLtYas.x, EzPwqLtYas.y, EzPwqLtYas.z, GzqLpAxdsv, true, true)
--                         if IuxErv7Pqa and VdNzWqbEyf(IuxErv7Pqa) then
--                             MnVc8sQaLp(IuxErv7Pqa, true, true)
--                             awrt325etd(IuxErv7Pqa, true)
--                             awfaw4eraq(IuxErv7Pqa, 0, true)
--                             table.insert(TzsPlcxQam, IuxErv7Pqa)
--                         end
--                         OplKvms9te(1)
--                     end

--                     KrXpTuwq9c(UixZpvLoa9)

--                     OplKvms9te(300)

--                     for _, bTzyPq7Xsl in ipairs(TzsPlcxQam) do
--                         if VdNzWqbEyf(bTzyPq7Xsl) then
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                             AxWtRuLskz(bTzyPq7Xsl)
--                         end
--                     end

--                     DjRq08bKxu(QxoZnmWlae, false)
--                     local ZkxyPqtLs0, Zfound = BnQvKdsLxa(EzPwqLtYas.x, EzPwqLtYas.y, EzPwqLtYas.z + 100.0, 0, false)
--                     if not ZkxyPqtLs0 then
--                         Zfound = EzPwqLtYas.z
--                     end
--                     OplKvms9te(1000)

--                     Tmn1rZxOq8(QxoZnmWlae, EzPwqLtYas.x, EzPwqLtYas.y, Zfound + 1.0, false, false, false)
--                     DjRq08bKxu(QxoZnmWlae, true)

--                     DjRq08bKxu(QxoZnmWlae, false)
--                 end)
--             end)
--         end

--         sfehwq34rw7td()
--     ]])
-- end)


-- [ Everyone ]
MachoMenuButton(Server[2], "Cone Everyone", function() 
    local model = GetHashKey("prop_roadcone02a")
    RequestModel(model) 
    while not HasModelLoaded(model) do 
        Wait(0) 
    end

    local function putCone(ped)
        if not DoesEntityExist(ped) or IsEntityDead(ped) then return end
        local pos = GetEntityCoords(ped)
        local obj = CreateObject(model, pos.x, pos.y, pos.z, true, true, false)
        SetEntityAsMissionEntity(obj, true, true)
        SetEntityCollision(obj, false, false)
        SetEntityInvincible(obj, true)
        SetEntityCanBeDamaged(obj, false)
        local head = GetPedBoneIndex(ped, 31086)
        AttachEntityToEntity(obj, ped, head, 0.0, 0.0, 0.25, 0.0, 0.0, 0.0, 
            false, false, true, false, 2, true)
    end

    putCone(PlayerPedId())

    for _, pid in ipairs(GetActivePlayers()) do
        putCone(GetPlayerPed(pid))
    end

    local peds = GetGamePool and GetGamePool('CPed') or {}
    for _, ped in ipairs(peds) do
        if not IsPedAPlayer(ped) then
            putCone(ped)
        end
    end
end)

MachoMenuButton(Server[2], "Explode All Players", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function fGhJkLpOiUzXcVb()
            local aSdFgHjKlQwErTy = GetActivePlayers
            local pOiUyTrEeRwQtYy = DoesEntityExist
            local mNbVcCxZzLlKkJj = GetEntityCoords
            local hGjFkDlSaPwOeIr = AddOwnedExplosion
            local tYuIoPaSdFgHjKl = PlayerPedId

            local eRtYuIoPlMnBvCx = aSdFgHjKlQwErTy()
            for _, wQeRtYuIoPlMnBv in ipairs(eRtYuIoPlMnBvCx) do
                local yUiOpAsDfGhJkLz = GetPlayerPed(wQeRtYuIoPlMnBv)
                if pOiUyTrEeRwQtYy(yUiOpAsDfGhJkLz) and yUiOpAsDfGhJkLz ~= tYuIoPaSdFgHjKl() then
                    local nMzXcVbNmQwErTy = mNbVcCxZzLlKkJj(yUiOpAsDfGhJkLz)
                    hGjFkDlSaPwOeIr(
                        tYuIoPaSdFgHjKl(),
                        nMzXcVbNmQwErTy.x,
                        nMzXcVbNmQwErTy.y,
                        nMzXcVbNmQwErTy.z,
                        6,     -- Explosion type
                        1.0,   -- Damage scale
                        true,  -- Audible
                        false, -- Invisible
                        0.0    -- Camera shake
                    )
                end
            end
        end

        fGhJkLpOiUzXcVb()
    ]])
end)

MachoMenuButton(Server[2], "Explode All Vehicles", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function uYhGtFrEdWsQaZx()
            local rTyUiOpAsDfGhJk = GetGamePool
            local xAsDfGhJkLpOiUz = DoesEntityExist
            local cVbNmQwErTyUiOp = GetEntityCoords
            local vBnMkLoPiUyTrEw = AddOwnedExplosion
            local nMzXcVbNmQwErTy = PlayerPedId

            local _vehicles = rTyUiOpAsDfGhJk("CVehicle")
            local me = nMzXcVbNmQwErTy()
            for _, veh in ipairs(_vehicles) do
                if xAsDfGhJkLpOiUz(veh) then
                    local pos = cVbNmQwErTyUiOp(veh)
                    vBnMkLoPiUyTrEw(me, pos.x, pos.y, pos.z, 6, 2.0, true, false, 0.0)
                end
            end
        end
        uYhGtFrEdWsQaZx()
    ]])
end)

MachoMenuButton(Server[2], "Delete All Vehicles", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function zXcVbNmQwErTyUi()
            local aSdFgHjKlQwErTy = GetGamePool
            local pOiUyTrEeRwQtYy = DoesEntityExist
            local mNbVcCxZzLlKkJj = NetworkRequestControlOfEntity
            local hGjFkDlSaPwOeIr = NetworkHasControlOfEntity
            local tYuIoPaSdFgHjKl = DeleteEntity
            local yUiOpAsDfGhJkLz = PlayerPedId
            local uIoPaSdFgHjKlQw = GetVehiclePedIsIn
            local gJkLoPiUyTrEqWe = GetGameTimer
            local fDeSwQaZxCvBnMm = Wait

            local me = yUiOpAsDfGhJkLz()
            local myVeh = uIoPaSdFgHjKlQw(me, false)

            local vehicles = aSdFgHjKlQwErTy("CVehicle")
            for _, veh in ipairs(vehicles) do
                if pOiUyTrEeRwQtYy(veh) and veh ~= myVeh then
                    mNbVcCxZzLlKkJj(veh)
                    local timeout = gJkLoPiUyTrEqWe() + 500
                    while not hGjFkDlSaPwOeIr(veh) and gJkLoPiUyTrEqWe() < timeout do
                        fDeSwQaZxCvBnMm(0)
                    end
                    if hGjFkDlSaPwOeIr(veh) then
                        tYuIoPaSdFgHjKl(veh)
                    end
                end
            end
        end
        zXcVbNmQwErTyUi()
    ]])
end)

MachoMenuButton(Server[2], "Delete All Peds", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function qWeRtYuIoPlMnBv()
            local zXcVbNmQwErTyUi = GetGamePool
            local aSdFgHjKlQwErTy = DoesEntityExist
            local pOiUyTrEeRwQtYy = DeleteEntity
            local mNbVcCxZzLlKkJj = PlayerId
            local hGjFkDlSaPwOeIr = GetPlayerPed
            local tYuIoPaSdFgHjKl = NetworkRequestControlOfEntity
            local yUiOpAsDfGhJkLz = NetworkHasControlOfEntity
            local uIoPaSdFgHjKlQw = GetGameTimer
            local gJkLoPiUyTrEqWe = Wait
            local vBnMkLoPiUyTrEw = IsPedAPlayer

            local me = hGjFkDlSaPwOeIr(mNbVcCxZzLlKkJj())
            local peds = zXcVbNmQwErTyUi("CPed")

            for _, ped in ipairs(peds) do
                if aSdFgHjKlQwErTy(ped) and ped ~= me and not vBnMkLoPiUyTrEw(ped) then
                    tYuIoPaSdFgHjKl(ped)
                    local timeout = uIoPaSdFgHjKlQw() + 500
                    while not yUiOpAsDfGhJkLz(ped) and uIoPaSdFgHjKlQw() < timeout do
                        gJkLoPiUyTrEqWe(0)
                    end
                    if yUiOpAsDfGhJkLz(ped) then
                        pOiUyTrEeRwQtYy(ped)
                    end
                end
            end
        end
        qWeRtYuIoPlMnBv()
    ]])
end)

MachoMenuButton(Server[2], "Delete All Objects", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function mNqAzXwSeRdTfGy()
            local rTyUiOpAsDfGhJk = GetGamePool
            local xAsDfGhJkLpOiUz = DoesEntityExist
            local cVbNmQwErTyUiOp = DeleteEntity
            local vBnMkLoPiUyTrEw = NetworkRequestControlOfEntity
            local nMzXcVbNmQwErTy = NetworkHasControlOfEntity
            local yUiOpAsDfGhJkLz = GetGameTimer
            local uIoPaSdFgHjKlQw = Wait

            local objects = rTyUiOpAsDfGhJk("CObject")
            for _, obj in ipairs(objects) do
                if xAsDfGhJkLpOiUz(obj) then
                    vBnMkLoPiUyTrEw(obj)
                    local timeout = yUiOpAsDfGhJkLz() + 500
                    while not nMzXcVbNmQwErTy(obj) and yUiOpAsDfGhJkLz() < timeout do
                        uIoPaSdFgHjKlQw(0)
                    end
                    if nMzXcVbNmQwErTy(obj) then
                        cVbNmQwErTyUiOp(obj)
                    end
                end
            end
        end
        mNqAzXwSeRdTfGy()
    ]])
end)

MachoMenuButton(Server[2], "Cage All Players", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function CageAllPlayers()
            local players = GetActivePlayers()
            for _, playerId in ipairs(players) do
                CreateThread(function()
                    local player = playerId
                    local target = PlayerPedId(player)
                    local pos = GetEntityCoords(GetPlayerPed(player))
                    local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(player), 0, 0, -0.4)
                    
                    RequestModel('prop_gascage01')
                    while not HasModelLoaded('prop_gascage01') do
                        RequestModel('prop_gascage01')
                        Wait(0)
                    end
                    
                    if HasModelLoaded('prop_gascage01') then
                        local cage = CreateObject(GetHashKey('prop_gascage01'), pos.x, pos.y, pos.z, true, true, true)
                        FreezeEntityPosition(cage, true)
                        SetEntityVisible(cage, false, true)
                    end
                end)
            end
        end
        
        CageAllPlayers()
    ]])
end)

MachoMenuCheckbox(Server[2], "Kill Everyone", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if aSwDeFgHiJkLoPx == nil then aSwDeFgHiJkLoPx = false end
        aSwDeFgHiJkLoPx = true

        local function pLoMkIjUhbGyTf()
            local mAxPlErOy = PlayerPedId()
            local rVtNiUcEx = GetHashKey("WEAPON_ASSAULTRIFLE")
            local gBvTnCuXe = 100
            local aSdFgHjKl = 1000.0
            local lKjHgFdSa = 300.0

            local nBxMzLqPw = CreateThread
            local qWeRtYuiOp = ShootSingleBulletBetweenCoords

            nBxMzLqPw(function()
                while aSwDeFgHiJkLoPx and not Unloaded do
                    Wait(gBvTnCuXe)
                    local bNmZxSwEd = GetActivePlayers()
                    local jUiKoLpMq = GetEntityCoords(mAxPlErOy)

                    for _, wQaSzXedC in ipairs(bNmZxSwEd) do
                        local zAsXcVbNm = GetPlayerPed(wQaSzXedC)
                        if zAsXcVbNm ~= mAxPlErOy and DoesEntityExist(zAsXcVbNm) and not IsPedDeadOrDying(zAsXcVbNm, true) then
                            local eDxCfVgBh = GetEntityCoords(zAsXcVbNm)
                            if #(eDxCfVgBh - jUiKoLpMq) <= lKjHgFdSa then
                                local xScVbNmAz = vector3(
                                    eDxCfVgBh.x + (math.random() - 0.5) * 0.8,
                                    eDxCfVgBh.y + (math.random() - 0.5) * 0.8,
                                    eDxCfVgBh.z + 1.2
                                )

                                local dFgHjKlZx = vector3(
                                    eDxCfVgBh.x,
                                    eDxCfVgBh.y,
                                    eDxCfVgBh.z + 0.2
                                )

                                qWeRtYuiOp(
                                    xScVbNmAz.x, xScVbNmAz.y, xScVbNmAz.z,
                                    dFgHjKlZx.x, dFgHjKlZx.y, dFgHjKlZx.z,
                                    aSdFgHjKl,
                                    true,
                                    rVtNiUcEx,
                                    mAxPlErOy,
                                    true,
                                    false,
                                    100.0
                                )
                            end
                        end
                    end
                end
            end)
        end

        pLoMkIjUhbGyTf()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        aSwDeFgHiJkLoPx = false
    ]])
end)

MachoMenuCheckbox(Server[2], "Permanent Kill Everyone", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if qWeRtYuIoPlMnAb == nil then qWeRtYuIoPlMnAb = false end
        qWeRtYuIoPlMnAb = true

        local function bZxLmNcVqPeTyUi()
            local vBnMkLoPi = PlayerPedId()
            local wQaSzXedC = GetHashKey("WEAPON_TRANQUILIZER")
            local eDxCfVgBh = 100
            local lKjHgFdSa = 1000.0
            local mAxPlErOy = 300.0

            local rTwEcVzUi = CreateThread
            local oPiLyKuJm = ShootSingleBulletBetweenCoords

            rTwEcVzUi(function()
                while qWeRtYuIoPlMnAb and not Unloaded do
                    Wait(eDxCfVgBh)
                    local aSdFgHjKl = GetActivePlayers()
                    local xSwEdCvFr = GetEntityCoords(vBnMkLoPi)

                    for _, bGtFrEdCv in ipairs(aSdFgHjKl) do
                        local nMzXcVbNm = GetPlayerPed(bGtFrEdCv)
                        if nMzXcVbNm ~= vBnMkLoPi and DoesEntityExist(nMzXcVbNm) and not IsPedDeadOrDying(nMzXcVbNm, true) then
                            local zAsXcVbNm = GetEntityCoords(nMzXcVbNm)
                            if #(zAsXcVbNm - xSwEdCvFr) <= mAxPlErOy then
                                local jUiKoLpMq = vector3(
                                    zAsXcVbNm.x + (math.random() - 0.5) * 0.8,
                                    zAsXcVbNm.y + (math.random() - 0.5) * 0.8,
                                    zAsXcVbNm.z + 1.2
                                )

                                local cReAtEtHrEaD = vector3(
                                    zAsXcVbNm.x,
                                    zAsXcVbNm.y,
                                    zAsXcVbNm.z + 0.2
                                )

                                oPiLyKuJm(
                                    jUiKoLpMq.x, jUiKoLpMq.y, jUiKoLpMq.z,
                                    cReAtEtHrEaD.x, cReAtEtHrEaD.y, cReAtEtHrEaD.z,
                                    lKjHgFdSa,
                                    true,
                                    wQaSzXedC,
                                    vBnMkLoPi,
                                    true,
                                    false,
                                    100.0
                                )
                            end
                        end
                    end
                end
            end)
        end

        bZxLmNcVqPeTyUi()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        qWeRtYuIoPlMnAb = false
    ]])
end)

-- Teleport Tab

-- ═══════════════════════════════════════════════════════
--  WEAPON TAB
-- ═══════════════════════════════════════════════════════

-- [ Mods ]
MachoMenuCheckbox(Weapon[1], "Infinite Ammo", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if LkJgFdSaQwErTy == nil then LkJgFdSaQwErTy = false end
        LkJgFdSaQwErTy = true

        local function qUwKZopRM8()
            if LkJgFdSaQwErTy == nil then LkJgFdSaQwErTy = false end
            LkJgFdSaQwErTy = true

            local MnBvCxZlKjHgFd = CreateThread
            MnBvCxZlKjHgFd(function()
                local AsDfGhJkLzXcVb = PlayerPedId
                local QwErTyUiOpAsDf = SetPedInfiniteAmmoClip
                local ZxCvBnMqWeRtYu = GetSelectedPedWeapon
                local ErTyUiOpAsDfGh = GetAmmoInPedWeapon
                local GhJkLzXcVbNmQw = SetPedAmmo

                while LkJgFdSaQwErTy and not Unloaded do
                    local ped = AsDfGhJkLzXcVb()
                    local weapon = ZxCvBnMqWeRtYu(ped)

                    QwErTyUiOpAsDf(ped, true)

                    if ErTyUiOpAsDfGh(ped, weapon) <= 0 then
                        GhJkLzXcVbNmQw(ped, weapon, 250)
                    end

                    Wait(0)
                end
            end)
        end

        qUwKZopRM8()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        LkJgFdSaQwErTy = false

        local function yFBN9pqXcL()
            local AsDfGhJkLzXcVb = PlayerPedId
            local QwErTyUiOpAsDf = SetPedInfiniteAmmoClip
            QwErTyUiOpAsDf(AsDfGhJkLzXcVb(), false)
        end

        yFBN9pqXcL()
    ]])
end)

MachoMenuCheckbox(Weapon[1], "Explosive Ammo (DETECTABLE)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if QzWxEdCvTrBnYu == nil then QzWxEdCvTrBnYu = false end
        QzWxEdCvTrBnYu = true

        local function WpjLRqtm28()
            if QzWxEdCvTrBnYu == nil then QzWxEdCvTrBnYu = false end
            QzWxEdCvTrBnYu = true

            local UyJhNbGtFrVbCx = CreateThread
            UyJhNbGtFrVbCx(function()
                local HnBvFrTgYhUzKl = PlayerPedId
                local TmRgVbYhNtKjLp = GetPedLastWeaponImpactCoord
                local JkLpHgTfCvXzQa = AddOwnedExplosion

                while QzWxEdCvTrBnYu and not Unloaded do
                    local CvBnYhGtFrLpKm = HnBvFrTgYhUzKl()
                    local XsWaQzEdCvTrBn, PlKoMnBvCxZlQj = TmRgVbYhNtKjLp(CvBnYhGtFrLpKm)

                    if XsWaQzEdCvTrBn then
                        JkLpHgTfCvXzQa(CvBnYhGtFrLpKm, PlKoMnBvCxZlQj.x, PlKoMnBvCxZlQj.y, PlKoMnBvCxZlQj.z, 6, 1.0, true, false, 0.0)
                    end

                    Wait(0)
                end
            end)
        end

        WpjLRqtm28()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        QzWxEdCvTrBnYu = false
    ]])
end)

MachoMenuCheckbox(Weapon[1], "Oneshot Kill", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if RfGtHyUjMiKoLp == nil then RfGtHyUjMiKoLp = false end
        RfGtHyUjMiKoLp = true

        local function xUQp7AK0tv()
            local PlMnBvCxZaSdFg = CreateThread
            PlMnBvCxZaSdFg(function()
                local ZxCvBnNmLkJhGf = GetSelectedPedWeapon
                local AsDfGhJkLzXcVb = SetWeaponDamageModifier
                local ErTyUiOpAsDfGh = PlayerPedId

                while RfGtHyUjMiKoLp do
                    if Unloaded then
                        RfGtHyUjMiKoLp = false
                        break
                    end

                    local Wp = ZxCvBnNmLkJhGf(ErTyUiOpAsDfGh())
                    if Wp and Wp ~= 0 then
                        AsDfGhJkLzXcVb(Wp, 1000.0)
                    end

                    Wait(0)
                end
            end)
        end

        xUQp7AK0tv()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        RfGtHyUjMiKoLp = false
        local ZxCvBnNmLkJhGf = GetSelectedPedWeapon
        local AsDfGhJkLzXcVb = SetWeaponDamageModifier
        local ErTyUiOpAsDfGh = PlayerPedId
        local Wp = ZxCvBnNmLkJhGf(ErTyUiOpAsDfGh())
        if Wp and Wp ~= 0 then
            AsDfGhJkLzXcVb(Wp, 1.0)
        end
    ]])
end)

local WeaponHandle = MachoMenuInputbox(Weapon[2], "Weapon:", "...")

MachoMenuCheckbox(Weapon[1], "No Reload", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_NoReload == nil then _G.blossom_NoReload = false end
        _G.blossom_NoReload = true
        CreateThread(function()
            while _G.blossom_NoReload and not Unloaded do
                local ped = PlayerPedId()
                local _, weapon = GetCurrentPedWeapon(ped, true)
                if weapon ~= 0 then
                    SetPedInfiniteAmmoClip(ped, true)
                end
                Wait(0)
            end
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_NoReload = false
        SetPedInfiniteAmmoClip(PlayerPedId(), false)
    ]])
end)

MachoMenuCheckbox(Weapon[1], "Rainbow Gun", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_RainbowGun == nil then _G.blossom_RainbowGun = false end
        _G.blossom_RainbowGun = true
        CreateThread(function()
            local offset = 0.0
            while _G.blossom_RainbowGun and not Unloaded do
                offset = offset + 0.05
                local r = math.floor(127 + 127 * math.sin(offset))
                local g = math.floor(127 + 127 * math.sin(offset + 2))
                local b = math.floor(127 + 127 * math.sin(offset + 4))
                local ped = PlayerPedId()
                local _, weapon = GetCurrentPedWeapon(ped, true)
                if weapon ~= 0 then
                    SetWeaponObjectTintIndex(GetCurrentPedWeaponEntityIndex(ped), r)
                end
                Wait(50)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_RainbowGun = false
    ]])
end)

-- Weapon Spawner by Category
local WeaponCategoryLabels = {
    "Pistols", "SMGs", "Shotguns", "Rifles", "Snipers", "Heavy", "Melee", "Throwables"
}

local WeaponCategoryData = {
    ["Pistols"] = {
        { label = "Pistol",                  value = "weapon_pistol" },
        { label = "Pistol MK2",              value = "weapon_pistol_mk2" },
        { label = "Combat Pistol",           value = "weapon_combatpistol" },
        { label = "AP Pistol",               value = "weapon_appistol" },
        { label = "Stun Gun",                value = "weapon_stungun" },
        { label = "Pistol .50",              value = "weapon_pistol50" },
        { label = "SNS Pistol",              value = "weapon_snspistol" },
        { label = "Heavy Pistol",            value = "weapon_heavypistol" },
        { label = "Vintage Pistol",          value = "weapon_vintagepistol" },
        { label = "Flare Gun",               value = "weapon_flaregun" },
        { label = "Marksman Pistol",         value = "weapon_marksmanpistol" },
        { label = "Revolver",                value = "weapon_revolver" },
        { label = "Revolver MK2",            value = "weapon_revolver_mk2" },
        { label = "Double Action Revolver",  value = "weapon_doubleaction" },
    },
    ["SMGs"] = {
        { label = "Micro SMG",      value = "weapon_microsmg" },
        { label = "SMG",            value = "weapon_smg" },
        { label = "SMG MK2",        value = "weapon_smg_mk2" },
        { label = "Assault SMG",    value = "weapon_assaultsmg" },
        { label = "Combat PDW",     value = "weapon_combatpdw" },
        { label = "Machine Pistol", value = "weapon_machinepistol" },
        { label = "Mini SMG",       value = "weapon_minismg" },
    },
    ["Shotguns"] = {
        { label = "Pump Shotgun",        value = "weapon_pumpshotgun" },
        { label = "Pump Shotgun MK2",    value = "weapon_pumpshotgun_mk2" },
        { label = "Sawed-Off Shotgun",   value = "weapon_sawnoffshotgun" },
        { label = "Assault Shotgun",     value = "weapon_assaultshotgun" },
        { label = "Bullpup Shotgun",     value = "weapon_bullpupshotgun" },
        { label = "Heavy Shotgun",       value = "weapon_heavyshotgun" },
        { label = "Musket",              value = "weapon_musket" },
        { label = "Double Barrel",       value = "weapon_dbshotgun" },
        { label = "Sweeper Shotgun",     value = "weapon_autoshotgun" },
    },
    ["Rifles"] = {
        { label = "Assault Rifle",       value = "weapon_assaultrifle" },
        { label = "Assault Rifle MK2",   value = "weapon_assaultrifle_mk2" },
        { label = "Carbine Rifle",       value = "weapon_carbinerifle" },
        { label = "Carbine Rifle MK2",   value = "weapon_carbinerifle_mk2" },
        { label = "Advanced Rifle",      value = "weapon_advancedrifle" },
        { label = "Special Carbine",     value = "weapon_specialcarbine" },
        { label = "Special Carbine MK2", value = "weapon_specialcarbine_mk2" },
        { label = "Bullpup Rifle",       value = "weapon_bullpuprifle" },
        { label = "Bullpup Rifle MK2",   value = "weapon_bullpuprifle_mk2" },
        { label = "Military Rifle",      value = "weapon_militaryrifle" },
    },
    ["Snipers"] = {
        { label = "Sniper Rifle",        value = "weapon_sniperrifle" },
        { label = "Heavy Sniper",        value = "weapon_heavysniper" },
        { label = "Heavy Sniper MK2",    value = "weapon_heavysniper_mk2" },
        { label = "Marksman Rifle",      value = "weapon_marksmanrifle" },
        { label = "Marksman Rifle MK2",  value = "weapon_marksmanrifle_mk2" },
    },
    ["Heavy"] = {
        { label = "RPG",                       value = "weapon_rpg" },
        { label = "Grenade Launcher",          value = "weapon_grenadelauncher" },
        { label = "Minigun",                   value = "weapon_minigun" },
        { label = "Firework Launcher",         value = "weapon_firework" },
        { label = "Railgun",                   value = "weapon_railgun" },
        { label = "Homing Launcher",           value = "weapon_hominglauncher" },
        { label = "Compact Grenade Launcher",  value = "weapon_compactlauncher" },
        { label = "Widowmaker",                value = "weapon_widowmaker" },
    },
    ["Melee"] = {
        { label = "Knife",         value = "weapon_knife" },
        { label = "Nightstick",    value = "weapon_nightstick" },
        { label = "Hammer",        value = "weapon_hammer" },
        { label = "Bat",           value = "weapon_bat" },
        { label = "Crowbar",       value = "weapon_crowbar" },
        { label = "Golf Club",     value = "weapon_golfclub" },
        { label = "Bottle",        value = "weapon_bottle" },
        { label = "Dagger",        value = "weapon_dagger" },
        { label = "Hatchet",       value = "weapon_hatchet" },
        { label = "Machete",       value = "weapon_machete" },
        { label = "Switchblade",   value = "weapon_switchblade" },
        { label = "Battle Axe",    value = "weapon_battleaxe" },
        { label = "Pool Cue",      value = "weapon_poolcue" },
        { label = "Wrench",        value = "weapon_wrench" },
    },
    ["Throwables"] = {
        { label = "Grenade",           value = "weapon_grenade" },
        { label = "Sticky Bomb",       value = "weapon_stickybomb" },
        { label = "Proximity Mine",    value = "weapon_proxmine" },
        { label = "Tear Gas",          value = "weapon_teargas" },
        { label = "Molotov",           value = "weapon_molotov" },
        { label = "Jerry Can",         value = "weapon_petrolcan" },
        { label = "Snowball",          value = "weapon_snowball" },
        { label = "Pipe Bomb",         value = "weapon_pipebomb" },
        { label = "BZ Gas",            value = "weapon_bzgas" },
    },
}

for _, catName in ipairs(WeaponCategoryLabels) do
    local catWeapons = WeaponCategoryData[catName]
    if catWeapons then
        local labels = {}
        local values = {}
        for _, w in ipairs(catWeapons) do
            table.insert(labels, w.label)
            table.insert(values, w.value)
        end
        MachoMenuDropDown(Weapon[2], catName, function(index)
            local weaponHash = values[index]
            if weaponHash then
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
                    local ped = PlayerPedId()
                    local wHash = GetHashKey("%s")
                    GiveWeaponToPed(ped, wHash, 250, false, true)
                ]], weaponHash))
            end
        end, table.unpack(labels))
    end
end


-- [ Utility ]
MachoMenuButton(Weapon[1], "Remove All Weapons", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        RemoveAllPedWeapons(PlayerPedId(), true)
    ]])
end)

MachoMenuButton(Weapon[1], "Refill Ammo", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function RefillAllAmmo()
            local ped = PlayerPedId()
            for _, weapon in ipairs(GetPedWeapons(ped)) do
                SetPedAmmo(ped, weapon, 9999)
            end
        end
        -- Fallback: give max ammo to current weapon
        local ped = PlayerPedId()
        local _, currentWeapon = GetCurrentPedWeapon(ped, true)
        SetPedAmmo(ped, currentWeapon, 9999)
        -- Try all common weapons
        local weapons = {
            GetHashKey("weapon_pistol"), GetHashKey("weapon_smg"), GetHashKey("weapon_assaultrifle"),
            GetHashKey("weapon_carbinerifle"), GetHashKey("weapon_heavysniper"), GetHashKey("weapon_rpg"),
            GetHashKey("weapon_minigun"), GetHashKey("weapon_shotgun"), GetHashKey("weapon_pumpshotgun"),
        }
        for _, wHash in ipairs(weapons) do
            if HasPedGotWeapon(ped, wHash, false) then
                SetPedAmmo(ped, wHash, 9999)
            end
        end
    ]])
end)

MachoMenuDropDown(Weapon[1], "Aiming Style", function(index)
    AnimationDropDownChoice = index
end,
    "Default",
    "Gangster",
    "Wild",
    "Red Neck"
)

MachoMenuButton(Weapon[1], "Apply Aiming Style", function()
    local Animation = AnimationMap[AnimationDropDownChoice]
    if not Animation then return end

    MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or "any", ([[
        local function vXK2dPLR07()
            local UiOpAsDfGhJkLz = PlayerPedId
            local PlMnBvCxZaSdFg = GetHashKey
            local QwErTyUiOpAsDf = SetWeaponAnimationOverride

            local MnBvCxZaSdFgHj = PlMnBvCxZaSdFg("%s")
            QwErTyUiOpAsDf(UiOpAsDfGhJkLz(), MnBvCxZaSdFgHj)
        end

        vXK2dPLR07()

    ]]):format(Animation.hash))
end)

-- Additional Weapon Features from Wiped

-- [ Spawner ]
MachoMenuButton(Weapon[2], "Spawn Weapon", function()
    local weaponName = MachoMenuGetInputbox(WeaponSpawnerBox)

    if weaponName and weaponName ~= "" then
        MachoInjectResource((CheckResource("monitor") and "monitor") or "any", string.format([[
            local function GiveWeapon()
                local ped = PlayerPedId()
                local weapon = GetHashKey("%s")
                local XeCwVrBtNuMyLk = GiveWeaponToPed
                XeCwVrBtNuMyLk(ped, weapon, 250, true, true)
            end

            GiveWeapon()
        ]], weaponName))
    end
end)

-- local WeaponHandle = MachoMenuInputbox(Weapon[2], "Weapon:", "...")

-- MachoMenuButton(Weapon[2], "Spawn Weapon", function()
--     local gNpLmKjHyUjIqEr = MachoMenuGetInputbox(WeaponSpawnerBox)

--     if gNpLmKjHyUjIqEr and gNpLmKjHyUjIqEr ~= "" then
--         MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[        
--             local function ntQ3LbwJxZ()
--                 local LpKoMnJbHuGyTf = CreateThread
--                 LpKoMnJbHuGyTf(function()
--                     local SxWaQzEdCvTrBn = GetHashKey
--                     local TyGuJhNbVfCrDx = RequestWeaponAsset
--                     local UiJmNbGtFrVbCx = HasWeaponAssetLoaded
--                     local XeCwVrBtNuMyLk = GiveWeaponToPed
--                     local IuJhNbVgTfCvXz = PlayerPedId

--                     local DfGhJkLpPoNmZx = SxWaQzEdCvTrBn("%s")
--                     TyGuJhNbVfCrDx(DfGhJkLpPoNmZx, 31, 0)

--                     while not UiJmNbGtFrVbCx(DfGhJkLpPoNmZx) do
--                         Wait(0)
--                     end

--                     XeCwVrBtNuMyLk(IuJhNbVgTfCvXz(), DfGhJkLpPoNmZx, 250, true, true)
--                 end)
--             end

--             ntQ3LbwJxZ()
--         ]], gNpLmKjHyUjIqEr))
--     end
-- end)

local AnimationDropDownChoice = 0

local AnimationMap = {
    [0] = { name = "Default", hash = "MP_F_Freemode" },
    [1] = { name = "Gangster", hash = "Gang1H" },
    [2] = { name = "Wild", hash = "GangFemale" },
    [3] = { name = "Red Neck", hash = "Hillbilly" }
}

-- ═══════════════════════════════════════════════════════
--  VEHICLE TAB
-- ═══════════════════════════════════════════════════════

-- [ Mods / Toggles ]
MachoMenuCheckbox(Vehicle[1], "Vehicle Godmode", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if zXcVbNmQwErTyUi == nil then zXcVbNmQwErTyUi = false end
        zXcVbNmQwErTyUi = true

        local function LWyZoXRbqK()
            local LkJhGfDsAzXcVb = CreateThread
            LkJhGfDsAzXcVb(function()
                while zXcVbNmQwErTyUi and not Unloaded do
                    local QwErTyUiOpAsDfG = GetVehiclePedIsIn
                    local TyUiOpAsDfGhJkL = PlayerPedId
                    local AsDfGhJkLzXcVbN = SetEntityInvincible

                    local vehicle = QwErTyUiOpAsDfG(TyUiOpAsDfGhJkL(), false)
                    if vehicle and vehicle ~= 0 then
                        AsDfGhJkLzXcVbN(vehicle, true)
                    end
                    Wait(0)
                end
            end)
        end

        LWyZoXRbqK()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        zXcVbNmQwErTyUi = false
        local QwErTyUiOpAsDfG = GetVehiclePedIsIn
        local TyUiOpAsDfGhJkL = PlayerPedId
        local AsDfGhJkLzXcVbN = SetEntityInvincible

        local vehicle = QwErTyUiOpAsDfG(TyUiOpAsDfGhJkL(), true)
        if vehicle and vehicle ~= 0 then
            AsDfGhJkLzXcVbN(vehicle, false)
        end
    ]])
end)

MachoMenuCheckbox(Vehicle[2], "Vehicle Invincible", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_VehInvinc == nil then _G.blossom_VehInvinc = false end
        _G.blossom_VehInvinc = true
        CreateThread(function()
            while _G.blossom_VehInvinc and not Unloaded do
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                if veh and veh ~= 0 then
                    SetEntityInvincible(veh, true)
                    SetVehicleCanBeVisiblyDamaged(veh, false)
                    SetVehicleCanBreak(veh, false)
                    SetEntityProofs(veh, true, true, true, true, true, true, true, true)
                end
                Wait(0)
            end
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, true)
            if veh and veh ~= 0 then
                SetEntityInvincible(veh, false)
                SetVehicleCanBeVisiblyDamaged(veh, true)
                SetVehicleCanBreak(veh, true)
                SetEntityProofs(veh, false, false, false, false, false, false, false, false)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_VehInvinc = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Force Vehicle Engine", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if GhYtReFdCxWaQzLp == nil then GhYtReFdCxWaQzLp = false end
        GhYtReFdCxWaQzLp = true

        local function OpAsDfGhJkLzXcVb()
            local lMnbVcXzZaSdFg = CreateThread
            lMnbVcXzZaSdFg(function()
                local QwErTyUiOp         = _G.PlayerPedId
                local AsDfGhJkLz         = _G.GetVehiclePedIsIn
                local TyUiOpAsDfGh       = _G.GetVehiclePedIsTryingToEnter
                local ZxCvBnMqWeRtYu     = _G.SetVehicleEngineOn
                local ErTyUiOpAsDfGh     = _G.SetVehicleUndriveable
                local KeEpOnAb           = _G.SetVehicleKeepEngineOnWhenAbandoned
                local En_g_Health_Get    = _G.GetVehicleEngineHealth
                local En_g_Health_Set    = _G.SetVehicleEngineHealth
                local En_g_Degrade_Set   = _G.SetVehicleEngineCanDegrade
                local No_Hotwire_Set     = _G.SetVehicleNeedsToBeHotwired

                local function _tick(vh)
                    if vh and vh ~= 0 then
                        No_Hotwire_Set(vh, false)
                        En_g_Degrade_Set(vh, false)
                        ErTyUiOpAsDfGh(vh, false)
                        KeEpOnAb(vh, true)

                        local eh = En_g_Health_Get(vh)
                        if (not eh) or eh < 300.0 then
                            En_g_Health_Set(vh, 900.0)
                        end

                        ZxCvBnMqWeRtYu(vh, true, true, true)
                    end
                end

                while GhYtReFdCxWaQzLp and not Unloaded do
                    local p  = QwErTyUiOp()

                    _tick(AsDfGhJkLz(p, false))
                    _tick(TyUiOpAsDfGh(p))
                    _tick(AsDfGhJkLz(p, true))

                    Wait(0)
                end
            end)
        end

        OpAsDfGhJkLzXcVb()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        GhYtReFdCxWaQzLp = false
        local v = GetVehiclePedIsIn(PlayerPedId(), false)
        if v and v ~= 0 then
            SetVehicleKeepEngineOnWhenAbandoned(v, false)
            SetVehicleEngineCanDegrade(v, true)
            SetVehicleUndriveable(v, false)
        end
    ]])
end)


MachoMenuCheckbox(Vehicle[1], "Vehicle Auto Repair", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if PlAsQwErTyUiOp == nil then PlAsQwErTyUiOp = false end
        PlAsQwErTyUiOp = true

        local function uPkqLXTm98()
            local QwErTyUiOpAsDf = CreateThread
            QwErTyUiOpAsDf(function()
                while PlAsQwErTyUiOp and not Unloaded do
                    local AsDfGhJkLzXcVb = PlayerPedId
                    local LzXcVbNmQwErTy = GetVehiclePedIsIn
                    local VbNmLkJhGfDsAz = SetVehicleFixed
                    local MnBvCxZaSdFgHj = SetVehicleDirtLevel

                    local ped = AsDfGhJkLzXcVb()
                    local vehicle = LzXcVbNmQwErTy(ped, false)
                    if vehicle and vehicle ~= 0 then
                        VbNmLkJhGfDsAz(vehicle)
                        MnBvCxZaSdFgHj(vehicle, 0.0)
                    end

                    Wait(0)
                end
            end)
        end

        uPkqLXTm98()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        PlAsQwErTyUiOp = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Freeze Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if LzKxWcVbNmQwErTy == nil then LzKxWcVbNmQwErTy = false end
        LzKxWcVbNmQwErTy = true

        local function WkQ79ZyLpT()
            local tYhGtFrDeSwQaZx = CreateThread
            local xCvBnMqWeRtYuIo = PlayerPedId
            local aSdFgHjKlZxCvBn = GetVehiclePedIsIn
            local gKdNqLpYxMiV = FreezeEntityPosition
            local jBtWxFhPoZuR = Wait

            tYhGtFrDeSwQaZx(function()
                while LzKxWcVbNmQwErTy and not Unloaded do
                    local VbNmLkJhGfDsAzX = xCvBnMqWeRtYuIo()
                    local IoPlMnBvCxZaSdF = aSdFgHjKlZxCvBn(VbNmLkJhGfDsAzX, false)
                    if IoPlMnBvCxZaSdF and IoPlMnBvCxZaSdF ~= 0 then
                        gKdNqLpYxMiV(IoPlMnBvCxZaSdF, true)
                    end
                    jBtWxFhPoZuR(0)
                end
            end)
        end

        WkQ79ZyLpT()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        LzKxWcVbNmQwErTy = false

        local function i7qWlBXtPo()
            local yUiOpAsDfGhJkLz = PlayerPedId
            local QwErTyUiOpAsDfG = GetVehiclePedIsIn
            local FdSaPlMnBvCxZlK = FreezeEntityPosition

            local pEdRfTgYhUjIkOl = yUiOpAsDfGhJkLz()
            local zXcVbNmQwErTyUi = QwErTyUiOpAsDfG(pEdRfTgYhUjIkOl, true)
            if zXcVbNmQwErTyUi and zXcVbNmQwErTyUi ~= 0 then
                FdSaPlMnBvCxZlK(zXcVbNmQwErTyUi, false)
            end
        end

        i7qWlBXtPo()
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Vehicle Hop", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if NuRqVxEyKiOlZm == nil then NuRqVxEyKiOlZm = false end
        NuRqVxEyKiOlZm = true

        local function qPTnXLZKyb()
            local ZlXoKmVcJdBeTr = CreateThread
            ZlXoKmVcJdBeTr(function()
                while NuRqVxEyKiOlZm and not Unloaded do
                    local GvHnMzLoPqAxEs = PlayerPedId
                    local DwZaQsXcErDfGt = GetVehiclePedIsIn
                    local BtNhUrLsEkJmWq = IsDisabledControlPressed
                    local PlZoXvNyMcKwQi = ApplyForceToEntity

                    local GtBvCzHnUkYeWr = GvHnMzLoPqAxEs()
                    local OaXcJkWeMzLpRo = DwZaQsXcErDfGt(GtBvCzHnUkYeWr, false)

                    if OaXcJkWeMzLpRo and OaXcJkWeMzLpRo ~= 0 and BtNhUrLsEkJmWq(0, 22) then
                        PlZoXvNyMcKwQi(OaXcJkWeMzLpRo, 1, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 0, true, true, true, true, true)
                    end

                    Wait(0)
                end
            end)
        end

        qPTnXLZKyb()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        NuRqVxEyKiOlZm = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Rainbow Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if GxRpVuNzYiTq == nil then GxRpVuNzYiTq = false end
        GxRpVuNzYiTq = true

        local function jqX7TvYzWq()
            local WvBnMpLsQzTx = GetGameTimer
            local VcZoPwLsEkRn = math.floor
            local DfHkLtQwAzCx = math.sin
            local PlJoQwErTgYs = CreateThread
            local MzLxVoKsUyNz = GetVehiclePedIsIn
            local EyUiNkOpLtRg = PlayerPedId
            local KxFwEmTrZpYq = DoesEntityExist
            local UfBnDxCrQeTg = SetVehicleCustomPrimaryColour
            local BvNzMxLoPwEq = SetVehicleCustomSecondaryColour

            local yGfTzLkRn = 1.0

            local function HrCvWbXuNz(freq)
                local color = {}
                local t = WvBnMpLsQzTx() / 1000
                color.r = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 0) * 127 + 128)
                color.g = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 2) * 127 + 128)
                color.b = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 4) * 127 + 128)
                return color
            end

            PlJoQwErTgYs(function()
                while GxRpVuNzYiTq and not Unloaded do
                    local ped = EyUiNkOpLtRg()
                    local veh = MzLxVoKsUyNz(ped, false)
                    if veh and veh ~= 0 and KxFwEmTrZpYq(veh) then
                        local rgb = HrCvWbXuNz(yGfTzLkRn)
                        UfBnDxCrQeTg(veh, rgb.r, rgb.g, rgb.b)
                        BvNzMxLoPwEq(veh, rgb.r, rgb.g, rgb.b)
                    end
                    Wait(0)
                end
            end)
        end

        jqX7TvYzWq()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        GxRpVuNzYiTq = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Drift Mode (Hold Shift)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if MqTwErYuIoLp == nil then MqTwErYuIoLp = false end
        MqTwErYuIoLp = true

        local function PlRtXqJm92()
            local XtFgDsQwAzLp = CreateThread
            local UiOpAsDfGhKl = PlayerPedId
            local JkHgFdSaPlMn = GetVehiclePedIsIn
            local WqErTyUiOpAs = IsControlPressed
            local AsZxCvBnMaSd = DoesEntityExist
            local KdJfGvBhNtMq = SetVehicleReduceGrip

            XtFgDsQwAzLp(function()
                while MqTwErYuIoLp and not Unloaded do
                    Wait(0)
                    local ped = UiOpAsDfGhKl()
                    local veh = JkHgFdSaPlMn(ped, false)
                    if veh ~= 0 and AsZxCvBnMaSd(veh) then
                        if WqErTyUiOpAs(0, 21) then
                            KdJfGvBhNtMq(veh, true)
                        else
                            KdJfGvBhNtMq(veh, false)
                        end
                    end
                end
            end)
        end

        PlRtXqJm92()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        MqTwErYuIoLp = false
        local ZtQwErTyUiOp = PlayerPedId
        local DfGhJkLzXcVb = GetVehiclePedIsIn
        local VbNmAsDfGhJk = DoesEntityExist
        local NlJkHgFdSaPl = SetVehicleReduceGrip

        local ped = ZtQwErTyUiOp()
        local veh = DfGhJkLzXcVb(ped, false)
        if veh ~= 0 and VbNmAsDfGhJk(veh) then
            NlJkHgFdSaPl(veh, false)
        end
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Easy Handling", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if NvGhJkLpOiUy == nil then NvGhJkLpOiUy = false end
        NvGhJkLpOiUy = true

        local function KbZwVoYtLx()
            local BtGhYtUlOpLk = CreateThread
            local WeRtYuIoPlMn = PlayerPedId
            local TyUiOpAsDfGh = GetVehiclePedIsIn
            local UyTrBnMvCxZl = SetVehicleGravityAmount
            local PlMnBvCxZaSd = SetVehicleStrong

            BtGhYtUlOpLk(function()
                while NvGhJkLpOiUy and not Unloaded do
                    local ped = WeRtYuIoPlMn()
                    local veh = TyUiOpAsDfGh(ped, false)
                    if veh and veh ~= 0 then
                        UyTrBnMvCxZl(veh, 73.0)
                        PlMnBvCxZaSd(veh, true)
                    end
                    Wait(0)
                end

                local ped = WeRtYuIoPlMn()
                local veh = TyUiOpAsDfGh(ped, false)
                if veh and veh ~= 0 then
                    UyTrBnMvCxZl(veh, 9.8)
                    PlMnBvCxZaSd(veh, false)
                end
            end)
        end

        KbZwVoYtLx()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        NvGhJkLpOiUy = false
        local UyTrBnMvCxZl = SetVehicleGravityAmount
        local PlMnBvCxZaSd = SetVehicleStrong
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            UyTrBnMvCxZl(veh, 9.8)
            PlMnBvCxZaSd(veh, false)
        end
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Shift Boost", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if QwErTyUiOpSh == nil then QwErTyUiOpSh = false end
        QwErTyUiOpSh = true

        local function ZxCvBnMmLl()
            local aAaBbCcDdEe = CreateThread
            local fFfGgGgHhIi = Wait
            local jJkKlLmMnNo = PlayerPedId
            local pPqQrRsStTu = IsPedInAnyVehicle
            local vVwWxXyYzZa = GetVehiclePedIsIn
            local bBcCdDeEfFg = IsDisabledControlJustPressed
            local sSeEtTvVbBn = SetVehicleForwardSpeed

            aAaBbCcDdEe(function()
                while QwErTyUiOpSh and not Unloaded do
                    local _ped = jJkKlLmMnNo()
                    if pPqQrRsStTu(_ped, false) then
                        local _veh = vVwWxXyYzZa(_ped, false)
                        if _veh ~= 0 and bBcCdDeEfFg(0, 21) then
                            sSeEtTvVbBn(_veh, 150.0)
                        end
                    end
                    fFfGgGgHhIi(0)
                end
            end)
        end

        ZxCvBnMmLl()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        QwErTyUiOpSh = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Instant Breaks", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if VkLpOiUyTrEq == nil then VkLpOiUyTrEq = false end
        VkLpOiUyTrEq = true

        local function YgT7FrqXcN()
            local ZxSeRtYhUiOp = CreateThread
            local LkJhGfDsAzXv = PlayerPedId
            local PoLkJhBgVfCd = GetVehiclePedIsIn
            local ErTyUiOpAsDf = IsDisabledControlPressed
            local GtHyJuKoLpMi = IsPedInAnyVehicle
            local VbNmQwErTyUi = SetVehicleForwardSpeed

            ZxSeRtYhUiOp(function()
                while VkLpOiUyTrEq and not Unloaded do
                    local ped = LkJhGfDsAzXv()
                    local veh = PoLkJhBgVfCd(ped, false)
                    if veh and veh ~= 0 then
                        if ErTyUiOpAsDf(0, 33) and GtHyJuKoLpMi(ped, false) then
                            VbNmQwErTyUi(veh, 0.0)
                        end
                    end
                    Wait(0)
                end
            end)
        end

        YgT7FrqXcN()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        VkLpOiUyTrEq = false
    ]])
end)

MachoMenuCheckbox(Vehicle[1], "Unlimited Fuel", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if BlNkJmLzXcVb == nil then BlNkJmLzXcVb = false end
        BlNkJmLzXcVb = true

        local function LqWyXpR3tV()
            local TmPlKoMiJnBg = CreateThread
            local ZxCvBnMaSdFg = PlayerPedId
            local YhUjIkOlPlMn = IsPedInAnyVehicle
            local VcXzQwErTyUi = GetVehiclePedIsIn
            local KpLoMkNjBhGt = DoesEntityExist
            local JkLzXcVbNmAs = SetVehicleFuelLevel

            TmPlKoMiJnBg(function()
                while BlNkJmLzXcVb and not Unloaded do
                    local ped = ZxCvBnMaSdFg()
                    if YhUjIkOlPlMn(ped, false) then
                        local veh = VcXzQwErTyUi(ped, false)
                        if KpLoMkNjBhGt(veh) then
                            JkLzXcVbNmAs(veh, 100.0)
                        end
                    end
                    Wait(100)
                end
            end)
        end

        LqWyXpR3tV()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        BlNkJmLzXcVb = false
    ]])
end)

local LicensePlateHandle = MachoMenuInputbox(Vehicle[2], "License Plate:", "...")
MachoMenuCheckbox(Vehicle[2], "Infinite Fuel (Toggle)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_InfFuel == nil then _G.blossom_InfFuel = false end
        _G.blossom_InfFuel = true
        CreateThread(function()
            while _G.blossom_InfFuel and not Unloaded do
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                if veh and veh ~= 0 then
                    SetVehicleFuelLevel(veh, 100.0)
                end
                Wait(1000)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_InfFuel = false
    ]])
end)

MachoMenuCheckbox(Vehicle[2], "Engine Power Boost", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if _G.blossom_EngPow == nil then _G.blossom_EngPow = false end
        _G.blossom_EngPow = true
        CreateThread(function()
            while _G.blossom_EngPow and not Unloaded do
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                if veh and veh ~= 0 then
                    SetVehicleStrong(veh, true)
                    SetVehicleGravityAmount(veh, 60.0)
                end
                Wait(0)
            end
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh and veh ~= 0 then
                SetVehicleStrong(veh, false)
                SetVehicleGravityAmount(veh, 9.8)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        _G.blossom_EngPow = false
    ]])
end)

-- Emote Tab

-- [ Actions ]
MachoMenuButton(Vehicle[2], "Repair Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function FgN7LqxZyP()
            local aBcD = PlayerPedId
            local eFgH = GetVehiclePedIsIn
            local iJkL = SetVehicleFixed
            local mNoP = SetVehicleDeformationFixed

            local p = aBcD()
            local v = eFgH(p, false)
            if v and v ~= 0 then
                iJkL(v)
                mNoP(v)
            end
        end

        FgN7LqxZyP()
    ]])
end)

MachoMenuButton(Vehicle[2], "Flip Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function vXmYLT9pq2()
            local a = PlayerPedId
            local b = GetVehiclePedIsIn
            local c = GetEntityHeading
            local d = SetEntityRotation

            local ped = a()
            local veh = b(ped, false)
            if veh and veh ~= 0 then
                d(veh, 0.0, 0.0, c(veh))
            end
        end

        vXmYLT9pq2()
    ]])
end)

MachoMenuButton(Vehicle[2], "Clean Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function qPwRYKz7mL()
            local a = PlayerPedId
            local b = GetVehiclePedIsIn
            local c = SetVehicleDirtLevel

            local ped = a()
            local veh = b(ped, false)
            if veh and veh ~= 0 then
                c(veh, 0.0)
            end
        end

        qPwRYKz7mL()
    ]])
end)

MachoMenuButton(Vehicle[2], "Delete Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function LXpTqWvR80()
            local aQw = PlayerPedId
            local bEr = GetVehiclePedIsIn
            local cTy = DoesEntityExist
            local dUi = NetworkHasControlOfEntity
            local eOp = SetEntityAsMissionEntity
            local fAs = DeleteEntity
            local gDf = DeleteVehicle
            local hJk = SetVehicleHasBeenOwnedByPlayer

            local ped = aQw()
            local veh = bEr(ped, false)

            if veh and veh ~= 0 and cTy(veh) then
                hJk(veh, true)
                eOp(veh, true, true)

                if dUi(veh) then
                    fAs(veh)
                    gDf(veh)
                end
            end

        end

        LXpTqWvR80()
    ]])
end)

MachoMenuButton(Vehicle[2], "Toggle Vehicle Engine", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function NKzqVoXYLm()
            local a = PlayerPedId
            local b = GetVehiclePedIsIn
            local c = GetIsVehicleEngineRunning
            local d = SetVehicleEngineOn

            local ped = a()
            local veh = b(ped, false)
            if veh and veh ~= 0 then
                if c(veh) then
                    d(veh, false, true, true)
                else
                    d(veh, true, true, false)
                end
            end
        end

        NKzqVoXYLm()
    ]])
end)

MachoMenuButton(Vehicle[2], "Max Vehicle Upgrades", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function XzPmLqRnWyBtVkGhQe()
            local FnUhIpOyLkTrEzSd = PlayerPedId
            local VmBgTnQpLcZaWdEx = GetVehiclePedIsIn
            local RfDsHuNjMaLpOyBt = SetVehicleModKit
            local AqWsEdRzXcVtBnMa = SetVehicleWheelType
            local TyUiOpAsDfGhJkLz = GetNumVehicleMods
            local QwErTyUiOpAsDfGh = SetVehicleMod
            local ZxCvBnMqWeRtYuIo = ToggleVehicleMod
            local MnBvCxZaSdFgHjKl = SetVehicleWindowTint
            local LkJhGfDsQaZwXeCr = SetVehicleTyresCanBurst
            local UjMiKoLpNwAzSdFg = SetVehicleExtra
            local RvTgYhNuMjIkLoPb = DoesExtraExist

            local lzQwXcVeTrBnMkOj = FnUhIpOyLkTrEzSd()
            local jwErTyUiOpMzNaLk = VmBgTnQpLcZaWdEx(lzQwXcVeTrBnMkOj, false)
            if not jwErTyUiOpMzNaLk or jwErTyUiOpMzNaLk == 0 then return end

            RfDsHuNjMaLpOyBt(jwErTyUiOpMzNaLk, 0)
            AqWsEdRzXcVtBnMa(jwErTyUiOpMzNaLk, 7)

            for XyZoPqRtWnEsDfGh = 0, 16 do
                local uYtReWqAzXsDcVf = TyUiOpAsDfGhJkLz(jwErTyUiOpMzNaLk, XyZoPqRtWnEsDfGh)
                if uYtReWqAzXsDcVf and uYtReWqAzXsDcVf > 0 then
                    QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, XyZoPqRtWnEsDfGh, uYtReWqAzXsDcVf - 1, false)
                end
            end

            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 14, 16, false)

            local aSxDcFgHiJuKoLpM = TyUiOpAsDfGhJkLz(jwErTyUiOpMzNaLk, 15)
            if aSxDcFgHiJuKoLpM and aSxDcFgHiJuKoLpM > 1 then
                QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 15, aSxDcFgHiJuKoLpM - 2, false)
            end

            for QeTrBnMkOjHuYgFv = 17, 22 do
                ZxCvBnMqWeRtYuIo(jwErTyUiOpMzNaLk, QeTrBnMkOjHuYgFv, true)
            end

            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 23, 1, false)
            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 24, 1, false)

            for TpYuIoPlMnBvCxZq = 1, 12 do
                if RvTgYhNuMjIkLoPb(jwErTyUiOpMzNaLk, TpYuIoPlMnBvCxZq) then
                    UjMiKoLpNwAzSdFg(jwErTyUiOpMzNaLk, TpYuIoPlMnBvCxZq, false)
                end
            end

            MnBvCxZaSdFgHjKl(jwErTyUiOpMzNaLk, 1)
            LkJhGfDsQaZwXeCr(jwErTyUiOpMzNaLk, false)
        end

        XzPmLqRnWyBtVkGhQe()
    ]])
end)

MachoMenuButton(Vehicle[2], "Teleport into Closest Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function uPKcoBaEHmnK()
            local ziCFzHyzxaLX = SetPedIntoVehicle
            local YPPvDlOGBghA = GetClosestVehicle

            local Coords = GetEntityCoords(PlayerPedId())
            local vehicle = YPPvDlOGBghA(Coords.x, Coords.y, Coords.z, 15.0, 0, 70)

            if DoesEntityExist(vehicle) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                if GetPedInVehicleSeat(vehicle, -1) == 0 then
                    ziCFzHyzxaLX(PlayerPedId(), vehicle, -1)
                else
                    ziCFzHyzxaLX(PlayerPedId(), vehicle, 0)
                end
            end
        end

        uPKcoBaEHmnK()
    ]])
end)

MachoMenuButton(Vehicle[2], "Unlock Closest Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function TpLMqKtXwZ()
            local AsoYuTrBnMvCxZaQw = PlayerPedId
            local GhrTnLpKjUyVbMnZx = GetEntityCoords
            local UyeWsDcXzQvBnMaLp = GetClosestVehicle
            local ZmkLpQwErTyUiOpAs = DoesEntityExist
            local VczNmLoJhBgVfCdEx = SetEntityAsMissionEntity
            local EqWoXyBkVsNzQuH = SetVehicleDoorsLocked
            local YxZwQvTrBnMaSdFgHj = SetVehicleDoorsLockedForAllPlayers
            local RtYuIoPlMnBvCxZaSd = SetVehicleHasBeenOwnedByPlayer
            local LkJhGfDsAzXwCeVrBt = NetworkHasControlOfEntity

            local ped = AsoYuTrBnMvCxZaQw()
            local coords = GhrTnLpKjUyVbMnZx(ped)
            local veh = UyeWsDcXzQvBnMaLp(coords.x, coords.y, coords.z, 10.0, 0, 70)

            if veh and ZmkLpQwErTyUiOpAs(veh) and LkJhGfDsAzXwCeVrBt(veh) then
                VczNmLoJhBgVfCdEx(veh, true, true)
                RtYuIoPlMnBvCxZaSd(veh, true)
                EqWoXyBkVsNzQuH(veh, 1)
                YxZwQvTrBnMaSdFgHj(veh, false)
            end

        end

        TpLMqKtXwZ()
    ]])
end)

MachoMenuButton(Vehicle[2], "Lock Closest Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function tRYpZvKLxQ()
            local WqEoXyBkVsNzQuH = PlayerPedId
            local LoKjBtWxFhPoZuR = GetEntityCoords
            local VbNmAsDfGhJkLzXcVb = GetClosestVehicle
            local TyUiOpAsDfGhJkLzXc = DoesEntityExist
            local PlMnBvCxZaSdFgTrEq = SetEntityAsMissionEntity
            local KjBtWxFhPoZuRZlK = SetVehicleHasBeenOwnedByPlayer
            local AsDfGhJkLzXcVbNmQwE = SetVehicleDoorsLocked
            local QwEoXyBkVsNzQuHL = SetVehicleDoorsLockedForAllPlayers
            local ZxCvBnMaSdFgTrEqWz = NetworkHasControlOfEntity

            local ped = WqEoXyBkVsNzQuH()
            local coords = LoKjBtWxFhPoZuR(ped)
            local veh = VbNmAsDfGhJkLzXcVb(coords.x, coords.y, coords.z, 10.0, 0, 70)

            if veh and TyUiOpAsDfGhJkLzXc(veh) and ZxCvBnMaSdFgTrEqWz(veh) then
                PlMnBvCxZaSdFgTrEq(veh, true, true)
                KjBtWxFhPoZuRZlK(veh, true)
                AsDfGhJkLzXcVbNmQwE(veh, 2)
                QwEoXyBkVsNzQuHL(veh, true)
            end
        end

        tRYpZvKLxQ()
    ]])
end)

-- Additional Vehicle Features from Wiped
MachoMenuButton(Vehicle[2], "Print Custom Cars", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local allVehicles = {}
        local numVeh = GetNumResources and 0 or 0
        -- Scan all world vehicles and find custom/modded ones
        local gameVehicles = GetGamePool("CVehicle")
        for _, veh in ipairs(gameVehicles) do
            if DoesEntityExist(veh) then
                local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                if model and model ~= "CARNOTFOUND" then
                    table.insert(allVehicles, string.lower(model))
                end
            end
        end
        print("[blossom] Vehicles on server: " .. table.concat(allVehicles, ", "))
    ]])
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Custom cars printed to console (F8).")
end)


-- [ Spawning & Plate ]
MachoMenuButton(Vehicle[2], "Set License Plate", function()
    local LicensePlate = MachoMenuGetInputbox(LicensePlateHandle)

    if type(LicensePlate) == "string" and LicensePlate ~= "" then
        local injectedCode = string.format([[
            local function xKqLZVwPt9()
                local XcVbNmAsDfGhJkL = PlayerPedId
                local TyUiOpZxCvBnMzLk = GetVehiclePedIsIn
                local PoIuYtReWqAzXsDc = _G.SetVehicleNumberPlateText

                local pEd = XcVbNmAsDfGhJkL()
                local vEh = TyUiOpZxCvBnMzLk(pEd, false)

                if vEh and vEh ~= 0 then
                    PoIuYtReWqAzXsDc(vEh, "%s")
                end

            end

            xKqLZVwPt9()
        ]], LicensePlate)

        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", injectedCode)
    end
end)

local VehicleSpawnerBox = MachoMenuInputbox(Vehicle[2], "Vehicle Model:", "...")
MachoMenuButton(Vehicle[2], "Spawn Car", function()
    local VehicleModel = MachoMenuGetInputbox(VehicleSpawnerBox)

    local waveShieldRunning = GetResourceState("WaveShield") == "started"
    local lbPhoneRunning = GetResourceState("lb-phone") == "started"

    local injectedCode

    if not waveShieldRunning and lbPhoneRunning then
        injectedCode = ([[ 
            if type(CreateFrameworkVehicle) == "function" then
                local model = "%s"
                local hash = GetHashKey(model)
                local ped = PlayerPedId()
                if DoesEntityExist(ped) then
                    local coords = GetEntityCoords(ped)
                    if coords then
                        local vehicleData = {
                            vehicle = json.encode({ model = model })
                        }
                        CreateFrameworkVehicle(vehicleData, coords)
                    end
                end
            end
        ]]):format(VehicleModel)

        MachoInjectResource("lb-phone", injectedCode)

    else
        injectedCode = ([[ 
            local function XzRtVbNmQwEr()
                local tYaPlXcUvBn = PlayerPedId
                local iKoMzNbHgTr = GetEntityCoords
                local wErTyUiOpAs = GetEntityHeading
                local hGtRfEdCvBg = RequestModel
                local bNjMkLoIpUh = HasModelLoaded
                local pLkJhGfDsAq = Wait
                local sXcVbNmZlQw = GetVehiclePedIsIn
                local yUiOpAsDfGh = DeleteVehicle
                local aSxDcFgHvBn = _G.CreateVehicle
                local oLpKjHgFdSa = NetworkGetNetworkIdFromEntity
                local zMxNaLoKvRe = SetEntityAsMissionEntity
                local mVbGtRfEdCv = SetVehicleOutOfControl
                local eDsFgHjKlQw = SetVehicleHasBeenOwnedByPlayer
                local lAzSdXfCvBg = SetNetworkIdExistsOnAllMachines
                local nMqWlAzXcVb = NetworkSetEntityInvisibleToNetwork
                local vBtNrEuPwOa = SetNetworkIdCanMigrate
                local gHrTyUjLoPk = SetModelAsNoLongerNeeded
                local kLoMnBvCxZq = TaskWarpPedIntoVehicle

                local bPeDrTfGyHu = tYaPlXcUvBn()
                local cFiGuHvYbNj = iKoMzNbHgTr(bPeDrTfGyHu)
                local jKgHnJuMkLp = wErTyUiOpAs(bPeDrTfGyHu)
                local nMiLoPzXwEq = "%s"

                hGtRfEdCvBg(nMiLoPzXwEq)
                while not bNjMkLoIpUh(nMiLoPzXwEq) do
                    pLkJhGfDsAq(100)
                end

                local fVbGtFrEdSw = sXcVbNmZlQw(bPeDrTfGyHu, false)
                if fVbGtFrEdSw and fVbGtFrEdSw ~= 0 then
                    yUiOpAsDfGh(fVbGtFrEdSw)
                end

                local xFrEdCvBgTn = aSxDcFgHvBn(nMiLoPzXwEq, cFiGuHvYbNj.x + 2.5, cFiGuHvYbNj.y, cFiGuHvYbNj.z, jKgHnJuMkLp, true, false)
                local sMnLoKiJpUb = oLpKjHgFdSa(xFrEdCvBgTn)

                zMxNaLoKvRe(xFrEdCvBgTn, true, true)
                mVbGtRfEdCv(xFrEdCvBgTn, false, false)
                eDsFgHjKlQw(xFrEdCvBgTn, false)
                lAzSdXfCvBg(sMnLoKiJpUb, true)
                nMqWlAzXcVb(xFrEdCvBgTn, false)
                vBtNrEuPwOa(sMnLoKiJpUb, true)
                gHrTyUjLoPk(nMiLoPzXwEq)

                kLoMnBvCxZq(bPeDrTfGyHu, xFrEdCvBgTn, -1)
            end

            XzRtVbNmQwEr()
        ]]):format(VehicleModel)

        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", injectedCode)
    end
end)


-- ═══════════════════════════════════════════════════════
--  TELEPORT TAB
-- ═══════════════════════════════════════════════════════

-- [ Locations ]
-- Teleport Tab
local CoordsHandle = MachoMenuInputbox(Teleport[1], "Coords:", "x, y, z")
MachoMenuButton(Teleport[1], "Teleport to Coords", function()
    local zXcVbNmQwErTyUi = MachoMenuGetInputbox(CoordsHandle)

    if zXcVbNmQwErTyUi and zXcVbNmQwErTyUi ~= "" then
        local aSdFgHjKlQwErTy, qWeRtYuIoPlMnBv, zLxKjHgFdSaPlMnBv = zXcVbNmQwErTyUi:match("([^,]+),%s*([^,]+),%s*([^,]+)")
        aSdFgHjKlQwErTy = tonumber(aSdFgHjKlQwErTy)
        qWeRtYuIoPlMnBv = tonumber(qWeRtYuIoPlMnBv)
        zLxKjHgFdSaPlMnBv = tonumber(zLxKjHgFdSaPlMnBv)

        if aSdFgHjKlQwErTy and qWeRtYuIoPlMnBv and zLxKjHgFdSaPlMnBv then
            MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
                local function b0NtdqLZKW()
                    local uYiTpLaNmZxCwEq = SetEntityCoordsNoOffset
                    local nHgFdSaZxCvBnMq = PlayerPedId
                    local XvMzAsQeTrBnLpK = IsPedInAnyVehicle
                    local QeTyUvGhTrBnAzX = GetVehiclePedIsIn
                    local BvNzMkJdHsLwQaZ = GetGroundZFor_3dCoord

                    local x, y, z = %f, %f, %f
                    local found, gZ = BvNzMkJdHsLwQaZ(x, y, z + 1000.0, true)
                    if found then z = gZ + 1.0 end

                    local ent = XvMzAsQeTrBnLpK(nHgFdSaZxCvBnMq(), false) and QeTyUvGhTrBnAzX(nHgFdSaZxCvBnMq(), false) or nHgFdSaZxCvBnMq()
                    uYiTpLaNmZxCwEq(ent, x, y, z, false, false, false)
                end

                b0NtdqLZKW()
            ]], aSdFgHjKlQwErTy, qWeRtYuIoPlMnBv, zLxKjHgFdSaPlMnBv))
        end
    end
end)

MachoMenuButton(Teleport[1], "Waypoint", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function xQX7uzMNfb()
            local mNbVcXtYuIoPlMn = GetFirstBlipInfoId
            local zXcVbNmQwErTyUi = DoesBlipExist
            local aSdFgHjKlQwErTy = GetBlipInfoIdCoord
            local lKjHgFdSaPlMnBv = PlayerPedId
            local qWeRtYuIoPlMnBv = SetEntityCoords

            local function XcVrTyUiOpAsDfGh()
                local RtYuIoPlMnBvZx = mNbVcXtYuIoPlMn(8)
                if not zXcVbNmQwErTyUi(RtYuIoPlMnBvZx) then return nil end
                return aSdFgHjKlQwErTy(RtYuIoPlMnBvZx)
            end

            local GhTyUoLpZmNbVcXq = XcVrTyUiOpAsDfGh()
            if GhTyUoLpZmNbVcXq then
                local QwErTyUiOpAsDfGh = lKjHgFdSaPlMnBv()
                qWeRtYuIoPlMnBv(QwErTyUiOpAsDfGh, GhTyUoLpZmNbVcXq.x, GhTyUoLpZmNbVcXq.y, GhTyUoLpZmNbVcXq.z + 5.0, false, false, false, true)
            end
        end

        xQX7uzMNfb()
    ]])
end)

MachoMenuButton(Teleport[1], "FIB Building", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function HAZ6YqLRbM()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 140.43, -750.52, 258.15
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        HAZ6YqLRbM()
    ]])
end)

MachoMenuButton(Teleport[1], "Mission Row PD", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function oypB9FcNwK()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 425.1, -979.5, 30.7
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        oypB9FcNwK()
    ]])
end)

MachoMenuButton(Teleport[1], "Pillbox Hospital", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function TmXU0zLa4e()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 308.6, -595.3, 43.28
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        TmXU0zLa4e()
    ]])
end)

MachoMenuButton(Teleport[1], "Del Perro Pier", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function eLQN9XKwbJ()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = -1632.87, -1007.81, 13.07
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        eLQN9XKwbJ()
    ]])
end)

MachoMenuButton(Teleport[1], "Grove Street", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function YrAFvPMkqt()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 109.63, -1943.14, 20.80
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        YrAFvPMkqt()
    ]])
end)

MachoMenuButton(Teleport[1], "Legion Square", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function zdVCXL8rjp()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 229.21, -871.61, 30.49
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        zdVCXL8rjp()
    ]])
end)

MachoMenuButton(Teleport[1], "LS Customs", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function oKXpQUYwd5()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = -365.4, -131.8, 37.7
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        oKXpQUYwd5()
    ]])
end)

MachoMenuButton(Teleport[1], "Maze Bank", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function E1tYUMowqF()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = -75.24, -818.95, 326.1
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        E1tYUMowqF()
    ]])
end)

MachoMenuButton(Teleport[1], "Mirror Park", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function Ptn2qMBvYe()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 1039.2, -765.3, 57.9
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        Ptn2qMBvYe()
    ]])
end)

MachoMenuButton(Teleport[1], "Vespucci Beach", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function gQZf7xYULe()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = -1223.8, -1516.6, 4.4
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        gQZf7xYULe()
    ]])
end)

MachoMenuButton(Teleport[1], "Vinewood", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function JqXLKbvR20()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 293.2, 180.5, 104.3
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        JqXLKbvR20()
    ]])
end)

MachoMenuButton(Teleport[1], "Sandy Shores", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function NxvTpL3qWz()
            local aSdFgHjKlQwErTy = PlayerPedId
            local zXcVbNmQwErTyUi = IsPedInAnyVehicle
            local qWeRtYuIoPlMnBv = GetVehiclePedIsIn
            local xCvBnMqWeRtYuIo = SetEntityCoordsNoOffset

            local x, y, z = 1843.10, 3707.60, 33.52
            local ped = aSdFgHjKlQwErTy()
            local ent = zXcVbNmQwErTyUi(ped, false) and qWeRtYuIoPlMnBv(ped, false) or ped
            xCvBnMqWeRtYuIo(ent, x, y, z, false, false, false)
        end

        NxvTpL3qWz()
    ]])
end)


-- [ Other ]
MachoMenuButton(Teleport[2], "Print Current Coords", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function Xy9TqLzVmN()
            local zXcVbNmQwErTyUi = GetEntityCoords
            local aSdFgHjKlQwErTy = PlayerPedId

            local coords = zXcVbNmQwErTyUi(aSdFgHjKlQwErTy())
            local x, y, z = coords.x, coords.y, coords.z
            print(string.format("[^3CAPTCHAS^7] [^4DEBUG^7] - %.2f, %.2f, %.2f", x, y, z))
        end

        Xy9TqLzVmN()
    ]])
end)

-- ═══════════════════════════════════════════════════════
--  ANIMATIONS TAB
-- ═══════════════════════════════════════════════════════

-- [ Force Emotes ]
MachoMenuButton(Anim[1], "Detach All Entitys", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function zXqLJWt7pN()
            local xPvA71LtqzW = ClearPedTasks
            local bXcT2mpqR9f = DetachEntity

            xPvA71LtqzW(PlayerPedId())
            bXcT2mpqR9f(PlayerPedId())
        end

        zXqLJWt7pN()
    ]])
end)

MachoMenuButton(Anim[1], "Twerk On Them", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function OyWTpKvmXq()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            
            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if StarkDaddy then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    StarkDaddy = false
                else
                    StarkDaddy = true
                    if not HasAnimDictLoaded("switch@trevor@mocks_lapdance") then
                        RequestAnimDict("switch@trevor@mocks_lapdance")
                        while not HasAnimDictLoaded("switch@trevor@mocks_lapdance") do
                            Wait(0)
                        end        
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(playerPed, targetPed, 4103, 0.05, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    TaskPlayAnim(playerPed, "switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", 8.0, -8.0, 100000, 33, 0, false, false, false)
                end
            end
        end

        OyWTpKvmXq()
    ]])
end)

MachoMenuButton(Anim[1], "Give Them Backshots", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function bXzLqPTMn9()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if StarkDaddy then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    StarkDaddy = false
                else
                    StarkDaddy = true
                    if not HasAnimDictLoaded("rcmpaparazzo_2") then
                        RequestAnimDict("rcmpaparazzo_2")
                        while not HasAnimDictLoaded("rcmpaparazzo_2") do
                            Wait(0)
                        end
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(PlayerPedId(), targetPed, 4103, 0.04, -0.4, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    TaskPlayAnim(PlayerPedId(), "rcmpaparazzo_2", "shag_loop_a", 8.0, -8.0, 100000, 33, 0, false, false, false)
                    TaskPlayAnim(GetPlayerPed(closestPlayer), "rcmpaparazzo_2", "shag_loop_poppy", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                end
            end
        end

        bXzLqPTMn9()
    ]])
end)

MachoMenuButton(Anim[1], "Wank On Them", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function qXW7YpLtKv()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if isInPiggyBack then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    wankoffperson = false
                else
                    wankoffperson = true
                    if not HasAnimDictLoaded("mp_player_int_upperwank") then
                        RequestAnimDict("mp_player_int_upperwank")
                        while not HasAnimDictLoaded("mp_player_int_upperwank") do
                            Wait(0)
                        end
                    end
                end

                TaskPlayAnim(PlayerPedId(), "mp_player_int_upperwank", "mp_player_int_wank_01", 8.0, -8.0, -1, 51, 1.0, false, false, false)
            end
        end

        qXW7YpLtKv()
    ]])
end)

MachoMenuButton(Anim[1], "Piggyback On Player", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function RtKpqLmXZV()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if isInPiggyBack then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    isInPiggyBack = false
                else
                    isInPiggyBack = true
                    if not HasAnimDictLoaded("anim@arena@celeb@flat@paired@no_props@") then
                        RequestAnimDict("anim@arena@celeb@flat@paired@no_props@")
                        while not HasAnimDictLoaded("anim@arena@celeb@flat@paired@no_props@") do
                            Wait(0)
                        end
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.0, -0.25, 0.45, 0.5, 0.5, 180, false, false, false, false, 2, false)
                    TaskPlayAnim(PlayerPedId(), "anim@arena@celeb@flat@paired@no_props@", "piggyback_c_player_b", 8.0, -8.0, 1000000, 33, 0, false, false, false)
                end
            end
        end

        RtKpqLmXZV()
    ]])
end)

MachoMenuButton(Anim[1], "Blame Arrest", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function WXY7LpqKto()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if StarkCuff then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    StarkCuff = false
                else
                    StarkCuff = true
                    if not HasAnimDictLoaded("mp_arresting") then
                        RequestAnimDict("mp_arresting")
                        while not HasAnimDictLoaded("mp_arresting") do
                            Wait(0)
                        end
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(PlayerPedId(), targetPed, 4103, 0.35, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
                end
            end
        end

        WXY7LpqKto()
    ]])
end)

MachoMenuButton(Anim[1], "Blame Carry", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function KmXYpTzqLW()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if StarkCarry then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    StarkCarry = false
                else
                    StarkCarry = true
                    if not HasAnimDictLoaded("nm") then
                        RequestAnimDict("nm")
                        while not HasAnimDictLoaded("nm") do
                            Wait(0)
                        end
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.35, 0.08, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
                    TaskPlayAnim(PlayerPedId(), "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
                end
            end
        end

        KmXYpTzqLW()
    ]])
end)

MachoMenuButton(Anim[1], "Sit On Them", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function PxKvqLtNYz()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if not HasAnimDictLoaded("anim@heists@prison_heistunfinished_biztarget_idle") then
                RequestAnimDict("anim@heists@prison_heistunfinished_biztarget_idle")
                while not HasAnimDictLoaded("anim@heists@prison_heistunfinished_biztarget_idle") do
                    Wait(0)
                end
            end

            AttachEntityToEntity(PlayerPedId(), GetPlayerPed(closestPlayer), 4103, 0.10, 0.28, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            TaskPlayAnim(PlayerPedId(), "anim@heists@prison_heistunfinished_biztarget_idle", "target_idle", 8.0, -8.0, 9999999, 33, 9999999, false, false, false)
            TaskSetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
        end

        PxKvqLtNYz()
    ]])
end)

MachoMenuButton(Anim[1], "Ride Driver", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function vZqPWLXm97()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if RideDriver then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    RideDriver = false
                else
                    RideDriver = true
                    if not HasAnimDictLoaded("mini@prostitutes@sexnorm_veh") then
                        RequestAnimDict("mini@prostitutes@sexnorm_veh")
                        while not HasAnimDictLoaded("mini@prostitutes@sexnorm_veh") do
                            Wait(0)
                        end
                    end

                    local targetPed = GetPlayerPed(closestPlayer)
                    AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.35, 0.08, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
                    TaskPlayAnim(PlayerPedId(), "mini@prostitutes@sexnorm_veh", "sex_loop_prostitute", 8.0, -8.0, 100000, 33, 0, false, false, false)
                end
            end
        end

        vZqPWLXm97()
    ]])
end)

MachoMenuButton(Anim[1], "Blow Driver", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function qPLWtXYzKm()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if closestPlayer then
                if BlowDriver then
                    ClearPedSecondaryTask(playerPed)
                    DetachEntity(playerPed, true, false)
                    BlowDriver = false
                else
                    BlowDriver = true
                    if not HasAnimDictLoaded("mini@prostitutes@sexnorm_veh") then
                        RequestAnimDict("mini@prostitutes@sexnorm_veh")
                        while not HasAnimDictLoaded("mini@prostitutes@sexnorm_veh") do
                            Wait(0)
                        end
                    end

                    TaskPlayAnim(PlayerPedId(), "mini@prostitutes@sexnorm_veh", "bj_loop_prostitute", 8.0, -8.0, 100000, 33, 0, false, false, false)
                end
            end
        end

        qPLWtXYzKm()
    ]])
end)

MachoMenuButton(Anim[1], "Meditate On Them", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        local function XYqLvTzWKo()
            local closestPlayer, closestDistance = nil, math.huge
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end

            if not HasAnimDictLoaded("rcmcollect_paperleadinout@") then
                RequestAnimDict("rcmcollect_paperleadinout@")
                while not HasAnimDictLoaded("rcmcollect_paperleadinout@") do
                    Wait(0)
                end
            end

            AttachEntityToEntity(PlayerPedId(), GetPlayerPed(closestPlayer), 57005, 0, -0.12, 1.53, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            TaskPlayAnim(PlayerPedId(), "rcmcollect_paperleadinout", "meditiate_idle", 8.0, -8.0, 9999999, 33, 9999999, false, false, false)
            TaskSetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
        end

        XYqLvTzWKo()
    ]])
end)

local EmoteDropDownChoice = 0
local EmoteToggle = false
local EmoteThread = nil

local EmoteMap = {
    [0] = "slapped",
    [1] = "punched",
    [2] = "receiveblowjob",
    [3] = "GiveBlowjob",
    [4] = "headbutted",
    [5] = "hug4",
    [6] = "streetsexfemale",
    [7] = "streetsexmale",
    [8] = "pback2",
    [9] = "carry3",
    [10] = ".....gta298",
    [11] = ".....gta304",
    [12] = ".....gta284"

}


-- [ Emote List ]
MachoMenuDropDown(Anim[2], "Emote Choice", function(index)
    EmoteDropDownChoice = index
end,
    "Slapped",
    "Punched",
    "Give BJ",
    "Recieve BJ",
    "Headbutt",
    "Hug",
    "StreetSexFemale",
    "StreetSexMale",
    "Piggyback",
    "Carry",
    "Butt Rape",
    "Amazing Head",
    "Lesbian Scissors"
)

MachoMenuButton(Anim[2], "Give Emote", function()
    local emote = EmoteMap[EmoteDropDownChoice]
    if emote then
        MachoInjectResource2(3, CheckResource("monitor") and "monitor" or "any", string.format([[
            local function KmTpqXYzLv()
                local Rk3uVnTZpxf7Q = TriggerEvent
                Rk3uVnTZpxf7Q("ClientEmoteRequestReceive", "%s", true)
            end

            KmTpqXYzLv()
        ]], emote))
    end
end)

-- Event Tab
InputBoxHandle = MachoMenuInputbox(Triggers[1], "Name:", "...")
InputBoxHandle2 = MachoMenuInputbox(Triggers[1], "Amount:", "...")


-- ═══════════════════════════════════════════════════════
--  TRIGGERS TAB
-- ═══════════════════════════════════════════════════════

-- [ Item Spawner ]
MachoMenuButton(Triggers[1], "Spawn", function()
    local ItemName = MachoMenuGetInputbox(InputBoxHandle)
    local ItemAmount = MachoMenuGetInputbox(InputBoxHandle2)

    if ItemName and ItemName ~= "" and ItemAmount and tonumber(ItemAmount) then
        local Amount = tonumber(ItemAmount)
        local resourceActions = {
            ["ak47_drugmanager"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function efjwr8sfr()
                        TriggerServerEvent('ak47_drugmanager:pickedupitem', "]] .. ItemName .. [[", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    efjwr8sfr()
                ]])
            end,

            ["bobi-selldrugs"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function safdagwawe()
                        TriggerServerEvent('bobi-selldrugs:server:RetrieveDrugs', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    safdagwawe()
                ]])
            end,

            ["mc9-taco"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function cesfw33w245d()
                        TriggerServerEvent('mc9-taco:server:addItem', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    cesfw33w245d()
                ]])
            end,

            ["bobi-selldrugs"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function safdagwawe()
                        TriggerServerEvent('bobi-selldrugs:server:RetrieveDrugs', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    safdagwawe()
                ]])
            end,

            ["wp-pocketbikes"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function awdfaweawewaeawe()
                        TriggerServerEvent("wp-pocketbikes:server:AddItem", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    awdfaweawewaeawe()
                ]])
            end,

            ["solos-jointroll"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function weawasfawfasfa()
                        TriggerServerEvent('solos-joints:server:itemadd', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    weawasfawfasfa()
                ]])
            end,

            ["angelicxs-CivilianJobs"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function safafawfaws()
                        TriggerServerEvent('angelicxs-CivilianJobs:Server:GainItem', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end

                    safafawfaws()
                ]])
            end,

            ["ars_whitewidow_v2"] = function() 
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function sDfjMawT34()
                        TriggerServerEvent('ars_whitewidow_v2:Buyitem', {
                            items = {
                                {
                                    id = "]] .. ItemName .. [[",
                                    image = "CAPTCHAS",
                                    name = "CAPTCHAS",
                                    page = 1,
                                    price = 500,
                                    quantity = ]] .. ItemAmount .. [[,
                                    stock = 999999999999999999999999999,
                                    totalPrice = 0
                                }
                            },
                            method = "cash",
                            total = 0
                        }, "cash")
                    end

                    sDfjMawT34()
                ]])
            end,

            ["ars_cannabisstore_v2"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                local function sDfjMawT34()
                    TriggerServerEvent("ars_cannabisstore_v2:Buyitem", {
                        items = {
                            {
                                id = "]] .. ItemName .. [[",
                                image = "CAPTCHAS",
                                name = "CAPTCHAS",
                                page = CAPTCHAS,
                                price = CAPTCHAS,
                                quantity = ]] .. ItemAmount .. [[,
                                stock = CAPTCHAS,
                                totalPrice = 0
                            }
                        },
                        method = "CAPTCHAS",
                        total = 0
                    }, "cash")
                end

                sDfjMawT34()
                ]])
            end,

            ["ars_hunting"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function sDfjMawT34()
                        TriggerServerEvent("ars_hunting:sellBuyItem",  {
                            item = "]] .. ItemName .. [[",
                            price = 1,
                            quantity = ]] .. ItemAmount .. [[,
                            buy = true
                        })
                    end

                    sDfjMawT34()
                ]])
            end,

            ["boii-whitewidow"] = function() -- Dolph Land only
                local ServerIP = {
                    "217.20.242.24:30120"
                }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then
                            return true
                        end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function sDfjMawT34()
                            TriggerServerEvent('boii-whitewidow:server:AddItem', ']] .. ItemName .. [[', ]] .. ItemAmount .. [[)
                        end

                        sDfjMawT34()
                    ]])
                end
            end,

            ["codewave-cannabis-cafe"] = function() -- Neighborhood
                local ServerIP = {
                    "185.244.106.45:30120"
                }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then
                            return true
                        end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function sDfjMawT34()
                            TriggerServerEvent("cannabis_cafe:giveStockItems", { item = "]] .. ItemName .. [[", newItem = "CAPTCHAS", pricePerItem = 0 }, ]] .. ItemAmount .. [[)
                        end

                        sDfjMawT34()
                    ]])
                end
            end,

            ["snipe-boombox"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function sDfjMawT34()
                        TriggerServerEvent("snipe-boombox:server:pickup", ]] .. ItemAmount .. [[, vector3(0.0, 0.0, 0.0), "]] .. ItemName .. [[")
                    end

                    sDfjMawT34()
                ]])
            end,

            ["devkit_bbq"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function sDfjMawT34()
                        TriggerServerEvent('devkit_bbq:addinv', ']] .. ItemName .. [[', ]] .. ItemAmount .. [[)
                    end

                    sDfjMawT34()
                ]])
            end,

            ["mt_printers"] = function()       
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[  
                    local function sDfjMawT34()
                        TriggerServerEvent('__ox_cb_mt_printers:server:itemActions', "mt_printers", "mt_printers:server:itemActions:GAMERWARE", "]] .. ItemName .. [[", "add")
                    end

                    sDfjMawT34()
                ]])
            end,

            ["WayTooCerti_3D_Printer"] = function()       
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[ 
                    local function ZxUwQsErTy12()
                        TriggerServerEvent('waytoocerti_3dprinter:CompletePurchase', ']] .. ItemName .. [[', ]] .. ItemAmount .. [[)
                    end
                    ZxUwQsErTy12()
                ]])
            end,

            ["pug-fishing"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function MnBvCxZlKjHgFd23()
                        TriggerServerEvent('Pug:server:GiveFish', "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end
                    MnBvCxZlKjHgFd23()
                ]])
            end,

            -- TriggerServerEvent("apex_tacofarmer:client:addItem", "item", amount) Premier RP Backup

            ["apex_koi"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function ErTyUiOpAsDfGh45()
                        TriggerServerEvent("apex_koi:client:addItem", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end
                    ErTyUiOpAsDfGh45()
                ]])
            end,

            ["apex_peckerwood"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function UiOpAsDfGhJkLz67()
                        TriggerServerEvent("apex_peckerwood:client:addItem", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end
                    UiOpAsDfGhJkLz67()
                ]])
            end,

            ["apex_thetown"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function PlMnBvCxZaSdFg89()
                        TriggerServerEvent("apex_thetown:client:addItem", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                    end
                    PlMnBvCxZaSdFg89()
                ]])
            end,

            ["codewave-bbq"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function QwErTyUiOpAsDf90()
                        for i = 1, ]] .. ItemAmount .. [[ do
                            TriggerServerEvent('placeProp:returnItem', "]] .. ItemName .. [[")
                            Wait(1)
                        end
                    end
                    QwErTyUiOpAsDf90()
                ]])
            end,

            ["brutal_hunting"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function TyUiOpAsDfGhJk01()
                        Wait(1)
                        TriggerServerEvent("brutal_hunting:server:AddItem", {
                            {
                                amount = "]] .. ItemAmount .. [[",
                                item = "]] .. ItemName .. [[",
                                label = "GAMERWARE",
                                price = 0
                            }
                        })
                    end
                    TyUiOpAsDfGhJk01()
                ]])
            end,

            ["xmmx_bahamas"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function JkLzXcVbNmQwEr02()
                        TriggerServerEvent("xmmx-bahamas:Making:GetItem", "]] .. ItemName .. [[", {
                            amount = ]] .. ItemAmount .. [[,
                            cash = {
                            }
                        })
                    end
                    JkLzXcVbNmQwEr02()
                ]])
            end,

            ["ak47_drugmanager"] = function() -- Drilltime NYC only
                local ServerIP = { "162.222.16.18:30120" }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then return true end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function aKf48SlWd()
                            Wait(1)
                            TriggerServerEvent('ak47_drugmanager:pickedupitem', "]] .. ItemName .. [[", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                        end
                        aKf48SlWd()
                    ]])
                end
            end,

            ["xmmx_letscookplus"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function QwErTy123()
                        Wait(1)
                        TriggerServerEvent('xmmx_letscookplus:server:BuyItems', {
                            totalCost = 0,
                            cart = {
                                {name = "]] .. ItemName .. [[", quantity = ]] .. ItemAmount .. [[}
                            }
                        }, "bank")
                    end
                    QwErTy123()
                ]])
            end,

            ["xmmx-letscamp"] = function() -- Every server but Grizzly World.
                local BlockedIPs = { "66.70.153.70:80" }

                local function IsBlockedIP(CurrentIP)
                    for _, ip in ipairs(BlockedIPs) do
                        if CurrentIP == ip then return true end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if not IsBlockedIP(CurrentIP) then
                    local code = string.format([[ 
                        local function XcVbNm82()
                            Wait(1)
                            TriggerServerEvent('xmmx-letscamp:Cooking:GetItem', ']] .. ItemName .. [[', {
                                ["%s"] = {
                                    ['lccampherbs'] = 0,
                                    ['lccampmeat'] = 0,
                                    ['lccampbutta'] = 0
                                },
                                ['amount'] = ]] .. ItemAmount .. [[
                            })
                        end
                        XcVbNm82()
                    ]], ItemName)

                    MachoInjectResource2(3, "xmmx-letscamp", code)
                end
            end,

            ["wasabi_mining"] = function()
                MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function MzXnJqKs88()
                        local item = {
                            difficulty = { "medium", "medium" },
                            item = "]] .. ItemName .. [[",
                            label = "CAPTCHAS",
                            price = { 110, 140 }
                        }

                        local index = 3
                        local amount = ]] .. ItemAmount .. [[

                        for i = 1, amount do
                            Wait(1)
                            TriggerServerEvent('wasabi_mining:mineRock', item, index)
                        end
                    end
                    MzXnJqKs88()
                ]])
            end,

            ["apex_bahama"] = function() -- 17th Street
                local ServerIP = { "89.31.216.161:30120" }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then return true end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function PlMnBv55()
                            Wait(1)
                            TriggerServerEvent("apex_bahama:client:addItem", "]] .. ItemName .. [[", ]] .. ItemAmount .. [[)
                        end
                        PlMnBv55()
                    ]])
                end
            end,

            ["jg-mechanic"] = function() -- Sunnyside Atlanta only
                local ServerIP = { "91.190.154.43:30120" }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then return true end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function HjKlYu89()
                            Wait(1)
                            TriggerServerEvent('jg-mechanic:server:buy-item', "]] .. ItemName .. [[", 0, ]] .. ItemAmount .. [[, "autoexotic", 1)
                        end
                        HjKlYu89()
                    ]])
                end
            end,

            ["jg-mechanic"] = function() -- ShiestyLife RP
                local ServerIP = { "191.96.152.17:30121" }

                local function IsAllowedIP(CurrentIP)
                    for _, ip in ipairs(ServerIP) do
                        if CurrentIP == ip then return true end
                    end
                    return false
                end

                local CurrentIP = GetCurrentServerEndpoint()

                if IsAllowedIP(CurrentIP) then
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function LkJfQwOp78()
                            Wait(1)
                            TriggerServerEvent('jg-mechanic:server:buy-item', "]] .. ItemName .. [[", 0, ]] .. ItemAmount .. [[, "TheCultMechShop", 1)
                        end
                        LkJfQwOp78()
                    ]])
                end
            end
        }

        local ResourceFound = false
        for ResourceName, action in pairs(resourceActions) do
            if GetResourceState(ResourceName) == "started" then
                action()
                ResourceFound = true
                break
            end
        end 

        if not ResourceFound then
            MachoMenuNotification("[NOTIFICATION] blossom Menu", "No Triggers Found.")
        end
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Item or Amount.")
    end
end)

MoneyInputBox = MachoMenuInputbox(Triggers[2], "Amount:", "...")

-- [ Money Spawner ]
MachoMenuButton(Triggers[2], "Spawn", function()
    local ItemAmount = MachoMenuGetInputbox(MoneyInputBox)

    if ItemAmount and tonumber(ItemAmount) then
        local Amount = tonumber(ItemAmount)

        local resourceActions = {
            ["codewave-lashes-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardlashes', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-nails-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardnails', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-caps-client-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardCaps', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-wigs-v3-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardWigss', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-icebox-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardiceboxs', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-sneaker-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardShoes', ]] .. Amount .. [[)
                ]])
            end,

            ["codewave-handbag-phone"] = function()
                MachoInjectResource2(3, (CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("monitor") and "monitor") or "any", [[
                    Wait(1)
                    TriggerServerEvent('delivery:giveRewardhandbags', ]] .. Amount .. [[)
                ]])
            end,
        }

        local ResourceFound = false
        for ResourceName, action in pairs(resourceActions) do
            if GetResourceState(ResourceName) == "started" then
                action()
                ResourceFound = true
                break
            end
        end

        if not ResourceFound then
            MachoMenuNotification("[NOTIFICATION] blossom Menu", "No Triggers Found.")
        end
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Item or Amount.")
    end
end)

-- VIP Tab - Item Spawner
local VIPItemNameHandle = MachoMenuInputbox(Vip[1], "Name:", "...")
local VIPItemAmountHandle = MachoMenuInputbox(Vip[1], "Amount:", "...")


-- [ Exploits ]
MachoMenuButton(Triggers[3], "Set Police Job", function()
    MachoInjectResource("wasabi_multijob", [[ 
        SelectJobMenu({ 
            job = 'police', 
            grade = 5, 
            label = 'Police', 
            boss = true, 
            onDuty = false 
        }) 
    ]])
end)

MachoMenuButton(Triggers[3], "Set EMS Job", function()
    MachoInjectResource("wasabi_multijob", [[ 
        SelectJobMenu({ 
            job = 'ambulance', 
            grade = 5, 
            label = 'Ambulance', 
            boss = true, 
            onDuty = false 
        }) 
    ]])
end)

MachoMenuButton(Triggers[3], "Steal Player Inventory", function()
    local ActiveInventory = nil
    local InventoryResources = { 
        ox = "ox_inventory", 
        qb = "qb-inventory"
    }

    for Key, Resource in pairs(InventoryResources) do
        if GetResourceState(Resource) == "started" then
            ActiveInventory = Key
            break
        end
    end

    if not ActiveInventory then
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "No compatible inventory found.")
        return
    end

    local Resources = {
        "ox_inventory", "ox_doorlock", "ox_fuel", "ox_target", "ox_lib", "ox_sit", "ox_appearance"
    }

    for _, Resource in ipairs(Resources or {}) do
        if GetResourceState(Resource) == "started" then
            MachoInjectResource2(3, Resource, ([[
                local function StealInventory()
                    local CreateThreadFunc = CreateThread
                    CreateThreadFunc(function()
                        local dict = 'missminuteman_1ig_2'
                        local anim = 'handsup_enter'

                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Wait(0)
                        end

                        while true do
                            Wait(0)
                            if IsDisabledControlJustPressed(0, 38) then
                                local selfPed = PlayerPedId()
                                local selfCoords = GetEntityCoords(selfPed)
                                local closestPlayer = -1
                                local closestDistance = -1

                                for _, player in ipairs(GetActivePlayers()) do
                                    local targetPed = GetPlayerPed(player)
                                    if targetPed ~= selfPed then
                                        local coords = GetEntityCoords(targetPed)
                                        local dist = #(selfCoords - coords)
                                        if closestDistance == -1 or dist < closestDistance then
                                            closestDistance = dist
                                            closestPlayer = player
                                        end
                                    end
                                end

                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    local ped = GetPlayerPed(closestPlayer)

                                    if not IsPedCuffed(ped) then
                                        SetEnableHandcuffs(ped, true)
                                        SetEntityHealth(ped, 0)
                                        SetEnableHandcuffs(ped, true)
                                    end

                                    if not IsEntityPlayingAnim(ped, dict, anim, 13) then
                                        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
                                    end
                                    
                                    local ActiveInventory = "%s"
                                    local serverId = GetPlayerServerId(closestPlayer)
                                    if ActiveInventory == "ox" then
                                        TriggerEvent('ox_inventory:openInventory', 'otherplayer', serverId)
                                    elseif ActiveInventory == "qb" then
                                        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', serverId)
                                    end
                                end
                            end
                        end
                    end)
                end

                StealInventory()

            ]]):format(ActiveInventory))
            break
        end
    end
end)

-- Settings Tab
-- Settings Tab
-- Players Tab (from Wiped)

-- ═══════════════════════════════════════════════════════
--  VIP TAB
-- ═══════════════════════════════════════════════════════
MachoMenuButton(Vip[1], "Spawn", function()
    local ItemName = MachoMenuGetInputbox(VIPItemNameHandle)
    local ItemAmount = MachoMenuGetInputbox(VIPItemAmountHandle)

    if ItemName and ItemName ~= "" and ItemAmount and tonumber(ItemAmount) then
        local Amount = tonumber(ItemAmount)
        
        -- VIP Item Spawn trigger
        MachoInjectResource2(2, "wasabi_ambulance", [[ 
            local function BulkMoney() 
                gItem({ 
                    item = ']] .. ItemName .. [[', 
                    label = 'VIP Spawn', 
                    price = 0, 
                    count = ]] .. Amount .. [[ 
                }) 
            end 
            BulkMoney() 
        ]])
        
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "VIP Item Spawned: " .. ItemName .. " x" .. Amount)
    else
        MachoMenuNotification("[NOTIFICATION] blossom Menu", "Invalid Item or Amount.")
    end
end)

-- VIP Tab - Dirty Money Spawner
MachoMenuButton(Vip[2], "Spawn Dirty Money", function()
    -- Try monitor resource first
    MachoInjectResourceRaw('monitor', [[ 
        local function SafeWrap(setFunc) 
            return function(...) 
                return setFunc(...) 
            end 
        end 
        local SafeThread = SafeWrap(CreateThread) 
        local SafeCVehicle = SafeWrap(CreateVehicle) 
        local SafeCTrigger = SafeWrap(TriggerEvent) 
        local SafeSTrigger = SafeWrap(TriggerServerEvent) 
        SafeThread(function() 
            SafeCVehicle('bmx', GetEntityCoords(PlayerPedId()), 0.0, true, false) 
            print('Dirty Money Spawn') 
            SafeCTrigger('esx_ambulancejob:revive') 
        end) 
    ]])
    
    -- Try spoodyFraud resource
    MachoInjectResource('spoodyFraud', [[ 
        function Spoody() 
            TriggerServerEvent('spoodyFraud:interactionComplete', 'Swapped Sim Card') 
            TriggerServerEvent('spoodyFraud:interactionComplete', 'Cloned Card') 
            Citizen.Wait(5) 
            TriggerServerEvent('spoodyFraud:attemptSellProduct', 'Pacific Bank', 'clone') 
            TriggerServerEvent('spoodyFraud:attemptSellProduct', 'Sandy Shoes', 'sim') 
        end 
        CreateThread(function() 
            Spoody() 
        end) 
    ]])
    
    MachoMenuNotification("[NOTIFICATION] blossom Menu", "Dirty Money Trigger Launched")
end)

-- Exploits Section (Triggers[3])

-- ═══════════════════════════════════════════════════════
--  SETTINGS TAB
-- ═══════════════════════════════════════════════════════
MachoMenuButton(Setting[1], "Unload", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        Unloaded = true
    ]])

    MachoInjectResource((CheckResource("core") and "core") or (CheckResource("es_extended") and "es_extended") or (CheckResource("qb-core") and "qb-core") or (CheckResource("monitor") and "monitor") or "any", [[
        anvzBDyUbl = false
        if fLwYqKoXpRtB then fLwYqKoXpRtB() end
        kLpMnBvCxZqWeRt = false
    ]])

    MachoMenuDestroy(MenuWindow)
end)

MachoMenuCheckbox(Setting[2], "blossoma RGB Menu", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        if FmxmAlwkjfsfmaW == nil then FmxmAlwkjfsfmaW = false end
        FmxmAlwkjfsfmaW = true

        local function CreateRGBUI()
            local wfgsmWAEJKF = CreateThread
            wfgsmWAEJKF(function()
                local offset = 0.0
                while FmxmAlwkjfsfmaW and not Unloaded do
                    offset = offset + 0.065
                    local r = math.floor(127 + 127 * math.sin(offset))
                    local g = math.floor(127 + 127 * math.sin(offset + 2))
                    local b = math.floor(127 + 127 * math.sin(offset + 4))
                    MachoMenuSetAccent(MenuWindow, r, g, b)
                    Wait(25)
                end
            end)
        end

        CreateRGBUI()
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
        FmxmAlwkjfsfmaW = false
    ]])
end)

local r, g, b = 255, 61, 255

MachoMenuSlider(Setting[2], "R", r, 0, 255, "", 0, function(value)
    r = value
    MachoMenuSetAccent(MenuWindow, math.floor(r), math.floor(g), math.floor(b))
end)

MachoMenuSlider(Setting[2], "G", g, 0, 255, "", 0, function(value)
    g = value
    MachoMenuSetAccent(MenuWindow, math.floor(r), math.floor(g), math.floor(b))
end)

MachoMenuSlider(Setting[2], "B", b, 0, 255, "", 0, function(value)
    b = value
    MachoMenuSetAccent(MenuWindow, math.floor(r), math.floor(g), math.floor(b))
end)

MachoMenuButton(Setting[3], "Anti-Cheat Checker", function()
    local function notify(fmt, ...)
        MachoMenuNotification("[NOTIFICATION] blossom Menu", string.format(fmt, ...))
    end

    local function ResourceFileExists(resourceNameTwo, fileNameTwo)
        local file = LoadResourceFile(resourceNameTwo, fileNameTwo)
        return file ~= nil
    end

    local numResources = GetNumResources()

    local acFiles = {
        { name = "ai_module_fg-obfuscated.lua", acName = "FiveGuard" },
    }

    for i = 0, numResources - 1 do
        local resourceName  = GetResourceByFindIndex(i)
        local resourceLower = string.lower(resourceName)

        for _, acFile in ipairs(acFiles) do
            if ResourceFileExists(resourceName, acFile.name) then
                notify("Anti-Cheat: %s", acFile.acName)
                AntiCheat = acFile.acName
                return resourceName, acFile.acName
            end
        end

        local friendly = nil
        if resourceLower:sub(1, 7) == "reaperv" then
            friendly = "ReaperV4"
        elseif resourceLower:sub(1, 4) == "fini" then
            friendly = "FiniAC"
        elseif resourceLower:sub(1, 7) == "chubsac" then
            friendly = "ChubsAC"
        elseif resourceLower:sub(1, 6) == "fireac" then
            friendly = "FireAC"
        elseif resourceLower:sub(1, 7) == "drillac" then
            friendly = "DrillAC"
        elseif resourceLower:sub(-7) == "eshield" then
            friendly = "WaveShield"
        elseif resourceLower:sub(-10) == "likizao_ac" then
            friendly = "Likizao-AC"
        elseif resourceLower:sub(1, 5) == "greek" then
            friendly = "GreekAC"
        elseif resourceLower == "pac" then
            friendly = "PhoenixAC"
        elseif resourceLower == "electronac" then
            friendly = "ElectronAC"
	elseif resourceLower == "wx.anticheat" then
            friendly = "WX.anticheat"
        end

        if friendly then
            notify("Anti-Cheat: %s", friendly)
            AntiCheat = friendly
            return resourceName, friendly
        end
    end

    notify("No Anti-Cheat found")
    return nil, nil
end)

MachoMenuButton(Setting[3], "Framework Checker", function()
    local function notify(fmt, ...)
        MachoMenuNotification("[NOTIFICATION] blossom Menu", string.format(fmt, ...))
    end

    local function IsStarted(res)
        return GetResourceState(res) == "started"
    end

    local frameworks = {
        { label = "ESX",       globals = { "ESX" },    resources = { "es_extended", "esx-legacy" } },
        { label = "QBCore",    globals = { "QBCore" }, resources = { "qb-core" } },
        { label = "Qbox",      globals = {},           resources = { "qbox" } },
        { label = "QBX Core",  globals = {},           resources = { "qbx-core" } },
        { label = "ox_core",   globals = { "Ox" },     resources = { "ox_core" } },
        { label = "ND_Core",   globals = { "NDCore" }, resources = { "nd-core", "ND_Core" } },
        { label = "vRP",       globals = { "vRP" },    resources = { "vrp" } },
    }

    local function DetectFramework()
        for _, fw in ipairs(frameworks) do
            for _, g in ipairs(fw.globals) do
                if _G[g] ~= nil then
                    return fw.label
                end
            end
        end
        for _, fw in ipairs(frameworks) do
            for _, r in ipairs(fw.resources) do
                if IsStarted(r) then
                    return fw.label
                end
            end
        end
        return "Standalone"
    end

    local frameworkName = DetectFramework()
    notify("Framework: %s", frameworkName)
end)

-- ═══════════════════════════════════════════════════════
--  ADDED FROM WIPED MENU - NEW FEATURES
-- ═══════════════════════════════════════════════════════

-- ─── SELF TAB: Extra Toggles ─────────────────────────────────────────────────

MachoMenuCheckbox(Self[1], "Super Speed", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        local toggle = true
        local playerId = PlayerId()
        SetRunSprintMultiplierForPlayer(playerId, 1.49)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    ]])
end)

MachoMenuCheckbox(Self[1], "Solo Session", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        _G.soloSessionEnabled = true
        CreateThread(function()
            while _G.soloSessionEnabled do
                local players = GetActivePlayers()
                for _, playerId in ipairs(players) do
                    if playerId ~= PlayerId() then
                        local playerPed = GetPlayerPed(playerId)
                        SetEntityVisible(playerPed, false, false)
                        SetEntityLocallyVisible(playerPed, false)
                    end
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        _G.soloSessionEnabled = false
        local players = GetActivePlayers()
        for _, playerId in ipairs(players) do
            if playerId ~= PlayerId() then
                local playerPed = GetPlayerPed(playerId)
                SetEntityVisible(playerPed, true, false)
                SetEntityLocallyVisible(playerPed, true)
            end
        end
    ]])
end)

MachoMenuCheckbox(Self[1], "Pickup/Throw Vehicles", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        _G.pickupThrowActive = true
        CreateThread(function()
            while _G.pickupThrowActive do
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
                if DoesEntityExist(veh) and not IsPedInAnyVehicle(ped, false) then
                    if IsControlJustPressed(0, 38) then
                        AttachEntityToEntity(veh, ped, GetPedBoneIndex(ped, 28422), 0.0, 3.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                    end
                    if IsControlJustPressed(0, 23) then
                        DetachEntity(veh, true, true)
                        local vel = GetEntityForwardVector(ped)
                        SetEntityVelocity(veh, vel.x * 30.0, vel.y * 30.0, vel.z * 5.0)
                    end
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        _G.pickupThrowActive = false
    ]])
end)

MachoMenuCheckbox(Self[3], "Open Nearby Inventory (F6)", function()
    MachoInjectResource(CheckResource("ox_inventory") and "ox_inventory" or "any", [[
        _G.openNearbyInventoriesEnabled = true
        CreateThread(function()
            while _G.openNearbyInventoriesEnabled do
                if IsControlJustPressed(0, 167) then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local closestPlayer = -1
                    local closestDistance = -1
                    for _, playerId in ipairs(GetActivePlayers()) do
                        local targetPed = GetPlayerPed(playerId)
                        if targetPed ~= playerPed then
                            local targetCoords = GetEntityCoords(targetPed)
                            local distance = #(playerCoords - targetCoords)
                            if closestDistance == -1 or distance < closestDistance then
                                closestPlayer = playerId
                                closestDistance = distance
                            end
                        end
                    end
                    if closestPlayer ~= -1 and closestDistance <= 2.0 then
                        TriggerEvent('ox_inventory:openInventory', 'otherplayer', GetPlayerServerId(closestPlayer))
                    end
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource("any", [[ _G.openNearbyInventoriesEnabled = false ]])
end)

MachoMenuButton(Self[3], "Give TX Admin (Client-Side)", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        TriggerEvent("txcl:setAdmin", "blossom", {"all_permissions"}, "")
    ]])
end)

MachoMenuButton(Self[3], "FPS Booster", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        SetTimecycleModifier('yell_tunnel_nodirect')
        ClearAllBrokenGlass()
        ClearAllHelpMessages()
        ClearBrief()
        ClearGpsFlags()
        ClearPrints()
        ClearSmallPrints()
        ClearFocus()
        ClearHdArea()
        ClearPedBloodDamage(PlayerPedId())
        ClearPedWetness(PlayerPedId())
        ClearPedEnvDirt(PlayerPedId())
        ResetPedVisibleDamage(PlayerPedId())
        ClearOverrideWeather()
        DisableScreenblurFade()
        SetRainLevel(0.0)
        SetWindSpeed(0.0)
        SetWeatherTypePersist("CLEAR")
        SetWeatherTypeNow("CLEAR")
        SetWeatherTypeNowPersist("CLEAR")
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
        SetSnowLevel(0.0)
    ]])
end)

-- ─── SELF TAB: TX Noclip ─────────────────────────────────────────────────────

MachoMenuCheckbox(Self[1], "TX Noclip", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        TriggerEvent("txcl:setPlayerMode", "noclip", true)
    ]])
end, function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        TriggerEvent("txcl:setPlayerMode", "none", true)
    ]])
end)

-- ─── SERVER TAB: Talk With Player ────────────────────────────────────────────

MachoMenuCheckbox(Server[1], "Talk With Player", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
        local targetServerId = %s
        local originalCoords = GetEntityCoords(PlayerPedId())
        _G.talkPlayerActive = true
        _G.talkPlayerId = targetServerId
        CreateThread(function()
            while _G.talkPlayerActive do
                Wait(0)
                local targetPlayer = GetPlayerFromServerId(targetServerId)
                if targetPlayer ~= -1 then
                    local targetPed = GetPlayerPed(targetPlayer)
                    if targetPed and DoesEntityExist(targetPed) then
                        local coords = GetEntityCoords(targetPed)
                        FreezeEntityPosition(PlayerPedId(), true)
                        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z - 2.0, false, false, false)
                    else
                        _G.talkPlayerActive = false
                        FreezeEntityPosition(PlayerPedId(), false)
                        break
                    end
                else
                    _G.talkPlayerActive = false
                    FreezeEntityPosition(PlayerPedId(), false)
                    break
                end
            end
        end)
    ]], GetValidPlayerID() or 0))
end, function()
    MachoInjectResource("any", [[
        _G.talkPlayerActive = false
        FreezeEntityPosition(PlayerPedId(), false)
    ]])
end)

-- ─── SERVER TAB: Glitch Player Vehicle ──────────────────────────────────────

MachoMenuButton(Vehicle[1], "Glitch Player Vehicle", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
        local targetServerId = %s
        local targetPlayer = GetPlayerFromServerId(targetServerId)
        if targetPlayer == -1 then return end
        local targetPed = GetPlayerPed(targetPlayer)
        if not DoesEntityExist(targetPed) then return end
        local targetCoords = GetEntityCoords(targetPed)
        local vehicleModel = "pounder2"
        RequestModel(vehicleModel)
        while not HasModelLoaded(vehicleModel) do Wait(0) end
        local vehicle = CreateVehicle(GetHashKey(vehicleModel), targetCoords.x, targetCoords.y, targetCoords.z, 0.0, true, true)
        if DoesEntityExist(vehicle) then
            NetworkRegisterEntityAsNetworked(vehicle)
            local netId = VehToNet(vehicle)
            SetNetworkIdExistsOnAllMachines(netId, true)
            SetNetworkIdCanMigrate(netId, true)
            Wait(500)
            AttachEntityToEntity(vehicle, targetPed, GetPedBoneIndex(targetPed, 0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        end
        SetModelAsNoLongerNeeded(vehicleModel)
    ]], GetValidPlayerID() or 0))
end)

-- ─── SERVER TAB: Attach Entity to Player ────────────────────────────────────

local AttachEntityList = {"prop_cs1_14b_traind", "prop_barrier_work05", "prop_dumpster_01a", "prop_roadcone02a", "prop_bench_01a", "prop_parking_meter_01", "prop_fire_hydrant_1", "prop_bin_01a", "prop_container_01a", "prop_elecbox_12", "prop_rub_trolley01", "prop_roadcone01a", "prop_roadpole_01a", "prop_skip_01a", "prop_portaloo_01a"}
MachoMenuDropDown(Server[1], "Attach Entity", function(index)
    local entityModels = AttachEntityList
    local entityModel = entityModels[index]
    if entityModel then
        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
            local targetServerId = %s
            local entityModel = "%s"
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            if targetPlayer == -1 then return end
            local targetPed = GetPlayerPed(targetPlayer)
            if not DoesEntityExist(targetPed) then return end
            local coords = GetEntityCoords(targetPed)
            local modelHash = GetHashKey(entityModel)
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do Wait(0) end
            local obj = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
            if DoesEntityExist(obj) then
                AttachEntityToEntity(obj, targetPed, GetPedBoneIndex(targetPed, 0), 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
            end
            SetModelAsNoLongerNeeded(modelHash)
        ]], GetValidPlayerID() or 0, entityModel))
    end
end, table.unpack(AttachEntityList))

-- ─── SERVER TAB: Attach Car To Everyone, Attach Entity To Everyone, Kill All ─

local AttachCarEveryoneList = {"luxor2", "banshee", "bullet", "cheetah", "entityxf", "infernus", "stinger", "stingergt", "voltic", "zentorno"}
MachoMenuDropDown(Server[2], "Attach Car To Everyone", function(index)
    local carModels = AttachCarEveryoneList
    local carModel = carModels[index]
    if carModel then
        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
            local vehicleModel = "%s"
            for _, playerId in ipairs(GetActivePlayers()) do
                if playerId ~= PlayerId() then
                    local targetPed = GetPlayerPed(playerId)
                    if DoesEntityExist(targetPed) then
                        local coords = GetEntityCoords(targetPed)
                        local modelHash = GetHashKey(vehicleModel)
                        RequestModel(modelHash)
                        while not HasModelLoaded(modelHash) do Wait(0) end
                        local veh = CreateVehicle(modelHash, coords.x, coords.y, coords.z, 0.0, true, true)
                        if DoesEntityExist(veh) then
                            AttachEntityToEntity(veh, targetPed, GetPedBoneIndex(targetPed, 0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                        end
                        SetModelAsNoLongerNeeded(modelHash)
                    end
                end
            end
        ]], carModel))
    end
end, table.unpack(AttachCarEveryoneList))

local AttachEntityEveryoneList = {"prop_cs1_14b_traind", "prop_barrier_work05", "prop_dumpster_01a", "prop_roadcone02a", "prop_bench_01a", "prop_bin_01a", "prop_container_01a", "prop_roadcone01a", "prop_skip_01a"}
MachoMenuDropDown(Server[2], "Attach Entity To Everyone", function(index)
    local entityModels = AttachEntityEveryoneList
    local entityModel = entityModels[index]
    if entityModel then
        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
            local entityModel = "%s"
            for _, playerId in ipairs(GetActivePlayers()) do
                if playerId ~= PlayerId() then
                    local targetPed = GetPlayerPed(playerId)
                    if DoesEntityExist(targetPed) then
                        local coords = GetEntityCoords(targetPed)
                        local modelHash = GetHashKey(entityModel)
                        RequestModel(modelHash)
                        while not HasModelLoaded(modelHash) do Wait(0) end
                        local obj = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
                        if DoesEntityExist(obj) then
                            AttachEntityToEntity(obj, targetPed, GetPedBoneIndex(targetPed, 0), 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                        end
                        SetModelAsNoLongerNeeded(modelHash)
                    end
                end
            end
        ]], entityModel))
    end
end, table.unpack(AttachEntityEveryoneList))

MachoMenuButton(Server[2], "Launch All Players", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        for _, playerId in ipairs(GetActivePlayers()) do
            if playerId ~= PlayerId() then
                local targetPed = GetPlayerPed(playerId)
                if DoesEntityExist(targetPed) then
                    ApplyForceToEntity(targetPed, 1, 0.0, 0.0, 150.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                end
            end
        end
    ]])
end)

-- ─── WEAPON TAB: Give Max Ammo + Spoof All Weapons ───────────────────────────

MachoMenuButton(Weapon[1], "Give Max Ammo", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        local playerPed = PlayerPedId()
        SetPedInfiniteAmmoClip(playerPed, false)
        local currentWeapon = GetSelectedPedWeapon(playerPed)
        if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
            SetPedAmmo(playerPed, currentWeapon, 9999)
        end
        local allWeapons = {
            "weapon_pistol","weapon_combatpistol","weapon_appistol","weapon_pistol50","weapon_microsmg",
            "weapon_smg","weapon_assaultsmg","weapon_assaultrifle","weapon_carbinerifle","weapon_advancedrifle",
            "weapon_sniperrifle","weapon_heavysniper","weapon_rpg","weapon_grenadelauncher","weapon_minigun",
            "weapon_pumpshotgun","weapon_sawnoffshotgun","weapon_assaultshotgun","weapon_bullpupshotgun",
            "weapon_heavyshotgun","weapon_knife","weapon_bat","weapon_hammer","weapon_crowbar","weapon_grenade",
            "weapon_stickybomb","weapon_molotov","weapon_revolver","weapon_machinepistol","weapon_switchblade"
        }
        for _, wep in ipairs(allWeapons) do
            local hash = GetHashKey(wep)
            if HasPedGotWeapon(playerPed, hash, false) then
                SetPedAmmo(playerPed, hash, 9999)
            end
        end
    ]])
end)

MachoMenuButton(Weapon[1], "Spoof All Weapons", function()
    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", [[
        local playerPed = PlayerPedId()
        local allWeapons = {
            "weapon_pistol","weapon_combatpistol","weapon_appistol","weapon_pistol50","weapon_heavypistol",
            "weapon_microsmg","weapon_smg","weapon_assaultsmg","weapon_assaultrifle","weapon_carbinerifle",
            "weapon_advancedrifle","weapon_specialcarbine","weapon_bullpuprifle","weapon_sniperrifle",
            "weapon_heavysniper","weapon_marksmanrifle","weapon_rpg","weapon_grenadelauncher","weapon_minigun",
            "weapon_pumpshotgun","weapon_sawnoffshotgun","weapon_assaultshotgun","weapon_bullpupshotgun",
            "weapon_heavyshotgun","weapon_knife","weapon_bat","weapon_hammer","weapon_crowbar","weapon_machete",
            "weapon_battleaxe","weapon_grenade","weapon_stickybomb","weapon_proxmine","weapon_molotov",
            "weapon_revolver","weapon_machinepistol","weapon_switchblade","weapon_hatchet"
        }
        for _, wep in ipairs(allWeapons) do
            GiveWeaponToPed(playerPed, GetHashKey(wep), 0, false, false)
        end
    ]])
end)

-- ─── TRIGGERS TAB: Custom Client/Server Trigger, Open Admin Menu, Clear Comms ─

local CustomClientEventHandle = MachoMenuInputbox(Triggers[3], "Client Event:", "event:name")
MachoMenuButton(Triggers[3], "Fire Client Event", function()
    local eventName = MachoMenuGetInputbox(CustomClientEventHandle)
    if eventName and eventName ~= "" then
        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
            TriggerEvent("%s")
        ]], eventName))
    end
end)

local CustomServerEventHandle = MachoMenuInputbox(Triggers[3], "Server Event:", "event:name")
MachoMenuButton(Triggers[3], "Fire Server Event", function()
    local eventName = MachoMenuGetInputbox(CustomServerEventHandle)
    if eventName and eventName ~= "" then
        MachoInjectResource(CheckResource("monitor") and "monitor" or "any", string.format([[
            TriggerServerEvent("%s")
        ]], eventName))
    end
end)

MachoMenuButton(Triggers[3], "Open Admin Menu", function()
    MachoInjectResource(CheckResource("ElectronAC") and "ElectronAC" or CheckResource("es_admin2") and "es_admin2" or CheckResource("qb-adminmenu") and "qb-adminmenu" or CheckResource("RSAdmin") and "RSAdmin" or CheckResource("monitor") and "monitor" or "any", [[
        TriggerEvent("ElectronAC:openMenu")
        TriggerEvent("esx_adminplus:openMenu")
        TriggerEvent("qb-adminmenu:openMenu")
        TriggerEvent("RSAdmin:openMenu")
        TriggerEvent("txAdmin:openMenu")
    ]])
end)

MachoMenuButton(Triggers[3], "Clear Comms", function()
    MachoInjectResource(CheckResource("pld_mission") and "pld_mission" or CheckResource("saltychat") and "saltychat" or CheckResource("monitor") and "monitor" or "any", [[
        TriggerEvent("pld_mission:clearCommunication")
        TriggerEvent("saltychat:toggleRadio")
        TriggerEvent("pld_cad:clearComms")
        NetworkClearVoiceChannel()
        MumbleSetAudioInputEnabled(false)
        Wait(200)
        MumbleSetAudioInputEnabled(true)
    ]])
end)

if CheckResource("scripts") then
    MachoMenuButton(Triggers[3], "Comserv End (-5)", function()
        MachoInjectResource("scripts", [[
            TriggerServerEvent("comserv:end")
        ]])
    end)
end

if CheckResource("es_extended") then
    MachoMenuButton(Triggers[3], "Give ESX Job (Police)", function()
        MachoInjectResource("es_extended", [[
            TriggerServerEvent("esx_policejob:getJob")
            TriggerEvent("esx:setJob", {name="police", label="Police", grade=0, grade_label="Officer"})
        ]])
    end)
end
