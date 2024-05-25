-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, _, _, _ = unpack(ElvUI)
local Module = ElvUI_ChatTweaks:NewModule("Hover Links", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Hover Links"]
Module.namespace = string.gsub(Module.name, " ", "")
Module.showingTip = false

local match = string.match

-- the link types we'll interact with, true = show tooltip, false = do nothing; list taken from https://wowpedia.fandom.com/wiki/Hyperlinks
local linkTypes = {
    achievement = true,
    api = false,
    battlepet = false,
    battlePetAbil = false,
    calendarEvent = false,
    channel = false,
    clubFinder = false,
    clubTicket = false,
    community = false,
    conduit = true,
    currency = true,
    death = false,
    dungeonScore = false,
    enchant = false,
    garrfollower = false,
    garrfollowerability = false,
    garrmission = false,
    instancelock = true,
    item = true,
    journal = false,
    keystone = true,
    levelup = false,
    lootHistory = false,
    mawpower = true,
    outfit = false,
    player = false,
    playerCommunity = false,
    BNplayer = false,
    BNplayerCommunity = false,
    quest = true,
    shareachieve = false,
    shareitem = false,
    sharess = false,
    spell = true,
    storecategory = false,
    talent = true,
    talentbuild = false,
    trade = false,
    transmogappearance = false,
    transmogillusion = false,
    transmogset = false,
    unit = true,
    urlIndex = false,
    worldmap = false,
}

function Module:OnHyperlinkEnter(frame, link)
    -- get the link type using regex
    local lType = match(link, "^(.-):")

    if linkTypes[lType] then
        -- show the tooltip
        self.showingTip = true
        ShowUIPanel(GameTooltip)
        GameTooltip:SetOwner(E.UIParent, "ANCHOR_CURSOR")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end
end

function Module:OnHyperlinkLeave(frame, link)
    if self.showingTip then
        -- hide the tooltip
        self.showingTip = false
        GameTooltip:Hide()
    end
end

function Module:OnEnable()
    for i = 1, NUM_CHAT_WINDOWS do
        local Frame = _G["ChatFrame" .. i]
        self:HookScript(Frame, "OnHyperlinkEnter", OnHyperlinkEnter)
        self:HookScript(Frame, "OnHyperlinkLeave", OnHyperlinkLeave)
    end
end

function Module:OnDisable()
    for i = 1, NUM_CHAT_WINDOWS do
        local Frame = _G["ChatFrame" .. i]
        self:Unhook(Frame, "OnHyperlinkEnter")
        self:Unhook(Frame, "OnHyperlinkLeave")
    end
end

function Module:Info()
    return L["Display a tooltip by hovering over a link in chat."]
end
