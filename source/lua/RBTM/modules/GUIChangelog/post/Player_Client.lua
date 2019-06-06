Script.Load("lua/RBTM/modules/GUIChangelog/new/GUIModChangelog.lua")

local function showchangelog()
    MainMenu_Open()
    local mm = GetGUIMainMenu and GetGUIMainMenu()
    if mm then
        local changelog = CreateMenuElement(mm.mainWindow, "GUIModChangelog")
        changelog:SetIsVisible(true)
    end
end

local oldOnInitLocalClient = Player.OnInitLocalClient
function Player:OnInitLocalClient()
    oldOnInitLocalClient(self)

    local oldversion = Client.GetOptionInteger("balancemod_version", 0)
    if kRBTMVersion > oldversion then
        Client.SetOptionInteger("balancemod_version", kRBTMVersion)
        showchangelog()
    end

end

Event.Hook("Console_changelog", showchangelog)