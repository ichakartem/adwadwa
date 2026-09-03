local a={cache={}::any}do do local function __modImpl()

return{
GameName="Dungeon Quest Reborn",





HUB_URL="https://apelhub.com/loader.lua",






DEV_URL="http://localhost:8081/DQR.lua",


ConfigFolder="ApelHub",




Debug=false,
}end function a.a():typeof(__modImpl())local b=a.cache.a if not b then b={c=__modImpl()}a.cache.a=b end return b.c end end do local function __modImpl()































local b=game:GetService"Players"
local c=game:GetService"RunService"
local d=game:GetService"UserInputService"
local e=b.LocalPlayer

local f={}


local g=false
pcall(function()g=d.TouchEnabled and not d.KeyboardEnabled end)
local function step()return g and 250 or 800 end

local function anyOn()return S.perfMode or S.ultraPerf end






local function protectedPart(h)
if h.Material==Enum.Material.Neon and h.Anchored
and not h.CanQuery and not h.CanCollide then
return true
end
local i=tostring(h.Name):lower()
if i:find("hitbox",1,true)or i:find("precast",1,true)then return true end
local j=h.Parent
if j then
local k=tostring(j.Name):lower()
if k:find("hitbox",1,true)or k:find("precast",1,true)then return true end
end
return false
end


local function tune(h)
if h:IsA"Terrain"then return end
if h:IsA"BasePart"and protectedPart(h)then return end
if h:IsA"BasePart"then
h.Material=Enum.Material.Plastic
h.Reflectance=0
if h:IsA"MeshPart"then h.TextureID=""end
elseif h:IsA"Decal"or h:IsA"Texture"then
h.Transparency=1
elseif h:IsA"ParticleEmitter"then
h.Lifetime=NumberRange.new(0)
elseif h:IsA"Trail"then
h.Lifetime=0
elseif h:IsA"Explosion"then
h.BlastPressure,h.BlastRadius=1,1
elseif h:IsA"Fire"or h:IsA"SpotLight"or h:IsA"Smoke"then
h.Enabled=false
end
end



function f.Boost()
if S._perfBoosting then return end
S._perfBoosting=true

pcall(function()
local h,i=game.Lighting,workspace.Terrain
pcall(function()i.WaterWaveSize,i.WaterWaveSpeed=0,0 end)
pcall(function()i.WaterReflectance,i.WaterTransparency=0,0 end)
pcall(function()h.GlobalShadows,h.FogEnd,h.Brightness=false,9e9,0 end)
pcall(function()settings().Rendering.QualityLevel="Level01"end)
for j,k in ipairs(h:GetChildren())do
if k:IsA"PostEffect"then pcall(function()k.Enabled=false end)end
end
end)




local h={workspace,game.Lighting}
pcall(function()
local i=e:FindFirstChild"PlayerGui"
if i then h[#h+1]=i end
end)

local i,j=0,step()
for k,l in ipairs(h)do
local m,n=pcall(function()return l:GetDescendants()end)
for o,p in ipairs((m and n)or{})do
if _apelStopped or not anyOn()then break end
pcall(tune,p)
i=i+1
if i%j==0 then task.wait()end
end
end

S._perfBoosting=false
end


function f.Watch()
regConn(workspace.DescendantAdded:Connect(function(h)
if anyOn()then pcall(tune,h)end
end))

end


local h="ApelUltraPerf"



local function guiParents()
local i={}
pcall(function()if gethui then i[#i+1]=gethui()end end)
pcall(function()i[#i+1]=game:GetService"CoreGui"end)
pcall(function()
local j=e:FindFirstChild"PlayerGui"
if j then i[#i+1]=j end
end)
return i
end

function f.KillScreen()
pcall(function()
if S._ultraGui then S._ultraGui:Destroy()end
end)
S._ultraGui,S._ultraLabel=nil,nil

for i,j in ipairs(guiParents())do
for k,l in ipairs(j:GetChildren())do
if l.Name==h then pcall(function()l:Destroy()end)end
end
end
end

function f.BuildScreen()
if S._ultraGui and S._ultraGui.Parent then return end

for i,j in ipairs(guiParents())do
local k=pcall(function()
local k=Instance.new"ScreenGui"
k.Name=h
k.IgnoreGuiInset=true
k.ResetOnSpawn=false
k.DisplayOrder=-1
k.Parent=j

local l=Instance.new"Frame"
l.Size=UDim2.fromScale(1,1)
l.BackgroundColor3=Color3.new(0,0,0)
l.BorderSizePixel=0
l.Parent=k

local m=Instance.new"TextLabel"
m.Size=UDim2.fromScale(1,1)
m.BackgroundTransparency=1
m.Font=Enum.Font.Code
m.TextSize=18
m.TextColor3=Color3.fromRGB(160,160,160)
m.TextXAlignment=Enum.TextXAlignment.Center
m.TextYAlignment=Enum.TextYAlignment.Center
m.Text="ULTRA PERFORMANCE MODE"
m.Parent=l

S._ultraGui,S._ultraLabel=k,m
end)
if k and S._ultraGui then return end
end
end

function f.SetScreenText(i)
if S._ultraLabel then pcall(function()S._ultraLabel.Text=i end)end
end

function f.Set3D(i)
pcall(function()c:Set3dRenderingEnabled(i)end)
end


function f.Stop()
f.Set3D(true)
f.KillScreen()
end

return f end function a.b():typeof(__modImpl())local b=a.cache.b if not b then b={c=__modImpl()}a.cache.b=b end return b.c end end do local function __modImpl()







local b={}


function b.begin()
ApelHubRunToken=tostring(tick()).."_"..tostring(math.random(1,1000000))
if getgenv then
getgenv()._ApelHub_RunToken=ApelHubRunToken
pcall(function()if getgenv()._ApelHub_Stop then getgenv()._ApelHub_Stop()end end)
end
task.wait(0.6)



_apelStopped=false
_apelConns={}
_apelThreads={}
function regConn(c)table.insert(_apelConns,c);return c end





function spawnLoop(c)
local d=task.spawn(c)
table.insert(_apelThreads,d)
return d
end
end


function b.install(c)
local function stopHub()
_apelStopped=true






pcall(function()a.b().Stop()end)
for d,e in ipairs(_apelConns or{})do pcall(function()e:Disconnect()end)end
table.clear(_apelConns)

for d,e in ipairs(_apelThreads or{})do
if coroutine.status(e)~="running"then pcall(task.cancel,e)end
end
table.clear(_apelThreads)
end

if getgenv then
getgenv()._ApelHub_Stop=function()
stopHub()
pcall(function()c:Destroy()end)
end


task.spawn(function()
while getgenv()._ApelHub_RunToken==ApelHubRunToken do task.wait(0.25)end
stopHub()
pcall(function()c:Destroy()end)
end)
end

c:OnUnload(function()
stopHub()
print"Apel Hub unloaded!"
end)
end

return b end function a.c():typeof(__modImpl())local b=a.cache.c if not b then b={c=__modImpl()}a.cache.c=b end return b.c end end do local function __modImpl()









local function loadApLib()
local b="https://raw.githubusercontent.com/dvorfkar6-lab/uis/refs/heads/main/ApLib.lua"
local c,d,e,f=b:match
"^https://raw%.githubusercontent%.com/([^/]+)/([^/]+)/refs/heads/([^/]+)/(.+)$"

local g={"http://localhost:8081/ApLib.lua",b}
if c then
g[#g+1]="https://apelhub.com/scripts/uis/"..f
g[#g+1]=("https://cdn.jsdelivr.net/gh/%s/%s@%s/%s"):format(c,d,e,f)
g[#g+1]=("https://fastly.jsdelivr.net/gh/%s/%s@%s/%s"):format(c,d,e,f)
end



local function looksLikeHtml(h)
local i=h:find"%S";if not i then return true end
local j=h:sub(i,i+13):lower()
return j=="<!doctype html"or j:sub(1,5)=="<html"
end




local function tryGet(h)
local i,j=false
task.spawn(function()
local k,l=pcall(function()return game:HttpGet(h)end)
if k then j=l end
i=true
end)
local k=0
while not i and k<5 do k=k+task.wait(0.05)end
if type(j)=="string"and#j>100 and not looksLikeHtml(j)then return j end
return nil
end

for h,i in ipairs(g)do
local j=tryGet(i)
if j then
local k=loadstring(j)
if k then
local l,m=pcall(k)
if l and type(m)=="table"then return m end
end
end
end
error"Apel Hub: failed to load ApLib"
end






HUB_URL="https://raw.githubusercontent.com/ApelsinkaFr/ApelHub/refs/heads/main/ApelHub"

return loadApLib end function a.d():typeof(__modImpl())local b=a.cache.d if not b then b={c=__modImpl()}a.cache.d=b end return b.c end end do local function __modImpl()



return function(b)
Players=game:GetService"Players"
ReplicatedStorage=game:GetService"ReplicatedStorage"
RunService=game:GetService"RunService"
Workspace=game:GetService"Workspace"

LocalPlayer=Players.LocalPlayer
GameName=b.GameName


S={

autoFarm=false,





autoDodge=true,

perfMode=false,
ultraPerf=false,


castReach=0,

showCastRange=false,

testZones=false,

testHop=false,

animRec=false,


castFirst="Any",


speedOn=false,
speedValue=20,
noclip=false,


autoGear=false,
gearSet=nil,
autoReady=false,
autoStart=false,
autoReplay=false,



stall=false,
stallSeconds=120,


smartDungeon=false,
lobbyDungeon=nil,
lobbyDifficulty="Nightmare",
lobbyLevelReq=1,
lobbyHardcore=false,
lobbyPrivate=false,
lobbyWaveDefence=false,
autoStartLobby=false,
autoJoin=false,
joinDungeons={},
joinDifficulty={},
joinHardcoreOnly=false,


raidTier=1,
raidPrivate=false,
raidLevelReq=1,
autoRaid=false,


autoSell=false,
sellMode="Rarity",
sellRarities={},
sellCategories={},
sellBelowLevel=1,
sellHold={},
sellKeepBest=true,
autoEquipBest=false,


equipByPotential=false,
equipGainPct=0,
equipBy="Spell Power",
equipArmorBy="Health",
autoUpgrade=false,
upgradeScope="Equipped",
upgradeStat="spell",
upgradeMode="spendAll",
autoSkill=false,
skillStat="spellPower",

hideName=false,


cosmeticGet=false,
cosmeticTargets={},


webhookOn=false,
webhookUrl="",
webhookUserId="",
webhookEveryone=false,
pingRarities={},


run=nil,
}
end end function a.e():typeof(__modImpl())local b=a.cache.e if not b then b={c=__modImpl()}a.cache.e=b end return b.c end end do local function __modImpl()







local b={
[85776757589518]=true,
[122144693520240]=true,
[14052121570]=true,
[14470497982]=true,
[108777488403937]=true,
}

return function()
IN_MATCH=b[game.PlaceId]==true



if not IN_MATCH and not b[game.PlaceId]then
pcall(function()
if workspace:FindFirstChild"dungeon"and not workspace:FindFirstChild"Lobby"then
IN_MATCH=true
end
end)
end

IN_LOBBY=not IN_MATCH
return IN_MATCH
end end function a.f():typeof(__modImpl())local b=a.cache.f if not b then b={c=__modImpl()}a.cache.f=b end return b.c end end do local function __modImpl()










return function()
local b=game:GetService"UserInputService"

S.lastInput=os.clock()
S.maxIdle=0
S.afkPulses=0
S.afkResets=0
S.idledAt=nil
S.idledVal=0


local c=getconnections or get_signal_cons
if c then
pcall(function()
for d,e in pairs(c(LocalPlayer.Idled))do
if e.Disable then e:Disable()elseif e.Disconnect then e:Disconnect()end
end
end)
else
local d=cloneref(game:GetService"VirtualUser")
regConn(LocalPlayer.Idled:Connect(function()
d:CaptureController()
d:ClickButton2(Vector2.new())
end))
end


regConn(LocalPlayer.Idled:Connect(function(d)
S.idledAt,S.idledVal=os.clock(),d
end))



local function markInput()
if os.clock()-S.lastInput>1 then S.afkResets=S.afkResets+1 end
S.lastInput=os.clock()
end
regConn(b.InputBegan:Connect(markInput))
regConn(b.InputChanged:Connect(function(d)
local e=d.UserInputType
if e==Enum.UserInputType.MouseMovement or e==Enum.UserInputType.Touch
or string.find(e.Name,"Gamepad")then
markInput()
end
end))


coroutine.wrap(function()
while not _apelStopped do
task.wait(5)
if _apelStopped then break end
pcall(function()
Instance.new"VirtualInputManager":SendKeyEvent(true,Enum.KeyCode.Unknown,false,game)
task.wait(0.05)
Instance.new"VirtualInputManager":SendKeyEvent(false,Enum.KeyCode.Unknown,false,game)
S.afkPulses=S.afkPulses+1
end)
end
end)()
end end function a.g():typeof(__modImpl())local b=a.cache.g if not b then b={c=__modImpl()}a.cache.g=b end return b.c end end do local function __modImpl()








return function(b,c,d)
Window=b.new{
Title="<text>Apel</text> Hub",
Menu=tostring(GameName):upper(),
Size=Vector2.new(780,440),
Key=Enum.KeyCode.LeftControl,
DragStyle=2,
Scope=d and"match"or"lobby",
}

tabs={
Dungeon=Window:Page"Dungeon",
Lobby=Window:Page"Lobby",
Joiner=Window:Page"Joiner",
Items=Window:Page"Items",
Char=Window:Page"Character",
Misc=Window:Page"Misc",
Settings=Window:Page"UI Settings",
Info=Window:Page("Information",{Hidden=true,Searchable=false}),
}

sections={
Farm=tabs.Dungeon:Section("Auto Farm",{Side="Left",Scope="match"}),
RunInfo=tabs.Dungeon:Section("Progress",{Side="Left",Scope="match"}),
Run=tabs.Dungeon:Section("Run Control",{Side="Right",Scope="match"}),

Create=tabs.Lobby:Section("Create Dungeon",{Side="Left",Scope="lobby"}),
Join=tabs.Lobby:Section("Join Other Dungeon",{Side="Right",Scope="lobby"}),
Raid=tabs.Lobby:Section("Boss Raid",{Side="Left",Scope="lobby"}),






Hoster=tabs.Joiner:Section("Hoster",{Side="Left"}),
Joining=tabs.Joiner:Section("Joiner",{Side="Right"}),

Sell=tabs.Items:Section("Auto Sell",{Side="Left"}),
Equip=tabs.Items:Section("Equip",{Side="Right"}),
Smith=tabs.Items:Section("Upgrade",{Side="Left"}),
Skills=tabs.Items:Section("Skill Points",{Side="Right"}),



Move=tabs.Char:Section("Movement",{Side="Left"}),

Stats=tabs.Misc:Section("Stats",{Side="Left"}),
Hook=tabs.Misc:Section("Discord",{Side="Right"}),
Perf=tabs.Misc:Section("Performance",{Side="Left"}),



Util=tabs.Misc:Section("Utility",{Side="Left"}),





Cosmetic=tabs.Misc:Section("Cosmetic Getter",{Side="Right"}),




SettingsSection=tabs.Settings:Section("Interface",{Side="Left",Collapsible=false}),
SettingsSection2=tabs.Settings:Section("Window",{Side="Right",Collapsible=false}),
SettingsSection3=tabs.Settings:Section("Session",{Side="Bottom",Collapsible=false}),
SettingsSection4=tabs.Settings:Section("Script Config",{Side="Bottom",Collapsible=false}),
KeyTimerSection=tabs.Settings:Section("Key Timer",{Side="Bottom",Collapsible=false}),

InfoSection=tabs.Info:Section("Getting started",{Collapsible=false}),
}



function Notify(e)
pcall(function()Window:Notify{Title="Apel Hub",Text=tostring(e)}end)
end

sections.InfoSection:Label(table.concat({
"<b>Apel <accent>Hub</accent></b> is loaded and ready.",
"",
"This game runs on two places, so the hub works on both:",
"in town open <accent>Lobby</accent> to pick a dungeon and queue it,",
"inside a dungeon open <accent>Dungeon</accent> for farming and run control.",
"Sections that belong to the other place are marked and stay quiet here.",
"",
"Everything you touch is saved automatically and comes back as you left it.",
"",
"Press <accent>Ctrl K</accent> to search every feature across all tabs.",
"Press <accent>Left Control</accent> to hide or show the window.",
"",
"Ideas, questions or just want to hang out? We are at <accent>discord.gg/apel</accent>.",
},"\n"))

return tabs,sections
end end function a.h():typeof(__modImpl())local b=a.cache.h if not b then b={c=__modImpl()}a.cache.h=b end return b.c end end do local function __modImpl()



return function(b,c,d)



local function notify(e)
pcall(function()b:Notify{Title="Apel Hub",Description=e}end)
end

c.SettingsSection:Slider{
Name="UI Size",
Default=1,
Min=0.5,
Max=2,
Decimals=2,
Flag="UiSizeSlider",
Callback=function(e)b:SetScale(e)end
}




c.SettingsSection:Toggle{
Name="UI Transparency",
Desc="Semi-transparent panels across the menu",
Default=true,
Flag="UiTransparency",
Callback=function(e)b:SetTransparencyEnabled(e)end
}

c.SettingsSection:Toggle{
Name="Minimize Button",
Desc="Floating round button that hides the menu",
Default=true,
Flag="UiMinimizer",
Callback=function(e)d:SetVisibility(e)end
}

c.SettingsSection:Toggle{
Name="Notifications",
Default=true,
Flag="UiNotifications",
Callback=function(e)
b.NotifyTop.Visible=e
b.NotifyBottom.Visible=e
end
}

c.SettingsSection2:Keybind{
Name="Toggle UI",
Default=Enum.KeyCode.LeftControl,
Flag="UiToggleKey",
Callback=function(e)b.ToggleKey=e end
}




c.SettingsSection2:Button{
Name="Reset UI Resize",
Text="Reset size",
Callback=function()b:ResetSize()end
}



c.SettingsSection2:Button{
Name="Destroy GUI",
Text="Unload",
Callback=function()
b:Dialog{
Title="Unload Apel Hub?",
Text=[[The menu closes and every running feature stops. You will have to execute the script again to bring it back.]]
,
Buttons={
{Name="Cancel"},
{Name="Unload",Primary=true,Callback=function()b:Destroy()end},
}
}
end
}
return notify
end end function a.i():typeof(__modImpl())local b=a.cache.i if not b then b={c=__modImpl()}a.cache.i=b end return b.c end end do local function __modImpl()







local b={weights={},_cond={},_order={},_n=0,_top=nil,_topAt=-1}

local c=0.25

function b.Register(d,e,f,g)
if d._order[e]==nil then
d._n=d._n+1
d._order[e]=d._n
end
d.weights[e]=f or d.weights[e]or 0
if g~=nil then d._cond[e]=g end
d._topAt=-1
return d
end

function b.SetWeight(d,e,f)
d.weights[e]=f or 0
d._topAt=-1
end

function b.SetEnabled(d,e,f)
d._cond[e]=f
d._topAt=-1
end


function b.List(d)
local e={}
for f in pairs(d._order)do e[#e+1]=f end
table.sort(e,function(f,g)return d._order[f]<d._order[g]end)
return e
end

function b.Top(d)
if _apelStopped then return nil end

local e=os.clock()
if(e-d._topAt)<c then return d._top end
d._topAt=e


if Window and Window.IsLoadingConfig and Window:IsLoadingConfig()then
d._top=nil
return nil
end

local f,g,h
for i,j in pairs(d._cond)do
local k=j
if type(j)=="function"then
local l,m=pcall(j)
k=l and m
end
if k then
local l,m=d.weights[i]or 0,d._order[i]or math.huge

if not f or l>g
or(l==g and m<h)then
f,g,h=i,l,m
end
end
end

d._top=f
return f
end




function b.Invalidate(d)
d._topAt=-1
end

function b.IsTop(d,e)
return d:Top()==e
end

return b end function a.j():typeof(__modImpl())local b=a.cache.j if not b then b={c=__modImpl()}a.cache.j=b end return b.c end end do local function __modImpl()




local b=a.j()

return function(c)
local d=b:List()
if#d==0 then return end


local e={}
for f,g in ipairs(d)do e[f]=g end
table.sort(e,function(f,g)
local h,i=b.weights[f]or 0,b.weights[g]or 0
if h==i then return f<g end
return h>i
end)

local f,g={},{}
for h,i in ipairs(e)do
local j=(i:gsub("(%l)(%u)","%1 %2"))
f[j]=i
g[h]=j
end

local h=c:Page"Priority":Section("Activity order",{Collapsible=false})
h:SubLabel"Drag to reorder. When several of these want to run at once, the one on top moves the character."

h:Priority{
Name="Activity order",
Items=g,
AlwaysOpen=true,
Flag="ActivityOrder",
Callback=function(i)
local j=#i
for k,l in ipairs(i)do
local m=f[l]
if m then b:SetWeight(m,(j-k+1)*10)end
end
end,
}
end end function a.k():typeof(__modImpl())local b=a.cache.k if not b then b={c=__modImpl()}a.cache.k=b end return b.c end end do local function __modImpl()

local b={}
b.enabled=false
function b.Init()end
function b.Log()end
function b.Dump()return""end
function b.Flush()end
return b end function a.l():typeof(__modImpl())local b=a.cache.l if not b then b={c=__modImpl()}a.cache.l=b end return b.c end end do local function __modImpl()






local b={}

local c
local d={}

local function folder()
if c and c.Parent then return c end
c=ReplicatedStorage:FindFirstChild"remotes"
or ReplicatedStorage:WaitForChild("remotes",20)
return c
end



function b.Get(e)
local f=d[e]
if f and f.Parent then return f end

local g=folder()
if not g then return nil end
f=g:FindFirstChild(e)
d[e]=f
return f
end


function b.Fire(e,...)
local f=b.Get(e)
if not f then return false end
local g=table.pack(...)
return(pcall(function()f:FireServer(table.unpack(g,1,g.n))end))
end



function b.Invoke(e,...)
local f=b.Get(e)
if not f then return false,nil end
local g=table.pack(...)
local h,i=pcall(function()return f:InvokeServer(table.unpack(g,1,g.n))end)
return h,i
end






function b.InvokeMulti(e,...)
local f=b.Get(e)
if not f then return false end
local g=table.pack(...)
local h=table.pack(pcall(function()
return f:InvokeServer(table.unpack(g,1,g.n))
end))
return table.unpack(h,1,h.n)
end






function b.OnClient(e,f)
local g=b.Get(e)
if not g or not g:IsA"RemoteEvent"then return nil end
return regConn(g.OnClientEvent:Connect(f))
end

return b end function a.m():typeof(__modImpl())local b=a.cache.m if not b then b={c=__modImpl()}a.cache.m=b end return b.c end end do local function __modImpl()






local b=a.m()

local c={}



function c.Char()
return LocalPlayer.Character
end

function c.HRP()
local d=LocalPlayer.Character
return d and d:FindFirstChild"HumanoidRootPart"
end

function c.Humanoid()
local d=LocalPlayer.Character
return d and d:FindFirstChildOfClass"Humanoid"
end

function c.Alive()
local d=c.Humanoid()
return d~=nil and d.Health>0 and c.HRP()~=nil
end





function c.Val(d,e)
local f=LocalPlayer:FindFirstChild(d)
if f and f:IsA"ValueBase"then return f.Value end
return e
end

function c.Level()return tonumber(c.Stat"Level")or 0 end
function c.Gold()return tonumber(c.Stat"Gold")or 0 end
function c.Gems()return tonumber(c.Stat"Gems")or 0 end

function c.Stat(d)
local e=LocalPlayer:FindFirstChild"leaderstats"
local f=e and e:FindFirstChild(d)
return f and f.Value or nil
end

function c.SkillPoints()return tonumber(c.Val("skillPoints",0))or 0 end
function c.Peaceful()return c.Val("peaceful",false)==true end
function c.BusyCasting()
local d=LocalPlayer.Character
local e=d and d:FindFirstChild"busyCasting"
return e~=nil and e.Value==true
end












local d,e=(-1)

function c.Inventory(f)
if not f and e and(os.clock()-d)<2 then return e end
local g,h=b.Invoke"reloadInvy"
if g and type(h)=="table"then
e,d=h,os.clock()
end
return e
end

function c.InvalidateInventory()
d=-1
end


c.CATEGORY_TO_TYPE={
weapons="weapon",
abilities="ability",
helmets="helmet",
chests="chest",
}




local function isEquipped(f)
if type(f)=="table"then
for g,h in pairs(f)do
if h==true then return true end
end
return false
end
return f==true
end
c.IsEquipped=isEquipped



function c.Items(f)
local g=c.Inventory(f)
local h={}
if type(g)~="table"then return h end

for i,j in pairs(c.CATEGORY_TO_TYPE)do
local k=g[i]
if type(k)=="table"then
for l,m in pairs(k)do
if type(m)=="table"then



local n=tostring(l):match"_(.+)$"or tostring(l)
local o=tonumber(n)or n
h[#h+1]={
type=j,
category=i,
num=o,
key=l,
data=m,
name=tostring(m.name or l),
rarity=string.lower(tostring(m.rarity or"common")),
equipped=isEquipped(m.equipped),
}
end
end
end
end
return h
end


function c.Keys()
local f=c.Inventory()
local g,h={},type(f)=="table"and f.keys or nil
if type(h)=="table"then
for i in pairs(h)do
local j=tonumber(i)
if j then g[#g+1]=j end
end
end
table.sort(g)
return g,(type(f)=="table"and tonumber(f.highestKeyTierObtained))or 0
end



c.RARITIES={"common","uncommon","rare","epic","legendary","ultimate"}

c.RARITY_COLOR={
common="#989898",
uncommon="#5BC250",
rare="#4B4DC3",
epic="#92469F",
legendary="#F49A09",
ultimate="#FF0000",
dev="#FFFFFF",
}

return c end function a.n():typeof(__modImpl())local b=a.cache.n if not b then b={c=__modImpl()}a.cache.n=b end return b.c end end do local function __modImpl()








local b=game:GetService"Players"

local c={}

local function ws(d)
return workspace:FindFirstChild(d)
end

local function valueOf(d,e,f)
local g=d and d:FindFirstChild(e)
if g and g:IsA"ValueBase"then return g.Value end
return f
end

function c.Folder()return ws"dungeon"end
function c.Name()return valueOf(workspace,"dungeonName","")end
function c.Progress()return valueOf(workspace,"dungeonProgress","")end
function c.Started()return valueOf(workspace,"dungeonStarted",false)==true end
function c.Hardcore()return valueOf(workspace,"hardcore",false)==true end
function c.Wave()return tonumber(valueOf(workspace,"currentWave",0))or 0 end
function c.Tier()return tonumber(valueOf(workspace,"tier",0))or 0 end
function c.TimeLeft()return tonumber(valueOf(workspace,"timeLeft",0))or 0 end

function c.BossRoom()
local d=c.Folder()
return d and d:FindFirstChild"bossRoom"
end

function c.Finished()
return valueOf(c.BossRoom(),"dungeonFinished",false)==true
end















function c.Elapsed()
local d=ws"start"
local e=d and d:FindFirstChild"startTime"
local f=e and tonumber(e.Value)
if not f then return nil end
return workspace:GetServerTimeNow()-f
end

function c.CountdownFinished()
local d=ws"start"
if not d then return true end

local e=d:FindFirstChild"countdownFinished"
if e and e.Value==true then return true end











local f=d:FindFirstChild"startTime"
local g=f and tonumber(f.Value)
if g then return workspace:GetServerTimeNow()>=g end

return e==nil
end

function c.FightingBoss()
return valueOf(c.BossRoom(),"fightingBoss",false)==true
end











function c.Rooms()
local d=c.Folder()
local e={}
if not d then return e end

for f,g in ipairs(d:GetChildren())do
if g:IsA"Model"or g:IsA"Folder"then
local h=g.Name=="bossRoom"
local i=g:FindFirstChild"enemyFolder"
local j=tonumber(valueOf(g,"order",nil))



local k
if h then k=math.huge
elseif j then k=j
elseif g:FindFirstChild"playerSpawn"or not i then k=-1
else k=f end

e[#e+1]={
model=g,
name=g.Name,
boss=h,
order=k,
enemies=i,


startPart=g:FindFirstChild"startPart"
or g:FindFirstChild"playerSpawn"
or g:FindFirstChild"checkPoint"
or g:FindFirstChildWhichIsA("BasePart",true),
endPart=g:FindFirstChild"endPart",
checkPoint=g:FindFirstChild"checkPoint",
}
end
end
table.sort(e,function(f,g)return f.order<g.order end)
return e
end



function c.PivotOf(d)
local e=d:FindFirstChild"HumanoidRootPart"or d.PrimaryPart
if e then return e.Position end
local f,g=pcall(function()return d:GetPivot()end)
if f and g then
local h=g.Position
if h.Magnitude>0.01 then return h end
end
return nil
end



function c.IsAlive(d)
local e=d:FindFirstChildOfClass"Humanoid"
return e~=nil and e.Health>=0.1
end

function c.AliveIn(d)
local e={}
local f=d and d.enemies
if not f then return e end
for g,h in ipairs(f:GetChildren())do
if h:IsA"Model"and c.IsAlive(h)and c.PivotOf(h)then e[#e+1]=h end
end
return e
end



function c.NextRoomWithEnemies(d)
for e,f in ipairs(c.Rooms())do
if not(d and f.boss)then
local g=c.AliveIn(f)
if#g>0 then return f,g end
end
end
return nil,{}
end



c.LOOSE_TARGETS={
["Azrallik's Heart"]=true,
}

function c.AllAlive()
local d={}
local e=c.Folder()
if e then
for f,g in ipairs(e:GetChildren())do
local h=g:FindFirstChild"enemyFolder"
if h then
for i,j in ipairs(h:GetChildren())do
if j:IsA"Model"and c.IsAlive(j)then d[#d+1]=j end
end
end
end
end

local f=ws"enemies"
if f then
for g,h in ipairs(f:GetChildren())do
if h:IsA"Model"and c.IsAlive(h)then d[#d+1]=h end
end
end










for g in pairs(c.LOOSE_TARGETS)do
local h=ws(g)
if h and h:IsA"Model"and c.IsAlive(h)then d[#d+1]=h end
end












if not e then
for g,h in ipairs(workspace:GetChildren())do
if h:IsA"Model"and not b:GetPlayerFromCharacter(h)
and h:FindFirstChildWhichIsA"Humanoid"and c.IsAlive(h)then
d[#d+1]=h
end
end
end

return d
end















function c.Targets()
local d=c.AllAlive()
if c.Folder()then return d end

local e={}
local f=ws"enemies"
if f then
for g,h in ipairs(d)do
if h.Parent==f then e[#e+1]=h end
end
end
if#e==0 then return d end
return e
end

function c.Nearest(d,e)
local f,g=e or math.huge
for h,i in ipairs(c.AllAlive())do
local j=c.PivotOf(i)
if j then
local k=(j-d).Magnitude
if k<=f then g,f=i,k end
end
end
return g,f
end







function c.Difficulty()
local d=""
pcall(function()
local e=game:GetService"ReplicatedStorage":FindFirstChild"Utility"
local f=e and e:FindFirstChild"PlaceManager"
if not f then return end
local g=require(f)
local h=g.GetPlaceTeleportData and g.GetPlaceTeleportData()
local i=type(h)=="table"and(h.dungeonStats or h)or nil
if type(i)=="table"and i.difficulty then d=tostring(i.difficulty)end
end)
return d
end





function c.IsOwner()
local d=LocalPlayer.UserId

local e,f=pcall(function()
local e=ReplicatedStorage:FindFirstChild"Utility"
e=e and e:FindFirstChild"PlaceManager"
if not e then return nil end
local f=require(e)
return f.GetDungeonOwnerId and f.GetDungeonOwnerId()or nil
end)
if e and f then return d==f end

local g,h=pcall(function()return LocalPlayer:GetJoinData()end)
if g and h and h.TeleportData then
local i=h.TeleportData
if i.ownerId then return d==i.ownerId end
if i.dungeonStats and i.dungeonStats.ownerId then return d==i.dungeonStats.ownerId end
end

local i=c.Folder()
if i then
local j=i:FindFirstChild"ownerId"or(c.BossRoom()and c.BossRoom():FindFirstChild"ownerId")
if j and j:IsA"NumberValue"then return d==j.Value end
end
return false
end



function c.ReplayData()
local d={}
d.dungeonName=c.Name()
d.dungeonProgress=c.Progress()
d.dungeonStarted=c.Started()
d.hardcore=c.Hardcore()
d.isHardcore=d.hardcore

local e=c.Folder()
if e then
for f,g in ipairs(e:GetChildren())do
if g:IsA"ValueBase"then d[g.Name]=g.Value end
end
local f=e:FindFirstChild"bossRoom"
if f then
for g,h in ipairs(f:GetChildren())do
if h:IsA"ValueBase"then d[h.Name]=h.Value end
end
end
end
return d
end







local function statOf(d,e)
local f=d and d:FindFirstChild(e)
if not f then return 0 end
local g=f:FindFirstChild(LocalPlayer.Name)
if g and g:IsA"ValueBase"then return tonumber(g.Value)or 0 end
return 0
end

function c.Stats()
local d=ws"stats"
if not d then return{dealt=0,taken=0,healed=0}end
return{
dealt=statOf(d,"dealt"),
taken=statOf(d,"taken"),
healed=statOf(d,"healed"),
}
end

return c end function a.o():typeof(__modImpl())local b=a.cache.o if not b then b={c=__modImpl()}a.cache.o=b end return b.c end end do local function __modImpl()













local b=a.m()
local c=a.n()
local d=a.o()

local e={}

local f
local g



local h=4



e.WantReport=nil

local function num(i)return tonumber(i)or 0 end



e.Prefetch=nil









e.OnOutcome=nil



function e.Active()return f~=nil end








function e.Begin(i)
if f then return end


task.spawn(function()
local j=e.DungeonImage(d.Name())
if j and e.Prefetch then e.Prefetch(j)end
end)
f={
startedAt=os.clock(),
fromStart=i~=false,
dungeon=d.Name(),
difficulty="",
hardcore=d.Hardcore(),
tier=d.Tier(),
level=num(c.Level()),
xp=num(c.Val("XP",0)),
xpNeeded=num(c.Val("XPNeeded",0)),
}






pcall(function()
local j=ReplicatedStorage:FindFirstChild"Utility"
local k=j and j:FindFirstChild"PlaceManager"
if not k then return end

local l=require(k)
local m=l.GetPlaceTeleportData and l.GetPlaceTeleportData()
local n=type(m)=="table"and(m.dungeonStats or m)or nil
if type(n)~="table"then return end

f.difficulty=tostring(n.difficulty or"")
f.waveDefence=n.isWaveDefense==true
if n.hardcore~=nil then f.hardcore=n.hardcore==true end
if n.isHardcore~=nil then f.hardcore=n.isHardcore==true end
end)
end



local i={}

function e.DungeonImage(j)
if not j or j==""then return nil end
if i[j]~=nil then return i[j]or nil end
local k,l=b.Invoke("getDungeonStats",j)
i[j]=(k and type(l)=="table"and l.imageId)or false
return i[j]or nil
end



function e.Finish(j)
if not f then return false end
local k=f
f=nil

g={
snap=k,
completed=j==true,
stats=d.Stats(),
duration=os.clock()-k.startedAt,
imageId=e.DungeonImage(k.dungeon~=""and k.dungeon or d.Name()),
gold=0,
drops={},
}
return true
end





local function tpl(j,k)
if typeof(j)~="Instance"then return nil end
local l=j:FindFirstChild(k)
if l and l:IsA"ValueBase"then return l.Value end
return nil
end

local function describeItem(j)
local k=j and j.template
local l=tpl(k,"name")
or(typeof(k)=="Instance"and k.Name)
or"Unknown item"



return{
name=tostring(l),
rarity=string.lower(tostring(j.rarity or tpl(k,"rarity")or"common")),
imageId=tpl(k,"imageId"),
levelReq=tpl(k,"levelReq"),
physicalDamage=tpl(k,"physicalDamage"),
physicalPower=tpl(k,"physicalPower"),
spellPower=tpl(k,"spellPower"),
health=tpl(k,"health"),
sellPrice=tpl(k,"sellPrice"),
maxUpgrades=tpl(k,"maxUpgrades"),
itemType=tpl(k,"type")or"item",
}
end



local function compose(j)
local k=j.snap
local l=j.stats or{}

local m=num(c.Level())
local n=num(c.Val("XP",0))



local o=n-num(k.xp)
if m>num(k.level)then o=n+math.max(0,num(k.xpNeeded)-num(k.xp))end

return{
completed=j.completed,
dungeon=k.dungeon~=""and k.dungeon or d.Name(),
difficulty=k.difficulty,
hardcore=k.hardcore,
waveDefence=k.waveDefence,
tier=k.tier,
imageId=j.imageId,
duration=j.duration,
dealt=l.dealt,taken=l.taken,healed=l.healed,


gold=num(j.gold),
goldTotal=num(c.Gold())+num(j.gold),
eventCurrency=j.eventCurrency,
xp=math.max(0,o),
level=m,



xpNow=n,
xpNeeded=num(c.Val("XPNeeded",0)),
levels=math.max(0,m-num(k.level)),
drops=j.drops or{},
}
end



function e.Watch(j,k)


if d.Started()then e.Begin(false)end

local l=workspace:FindFirstChild"dungeonStarted"
if l then
regConn(l.Changed:Connect(function(m)
if m==true then e.Begin()end
end))
end



local function send()
local m=g
if not m then return end
g=nil
local n=compose(m)
if j then j(n)end
end




b.OnClient("cloneRewardGui",function(m)
if type(m)~="table"then return end

local n={}
for o,p in pairs(m.items or{})do
if type(p)=="table"and p.template~=nil then
n[#n+1]=describeItem(p)
end
end

if g then
g.gold=num(m.gold)
g.eventCurrency=m.eventCurrency
g.rewarded=true
for o,p in ipairs(n)do
g.drops[#g.drops+1]=p


if p.imageId and e.Prefetch then e.Prefetch(p.imageId)end
end
end
end)











local function finish(m)
if not e.Finish(m)then return end




if e.OnOutcome and g then
local n=g
pcall(e.OnOutcome,{
completed=n.completed,
dungeon=n.snap.dungeon~=""and n.snap.dungeon or d.Name(),



difficulty=(n.snap.difficulty~=""and n.snap.difficulty)
or d.Difficulty(),
hardcore=n.snap.hardcore,
duration=n.duration,
dealt=(n.stats or{}).dealt,
measured=n.snap.fromStart~=false,
})
end

local n=e.WantReport==nil or e.WantReport()==true
if not n then
g=nil
if k then k()end
return
end

task.spawn(function()
local o=0

while m and g and not g.rewarded and o<h do
o=o+task.wait(0.1)
end
send()
if k then k()end
end)
end



spawnLoop(function()
while not _apelStopped do
task.wait(0.15)
if d.Finished()or d.Progress()=="bossKilled"then


if f and(os.clock()-f.startedAt)>3 then finish(true)end
elseif not f and d.Started()then
e.Begin()
end
end
end)

b.OnClient("loadCompleteGui",function()finish(true)end)
b.OnClient("loadFailedGui",function()finish(false)end)
end

return e end function a.p():typeof(__modImpl())local b=a.cache.p if not b then b={c=__modImpl()}a.cache.p=b end return b.c end end do local function __modImpl()



















local b=game:GetService"HttpService"

local c={}















local function fileName()
local d,e=pcall(function()
return game:GetService"Players".LocalPlayer.UserId
end)
return("ApelHub/DQR_smart_%s.json"):format(d and tostring(e)or"unknown")
end


local d=3


local e=1.10











local function keyOf(f,g)
return tostring(f or""):lower().."|"..tostring(g or""):lower()
end

local function canDisk()
return type(writefile)=="function"and type(readfile)=="function"
and type(isfile)=="function"
end

local f











local function load()
if f then return f end
if not canDisk()then
f={}
return f
end

local g
pcall(function()
if isfile(fileName())then
local h=b:JSONDecode(readfile(fileName()))
if type(h)=="table"then g=h end
else
g={}
end
end)

if not g then return{}end
f=g
return f
end

local function save()

if not canDisk()or not f then return end
pcall(function()
if type(isfolder)=="function"and type(makefolder)=="function"
and not isfolder"ApelHub"then
makefolder"ApelHub"
end
writefile(fileName(),b:JSONEncode(f))
end)
end




local function peek(g,h)
return load()[keyOf(g,h)]
end

local function entry(g,h)
local i=load()
local j=keyOf(g,h)
local k=i[j]
if not k then
k={hcFails=0,hcOff=false,hcDps=0,
fails=0,dropped=false,dropDps=0}
i[j]=k
end
return k
end









local function release(g,h)
local i=load()


local j=tostring(g):lower().."|"
for k,l in pairs(i)do
if type(l)=="table"and type(k)=="string"and k:sub(1,#j)==j then







if l.hcOff and(not l.hcDps or l.hcDps<=0 or h>l.hcDps*e)then
l.hcOff,l.hcDps=false,0
end
if l.dropped and(not l.dropDps or l.dropDps<=0 or h>l.dropDps*e)then
l.dropped,l.dropDps=false,0
end
end
end
end




function c.HardcoreAllowed(g,h)
if not g or g==""then return true end
local i=peek(g,h)
return not(i and i.hcOff)
end







function c.Rejects(g,h,i)
if not g or g==""or not h or h==""then
return false
end
local j=peek(g,h)
if not j then return false end
if i and j.hcOff then return true end
return j.dropped==true
end


function c.Dropped(g,h)
if not g or g==""then return false end
local i=peek(g,h)
return i~=nil and i.dropped==true
end





local function stepDown(g,h)
for i,j in ipairs(h or{})do
if j==g then



return i>1 and h[i-1]or g
end
end
return g
end











function c.Adjust(g,h,i)
if not g or g==""or not h then return h end
local j=#(i or{})
for k=1,math.max(j,1)do
if not c.Dropped(g,h)then break end
local l=stepDown(h,i)
if l==h then break end
h=l
end
return h
end









function c.Note(g)
if type(g)~="table"then return end
local h=g.dungeon
local i=g.difficulty
if not h or h==""or not i or i==""then return end

local j=entry(h,i)

local k=tonumber(g.duration)or 0
local l=tonumber(g.dealt)or 0




local m=(g.measured~=false and k>1)and(l/k)or 0

if g.completed then





j.hcFails,j.fails=0,0
release(h,m)
save()
return
end


if g.hardcore then
j.hcFails=j.hcFails+1
if j.hcFails>=d then
j.hcOff=true

j.hcDps=m






j.hcFails,j.fails=0,0
end
else
j.fails=j.fails+1
if j.fails>=d then
j.dropped=true
j.dropDps=m
j.fails=0
end
end
save()
end



function c.Forget(g,h)
local i=load()
if g and g~=""then
i[keyOf(g,h)]=nil
else
f={}
end
save()
end

function c.All()return load()end

return c end function a.q():typeof(__modImpl())local b=a.cache.q if not b then b={c=__modImpl()}a.cache.q=b end return b.c end end do local function __modImpl()










local b=game:GetService"HttpService"

local c={}

local d="Apel Hub Webhook"
local e=32768

local function requestFn()
return(syn and syn.request)or(http and http.request)or http_request or request
end
















local f="ApelHub/DQR_thumbs.json"

local g

local function loadThumbs()
if g then return g end
g={}
if type(isfile)~="function"or type(readfile)~="function"then return g end
pcall(function()
if isfile(f)then
local h=b:JSONDecode(readfile(f))
if type(h)=="table"then g=h end
end
end)
return g
end

local function saveThumbs()
if type(writefile)~="function"then return end
pcall(function()
if type(isfolder)=="function"and type(makefolder)=="function"and not isfolder"ApelHub"then
makefolder"ApelHub"
end
writefile(f,b:JSONEncode(g or{}))
end)
end



local function resolve(h)
local i=loadThumbs()
if i[h]then return i[h]end

local j=requestFn()
if not j then return nil end
local k=("https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=420x420&format=Png&isCircular=false"):format(h)
local l,m=pcall(function()return j{Url=k,Method="GET"}end)
local n=l and m and(m.Body or m.body)
if type(n)~="string"then return nil end

local o=n:match'"imageUrl"%s*:%s*"(.-)"'
if not o or o==""then return nil end
o=(o:gsub("\\/","/"))

i[h]=o
saveThumbs()
return o
end

local function assetId(h)
return tostring(h or""):match"(%d+)"
end


function c.Prefetch(h)
local i=assetId(h)
if not i then return end
if loadThumbs()[i]then return end
task.spawn(resolve,i)
end






function c.Thumb(h)
local i=assetId(h)
if not i then return nil end

local j=loadThumbs()[i]
if j then return j end

task.spawn(resolve,i)
return nil
end






local function sendRaw(h)
local i=tostring(S.webhookUrl or"")
if i==""then return 0 end
i=i..(i:find("?",1,true)and"&"or"?").."with_components=true"

local j,k=0

local l=requestFn()
if l then
local m,n=pcall(function()
return l{Url=i,Method="POST",
Headers={["Content-Type"]="application/json"},Body=h}
end)
if m and n then
local o=tonumber(n.StatusCode or n.status_code or n.code)or 0
if o>=200 and o<=299 then return o end
if o>0 then j,k=o,n.Body or n.body end
end
end

local m,n=pcall(function()
return b:RequestAsync{Url=i,Method="POST",
Headers={["Content-Type"]="application/json"},Body=h}
end)
if m and n then
local o=tonumber(n.StatusCode)or 0
if o>=200 and o<=299 then return o end
if o>0 and j==0 then j,k=o,n.Body end
end



if j==0 then
local o=pcall(function()
b:PostAsync(i,h,Enum.HttpContentType.ApplicationJson,false)
end)
if o then return 200 end
end

return j,k
end

local function ping()
local h={}
if S.webhookEveryone then h[#h+1]="@everyone"end
local i=tostring(S.webhookUserId or"")
if i~=""then h[#h+1]="<@"..i..">"end
return#h>0 and table.concat(h," ")or nil
end



function c.SendRaw(h)
if tostring(S.webhookUrl or"")==""then return 0,"no url"end
if type(h)~="table"then return 0,"bad message"end

h.username=d
h.flags=e
h.allowed_mentions={parse={"users","everyone"}}

local i,j=pcall(function()return b:JSONEncode(h)end)
if not i then return 0,"encode failed"end

local k,l=sendRaw(j)
if k>=200 and k<=299 then return k end
if k==0 then return 0,"no HTTP access"end


local m=type(l)=="string"and l:match'"message"%s*:%s*"(.-)"'or nil
return k,("HTTP %s%s"):format(tostring(k),m and(" — "..m)or"")
end











local h={
arrow="<:arrow:1529932375339827271>",
victory="<:victory:1529957193569407064>",
defeat="<:defeat:1529975410928914486>",
clock="<:clock:1531389528021925918>",
person="<:person:1529967343193817089>",
rewards="<:Rewards:1531389702756634654>",
gold="<:gold:1531391553283821668>",
gem="<:gem:1531391256448602152>",
exp="<:player_exp:1531391369178910720>",
}

local i=string.rep("\226\160\128",3)

local function whE(j)return h[j]or""end
local function whHead(j)return"-# "..j end
local function whItem(j)return i..whE"arrow".." "..j end

local function short(j)
j=tonumber(j)or 0
for k,l in ipairs{{1e12,"T"},{1e9,"B"},{1e6,"M"},{1e3,"K"}}do
if j>=l[1]then return("%.2f%s"):format(j/l[1],l[2])end
end
return("%.0f"):format(j)
end

local function clock(j)
j=math.max(0,math.floor(tonumber(j)or 0))
return("%d:%02d"):format(math.floor(j/60),j%60)
end


local function compose(j,k,l,m,n,o)
local p={

k and{type=9,components={{type=10,content=j}},
accessory={type=11,media={url=k}}}
or{type=10,content=j},
{type=14,divider=true,spacing=1},
}
for q,r in ipairs(m)do
if#r.lines>0 then
p[#p+1]={type=10,content=whHead(r.title).."\n"..table.concat(r.lines,"\n")}
p[#p+1]={type=14,divider=true,spacing=1}
end
end
p[#p+1]={type=10,content=whHead(n)}

local q={}

if o then q[#q+1]={type=10,content=o}end
q[#q+1]={type=17,accent_color=l,components=p}
return{flags=32768,components=q}
end

local function footerLine()
return("Dungeon Quest Reborn · %s ||%s|| · <t:%d:R>")
:format(whE"person",game.Players.LocalPlayer.Name,os.time())
end

function c.Test()
return c.SendRaw(compose(
("## %s Apel Hub connected"):format(whE"victory"),
nil,0xF08A3C,
{{title="Check",lines={
whItem"Webhook is wired up.",
whItem(("%s **Player** ||%s||"):format(whE"person",game.Players.LocalPlayer.Name)),
}}},
footerLine(),ping()))
end



function c.Run(j)
local k=j.completed==true



local l={tostring(j.dungeon or"Dungeon")}
if j.difficulty and j.difficulty~=""then l[#l+1]=j.difficulty end
if j.hardcore then l[#l+1]="Hardcore"end
if j.waveDefence then l[#l+1]="Wave Defence"end
if j.tier and j.tier>0 then l[#l+1]="Tier "..tostring(j.tier)end

local m={
("## %s %s"):format(k and whE"victory"or whE"defeat",k and"Completed"or"Failed"),
i.."**"..table.concat(l," · ").."**",
}

local n={
whItem(("**Duration** %s %s"):format(whE"clock",clock(j.duration))),
whItem(("**Damage dealt** %s"):format(short(j.dealt))),
}
if(j.taken or 0)>0 then n[#n+1]=whItem(("**Damage taken** %s"):format(short(j.taken)))end
if(j.healed or 0)>0 then n[#n+1]=whItem(("**Healing done** %s"):format(short(j.healed)))end

local o={}
if(j.gold or 0)>0 then
o[#o+1]=whItem(("%s **Gold** +%s  _(%s)_"):format(
whE"gold",short(j.gold),short(j.goldTotal)))
end
if(j.xp or 0)>0 then
o[#o+1]=whItem(("%s **XP** +%s"):format(whE"exp",short(j.xp)))
end



if(j.level or 0)>0 then
local p
if(j.levels or 0)>0 then
p=("%s **Level** %d → %d"):format(
whE"exp",j.level-j.levels,j.level)
else
p=("%s **Level** %d"):format(whE"exp",j.level)
end
if(j.xpNeeded or 0)>0 then
p=p..("  _(%s/%s)_"):format(
short(j.xpNow),short(j.xpNeeded))
end
o[#o+1]=whItem(p)
end


local p={}
for q,r in ipairs(j.drops or{})do
if#p>=20 then
p[#p+1]=whItem(("_and %d more_"):format(#j.drops-20))
break
end



local s={}
if r.levelReq then s[#s+1]="lvl "..tostring(r.levelReq)end
local u=(tonumber(r.physicalDamage)or 0)>0 and r.physicalDamage or r.physicalPower
if(tonumber(u)or 0)>0 then s[#s+1]=short(u).." phys"end
if(tonumber(r.spellPower)or 0)>0 then s[#s+1]=short(r.spellPower).." spell"end
if(tonumber(r.health)or 0)>0 then s[#s+1]=short(r.health).." hp"end
p[#p+1]=whItem(("**%s** _(%s)_%s"):format(
tostring(r.name),tostring(r.rarity),
#s>0 and("  ·  "..table.concat(s," · "))or""))
end
if#p==0 then p[1]=whItem"_nothing dropped_"end

local q=j.imageId and c.Thumb(j.imageId)or nil


local r=ping()
if r and next(S.pingRarities or{})then
r=nil
for s,u in ipairs(j.drops or{})do
if S.pingRarities[u.rarity]then r=ping()break end
end
end

return c.SendRaw(compose(
table.concat(m,"\n"),
q,
k and 0x5BC236 or 0xE03A3A,
{
{title="Run",lines=n},
{title="Gained",lines=o},
{title="Loot "..whE"rewards",lines=p},
},
footerLine(),r))
end

return c end function a.r():typeof(__modImpl())local b=a.cache.r if not b then b={c=__modImpl()}a.cache.r=b end return b.c end end do local function __modImpl()







local b=a.n()

local c=game:GetService"TweenService"

local d={}

local e=16








local f=false

local g=RaycastParams.new()
g.FilterType=Enum.RaycastFilterType.Exclude
g.IgnoreWater=true


local h







local i=false

function d.SetVoidGuard(j)
LPH_ATTRIBUTES(VM(NONE))
i=j==true
if not i then h=nil end
end



local j

function d.SetFloorFilter(k)
LPH_ATTRIBUTES(VM(NONE))j=k end





















local k={}

local function applyNoclip()
LPH_ATTRIBUTES(VM(NONE))
local l=LocalPlayer.Character
if not l then return end
for m,n in ipairs(l:GetDescendants())do
if n:IsA"BasePart"and n.CanCollide then
k[n]=true
n.CanCollide=false
end
end
end

function d.RestoreNoclip()
LPH_ATTRIBUTES(VM(NONE))
for l in pairs(k)do
pcall(function()
if l.Parent then l.CanCollide=true end
end)
end
table.clear(k)
end

















local l=20
local m=3

local n,o

local function rideStop()
LPH_ATTRIBUTES(VM(NONE))
if n then
pcall(function()n:Cancel()end)
n=nil
end
o=nil
end


























local function aimAt(p,q,r)
LPH_ATTRIBUTES(VM(NONE))
local s=r-q
if s.Magnitude<0.01 then

return CFrame.new(q)*(p.CFrame-p.CFrame.Position)
end
s=s.Unit

local u=Vector3.new(0,1,0)
if math.abs(s.Y)>0.999 then
u=p.CFrame.RightVector
if u.Magnitude<0.1 then u=Vector3.new(1,0,0)end
end
return CFrame.lookAt(q,q+s,u)
end

local function rideTo(p,q,r)
LPH_ATTRIBUTES(VM(NONE))







local s=n and n.PlaybackState==Enum.PlaybackState.Playing
local u=o and(q-o).Magnitude<m

local v=aimAt(p,q,r)



if u and s then return nil end

rideStop()
local w=(q-p.Position).Magnitude
o=q













if w<m then return v end

n=c:Create(p,
TweenInfo.new(w/l,Enum.EasingStyle.Linear),
{CFrame=v})
n:Play()
return nil
end

function d.BeginPin()
LPH_ATTRIBUTES(VM(NONE))
if f then return end
f=true
local p=b.Humanoid()
if p then
p.AutoRotate=false
p.PlatformStand=true
end
end

function d.EndPin()
LPH_ATTRIBUTES(VM(NONE))
if not f then return end
f=false

rideStop()






local p=b.HRP()
if p then
p.AssemblyLinearVelocity=Vector3.zero
p.AssemblyAngularVelocity=Vector3.zero
end

local q=b.Humanoid()
if q then
q.AutoRotate=true
q.PlatformStand=false
end
end

function d.IsPinning()
LPH_ATTRIBUTES(VM(NONE))return f end

















local function hasGroundUnder(p)
LPH_ATTRIBUTES(VM(NONE))
local q=LocalPlayer.Character
g.FilterDescendantsInstances=q and{q}or{}
return workspace:Raycast(p,Vector3.new(0,-300,0),g)~=nil
end
























local p="?"
local q
local r

function d.SetTrace(s)
LPH_ATTRIBUTES(VM(NONE))r=s end
function d.Where(s)
LPH_ATTRIBUTES(VM(NONE))p=s end












local s

function d.SetGroundClamp(u)
LPH_ATTRIBUTES(VM(NONE))s=u end














function d.Fit(u)
LPH_ATTRIBUTES(VM(NONE))
if not s then return u end
return s(u)or u
end



function d.LastWhere()
LPH_ATTRIBUTES(VM(NONE))return p end

function d.Grounded(u)
LPH_ATTRIBUTES(VM(NONE))
return hasGroundUnder(u)
end

function d.RescueFromVoid()
LPH_ATTRIBUTES(VM(NONE))
if not i then return false end
local u=b.HRP()
if not u or not h then return false end



if u.Position.Y>h.Y-40 then return false end
if hasGroundUnder(u.Position)then return false end

u.CFrame=CFrame.new(h)
u.AssemblyLinearVelocity=Vector3.zero
u.AssemblyAngularVelocity=Vector3.zero
return true
end


function d.Pin(u,v)
LPH_ATTRIBUTES(VM(NONE))
local w=b.HRP()
if not w then return false end



if s then
local x=s(u)
if x and x~=u then
v=v+(x-u)
u=x
end
end




















if i and not hasGroundUnder(u)then
v=w.Position+(v-u)
u=w.Position
end





if i then
if not hasGroundUnder(u)then
if h then
v=h+(v-u)
u=h
end
else
h=u
end
end

if r then
local x=q and(u-q).Magnitude or math.huge
if x>15 then
r(("s67"):format(
p,
w.Position.X,w.Position.Y,w.Position.Z,
u.X,u.Y,u.Z,
x==math.huge and-1 or x,
hasGroundUnder(u)and"s68"or"s69"))
end
q=u
end

d.BeginPin()

local x=b.Humanoid()
if x and not x.PlatformStand then x.PlatformStand=true end


local y=rideTo(w,u,v)
if y then w.CFrame=y end







w.AssemblyLinearVelocity=Vector3.zero
w.AssemblyAngularVelocity=Vector3.zero
return true
end








local u=20

function d.TargetSpeed()
LPH_ATTRIBUTES(VM(NONE))
if S.speedOn then
return math.clamp(tonumber(S.speedValue)or e,1,u)
end
return e
end






function d.Watch()
LPH_ATTRIBUTES(VM(NONE))
regConn(RunService.Heartbeat:Connect(function(v)
if _apelStopped then return end
local w=b.Humanoid()
if not w then return end




if S.speedOn then
local x=d.TargetSpeed()
if w.WalkSpeed~=x then w.WalkSpeed=x end
end



if S.noclip or f then
applyNoclip()
elseif next(k)~=nil then
d.RestoreNoclip()
end
end))


regConn(LocalPlayer.CharacterAdded:Connect(function()
f=false
table.clear(k)
end))
end


function d.Stop()
LPH_ATTRIBUTES(VM(NONE))
d.EndPin()
d.RestoreNoclip()
local v=b.Humanoid()
if v then
v.PlatformStand=false
v.AutoRotate=true
if S.speedOn then v.WalkSpeed=e end
end
end

return d end function a.s():typeof(__modImpl())local b=a.cache.s if not b then b={c=__modImpl()}a.cache.s=b end return b.c end end do local function __modImpl()

local b={}
function b.Start()end
return b end function a.t():typeof(__modImpl())local b=a.cache.t if not b then b={c=__modImpl()}a.cache.t=b end return b.c end end do local function __modImpl()













local b=a.o()a.l()


local c={}



local d={pirate=
{{"room5","barrier"}},
}


local e={}

local function pathTo(f)
local g=workspace:FindFirstChild"dungeon"
for h,i in ipairs(f)do
if not g then return nil end
g=g:FindFirstChild(i)
end
return g
end

local function openOnce()
local f=tostring(b.Name()or""):lower()
local g
for h,i in pairs(d)do
if f:find(h,1,true)then g=i break end
end
if not g then return end

for h,i in ipairs(g)do
local j=pathTo(i)
if j and j:IsA"BasePart"and j.CanCollide then
e[j]=true
j.CanCollide=false

end
end
end

function c.Start()






spawnLoop(function()
while not _apelStopped do
pcall(openOnce)
task.wait(2)
end
end)
end

function c.Restore()
for f in pairs(e)do
pcall(function()if f.Parent then f.CanCollide=true end end)
end
table.clear(e)
end

return c end function a.u():typeof(__modImpl())local b=a.cache.u if not b then b={c=__modImpl()}a.cache.u=b end return b.c end end do local function __modImpl()













local b=a.m()
local c=a.n()
local d=a.o()
local e=a.s()

local f={}





function f.WeaponRemote()
local g=LocalPlayer.Character
if not g then return nil end
local h
for i,j in ipairs(g:GetChildren())do
if j:IsA"Accessory"and j:FindFirstChild"Weapon"then h=j end
end
return h and h:FindFirstChildOfClass"RemoteEvent"or nil
end


function f.Swing()
if c.Peaceful()then return false end
if c.BusyCasting()then return false end
local g=f.WeaponRemote()
if not g then return false end
pcall(function()g:FireServer()end)
b.Fire"weaponUsed"
return true
end






function f.AbilityTools()
local g={}
for h,i in ipairs(LocalPlayer.Backpack:GetChildren())do
if i:FindFirstChild"abilitySlot"then g[#g+1]=i end
end
local h=LocalPlayer.Character
if h then
for i,j in ipairs(h:GetChildren())do
if j:IsA"Tool"and j:FindFirstChild"abilitySlot"then g[#g+1]=j end
end
end
return g
end

local function onCooldown(g)
local h=g:FindFirstChild"cooldown"
return h~=nil and h.Value>0
end











function f.CastReady(g,h,i)
if c.Peaceful()then return 0 end
if c.BusyCasting()then return 0 end

if g and h and h>0 then
local j=c.HRP()
local k,l=pcall(function()return g:GetPivot().Position end)
if j and k and l then



local m=Vector3.new(l.X-j.Position.X,0,l.Z-j.Position.Z)
if m.Magnitude>h then return 0 end
end
end








if not c.Alive()or not c.HRP()then return 0 end













local j=f.AbilityTools()
local k=i and i.first

if k=="q"or k=="e"then
local function letterOf(l)
local m=l:FindFirstChild"abilitySlot"
return m and tostring(m.Value):sub(1,1):lower()or"?"
end

local l={}
for m,n in ipairs(j)do
l[n]={letterOf(n)==k and 0 or 1,m}
end
table.sort(j,function(m,n)
local o,p=l[m],l[n]
if o[1]~=p[1]then return o[1]<p[1]end
return o[2]<p[2]
end)


local m,n,o=false,true,false
for p,q in ipairs(j)do
local r=not onCooldown(q)
if letterOf(q)==k then
o=true
if r then m=true end
elseif not r then
n=false
end
end

if o then
if m then




if not n then return 0 end
f._chain=os.clock()
else



if not(f._chain and os.clock()-f._chain<8)then return 0 end
end
end
end

local l=0
for m,n in ipairs(j)do
local o=n:FindFirstChild"abilitySlot"
local p=n:FindFirstChild"localEvent"
if o and p and not onCooldown(n)then



pcall(function()p:Fire()end)
b.Fire("abilityUsed",o.Value,n)


if k and tostring(o.Value):sub(1,1):lower()~=k then
f._chain=nil
end
l=l+1


break
end
end
return l
end





function f.FaceTo(g)
local h=c.HRP()
if not h then return false end
local i=h.Position
local j=Vector3.new(g.X,i.Y,g.Z)
if(j-i).Magnitude<0.05 then return false end
h.CFrame=CFrame.new(i,j)
return true
end



function f.HoldOn(g,h,i)
local j=c.HRP()
local k=g and d.PivotOf(g)
if not j or not k then return false end

local l=j.Position
local m=(Vector3.new(l.X,k.Y,l.Z)-k)
if m.Magnitude<0.1 then m=Vector3.new(0,0,1)else m=m.Unit end

local n=k+m*(i or 7)+Vector3.new(0,h or 8,0)


e.Pin(n,k)
return true
end

return f end function a.v():typeof(__modImpl())local b=a.cache.v if not b then b={c=__modImpl()}a.cache.v=b end return b.c end end do local function __modImpl()




















local b=a.o()

local c={}

local d=RaycastParams.new()
d.FilterType=Enum.RaycastFilterType.Include

local e,f=0




local function borderParts()
if f and os.clock()-e<5 then return f end
local g={}
local h=workspace:FindFirstChild"borders"
if h then
for i,j in ipairs(h:GetDescendants())do
if j:IsA"BasePart"then g[#g+1]=j end
end
end
f,e=g,os.clock()
return g
end








local function insideArena(g,h)
local i=borderParts()
if#i==0 then return true end
d.FilterDescendantsInstances=i
local j=h-g
if j.Magnitude<0.01 then return true end
return workspace:Raycast(g,j,d)==nil
end






local g=OverlapParams.new()
g.FilterType=Enum.RaycastFilterType.Exclude
g.MaxParts=6

local function insideSolid(h)
local i=game.Players.LocalPlayer.Character
g.FilterDescendantsInstances=i and{i}or{}
local j=workspace:GetPartBoundsInBox(
CFrame.new(h+Vector3.new(0,1,0)),Vector3.new(3,5,3),g)
for k,l in ipairs(j)do

if l.CanCollide then return true end
end
return false
end












local h,i

local function arenaRadius(j)
if h and i==j then return h end
local k=borderParts()
if#k==0 then return 60 end
d.FilterDescendantsInstances=k
local l=math.huge
for m=0,15 do
local n=(m/16)*math.pi*2
local o=Vector3.new(math.cos(n),0,math.sin(n))*600
local p=workspace:Raycast(j+Vector3.new(0,6,0),o,d)
if p then
local q=Vector3.new(p.Position.X-j.X,0,
p.Position.Z-j.Z).Magnitude
if q<l then l=q end
end
end

if l==math.huge then l=60 end
h,i=math.clamp(l-6,30,120),j
return h
end


local j="Temple Core Generator"

local function bossPresent()
local k=workspace:FindFirstChild"dungeon"
if not k then return false end
for l,m in ipairs(k:GetChildren())do
local n=m:FindFirstChild"enemyFolder"
if n and n:FindFirstChild(j)then return true end
end
return false
end














local k={




["mage overlord"]={
legacy=true,


reach=24,
},






["warrior overlord"]={

dome=true,


noVoid=true,







floorWhen="finalbosslineblast",
floorHold=2.5,
floorMargin=3,



reach=30,
hover=8,
},





["guardian overlord"]={

perch=true,
hover=17,
floorWhen="secondbosscrossbeam",


upWhen="secondbosscrescent",
reach=22,












floorMargin=5,
},kolvumar=




{hover=14},

["pirate captain"]={

legacy=true,







keepAway=30,
},miyamoto=

{
close=true,
rescue=true,





spin=80,
},
}














local l={aquatic=
{ground=true,bounds=true},steampunk=







{gears=true},volcanic=














{











looseMargin={flat=2,vert=2},






















keepAway=8,








hopNear=true,
































orbitFor={"lava walker","lava mage","deity of the volcano"},











dodgeNamed={"rockfall","s127"},









dodgeFar=50,
dodgeHold=4,






dodgeFlat=true,











haven="thirdBossSafeSpot",
havenWhen="thirdBossCurseRing",
havenTail=1.5,






orbitSteady=true,



orbit=16,



orbitSpeed=30,



orbitLift=5,



sideStep=4,






minimalDodge=2.5,
},ghastly=

{
bodyOnly=true,

cannon=true,
},northern=












{







orbitFor={
"northern warrior","northern mage","northern spearman",
"midgardian champion",
},







orbitTune={




["midgardian champion"]={
orbit=30,speed=45,lift=23,smooth=true,
},
},
orbitSteady=true,

orbit=25,
orbitSpeed=30,
orbitLift=5,
},
}



























local m={
"desert temple",
"winter outpost",
"pirate island",
"king's castle",
"underworld",
"samurai palace",
"canals",
"ghastly",
"steampunk",
"orbital outpost",
"volcanic",
}





function c.Orbit(n)
local o=c.Value"orbit"
local p=c.Value"orbitSpeed"or 20
local q=c.Value"orbitLift"or 0
local r=c.Allows"orbitSteady"
local s=c.Allows"orbitSmooth"

local u=c.Value"orbitTune"
if type(u)=="table"and n then
local v=tostring(n):lower()
for w,x in pairs(u)do
if type(x)=="table"and v:find(tostring(w),1,true)then
if x.orbit then o=x.orbit end
if x.speed then p=x.speed end
if x.lift then q=x.lift end
if x.steady~=nil then r=x.steady==true end
if x.smooth~=nil then s=x.smooth==true end
break
end
end
end
return o,p,q,r,s
end

function c.IsTuned(n)
local o=tostring(n or""):lower()
if o==""then return false end
for p,q in ipairs(m)do
if o:find(q,1,true)then return true end
end
return false
end

local function inRaid()
return workspace:FindFirstChild"Arena"~=nil
and workspace:FindFirstChild"dungeon"==nil
end




















local n={
ground=true,bounds=true,radius=90,cleanOnly=true,










minionGuard=0,











noMobGuard=true,




stand=0,













leash=30,


dirs=16,







ceiling=4,











lift=9,












safeSpots={
Vector3.new(-95,59,-84),
Vector3.new(-87,59,75),
Vector3.new(88,59,-74),
Vector3.new(102,59,42),
},
}



local o,p










local q,r

local function arenaFloorY(s,u)


if not u then return nil end
if q and r==u then return q end
local v=RaycastParams.new()
v.FilterType=Enum.RaycastFilterType.Exclude
local w=game.Players.LocalPlayer.Character
v.FilterDescendantsInstances=w and{w}or{}
local x=workspace:Raycast(Vector3.new(s.X,s.Y+40,s.Z),
Vector3.new(0,-400,0),v)
if not x then return nil end
q,r=x.Position.Y,u
return q
end

local function raidCenter()
local s=workspace:FindFirstChild"Arena"
if not s then return nil end
if o and p==s then return o end
local u,v=pcall(function()return(s:GetBoundingBox())end)
if not u or not v then return nil end
o,p=v.Position,s
return o
end












local s,u=(-99)

local function profile()
local v=game.Players.LocalPlayer.Character
local w=v and v:FindFirstChild"HumanoidRootPart"
if w then






for x,y in ipairs(b.AllAlive())do
local z=b.PivotOf(y)
if z and(z-w.Position).Magnitude<=150 then
local A=tostring(y.Name):lower()
for B,C in pairs(k)do
if A:find(B,1,true)then
u,s=C,os.clock()
return C
end
end
end
end
end

if u and os.clock()-s<1 then return u end


if inRaid()then return n end

local x=tostring(b.Name()):lower()
for y,z in pairs(l)do
if x:find(y,1,true)then return z end
end
return nil
end



function c.Allows(v)
local w=profile()
return w~=nil and w[v]~=nil and w[v]~=false
end


function c.Value(v)
local w=profile()
local x=w and w[v]
if x==nil or x==false then return nil end
return x
end

local v,w=0
local x


function c.Active()
if os.clock()-v<0.25 then return w end
v=os.clock()
w=nil


if not c.Allows"ground"then return nil end








local y=workspace:FindFirstChild"firstBossMiddlePart"
local z
if y and y:IsA"BasePart"then
z=y.Position
elseif inRaid()and raidCenter()then


z=raidCenter()
else










local A=game.Players.LocalPlayer.Character
local B=A and A:FindFirstChild"HumanoidRootPart"
local C=B and b.Nearest(B.Position,150)
local D,E=pcall(function()return C and C:GetPivot().Position end)
if D and E then
x=E
end
if not x then return nil end
z=x
end














if y and not bossPresent()then return nil end


local A=c.Value"radius"

w={
name=A and"s128"or"s129",
cleanOnly=c.Value"cleanOnly"==true,
leash=c.Value"leash",



ceiling=c.Value"ceiling",
lift=c.Value"lift",
floorY=arenaFloorY(z,workspace:FindFirstChild"Arena"),
dirs=c.Value"dirs",
safeSpots=c.Value"safeSpots",





groundOnly=true,
center=z,







hardAllow=function(B)
if not c.Allows"bounds"then return true end
local C=Vector3.new(B.X-z.X,0,B.Z-z.Z)
if C.Magnitude>(A or arenaRadius(z))then return false end
return insideArena(z,B)
end,
allow=function(B)
if not c.Allows"bounds"then return not insideSolid(B)end
local C=Vector3.new(B.X-z.X,0,B.Z-z.Z)
if C.Magnitude>(A or arenaRadius(z))then return false end
return insideArena(z,B)and not insideSolid(B)
end,
}
return w
end

return c end function a.w():typeof(__modImpl())local b=a.cache.w if not b then b={c=__modImpl()}a.cache.w=b end return b.c end end do local function __modImpl()



















local b=a.l()
local c=a.w()

local d={}


















local e=true

function d.SetEnabled(f)
LPH_ATTRIBUTES(VM(NONE))
e=f~=false
end

function d.Enabled()
LPH_ATTRIBUTES(VM(NONE))
return e
end







local function isCylinder(f)
LPH_ATTRIBUTES(VM(NONE))
return f:IsA"Part"and f.Shape==Enum.PartType.Cylinder
end























local function isTelegraphName(f)
LPH_ATTRIBUTES(VM(NONE))
local g=tostring(f):lower()















return g:find("hitbox",1,true)~=nil
or g:find("precast",1,true)~=nil
or g:find("hitindicator",1,true)~=nil
end



















local f={
poisonBomb=13,
iceBomb=20,
explosiveBomb=18,












["Ice Minion"]=7,











["Flame Cyclone"]=30,












["Infected Pirate"]=7,































































["Northern Warrior"]=13,
}











local function hazardRadius(g,h)
LPH_ATTRIBUTES(VM(NONE))
local i=g:FindFirstChildWhichIsA"UnionOperation"
if i then
local j=i.Size



if math.min(j.X,j.Y,j.Z)<2 then
local k=math.max(j.X,j.Y,j.Z)
if k>4 then return k*0.5 end
end
end
return h
end












































local g=1.365






local h=4







local i=0.3














local j={
outwardblastsize=0.15,
}
















local k={
crossbeam=0.9,
}




















local l={
silkblast=5.5,













northernwarriorcirclestrike=1.5,





















}






























local m={}


local function dangerLifeFor(n)
LPH_ATTRIBUTES(VM(NONE))
local o=l[tostring(n.Name):lower()]
if o then return o end
local p=n.Parent
return p and l[tostring(p.Name):lower()]or nil
end

local function dangerDelayFor(n)
LPH_ATTRIBUTES(VM(NONE))
local o=k[tostring(n.Name):lower()]
if o then return o end
local p=n.Parent
return p and k[tostring(p.Name):lower()]or nil
end

local function ghostLifeFor(n)
LPH_ATTRIBUTES(VM(NONE))
local o=tostring(n or""):lower()
for p,q in pairs(j)do
if o:find(p,1,true)then return q end
end
return i
end

local n={}













local o={}

function d.Note(p,q)
LPH_ATTRIBUTES(VM(NONE))
o[p]=q
end

function d.NotesText()
LPH_ATTRIBUTES(VM(NONE))
local p={}
for q,r in pairs(o)do p[#p+1]=("%s=%s"):format(q,tostring(r))end
table.sort(p)
return#p>0 and table.concat(p," ")or"-"
end


function d.PartInfo(p)
LPH_ATTRIBUTES(VM(NONE))
if typeof(p)~="Instance"or not p:IsA"BasePart"then return"-"end
local q=n[p]
local r=(type(q)=="table"and q.born)and(os.clock()-q.born)or-1
local s=isCylinder(p)and"s70"or"s71"






local u=""
if r<0 then
u=p.Parent and"s72"or"s73"
end
return("s74"):format(
p.Parent and p.Parent.Name or"?",p.Name,s,
p.Size.X,p.Size.Y,p.Size.Z,r,u)
end

function d.TimeToHit(p)
LPH_ATTRIBUTES(VM(NONE))
local q=n[p]
if type(q)~="table"or not q.born then return nil end
local r=tostring(p.Parent and p.Parent.Name or p.Name):lower()
local s=m[r]or m[tostring(p.Name):lower()]
if not s then return nil end
return s-(os.clock()-q.born)
end

local p={}











local q={cyclone=46}

local r={}
local s=0

local function updateSpins()
LPH_ATTRIBUTES(VM(NONE))
local u=os.clock()
if u-s<0.12 then return end
s=u



local v=c.Value"spin"
if not v then
if next(r)then table.clear(r)end
return
end

for w,x in pairs(r)do
if x.expires<=u or not w.Parent then r[w]=nil end
end

local w=game.Players.LocalPlayer.Character
local x=w and w:FindFirstChild"HumanoidRootPart"
local y=workspace:FindFirstChild"dungeon"
if not x or not y then return end










for z,A in ipairs(y:GetChildren())do
local B=A:FindFirstChild"enemyFolder"
if B then
for C,D in ipairs(B:GetChildren())do
if D:IsA"Model"then
local E,F=pcall(function()return D:GetPivot().Position end)
if E and(F-x.Position).Magnitude<130 then
local G=D:FindFirstChildWhichIsA"Humanoid"
if G then
local H,I=pcall(function()
return G:GetPlayingAnimationTracks()end)
if H then
for J,K in ipairs(I)do
local L=q[tostring(K.Name):lower()]
if L then


if type(v)=="number"then
L=v
end


r[D]={radius=L,expires=u+1}
end
end
end
end
end
end
end
end
end
end
local u={}












local v=setmetatable({},{__mode="k"})















local w={
secondbossdamageparts=true,
miyamotoflames=true,
}

local x,y=0

local function revealableParts()
LPH_ATTRIBUTES(VM(NONE))
if y and os.clock()-x<5 then return y end
local z={}
for A,B in ipairs(workspace:GetChildren())do
if w[tostring(B.Name):lower()]then
for C,D in ipairs(B:GetDescendants())do
if D:IsA"BasePart"then z[#z+1]=D end
end
end
end
y,x=z,os.clock()
return z
end

local function updateRevealed()
LPH_ATTRIBUTES(VM(NONE))
for z,A in ipairs(revealableParts())do
if A.Parent and A.Transparency<0.95 then
if not n[A]then n[A]={flat=0,vert=0}end
elseif n[A]then
n[A]=nil
end
end
end



















local z={}

local function kinOf(A)
LPH_ATTRIBUTES(VM(NONE))
local B=A.Parent
return(B and B:IsA"Model")and B or nil
end

local function modelLit(A)
LPH_ATTRIBUTES(VM(NONE))
for B,C in ipairs(A:GetChildren())do
if C:IsA"BasePart"and C.Transparency<0.95 then return true end
end
return false
end



























local A={
northernMageShot=true,
spearmanStrikeHitbox=true,
northernWarriorCircleStrike=true,
northernWarriorLineStrike=true,
}

local function neverSleep(B)
LPH_ATTRIBUTES(VM(NONE))
local C=B and B.Parent
return C~=nil and A[C.Name]==true
end

local function zoneDark(B,C)
LPH_ATTRIBUTES(VM(NONE))















return type(B)=="table"and B.dark==true
end






local B=8

local C=18



local D=0.45












local E={
secondbosscrescent=2.5,





harpoonmodel=2,


steampunkrangemobshot=2,

}

local function lookaheadOf(F)
LPH_ATTRIBUTES(VM(NONE))
local G=F.Parent and tostring(F.Parent.Name):lower()or""
return E[G]or E[tostring(F.Name):lower()]or D
end



local F=0

















local G={["flame cyclone"]=true}
local H=8






















local I={}
local J=20











local K={}







local L=800



















local M=setmetatable({},{__mode="k"})







local N=setmetatable({},{__mode="k"})
local O,P=0
local Q,R=0,0

function d.HitStats()
LPH_ATTRIBUTES(VM(NONE))
return Q,R
end




local T

local function noteTrail()
LPH_ATTRIBUTES(VM(NONE))
local U=LocalPlayer.Character
local V=U and U:FindFirstChild"HumanoidRootPart"
if not V then return end
table.insert(I,1,V.Position)
if#I>J then table.remove(I)end

local W=d.ZoneAt(V.Position,0)
table.insert(K,1,{
t=os.clock(),
p=V.Position,
safe=W==nil,
name=W and("%s/%s"):format(
(W.Parent and W.Parent.Name)or(W.name and tostring(W.name))or"?",
W.Name or"s75")or nil,
})
if#K>L then table.remove(K)end
end









local U=0

function d.NoteHop()
LPH_ATTRIBUTES(VM(NONE))
U=os.clock()
end

function d.SinceHop()
LPH_ATTRIBUTES(VM(NONE))
return U>0 and(os.clock()-U)or-1
end

function d.SafeTrail(V)
LPH_ATTRIBUTES(VM(NONE))
local W=os.clock()
local X,Y,Z=0,0,{}
local _
for aa,ab in ipairs(K)do
if W-ab.t>(V or 1.5)then break end
Y=Y+1
if not ab.safe then
X=X+1
_=W-ab.t
if ab.name and not Z[ab.name]then Z[ab.name]=0 end
if ab.name then Z[ab.name]=Z[ab.name]+1 end
end
end
if Y==0 then return"s76"end
if X==0 then




local aa=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
local ab="?"
if aa then
local ac=d.NearestZones(aa.Position,1)
ab=(type(ac)=="table"and ac[1])or"s77"
end








local ac=""
if aa then
local ad,ae=1e9
for af,ag in ipairs(workspace:GetChildren())do
local ah=ag.Name
if ah=="groundAura"or ah=="spearmanStrike"then
for ai,aj in ipairs(ag:GetDescendants())do
if aj:IsA"BasePart"then
local ak=aj.CFrame:PointToObjectSpace(aa.Position)
local al=aj.Size*0.5
local am=Vector3.new(
math.max(math.abs(ak.X)-al.X,0),
math.max(math.abs(ak.Y)-al.Y,0),
math.max(math.abs(ak.Z)-al.Z,0)).Magnitude
if am<ad then
ad,ae=am,("%s (%s)"):format(ah,tostring(aj.Size))
end
end
end
end
end
if ae then
ac=("s78"):format(ae,ad)
end
end
return("s79")
:format(V or 1.5,Y,ab,ac)
end
local aa={}
for ab,ac in pairs(Z)do aa[#aa+1]=("%s x%d"):format(ab,ac)end






local ab,ac=0,0
local ad,ae=0,0
local af,ag,ah
for ai,aj in ipairs(K)do
if W-aj.t>(V or 1.5)then break end
if aj.p then
if af then
local ak=(Vector3.new(aj.p.X,0,aj.p.Z)-Vector3.new(af.X,0,af.Z)).Magnitude
if ak<8 then
ab=ab+ak


if not aj.safe then
ad=ad+ak
ae=ae+math.abs((ag or aj.t)-aj.t)
end
end
end
af,ag=aj.p,aj.t
ah=ah or aj.p
end
end
if ah and af then
ac=(Vector3.new(ah.X,0,ah.Z)-Vector3.new(af.X,0,af.Z)).Magnitude
end






local ai=""
do



local aj=K[1]and K[1].p
local ak=aj and{Position=aj}or nil
if ak then


local al
for am,an in pairs(n)do
if am.Parent and not zoneDark(an,am)then
local ao=(type(an)=="table"and an.flat or 0)
local ap=am.CFrame:PointToObjectSpace(ak.Position)
local aq=am.Size*0.5+Vector3.new(ao,0,ao)
if math.abs(ap.X)<=aq.X and math.abs(ap.Z)<=aq.Z
and math.abs(ap.Y)<=aq.Y then
local ar=math.min(aq.X-math.abs(ap.X),aq.Z-math.abs(ap.Z))
if not al or ar<al then al=ar end
end
end
end
if al then ai=("s80"):format(al)end
end
end
return("s81"..ai)
:format(V or 1.5,X,Y,_ or 0,table.concat(aa,", "),ab,ac,
ad,ae,ae>0.01 and(ad/ae)or 0)
end






















local aa=setmetatable({},{__mode="k"})










local ab=setmetatable({},{__mode="k"})

function d.MarkDomeUsed(ac)
LPH_ATTRIBUTES(VM(NONE))
if ac then ab[ac]=true end
end

local function trackDomes()
LPH_ATTRIBUTES(VM(NONE))
for ac,ad in ipairs(workspace:GetChildren())do
if ad:IsA"BasePart"and tostring(ad.Name):lower()=="forcefield"then
local ae=aa[ad]
if not ae then
aa[ad]={pos=ad.Position,moved=false}
else
if(ad.Position-ae.pos).Magnitude>2 then ae.moved=true end
ae.pos=ad.Position
end
end
end
end













local function domeMoves(ac)
LPH_ATTRIBUTES(VM(NONE))
local ad=aa[ac]
return ad~=nil and ad.moved
end

local function ownerOf(ac)
LPH_ATTRIBUTES(VM(NONE))
local ad,ae=math.huge
for af,ag in ipairs(game:GetService"Players":GetPlayers())do
local ah=ag.Character
local ai=ah and ah:FindFirstChild"HumanoidRootPart"
if ai then
local aj=(ai.Position-ac).Magnitude
if aj<ad then ae,ad=ag,aj end
end
end
return ae,ad
end

















local ac=setmetatable({},{__mode="k"})
local ad=0

local function ridesPlayer(ae)
LPH_ATTRIBUTES(VM(NONE))
for af,ag in ipairs(game:GetService"Players":GetPlayers())do
local ah=ag.Character
if ah then





local ai=ah:FindFirstChild"HumanoidRootPart"
if ai and(ai.Position-ae).Magnitude<=H then return true end
local aj,ak=pcall(function()return ah:GetPivot().Position end)
if aj and(ak-ae).Magnitude<=H then return true end
end
end
return false
end

local function updateShared()
LPH_ATTRIBUTES(VM(NONE))
local ae=os.clock()
if ae-ad<0.2 then return end
ad=ae

for af,ag in ipairs(workspace:GetChildren())do
if ag:IsA"Model"and G[tostring(ag.Name):lower()]then
if not ac[ag]then
local ah,ai=pcall(function()return ag:GetPivot().Position end)
if ah and ridesPlayer(ai)then
ac[ag]=true
for aj,ak in ipairs(ag:GetDescendants())do n[ak]=nil end
end
end












if ac[ag]then p[ag]=nil end
end
end
end

local function updateMotion()
LPH_ATTRIBUTES(VM(NONE))
local ae=os.clock()
local af=ae-F
if af<1.1111111111111112E-2 then return end
F=ae

for ag in pairs(n)do
if ag.Parent then
local ah=v[ag]
local ai=ag.Position
if ah and ah.pos and af>0 then














if ah.cfPrev then
local aj,ak=pcall(function()
local aj=ag.CFrame*ah.cfPrev:Inverse()local
ak, al=aj:ToAxisAngle()


if math.abs(al)<0.002 then return nil end
local am=ag.CFrame
for an=1,B do am=aj*am end
return am
end)
ah.future=aj and ak or nil
end
ah.cfPrev=ag.CFrame
local aj=(ai-ah.pos)/af
local ak=aj.Magnitude
ah.pos=ai



ah.speed=ak
if ak>=C then
local al=aj.Unit








local am=math.min(ak*lookaheadOf(ag),60)
local an=ag.Size
local ao=math.max(an.X,an.Y,an.Z)
local ap=ai+al*(am*0.5)

local aq=math.abs(al.Y)>0.99
and Vector3.new(1,0,0)or Vector3.new(0,1,0)
ah.cf=CFrame.lookAt(ap,ap+al,aq)
ah.size=Vector3.new(ao,ao,am+ao)
else
ah.cf=nil
end
else
v[ag]={pos=ai}
end
else
v[ag]=nil
end
end
end

local function isPrecastNeon(ae)
LPH_ATTRIBUTES(VM(NONE))
return ae:IsA"BasePart"
and ae.Material==Enum.Material.Neon
and ae.Anchored
and not ae.CanQuery
and not ae.CanCollide
end









local function ownedByEnemy(ae)
LPH_ATTRIBUTES(VM(NONE))
local af=ae.Parent
while af and af~=workspace do
if af:IsA"Model"then
return af:FindFirstChildOfClass"Humanoid"~=nil
end
af=af.Parent
end
return false
end












local function modelHasTelegraph(ae)
LPH_ATTRIBUTES(VM(NONE))
if not ae or not ae:IsA"Model"then return false end
for af,ag in ipairs(ae:GetChildren())do
if ag:IsA"BasePart"and isTelegraphName(ag.Name)then return true end
end
return false
end












local ae={
cubepylonshot=true,
pyramidpylonspreadshot=true,


}




local af=0

function d.TargetedRecently(ag)
LPH_ATTRIBUTES(VM(NONE))
if not e then return false end
return os.clock()-af<(ag or 1.4)
end











local ag={
thirdbosssafespot=true,
}

local ah={
bossrifleshot=true,












groundaura=true,
artilleryrock=true,







bossrandomstrike=true,












firstbossattachpart=true,





firstbosscrisscross=true,
firstbossbigspike=true,
firstbossseekingspikes=true,











secondbosscrescent=true,











harpoonmodel=true,




steampunkrangemobshot=true,













flamingshuriken=true,




flamelashpart=true,







["molten shard"]=true,
["lava beam"]=true,
["lava beam explosion cylinder"]=true,
}

















local ai={




}












local aj={
riflemanshot=4,



































northernmageshot=0,



























flamebeam={flat=12,vert=6},
doubleflamebeam={flat=12,vert=6},



flameshurikenhit={flat=14,vert=10},


















secondbosscrossbeam={flat=0,vert=0},







secondbosscrescent={flat=4,vert=3},




harpoonmodel={flat=4,vert=6},






































bossrifleprecast={flat=3,vert=16},
bossrifleshot={flat=3,vert=4},


steampunkrangemobshot={flat=5,vert=5},












cannoncrabshot={flat=5,vert=5},
cannonbarragecannonhit={flat=5,vert=5},
corruptmolotov={flat=5,vert=5},








finalbossarrowshothitbox={flat=6,vert=6},







finalbosslineblast={flat=4,vert=0},
flamingshuriken={flat=10,vert=8},



firstbossattachpart=10,





















spikeprecast={flat=20,vert=90},











firstbossbigspike={flat=4,vert=90},
firstbossseekingspikes={flat=4,vert=90},











npcmageshot=10,
}


local function extraMargin(ak)
LPH_ATTRIBUTES(VM(NONE))
local al=aj[tostring(ak.Name):lower()]
if al==nil then
local am=ak.Parent
al=am and aj[tostring(am.Name):lower()]or nil
end










if al==nil then
local am=c.Value"looseMargin"
if am and tostring(ak.Parent and ak.Parent.Name)=="Model"then
al=am
end
end

if al==nil then return 0,0 end
if type(al)=="table"then return al.flat or 0,al.vert or 0 end
return al,al
end

local function isIgnoredAttack(ak)
LPH_ATTRIBUTES(VM(NONE))
if ai[tostring(ak.Name):lower()]then return true end
local al=ak.Parent
return al~=nil and ai[tostring(al.Name):lower()]==true
end

local function isAttackModelPart(ak)
LPH_ATTRIBUTES(VM(NONE))


if ah[tostring(ak.Name):lower()]then return true end
local al=ak.Parent
return al~=nil and ah[tostring(al.Name):lower()]==true
end

local function isBlastPart(ak)
LPH_ATTRIBUTES(VM(NONE))
return tostring(ak.Name):lower():find("explosion",1,true)~=nil
and modelHasTelegraph(ak.Parent)
end














local function siblingHeightBoost(ak)
LPH_ATTRIBUTES(VM(NONE))
if not tostring(ak.Name):lower():find("precast",1,true)then return 0 end
local al=ak.Parent
if not al then return 0 end

local am=0
for an,ao in ipairs(al:GetChildren())do
if ao:IsA"BasePart"and tostring(ao.Name):lower():find("hitbox",1,true)then
local ap=(ao.Size.Y-ak.Size.Y)*0.5
if ap>am then am=ap end
end
end
return am
end












local ak

local function isOwnProjectile(al)
LPH_ATTRIBUTES(VM(NONE))
if not ak then
ak={}
local am=game:GetService"ReplicatedStorage"
local an={}
local ao=am:FindFirstChild"enemyProjectiles"
if ao then
for ap,aq in ipairs(ao:GetChildren())do an[aq.Name:lower()]=true end
end
local ap=am:FindFirstChild"projectiles"
if ap then
for aq,ar in ipairs(ap:GetChildren())do
local V=ar.Name:lower()
if not an[V]then ak[V]=true end
end
end
end

local am=al
for an=1,4 do
if not am or am==workspace then break end
if ak[tostring(am.Name):lower()]then return true end
am=am.Parent
end
return false
end












local function isLooseAttackPart(al)
LPH_ATTRIBUTES(VM(NONE))










return al.Name=="Model"and al.Material==Enum.Material.Neon
end



local function remember(al,am,an,ao,ap,aq)
LPH_ATTRIBUTES(VM(NONE))
u[#u+1]={
cf=al,size=am,cylinder=an,
flat=ap or 0,vert=aq or 0,
name=ao,expires=os.clock()+ghostLifeFor(ao),
}
end
























function d.Foresee(al,am,an,ao,ap,aq,ar)
LPH_ATTRIBUTES(VM(NONE))
if typeof(al)~="CFrame"or typeof(am)~="Vector3"then return end
u[#u+1]={
cf=al,size=am,cylinder=ar or false,
flat=ap or 0,vert=aq or 0,
name=ao or"s82",expires=os.clock()+(an or 1),
}
end

local function consider(al)
LPH_ATTRIBUTES(VM(NONE))
if not al:IsA"BasePart"then return end
local am=al.Parent and al.Parent.Name or"?"


if isIgnoredAttack(al)then

return
end




if al:IsDescendantOf(workspace)
and al:FindFirstAncestor"secondBossSafeSpots"then

return
end








if al.Name=="ApelMark"then return end



if ag[tostring(al.Name):lower()]
or ag[tostring(am):lower()]then

return
end

if isOwnProjectile(al)then

return
end
if not(isTelegraphName(al.Name)or isTelegraphName(am)
or isAttackModelPart(al)or isBlastPart(al)or isPrecastNeon(al)
or isLooseAttackPart(al))then
return
end
if ownedByEnemy(al)then



return
end









if ae[am:lower()]and isTelegraphName(al.Name)then
local an=game.Players.LocalPlayer.Character
local ao=an and an:FindFirstChild"HumanoidRootPart"
if ao then







af=os.clock()

end
end



















if c.Allows"dodgeTargeted"then
local an=game.Players.LocalPlayer.Character
local ao=an and an:FindFirstChild"HumanoidRootPart"
if ao then
local ap=al.CFrame:PointToObjectSpace(ao.Position)
local aq=al.Size*0.5
if math.abs(ap.X)<=aq.X and math.abs(ap.Y)<=aq.Y
and math.abs(ap.Z)<=aq.Z then
af=os.clock()

end
end
end


local an,ao=extraMargin(al)












if al.Size.Y>60 and al.Size.X<=30 and al.Size.Z<=30 then
an=math.max(an,4)
end

if isLooseAttackPart(al)then






an=math.max(an,3)
ao=math.max(ao,2)
end
ao=math.max(ao,siblingHeightBoost(al))
































if isCylinder(al)then
local ap=al.CFrame.RightVector
if math.abs(ap.Y)>0.85 and al.Size.X<=8 then
ao=math.max(ao,h)
end
elseif al.Size.Y<=2 then
ao=math.max(ao,h)
end

local ap=dangerDelayFor(al)
local aq=dangerLifeFor(al)
n[al]={






born=os.clock(),
flat=an,vert=ao,

kin=kinOf(al),










seen=al.Transparency<0.95,

active=ap and(os.clock()+ap)or nil,

over=aq and(os.clock()+(ap or 0)+aq)or nil,
}
end

local function considerHazard(al)
LPH_ATTRIBUTES(VM(NONE))
local am=f[al.Name]
if am then
am=hazardRadius(al,am)
p[al]=am

elseif b.enabled and al:IsA"Model"then






if al==LocalPlayer.Character then return end
local an=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
local ao=an and al:FindFirstChildWhichIsA("BasePart",true)
if an and ao and(ao.Position-an.Position).Magnitude<60 then



local ap,aq={},0
for ar,V in ipairs(al:GetDescendants())do
if V:IsA"BasePart"and aq<5 then
aq=aq+1
ap[#ap+1]=("%s %s"):format(V.Name,tostring(V.Size))
end
end

end
end
end










local al={}












local am={}

function d.CoverReport()
LPH_ATTRIBUTES(VM(NONE))
if#am==0 then return"s83"end
local an,ao=os.clock(),{}
for ap=#am,1,-1 do
local aq=am[ap]
ao[#ao+1]=("s84"):format(
aq.name,an-aq.born,
aq.left and("s85"):format(aq.left)or"s86")
if#ao>=5 then break end
end
return("s87"):format(#am,table.concat(ao," ;; "))
end

local function watchCover(an)
LPH_ATTRIBUTES(VM(NONE))
local ao={
born=os.clock(),
name=("%s/%s %s"):format(
tostring(an.Parent and an.Parent.Name or"?"),tostring(an.Name),
tostring(an.Size)),
}
am[#am+1]=ao
if#am>12 then table.remove(am,1)end

task.spawn(function()
local ap=game.Players.LocalPlayer.Character
local aq=ap and ap:FindFirstChild"HumanoidRootPart"
while aq and an.Parent and os.clock()-ao.born<4 do
local ar=an.CFrame:PointToObjectSpace(aq.Position)
local V=an.Size*0.5
if not(math.abs(ar.X)<=V.X and math.abs(ar.Y)<=V.Y
and math.abs(ar.Z)<=V.Z)then
ao.left=os.clock()-ao.born
return
end
task.wait()
end
end)
end

local function noteAdd(an)
LPH_ATTRIBUTES(VM(NONE))
if not b.enabled or not an:IsA"BasePart"then return end
local ao=game.Players.LocalPlayer.Character
local ap=ao and ao:FindFirstChild"HumanoidRootPart"
if not ap then return end
local aq=(an.Position-ap.Position).Magnitude










if aq>250 then return end







if isOwnProjectile(an)then return end











local ar=an.CFrame:PointToObjectSpace(ap.Position)
local V=an.Size*0.5
local W=math.abs(ar.X)<=V.X
and math.abs(ar.Y)<=V.Y
and math.abs(ar.Z)<=V.Z

if W and b.enabled then watchCover(an)end

al[#al+1]={
t=os.clock(),gap=aq,
name=tostring(an.Parent and an.Parent.Name).."/"..tostring(an.Name),
size=tostring(an.Size),
mat=tostring(an.Material):gsub("Enum.Material.",""),
taken=n[an]~=nil,
covered=W,
}


if#al>1200 then table.remove(al,1)end
end



function d.MotionInfo()
LPH_ATTRIBUTES(VM(NONE))
local an,ao,ap=0,0
for aq,ar in pairs(v)do
if aq.Parent and ar.cf then
local V=ar.size and ar.size.Z or 0
local W=V>0 and(V/D)or 0
if W>an then ap,an,ao=aq,W,V end
end
end
if not ap then return"s88"end
return("s89"):format(
tostring(ap.Parent and ap.Parent.Name).."/"..tostring(ap.Name),
an,ao)
end








function d.RecentAdds(an)
LPH_ATTRIBUTES(VM(NONE))
local ao,ap=os.clock(),an or 2
local aq={}
for ar=#al,1,-1 do
local V=al[ar]
if ao-V.t>ap then break end
aq[#aq+1]=V
end
table.sort(aq,function(ar,V)
if ar.covered~=V.covered then return ar.covered end
return ar.t>V.t
end)

local ar={}
for V,W in ipairs(aq)do
ar[#ar+1]=("s90"):format(
ao-W.t,W.gap,W.name,W.size,W.mat,tostring(W.taken),tostring(W.covered))
end
return ar
end


















local an=7
local ao=110
local ap=0.9
local aq=0

local ar=0
local function projectMageBeam(V)
LPH_ATTRIBUTES(VM(NONE))
local W=os.clock()
ar=ar+1
if ar%20==1 and b.enabled then

end
if W-aq<0.4 then return end

local X,Y=1e9
local Z=workspace:FindFirstChild"dungeon"
if not Z then return end
for _,as in ipairs(Z:GetChildren())do
local au=as:FindFirstChild"enemyFolder"
if au then
for av,aw in ipairs(au:GetChildren())do
if aw.Name=="Northern Mage"then
local ax,ay=pcall(function()return aw:GetPivot().Position end)
if ax then
local az=(ay-V.Position).Magnitude
if az<X then Y,X=ay,az end
end
end
end
end
end
if not Y or X<5 or X>130 then return end

local as=Vector3.new(V.Position.X-Y.X,0,V.Position.Z-Y.Z)
if as.Magnitude<1 then return end
as=as.Unit

local au=ao-X
if au<10 then return end
local av=V.Position+as*(au*0.5)
aq=W
d.Foresee(CFrame.new(av,av+as),Vector3.new(an,6,au),
ap,"s91",0,0,false)
if b.enabled then

end
end



local function updatePooled()
LPH_ATTRIBUTES(VM(NONE))
local as=os.clock()
















for au,av in pairs(n)do
if not au.Parent then
n[au]=nil
elseif type(av)=="table"and not av.dark then
if av.over and as>av.over then
av.dark=true

elseif av.seen and au.Transparency>0.95 and not neverSleep(au)then
av.dark=true

end
end
end

for au,av in pairs(n)do
local aw=type(av)=="table"and av.kin or nil
if aw and aw.Parent and au.Parent then
if modelLit(aw)then
z[aw.Name]=true










if not av.wasLit then
av.wasLit=true
if aw.Name=="northernMageShot"then projectMageBeam(au)end
end
if av.dark then
av.dark=nil
local ax=dangerDelayFor(au)
local ay=dangerLifeFor(au)
av.active=ax and(as+ax)or nil
av.over=ay and(as+(ax or 0)+ay)or nil

end
elseif z[aw.Name]and not av.dark and not neverSleep(au)then




av.dark=true
av.wasLit=nil

end
end
end
end

function d.Watch()
LPH_ATTRIBUTES(VM(NONE))
regConn(game:GetService"RunService".Heartbeat:Connect(function()
if _apelStopped then return end
updateMotion()
updatePooled()
updateRevealed()
updateSpins()
updateShared()
noteTrail()
T()
trackDomes()
end))

for as,au in ipairs(workspace:GetDescendants())do consider(au)end












local function sweepHazards()
for as,au in ipairs(workspace:GetChildren())do considerHazard(au)end
local as=workspace:FindFirstChild"dungeon"
if not as then return end
for au,av in ipairs(as:GetChildren())do
local aw=av:FindFirstChild"enemyFolder"
if aw then
for ax,ay in ipairs(aw:GetChildren())do considerHazard(ay)end
end
end
end

sweepHazards()
spawnLoop(function()
while not _apelStopped do
task.wait(1)
pcall(sweepHazards)
end
end)

regConn(workspace.DescendantAdded:Connect(function(as)
consider(as)
noteAdd(as)
end))
regConn(workspace.DescendantRemoving:Connect(function(as)
if n[as]then


local au=n[as]
n[as]=nil
remember(as.CFrame,as.Size,isCylinder(as),
("%s/%s"):format(as.Parent and as.Parent.Name or"?",as.Name),
type(au)=="table"and au.flat or 0,
type(au)=="table"and au.vert or 0)
end
p[as]=nil
end))
regConn(workspace.ChildAdded:Connect(considerHazard))
regConn(workspace.ChildRemoved:Connect(function(as)
local au=p[as]
if not au then return end
p[as]=nil

local av=as:IsA"Model"and as.PrimaryPart
if av then
remember(av.CFrame,Vector3.new(au*2,40,au*2),true,"poisonBomb")
end
end))
end


local function hazardPoint(as)
LPH_ATTRIBUTES(VM(NONE))
local au=as.PrimaryPart or as:FindFirstChild"PrimaryPart"
or as:FindFirstChildWhichIsA("BasePart",true)
return au and au.Position or nil
end


local function sweepGhosts()
LPH_ATTRIBUTES(VM(NONE))
local as=os.clock()
for au=#u,1,-1 do
if u[au].expires<=as then table.remove(u,au)end
end
end

function d.Count()
LPH_ATTRIBUTES(VM(NONE))






sweepGhosts()

local as=0
for au,av in pairs(n)do
if not au.Parent then n[au]=nil
elseif not zoneDark(av,au)then as=as+1 end
end
for au in pairs(p)do
if au.Parent then as=as+1 else p[au]=nil end
end
return as+#u
end


















local as=2






local function penetrationOf(au,av,aw,ax,ay,az)
LPH_ATTRIBUTES(VM(NONE))
local V=au:PointToObjectSpace(ax)
local W=ay
local X=az

if aw then
local Y=av.Y*0.5+W


local Z=av.X*0.5+X
local _=math.sqrt(V.Y^2+V.Z^2)
if math.abs(V.X)>Z or _>Y then return nil end
return Y-_
end

local Y=av*0.5+Vector3.new(W,X,W)
if math.abs(V.X)>Y.X then return nil end
if math.abs(V.Y)>Y.Y then return nil end
if math.abs(V.Z)>Y.Z then return nil end
return math.min(Y.X-math.abs(V.X),Y.Z-math.abs(V.Z))
end

local function penetration(au,av,aw)
LPH_ATTRIBUTES(VM(NONE))







local ax=n[au]
local ay=type(ax)=="table"and ax.flat or 0
local az=type(ax)=="table"and ax.vert or 0
















local V=v[au]
local W=(V and V.size)and V.size.Z or 0
local X=au.Size
local Y=au.Position
local Z=av.Y-Y.Y
local _=X.Y*0.5+math.min(aw,as)+az
+W+6
if Z<-_ or Z>_ then return nil end

local aA,aB=av.X-Y.X,av.Z-Y.Z
local aC=math.max(X.X,X.Z)*0.71+aw+ay+W+6
if aA*aA+aB*aB>aC*aC then return nil end
local aD=aw+ay
local aE=math.min(aw,as)+az
local aF=penetrationOf(au.CFrame,au.Size,isCylinder(au),av,aD,aE)
if aF then return aF end






if V and V.future then
local aG=penetrationOf(V.future,au.Size,isCylinder(au),av,aD,aE)
if aG then return aG end
end

if V and V.cf then
return penetrationOf(V.cf,V.size,false,av,aD+2,aE+1)
end
return nil
end


local function hazardAt(au,av)
LPH_ATTRIBUTES(VM(NONE))
for aw,ax in pairs(p)do
if aw.Parent then
local ay=hazardPoint(aw)


if ay then
local az=Vector3.new(au.X-ay.X,0,au.Z-ay.Z)
if az.Magnitude<=ax+av then return aw end
end
else
p[aw]=nil
end
end
return nil
end



































local au=0

function d.HasDome()
LPH_ATTRIBUTES(VM(NONE))
local av=LocalPlayer.Character
local aw=av and av:FindFirstChild"HumanoidRootPart"
if not aw then return false end

local ax=false
for ay,az in ipairs(workspace:GetChildren())do
if az:IsA"BasePart"and tostring(az.Name):lower()=="forcefield"then
ax=true










local aA=ownerOf(az.Position)
if domeMoves(az)and aA==LocalPlayer then
au=os.clock()+1
return true
end
end
end



if not ax then
au=0
return false
end


return os.clock()<au
end






function d.DomeReport()
LPH_ATTRIBUTES(VM(NONE))
local av=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
local aw={}
for ax,ay in ipairs(workspace:GetChildren())do
if ay:IsA"BasePart"and tostring(ay.Name):lower()=="forcefield"then
local az,aA=ownerOf(ay.Position)local aB=
domeMoves(ay)and az==LocalPlayer
local aC=av and(ay.Position-av.Position).Magnitude or-1
local aD=d.GroundAt(ay.Position.X,ay.Position.Z,ay.Position.Y+6)
local aE=av and(av.Position.Y-ay.Position.Y)>40


local aF=-9
if av then aF=ay.CFrame.LookVector:Dot(av.CFrame.LookVector)end

aw[#aw+1]=("s92"):format(
ay.Position.Y,aC,
az and az.Name or"s93",aA,
domeMoves(ay)and"s94"or"s95",
aF,
aD and"s68"or"s69",
aE and"s96"or"s3")
end
end
return aw
end

function d.SafeDome()
LPH_ATTRIBUTES(VM(NONE))
local av=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"

local aw,ax,ay=math.huge
for az,aA in ipairs(workspace:GetChildren())do
if aA:IsA"BasePart"and tostring(aA.Name):lower()=="forcefield"then




















local aB=av and(aA.Position-av.Position).Magnitude or 0






local aC=av and(av.Position.Y-aA.Position.Y)>40
local aD=aB<=150 and not aC
and d.GroundAt(aA.Position.X,aA.Position.Z,aA.Position.Y+6)~=nil






local aE=domeMoves(aA)or ab[aA]

if aD and not aE then
if aB<aw then ax,aw,ay=aA.Position,aB,aA end
end
end
end

return ax,ay
end












local av=7
local aw=12







function d.CleanNear(ax,ay)
LPH_ATTRIBUTES(VM(NONE))
if not ax then return nil end
ay=ay or Vector3.new(0,3,0)
if d.IsSafe(ax+ay,6)then return ax end



for az,aA in ipairs{6,3,1}do
for aB=3,av,2 do
for aC=0,aw-1 do
local aD=math.rad((360/aw)*aC)
local aE=ax+Vector3.new(math.cos(aD)*aB,0,math.sin(aD)*aB)
if d.IsSafe(aE+ay,aA)then return aE end
end
end
end
return ax
end





function d.SafeSpot()
LPH_ATTRIBUTES(VM(NONE))
local ax=workspace:FindFirstChild"secondBossSafeSpots"
if not ax then return nil end
for ay,az in ipairs(ax:GetChildren())do
local aA=az:FindFirstChild"Union"
if aA and aA.Transparency<0.95 then
local aB=az:FindFirstChild"hitBox"
if aB then return aB.Position end
local aC,aD=pcall(function()return az:GetPivot().Position end)
if aC then return aD end
end
end
return nil
end










function d.TimerRing(ax,ay)
LPH_ATTRIBUTES(VM(NONE))
if type(ax)~="string"or ax==""or not ay then return false end
local az=ax:lower()
for aA,aB in ipairs(workspace:GetChildren())do
if tostring(aB.Name):lower()==az then
local aC=aB:IsA"BasePart"and aB
or aB:FindFirstChildWhichIsA"BasePart"
if aC then
local aD=Vector3.new(ay.X-aC.Position.X,0,ay.Z-aC.Position.Z)
local aE=math.max(aC.Size.X,aC.Size.Z)*0.5+g
if aD.Magnitude<=aE then
return true,math.max(aC.Size.X,aC.Size.Z)
end
end
end
end
return false
end






function d.HavenSpot(ax,ay)
LPH_ATTRIBUTES(VM(NONE))
if type(ax)~="string"or ax==""then return nil end
local az=ax:lower()
local aA,aB,aC=math.huge
for aD,aE in ipairs(workspace:GetChildren())do
if tostring(aE.Name):lower()==az then
local aF=aE:FindFirstChild"hitBox"or aE:FindFirstChild"precast"
local aG,V
if aF and aF:IsA"BasePart"then
aG,V=aF.Position,math.max(aF.Size.X,aF.Size.Z)*0.5
elseif aE:IsA"BasePart"then
aG,V=aE.Position,math.max(aE.Size.X,aE.Size.Z)*0.5
else
local W,X=pcall(function()return aE:GetPivot().Position end)
if W then aG,V=X,6 end
end
if aG then
local W=ay and(Vector3.new(ay.X-aG.X,0,ay.Z-aG.Z).Magnitude)or 0
if W<aA then aB,aA,aC=aG,W,V end
end
end
end
return aB,aC,aA~=math.huge and aA or nil
end





























function d.NamedZoneAt(ax,ay,az,aA)
LPH_ATTRIBUTES(VM(NONE))
local aB
if type(az)=="table"then
aB=az
elseif type(az)=="string"and az~=""then
aB={az}
else
return false
end
if#aB==0 then return false end
ay=ay or 0




local function flatHit(aC,aD,aE)
local aF=math.max(aD.X,aD.Z)*0.5+(aE or 0)+ay
local aG=Vector3.new(ax.X-aC.X,0,ax.Z-aC.Z)
return aG.Magnitude<=aF
end

local function named(aC)
local aD=tostring(aC or""):lower()
for aE,aF in ipairs(aB)do
if aD:find(tostring(aF),1,true)then return true end
end
return false
end











for aC in pairs(n)do
if aC.Parent and not zoneDark(n[aC],aC)
and(named(aC.Parent.Name)or named(aC.Name))then
local aD=n[aC]
local aE=type(aD)=="table"and aD.flat or 0
local aF
if aA then
aF=flatHit(aC.Position,aC.Size,aE)
else
aF=penetration(aC,ax,ay)~=nil
end
if aF then return true,aC.Position end
end
end



local aC=os.clock()
for aD,aE in ipairs(u)do
if aE.expires>aC and named(aE.name)then
local aF
if aA then
aF=flatHit(aE.cf.Position,aE.size,aE.flat or 0)
else
aF=penetrationOf(aE.cf,aE.size,aE.cylinder,ax,
ay+(aE.flat or 0),
math.min(ay,as)+(aE.vert or 0))~=nil
end
if aF then return true,aE.cf.Position end
end
end
return false
end







function d.HasZoneNamed(ax)
LPH_ATTRIBUTES(VM(NONE))
if type(ax)~="string"or ax==""then return false end
for ay in pairs(n)do
if ay.Parent then
local az=tostring(ay.Parent.Name):lower()
if az:find(ax,1,true)or tostring(ay.Name):lower():find(ax,1,true)then
return true
end
end
end
return false
end

function d.SpinRadius()
LPH_ATTRIBUTES(VM(NONE))
local ax
for ay,az in pairs(r)do
if ay.Parent and(not ax or az.radius>ax)then ax=az.radius end
end
return ax
end

local function spinThreat(ax,ay)
LPH_ATTRIBUTES(VM(NONE))
local az=0
for aA,aB in pairs(r)do
if aA.Parent then
local aC,aD=pcall(function()return aA:GetPivot().Position end)
if aC then
local aE=Vector3.new(ax.X-aD.X,0,ax.Z-aD.Z).Magnitude

if math.abs(ax.Y-aD.Y)<aB.radius then
local aF=aB.radius+ay-aE
if aF>az then az=aF end
end
end
end
end
return az
end



















local function exitVector(ax,ay,az,aA,aB,aC)
LPH_ATTRIBUTES(VM(NONE))
local aD=ax:PointToObjectSpace(aA)






if az then
local aE=ay.Y*0.5+aB
local aF=ay.X*0.5+aC
local aG=math.sqrt(aD.Y^2+aD.Z^2)
if math.abs(aD.X)>aF or aG>aE then return nil end

local V,W=aD.Y,aD.Z
if aG<0.01 then V,W,aG=1,0,0.01 end
local X=(ax.YVector*(V/aG))+(ax.ZVector*(W/aG))
return X.Unit,aE-aG
end

local aE=ay*0.5+Vector3.new(aB,aC,aB)
if math.abs(aD.X)>aE.X then return nil end
if math.abs(aD.Y)>aE.Y then return nil end
if math.abs(aD.Z)>aE.Z then return nil end

local aF=aE.X-math.abs(aD.X)
local aG=aE.Z-math.abs(aD.Z)
if aF<=aG then
return ax.XVector*(aD.X>=0 and 1 or-1),aF
end
return ax.ZVector*(aD.Z>=0 and 1 or-1),aG
end




















local ax=0.35

local function cheapestExit(ay,az)
LPH_ATTRIBUTES(VM(NONE))
local aA,aB=math.huge
local aC,aD,aE=Vector3.zero,0,0

local function note(aF,aG)
if aG<aA then aB,aA=aF,aG end
aC=aC+aF
if aG>aD then aD=aG end
aE=aE+1
end

for aF,aG in pairs(n)do
if aF.Parent then
local V=az+(type(aG)=="table"and aG.flat or 0)
local W=math.min(az,as)
+(type(aG)=="table"and aG.vert or 0)


if not zoneDark(aG,aF)then
local X,Y=exitVector(aF.CFrame,aF.Size,isCylinder(aF),
ay,V,W)
if X then note(X,Y)end
end
end
end

local aF=os.clock()
for aG,V in ipairs(u)do
if V.expires>aF then
local W,X=exitVector(V.cf,V.size,V.cylinder,ay,
az+(V.flat or 0),
math.min(az,as)+(V.vert or 0))
if W then note(W,X)end
end
end













for aG,V in pairs(p)do
if aG.Parent then
local W=hazardPoint(aG)
if W then
local X=Vector3.new(ay.X-W.X,0,ay.Z-W.Z)
local Y=X.Magnitude
if Y<=V+az and Y>0.1 then
note(X.Unit,math.min(V+az-Y,4))
end
end
end
end

if aE>1 then
local aG=Vector3.new(aC.X,0,aC.Z)


if aG.Magnitude/aE>=ax then

return aG.Unit,aD
end
end

return aB,aA
end












function d.EscapeStep(ay,az,aA)
LPH_ATTRIBUTES(VM(NONE))
if not e then return nil end
az=az or 1
aA=aA or 2

local aB,aC=ay,0
for aD=1,5 do
local aE,aF=cheapestExit(aB,az)
if not aE then










if aC<=0 then return nil end
if d.ZoneAt(aB,0)~=nil then return nil end
return aB,aC
end






local aG=Vector3.new(aE.X,0,aE.Z)
local V=aG.Magnitude
if V<0.01 then return nil end
local W=math.min((aF+aA)/V,(aF+aA)*5)
aB=aB+aG.Unit*W
aC=aC+W
end










return nil
end

function d.ZoneAt(ay,az)
LPH_ATTRIBUTES(VM(NONE))
az=az or 0
local aA=os.clock()
for aB,aC in pairs(n)do
if not aB.Parent then
n[aB]=nil
elseif zoneDark(aC,aB)then

elseif type(aC)=="table"and aC.seen and aB.Transparency>0.95
and not neverSleep(aB)then















aC.dark=true

elseif type(aC)=="table"and aC.over and aA>aC.over then


















aC.dark=true

else
local aD=not(type(aC)=="table"and aC.active and aA<aC.active)
if aD and penetration(aB,ay,az)then return aB end
end
end
local aB=os.clock()
for aC,aD in ipairs(u)do
if aD.expires>aB and penetrationOf(aD.cf,aD.size,aD.cylinder,ay,
az+(aD.flat or 0),math.min(az,as)+(aD.vert or 0))then
return aD
end
end
return hazardAt(ay,az)
end
































local ay=Vector3.new(4,6,4)
local az=OverlapParams.new()
az.FilterType=Enum.RaycastFilterType.Exclude
az.MaxParts=40

















local function attackPart(aA)
LPH_ATTRIBUTES(VM(NONE))
local aB=n[aA]
if not aB then return false end
if zoneDark(aB,aA)then return false end
local aC=os.clock()
if type(aB)=="table"then
if aB.active and aC<aB.active then return false end
if aB.over and aC>aB.over then return false end
end
return true
end











local aA
local aB,aC,aD=0,true

function d.BoxSafe(aE)
LPH_ATTRIBUTES(VM(NONE))
local aF=LocalPlayer.Character
if not aF then return true end
if aF~=aA then
aA=aF
az.FilterDescendantsInstances={aF}
end

local aG=os.clock()
if aD and(aG-aB)<0.008
and(aD-aE).Magnitude<0.05 then
return aC
end

local V,W=pcall(function()
return workspace:GetPartBoundsInBox(CFrame.new(aE),ay,az)
end)
local X,Y=true
if V and type(W)=="table"then
for Z,_ in ipairs(W)do
if attackPart(_)then
X,Y=false,_
break
end
end
end
aB,aD,aC=aG,aE,X
return X,Y
end

















function d.RoomSafe(aE,aF)
LPH_ATTRIBUTES(VM(NONE))
aF=aF or 2.5
local aG=LocalPlayer.Character
if not aG then return true end
if aG~=aA then
aA=aG
az.FilterDescendantsInstances={aG}
end
local V=Vector3.new(ay.X+aF*2,ay.Y,ay.Z+aF*2)
local W,X=pcall(function()
return workspace:GetPartBoundsInBox(CFrame.new(aE),V,az)
end)
if not W or type(X)~="table"then return true end
for Y,Z in ipairs(X)do
if attackPart(Z)then return false,Z end
end
return true
end












local aE=0.2

function d.PassAt(aF,aG,V)
LPH_ATTRIBUTES(VM(NONE))
aG=aG or 0
local W=os.clock()
for X,Y in pairs(n)do
if X.Parent and not zoneDark(Y,X)then
local Z=not(type(Y)=="table"and Y.active and W<Y.active)
local _=type(Y)=="table"and Y.over and W>Y.over
if Z and not _ and penetration(X,aF,aG)then
local aH=d.TimeToHit(X)
if not(aH and V<aH-aE)then
return false,X
end
end
end
end
for aH,X in ipairs(u)do
if X.expires>W and penetrationOf(X.cf,X.size,X.cylinder,aF,
aG+(X.flat or 0),math.min(aG,as)+(X.vert or 0))then
return false,X
end
end
if hazardAt(aF,aG)then return false,nil end
return true
end

T=function()
LPH_ATTRIBUTES(VM(NONE))
local aF=LocalPlayer.Character
if aF~=P then
P=aF
O=os.clock()
M=setmetatable({},{__mode="k"})
end
if not aF then return end
local aG=aF:FindFirstChild"HumanoidRootPart"
local aH=aF:FindFirstChildOfClass"Humanoid"
if not aG or not aH or aH.Health<=0 then return end

local V=aG.Position
local W=os.clock()


for X,Y in pairs(N)do
local Z=false
if X.Parent then
for _,aI in ipairs(X:GetDescendants())do
if aI:IsA"BasePart"and n[aI]and not zoneDark(n[aI],aI)
and penetration(aI,V,0)then
Z=true
break
end
end
end
if not Z then

N[X]=nil
end
end

for aI,X in pairs(n)do
local Y=aI.Parent
if aI.Parent and Y and not M[Y]and not zoneDark(X,aI)then
local Z=not(type(X)=="table"and X.active and W<X.active)
local _=type(X)=="table"and X.over and W>X.over
if Z and not _ and penetration(aI,V,0)then
M[Y]=true
N[Y]={t0=W,name=("%s/%s"):format(Y.Name,aI.Name)}
Q=Q+1
local aJ=aH.Health local aK=
W-O;








("%s/%s"):format(Y.Name,aI.Name)local aL=









aF:FindFirstChildOfClass"ForceField"~=nil local aM=
(type(X)=="table"and X.born)and(W-X.born)or-1
task.delay(1,function()
local aN=aH.Health
if aN>=aJ then R=R+1 end

end)
end
end
end
end





local function threatAt(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
aG=aG+g
local aH=spinThreat(aF,aG)
local aI=os.clock()
for aJ,aM in pairs(n)do
if aJ.Parent
and not(type(aM)=="table"and aM.active and aI<aM.active)
and not(type(aM)=="table"and aM.over and aI>aM.over)
and not zoneDark(aM,aJ)
and not(type(aM)=="table"and aM.seen and aJ.Transparency>0.95)then
local aN=penetration(aJ,aF,aG)
if aN and aN>aH then aH=aN end
end
end
local aJ=os.clock()
for aM,aN in ipairs(u)do
if aN.expires>aJ then
local V=penetrationOf(aN.cf,aN.size,aN.cylinder,aF,
aG+(aN.flat or 0),math.min(aG,as)+(aN.vert or 0))
if V and V>aH then aH=V end
end
end
for aM,aN in pairs(p)do
if aM.Parent then
local V=hazardPoint(aM)
if V then
local W=Vector3.new(aF.X-V.X,0,aF.Z-V.Z)
local X=aN+aG-W.Magnitude
if X>aH then aH=X end
end
end
end
return aH
end






function d.IsZone(aF)
LPH_ATTRIBUTES(VM(NONE))
return n[aF]~=nil
end

function d.ThreatAt(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
if not e then return 0 end
return threatAt(aF,aG)
end

function d.IsSafe(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
if not e then return true end
aG=(aG or 6)+g
if spinThreat(aF,aG)>0 then return false end
if d.ZoneAt(aF,aG)~=nil then return false end





return true
end











local aF=16
local aG=4
local aH=44













local aI=250

local aJ=RaycastParams.new()
aJ.FilterType=Enum.RaycastFilterType.Exclude
aJ.IgnoreWater=true



local aM,aN=(-99)

local function floorIgnore()
LPH_ATTRIBUTES(VM(NONE))
if aN and os.clock()-aM<0.5 then return aN end
local V={LocalPlayer.Character}
local W=workspace:FindFirstChild"dungeon"
if W then

for X,Y in ipairs(W:GetChildren())do
local Z=Y:FindFirstChild"enemyFolder"
if Z then V[#V+1]=Z end
end
end
















local X=workspace:FindFirstChild"enemies"
if X then V[#V+1]=X end
for Y,Z in ipairs(workspace:GetChildren())do
if Z~=LocalPlayer.Character and Z:IsA"Model"
and Z:FindFirstChildWhichIsA"Humanoid"then
V[#V+1]=Z
end
end









for Y,Z in ipairs(workspace:GetChildren())do
if ac[Z]or isOwnProjectile(Z)then V[#V+1]=Z end
end










for Y in pairs(n)do
if Y.Parent then V[#V+1]=Y end
end
aN,aM=V,os.clock()
return V
end











local V=RaycastParams.new()
V.FilterType=Enum.RaycastFilterType.Include
V.IgnoreWater=true

local W,X=(-99)





local function borderParts()
LPH_ATTRIBUTES(VM(NONE))
if X and os.clock()-W<5 then return X end

local Y={}
local function take(Z)
if Z:IsA"BasePart"then
Y[#Y+1]=Z
return
end
for _,aO in ipairs(Z:GetDescendants())do
if aO:IsA"BasePart"then Y[#Y+1]=aO end
end
end










for aO,Z in ipairs(workspace:GetChildren())do
local _=tostring(Z.Name):lower()
if _=="borders"or _:find("inviswall",1,true)then
take(Z)
end
end

X,W=Y,os.clock()
return Y
end

local function crossesBorder(aO,Y)
LPH_ATTRIBUTES(VM(NONE))
local Z=borderParts()
if#Z==0 then return false end
V.FilterDescendantsInstances=Z
local _=Y-aO
if _.Magnitude<0.01 then return false end
return workspace:Raycast(aO,_,V)~=nil
end

function d.CrossesBorder(aO,Y)
LPH_ATTRIBUTES(VM(NONE))
return crossesBorder(aO,Y)
end

local function hasFloor(aO)
LPH_ATTRIBUTES(VM(NONE))
aJ.FilterDescendantsInstances=floorIgnore()
return workspace:Raycast(aO,Vector3.new(0,-aI,0),aJ)~=nil
end












function d.FloorIgnore()
LPH_ATTRIBUTES(VM(NONE))
return floorIgnore()
end



function d.HazardRadius(aO)
LPH_ATTRIBUTES(VM(NONE))
return aO and p[aO]or nil
end

function d.HasFloor(aO)
LPH_ATTRIBUTES(VM(NONE))
return hasFloor(aO)
end

local function ringPoints(aO,Y)
LPH_ATTRIBUTES(VM(NONE))
local Z={}
for _=0,aF-1 do
local aP=(_/aF)*math.pi*2
Z[#Z+1]=aO+Vector3.new(math.cos(aP)*Y,0,math.sin(aP)*Y)
end
return Z
end



local aO,aP=(-99)





















local function atStandHeight(Y,Z)
LPH_ATTRIBUTES(VM(NONE))
if not Y then return nil end
local _=Z and Z.lift
if not _ or _==0 then return Y end
return Y+Vector3.new(0,_,0)
end

local function shelterSpot(Y,Z,_)
LPH_ATTRIBUTES(VM(NONE))
if not(Y and Y.safeSpots)then return nil end
local aQ,aR=math.huge
for aS,aT in ipairs(Y.safeSpots)do
local aU=atStandHeight(aT,Y)or aT
if d.ZoneAt(aU,_)==nil then
local aV=(aU-Z).Magnitude
if aV<aQ then aR,aQ=aU,aV end
end
end
return aR
end








local aQ="?"

function d.LastPick()
LPH_ATTRIBUTES(VM(NONE))
return aQ
end















local function pick(aR,aS,aT)
LPH_ATTRIBUTES(VM(NONE))
aQ=aR
if typeof(aS)~="Vector3"then return aS,aT end

local aU=c.Active()
local aV=aU and aU.ceiling
local Y=aU and aU.floorY
if not(aV and Y)then return aS,aT end







local Z=Y+aV+(aU.lift or 0)
local _=aS

if _.Y>Z then



local aW=d.GroundAt(_.X,_.Z,Y+30)
if aW and aW.Y<=Z then
_=aW
aQ=aR.."s97"
else
_=Vector3.new(_.X,Z,_.Z)
aQ=aR.."s98"
end
end

return _,aT
end













function d.SafePoint(aR,aS)
LPH_ATTRIBUTES(VM(NONE))
if not e then return aR end
aS=aS or 6
sweepGhosts()
if d.IsSafe(aR,aS)then return pick("s99",aR)end

local aT=c.Active()
local function permitted(aU)
return not aT or not aT.hardAllow or aT.hardAllow(aU)
end









local function onGround(aU)
if not(aT and aT.groundOnly)then return aU end
local aV=d.GroundAt(aU.X,aU.Z,aT.center.Y)
return atStandHeight(aV,aT)or aU
end


for aU=aG,aH,aG do
for aV,aW in ipairs(ringPoints(aR,aU))do
local Y=onGround(aW)
if d.IsSafe(Y,aS)and hasFloor(Y)and permitted(Y)then
return pick("s100",Y)
end
end
end

if aP and os.clock()-aO<0.35 then return pick("s101",aP)end




if hasFloor(aR)and not(aT and aT.groundOnly)then
for aU,aV in ipairs{20,45,80}do
local aW=aR+Vector3.new(0,aV,0)
if d.IsSafe(aW,aS)and permitted(aW)then
aP,aO=aW,os.clock()
return pick("s102",aW)
end
end
end















local aU=shelterSpot(aT,aR,aS)
if aU then
aP,aO=aU,os.clock()
return pick("s103",aU)
end

local aV=aT and aT.cleanOnly
local aW,Y=aR,threatAt(aR,aS)
local Z=(aT and aT.groundOnly)and{0}or{0,22,48}
for _,aX in ipairs(Z)do
for aY=aG*2,aH,aG*2 do
for aZ,a_ in ipairs(ringPoints(aR,aY))do
local a0=onGround(a_+Vector3.new(0,aX,0))
local a1=threatAt(a0,aS)
if a1<Y and hasFloor(a0)and permitted(a0)
and not(aV and d.ZoneAt(a0,0)~=nil)then
aW,Y=a0,a1
end
end
end
end

aP,aO=aW,os.clock()
return pick("s104",aW)
end

















local aR=16










local aS={0,8,16,26,40,60}































local aT=2.5
local aU=0.6









local aV=3











function d.GroundAt(aW,aX,aY)
LPH_ATTRIBUTES(VM(NONE))
aJ.FilterDescendantsInstances=floorIgnore()
local aZ=Vector3.new(aW,(aY or 0)+6,aX)
local a_=workspace:Raycast(aZ,Vector3.new(0,-aI,0),aJ)
if not a_ then return nil end
return Vector3.new(aW,a_.Position.Y+aV,aX)
end







local aW

function d.SetProbe(aX)
LPH_ATTRIBUTES(VM(NONE))
aW=aX
end

local function note(aX,aY)
LPH_ATTRIBUTES(VM(NONE))
if aW and aX then aW(aX,aY)end
end

function d.SafePointAround(aX,aY)
LPH_ATTRIBUTES(VM(NONE))


if not e then return pick("s105",aY.from or aX,true)end
local aZ=aY.from
local a_,a0=aY.min,aY.max
local a1=aY.margin or 6






local Y=aY.baseY or aZ.Y
local Z=aY.guards

local _=c.Active()















local a2=_ and _.minionGuard~=nil

local function tooCloseToMob(a3)
if not Z then return false end
for a4,a5 in ipairs(Z)do
local a6=Vector3.new(a3.X-a5.pos.X,0,a3.Z-a5.pos.Z).Magnitude
if a6<a5.radius and(a2 or math.abs(a3.Y-a5.pos.Y)<a5.height)then
return true
end
end
return false
end

sweepGhosts()









local a3={}
local a4={}
































local a5=c.Allows"close"and aT or aU
local a6=_ and _.groundOnly
local a7=a6 and math.max(a0*1.8,64)or a0*1.8

local function offer(a8,a9,ba)











if _ and _.groundOnly then
local bb=math.sqrt((a8-aX.X)^2+(a9-aX.Z)^2)
if bb<=a7 then
a3[#a3+1]={x=a8,z=a9,d=bb,lazy=true}
end
return
end

for bb,bc in ipairs(aS)do
local bd=Vector3.new(a8,Y+bc,a9)




if(bd-aX).Magnitude<=a7 then











local be={
p=bd,
d=(bd-aX).Magnitude
+math.abs(bd.Y-aX.Y)*a5,
}







if _ and not _.allow(bd)then
a4[#a4+1]=be
else
a3[#a3+1]=be
end
end
end
end





offer(aX.X,aX.Z,0)











local a8=3



















local a9=(_ and _.dirs)or aR
local function ring(ba)
for bb=0,a9-1 do
local bc=(bb/a9)*math.pi*2
offer(aX.X+math.cos(bc)*ba,
aX.Z+math.sin(bc)*ba,ba)
end
end

for ba=a_,a0,a8 do ring(ba)end



for ba=a0+4,a7,(a6 and 5 or 8)do ring(ba)end














if _ and _.hopNear then
local ba=aZ
table.sort(a3,function(bb,bc)
local bd=(bb.p and(bb.p-ba).Magnitude)
or math.sqrt((bb.x-ba.X)^2+(bb.z-ba.Z)^2)
local be=(bc.p and(bc.p-ba).Magnitude)
or math.sqrt((bc.x-ba.X)^2+(bc.z-ba.Z)^2)
return bd<be
end)
else
table.sort(a3,function(ba,bb)return ba.d<bb.d end)
end
















local ba=260
if _ and _.dirs then
ba=math.floor(ba*(_.dirs/aR))
end local
bb=0







local bc=_ and _.leash
if bc then






































local bd={}
for be,bf in ipairs(a3)do
if bf.d>bc then break end
if#bd>=200 then break end
if bf.lazy and not bf.p then
bf.p=atStandHeight(
d.GroundAt(bf.x,bf.z,_.center.Y),_)
end
if bf.p and _.hardAllow(bf.p)and not tooCloseToMob(bf.p)then
bd[#bd+1]=bf.p
end
end

for be,bf in ipairs{6,4,3}do
local bg,bh=math.huge
for bi,bj in ipairs(bd)do
if d.ZoneAt(bj,bf)==nil then
if d.IsSafe(bj,a1)and _.allow(bj)then
return pick("s106",bj,true)
end
local bk=threatAt(bj,a1)
if bk<bg then bh,bg=bj,bk end
end
end
if bh then












return pick(("s107"):format(bf),bh,false)
end
end

end

for bd,be in ipairs(a3)do
local bf=be.p
if be.lazy then
if ba<=0 then break end
ba=ba-1
bb=bb+1
bf=atStandHeight(
d.GroundAt(be.x,be.z,_.center.Y),_)





be.p=bf


if not bf then

elseif not _.hardAllow(bf)then
note(bf,"rules")
elseif tooCloseToMob(bf)then
note(bf,"mob")
elseif not d.IsSafe(bf,a1)then
elseif _.allow(bf)then
return pick("s108",bf,true)
else
note(bf,"spare")
a4[#a4+1]={p=bf,d=be.d}
end
bf=nil
elseif tooCloseToMob(bf)then
note(bf,"mob")
elseif not d.IsSafe(bf,a1)then
note(bf,"dirty")
elseif not hasFloor(bf)then
note(bf,"nofloor")
else
return pick("s109",bf,true)
end
end










if _ and _.groundOnly and#a4==0 then
for bd,be in ipairs{a1*0.5,1}do
local bf=0
for bg,bh in ipairs(a3)do

if bh.p and bf<160 then
bf=bf+1
if _.hardAllow(bh.p)and not tooCloseToMob(bh.p)
and d.IsSafe(bh.p,be)then
return pick("s110",bh.p,true)
end
end
end
end
end







if#a4>0 then

local bd=_ and _.cleanOnly
local be,bf=math.huge
for bg,bh in ipairs(a4)do
if not(bd and d.ZoneAt(bh.p,0)~=nil)then
local bi=threatAt(bh.p,a1)
if bi<be then bf,be=bh.p,bi end
end
end
if bf then return pick("s111",bf,false)end
end


local bd=shelterSpot(_,aZ,a1)
if bd then return pick("s103",bd,true)end











for be,bf in ipairs(_ and _.groundOnly and{}or{30,55,85,115})do
local bg=Vector3.new(aZ.X,aX.Y+bf,aZ.Z)
if d.IsSafe(bg,a1)then return pick("s112",bg,true)end
end




local be,bf=math.huge
for bg,bh in ipairs(a3)do




















if bh.p and not tooCloseToMob(bh.p)
and(not _ or not _.hardAllow or _.hardAllow(bh.p))then
local bi=threatAt(bh.p,a1)
if bi<be and hasFloor(bh.p)then
bf,be=bh.p,bi
end
end
end








if not bf and _ and _.groundOnly then
local bg=Vector3.new(aZ.X-_.center.X,0,aZ.Z-_.center.Z)
if bg.Magnitude<1 then bg=Vector3.new(1,0,0)end
bg=bg.Unit*42
bf=d.GroundAt(_.center.X+bg.X,_.center.Z+bg.Z,
_.center.Y)
if bf and _.hardAllow and not _.hardAllow(bf)then
bf=d.GroundAt(_.center.X,_.center.Z,_.center.Y)
end
end
if _ and _.groundOnly and b.enabled and bb>0 then

end



return pick("s113",bf,false)
end














local aX=20



















local aY=40












local aZ={
spikeprecast=true,
overgrowthspikes=true,
overgrowthlonglinespikes=true,

}

local function ceilingForced(a_)
LPH_ATTRIBUTES(VM(NONE))
local a0=tostring(a_.Name):lower()
if aZ[a0]then return true end
local a1=a_.Parent
return a1~=nil and aZ[tostring(a1.Name):lower()]==true
end

local function isBlocky(a_)
LPH_ATTRIBUTES(VM(NONE))
local a0=math.max(a_.X,a_.Z)
local a1=math.min(a_.X,a_.Z)
return a1>=aY and(a0/a1)<2
end

function d.CeilingNear(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
local a1

for a2,a3 in pairs(n)do
if a2.Parent and not zoneDark(a3,a2)and(ceilingForced(a2)
or(a2.Size.Y>=aX and isBlocky(a2.Size)))then
local a4=Vector3.new(a_.X-a2.Position.X,0,a_.Z-a2.Position.Z).Magnitude
if a4<=a0+math.max(a2.Size.X,a2.Size.Z)*0.5 then



local a5=n[a2]
local a6=type(a5)=="table"and a5.vert or 0
local a7=a2.Position.Y+a2.Size.Y*0.5+a6
if not a1 or a7>a1 then a1=a7 end
end
end
end

return a1
end

















function d.NearestZones(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
local a1={}
for a2,a3 in pairs(n)do
if a2.Parent and not zoneDark(a3,a2)then
local a4=a2.CFrame:PointToObjectSpace(a_)
local a5=a2.Size*0.5
local a6=Vector3.new(
math.max(math.abs(a4.X)-a5.X,0),
math.max(math.abs(a4.Y)-a5.Y,0),
math.max(math.abs(a4.Z)-a5.Z,0)).Magnitude
local a7=v[a2]
a1[#a1+1]={
gap=a6,
text=("s114"):format(
tostring(a2.Parent and a2.Parent.Name or"?"),tostring(a2.Name),
tostring(a2.Size),a6,
(a7 and a7.speed)or 0,
type(a3)=="table"and(a3.flat or 0)or 0,
type(a3)=="table"and(a3.vert or 0)or 0),
}
end
end
table.sort(a1,function(a2,a3)return a2.gap<a3.gap end)
local a2={}
for a3=1,math.min(#a1,a0 or 6)do a2[#a2+1]=a1[a3].text end
return a2
end








function d.ZoneShapes(a_,a0,a1)
LPH_ATTRIBUTES(VM(NONE))
a0=a0 or 80
a1=(a1 or 0)+g
local a2={}

for a3,a4 in pairs(n)do
if a3.Parent and not zoneDark(a4,a3)
and(a3.Position-a_).Magnitude<=a0 then
local a5=type(a4)=="table"and a4.flat or 0
local a6=type(a4)=="table"and a4.vert or 0
local a7=a1+a5
local a8=math.min(a1,as)+a6
a2[#a2+1]={
cf=a3.CFrame,
size=a3.Size+Vector3.new(a7*2,a8*2,a7*2),
raw=a3.Size,
cylinder=isCylinder(a3),
name=("%s/%s"):format(a3.Parent and a3.Parent.Name or"?",a3.Name),
ghost=false,
}
end
end

local a3=os.clock()
for a4,a5 in ipairs(u)do
if a5.expires>a3 and(a5.cf.Position-a_).Magnitude<=a0 then
local a6=a1+(a5.flat or 0)
local a7=math.min(a1,as)+(a5.vert or 0)
a2[#a2+1]={
cf=a5.cf,
size=a5.size+Vector3.new(a6*2,a7*2,a6*2),
raw=a5.size,
cylinder=a5.cylinder,
name="s35"..tostring(a5.name),
ghost=true,
}
end
end
return a2
end

function d.Nearby(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
a0=a0 or 60
local a1={}

for a2,a3 in pairs(n)do
if a2.Parent and not zoneDark(a3,a2)then
local a4=(a2.Position-a_).Magnitude
if a4<=a0 then
a1[#a1+1]=("%s/%s@%.0f"):format(
a2.Parent and a2.Parent.Name or"?",a2.Name,a4)
end
end
end

local a2=os.clock()
for a3,a4 in ipairs(u)do
if a4.expires>a2 then
local a5=(a4.cf.Position-a_).Magnitude
if a5<=a0 then a1[#a1+1]=("s115"):format(a4.name,a5)end
end
end

for a3 in pairs(p)do
if a3.Parent then
local a4=hazardPoint(a3)
if a4 then
local a5=(a4-a_).Magnitude
if a5<=a0 then a1[#a1+1]=("%s@%.0f"):format(a3.Name,a5)end
end
end
end

table.sort(a1)
return#a1>0 and table.concat(a1," ")or"s116"
end








function d.NamedReport(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
local a1
if type(a0)=="table"then a1=a0
elseif type(a0)=="string"and a0~=""then a1={a0}
else return"-"end

local function named(a2)
local a3=tostring(a2 or""):lower()
for a4,a5 in ipairs(a1)do
if a3:find(tostring(a5),1,true)then return true end
end
return false
end

local a2={}
local function add(a3,a4,a5,a6)
local a7=Vector3.new(a_.X-a4.X,0,a_.Z-a4.Z).Magnitude
local a8=math.max(a5.X,a5.Z)*0.5+(a6 or 0)
a2[#a2+1]=("s117"):format(
a3,a7,a8,a_.Y-a4.Y)
end

for a3 in pairs(n)do
if a3.Parent and not zoneDark(n[a3],a3)
and(named(a3.Parent.Name)or named(a3.Name))then
local a4=n[a3]
add(a3.Name,a3.Position,a3.Size,
type(a4)=="table"and a4.flat or 0)
end
end
local a3=os.clock()
for a4,a5 in ipairs(u)do
if a5.expires>a3 and named(a5.name)then
add("s35"..tostring(a5.name),a5.cf.Position,a5.size,a5.flat or 0)
end
end
if#a2==0 then return"s3"end
table.sort(a2)
return table.concat(a2," ")
end


function d.Describe(a_)
LPH_ATTRIBUTES(VM(NONE))
local a0={}
for a1,a2 in pairs(n)do
if a1.Parent and not zoneDark(a2,a1)and penetration(a1,a_,0)then
a0[#a0+1]=("%s/%s"):format(a1.Parent and a1.Parent.Name or"?",a1.Name)
end
end
local a1=os.clock()
for a2,a3 in ipairs(u)do
if a3.expires>a1 and penetrationOf(a3.cf,a3.size,a3.cylinder,a_,0,0)then
a0[#a0+1]="s35"..a3.name
end
end
local a2=hazardAt(a_,0)
if a2 then a0[#a0+1]=a2.Name end
return#a0>0 and table.concat(a0,",")or"none"
end

return d end function a.x():typeof(__modImpl())local aa=a.cache.x if not aa then aa={c=__modImpl()}a.cache.x=aa end return aa.c end end do local function __modImpl()






















local aa=a.x()
local ab=a.s()

local ac={}






function ac.Step(ad)
local ae=ad.stand
local af=(os.clock()-ad.state.dodgeAt)<ad.hold

if not af and aa.IsSafe(ae,ad.margin)and not ad.crowded(ae)then
ad.state.dodgeStand=nil












elseif ad.state.dodgeStand
and aa.IsSafe(ad.state.dodgeStand,ad.margin)
and not ad.crowded(ad.state.dodgeStand)
and(ad.keepFar
or(ad.state.dodgeStand-ad.pos).Magnitude<=ad.reach)
then
ae=ad.state.dodgeStand

elseif not aa.IsSafe(ae,ad.margin)or ad.crowded(ae)then
local ag=aa.SafePointAround(ad.pos,{
from=ad.here or ae,
min=ad.keepAway,
max=ad.reach,
margin=ad.margin,
baseY=ae.Y,
guards=ad.guards(),
})
ad.state.dodgeAt=os.clock()
if ag then
ad.state.dodgeStand,ae=ag,ag
if ad.log then
ad.log(("s126"):format(
ag.X,ag.Y,ag.Z,(ag-ad.pos).Magnitude,
aa.Describe(ad.here or ae),aa.Count()))
end
end

else
ad.state.dodgeStand=nil
end


ab.Pin(ae,ad.pos)
return ae
end

return ac end function a.y():typeof(__modImpl())local aa=a.cache.y if not aa then aa={c=__modImpl()}a.cache.y=aa end return aa.c end end do local function __modImpl()





















local aa=a.x()
local ab=a.s()

local ac={}










local ad,ae=10,4



local af={0,6,12}


local ag=6



local ah=6









local ai=2

function ac.Clear(aj)
aj.point,aj.at=nil,0
end


local function judge(aj,ak,al,am)
if not aj then return false,"nofloor"end
if ak and(aj.Y-ak>ae or ak-aj.Y>ad)then
return false,"nofloor"
end
for an,ao in ipairs(af)do
if not aa.IsSafe(aj+Vector3.new(0,ao,0),al)then
return false,"zone"
end
end
if am and am(aj)then return false,"crowded"end
return true,"good"
end















local function scan(aj,ak,al,am)
local an=aj.pos
local ao=aj.here or an
local ap=Vector3.new(ao.X-an.X,0,ao.Z-an.Z)
if ap.Magnitude<1 then ap=Vector3.new(1,0,0)end
ap=ap.Unit






local aq=aj.state and aj.state.point or ao

local ar,as=0,{}
for au=ag,aj.reach,ai do


local av=math.max(8,math.floor(2*math.pi*au/ai))
local aw,ax
local ay,az=math.huge,math.huge

for aA=0,av-1 do

local aB=(aA%2==0 and 1 or-1)*math.rad((360/av)*math.ceil(aA/2))
local aC=CFrame.Angles(0,aB,0)*ap
local aD,aE=an.X+aC.X*au,an.Z+aC.Z*au
local aF=aa.GroundAt(aD,aE,an.Y)
ar=ar+1

local aG,aH=judge(aF,ak,al,aj.crowded)
if aH=="zone"then


local aI=aa.ZoneAt(aF,al)
local aJ=aI
and(tostring(aI.Parent and aI.Parent.Name or"?")
.."/"..tostring(aI.Name))
or"s119"
as[aJ]=(as[aJ]or 0)+1
end


if aj.mark and am.n<200 then
am.n=am.n+1
aj.mark(aF or Vector3.new(aD,an.Y,aE),aH)
end

if aG then
local aI=(aF-aq).Magnitude
if judge(aF,ak,al+ah,aj.crowded)then
if aI<ay then aw,ay=aF,aI end
elseif aI<az then
ax,az=aF,aI
end
end
end

if aw then return aw,ar,as end
if ax then return ax,ar,as end
end
return nil,ar,as
end


function ac.Step(aj)
local ak,al=aj.pos,aj.state
local am=aa.GroundAt(ak.X,ak.Z,ak.Y)
local an=am and am.Y or nil












local ao=1.5
if al.point and judge(al.point,an,ao,aj.crowded)then
ab.Pin(al.point,Vector3.new(ak.X,al.point.Y,ak.Z))
return al.point
end











local ap=al.point and not aa.IsSafe(al.point,0)
if al.point and not ap and(os.clock()-(al.at or 0))<0.3 then
ab.Pin(al.point,Vector3.new(ak.X,al.point.Y,ak.Z))
return al.point
end












local aq={n=0}
local ar,as,au=scan(aj,an,aj.margin,aq)






if not ar then
ar=scan(aj,an,aj.margin*0.5,aq)
end
if not ar then
ar=scan(aj,an,1,aq)
end

if aj.log then
local av={}
for aw,ax in pairs(au)do
av[#av+1]=("%s x%d"):format(aw,ax)
end
aj.log(("s120"):format(
as,ar and"s121"or"s122",
#av>0 and table.concat(av,", ")or"-"))
end











if not ar and aj.escape then
ar=aj.escape()
if ar and aj.log then
aj.log"s123"
end
end

al.point=ar or al.point or am or ak
al.at=os.clock()



ab.Pin(al.point,Vector3.new(ak.X,al.point.Y,ak.Z))
return al.point
end

return ac end function a.z():typeof(__modImpl())local aa=a.cache.z if not aa then aa={c=__modImpl()}a.cache.z=aa end return aa.c end end do local function __modImpl()

















local aa=a.n()
local ab=a.s()
local ac=a.x()

local ad={}



local ae=3



local af=6

local function pickRing()
local ag=workspace:FindFirstChild"playerPickupCannonballRing"
return(ag and ag:IsA"BasePart")and ag or nil
end

local function fireRing()
local ag=workspace:FindFirstChild"playerFireCannon"
local ah=ag and ag:FindFirstChild"ring"
return(ah and ah:IsA"BasePart")and ah or nil
end



function ad.Active()
local ag=pickRing()
return ag~=nil and ag.Transparency<0.95
end






function ad.Carrying()
local ag=aa.HRP()
if not ag then return false end
for ah,ai in ipairs(workspace:GetChildren())do
if tostring(ai.Name):lower():find("overheadcannon",1,true)then
local aj,ak=pcall(function()return ai:GetPivot().Position end)
if aj then
local al=Vector3.new(ak.X-ag.Position.X,0,ak.Z-ag.Position.Z)
if al.Magnitude<=8 and ak.Y>ag.Position.Y then return true end
end
end
end
return false
end


function ad.Target()
local ag=ad.Carrying()and fireRing()or pickRing()
if not ag then return nil end
return ag.Position+Vector3.new(0,ae,0),ag
end


function ad.InPlace()
local ag=ad.Target()
local ah=aa.HRP()
if not ag or not ah then return false end
return Vector3.new(ag.X-ah.Position.X,0,ag.Z-ah.Position.Z).Magnitude<=af
end






function ad.Step()
if not ad.Active()then return false end local

ag=ad.Target()
if not ag then return false end



local ah=ac.CleanNear(ag)or ag


local ai=Vector3.new(ah.X-ag.X,0,ah.Z-ag.Z)
if ai.Magnitude>af then
ah=ag+ai.Unit*af
end


ab.Where(ad.Carrying()and"s60"or"s61")
ab.Pin(ah,ah+Vector3.new(0,0,1))
return true
end

return ad end function a.A():typeof(__modImpl())local aa=a.cache.A if not aa then aa={c=__modImpl()}a.cache.A=aa end return aa.c end end do local function __modImpl()

















local aa=a.n()
local ab=a.s()
local ac=a.x()

local ad={}



local ae=8



local af=1




local ag=15

local function centre()
local ah=workspace:FindFirstChild"thirdBossMiddlePart"
return(ah and ah:IsA"BasePart")and ah.Position or nil
end

function ad.Active()
return workspace:FindFirstChild"thirdBossSafeSpots"~=nil
end

local function cogs()
local ah=workspace:FindFirstChild"thirdBossSafeSpots"
local ai={}
if not ah then return ai end
for aj,ak in ipairs(ah:GetChildren())do
if tostring(ak.Name):lower()=="cog"then
local al,am=pcall(function()return ak:GetPivot().Position end)
if al then ai[#ai+1]=am end
end
end
return ai
end



local function behindNearest(ah,ai)
local aj,ak=math.huge
for al,am in ipairs(cogs())do
local an=Vector3.new(am.X-ah.X,0,am.Z-ah.Z)
if an.Magnitude>1 then
an=an.Unit
local ao=am+an*ae
local ap=ac.GroundAt(ao.X,ao.Z,ah.Y+20)
if ap and math.abs(ap.Y-ah.Y)<=ag then
ap=ap-Vector3.new(0,af,0)
local aq=(ap-ai.Position).Magnitude
if aq<aj then ak,aj=ap,aq end
end
end
end
return ak
end


function ad.Step(ah)
if not ad.Active()then
ah.point=nil
return false
end

local ai=centre()
local aj=aa.HRP()
if not ai or not aj then return false end



if not ah.point then
ah.point=behindNearest(ai,aj)
end



local ak=ah.point or aj.Position
ab.Where"s118"
ab.Pin(ak,ak+Vector3.new(0,0,1))
return true
end

return ad end function a.B():typeof(__modImpl())local aa=a.cache.B if not aa then aa={c=__modImpl()}a.cache.B=aa end return aa.c end end do local function __modImpl()























local aa=a.x()
local ab=a.l()

local ac={}



local ad=8

local function mark(ae,af,ag,ah)
aa.Foresee(ae,af,ag,ah,ad,ad)
if ab.enabled then local ai=
ae.Position

end
end

function ac.Watch()
local ae=game:GetService"ReplicatedStorage"
local af=ae:FindFirstChild"remotes"
local ag=af and af:FindFirstChild"volcanicBossSpecficEvents"
if not ag then return false end

regConn(ag.OnClientEvent:Connect(function(ah,ai)
if _apelStopped then return end

if ah=="Artillery Mob Shot"then

local aj=type(ai)=="table"and ai[2]or nil
if typeof(aj)=="CFrame"then






mark(aj,Vector3.new(15,15,15),1.1,"s158")
end

elseif ah=="Second Boss Rock Fall"then

if typeof(ai)=="CFrame"then
mark(ai,Vector3.new(42,42,42),2.2,"s127")
end

elseif ah=="First Boss Sky Shot"then

if typeof(ai)=="Vector3"then
mark(CFrame.new(ai),Vector3.new(25,60,25),3.0,"s159")
end
end
end))

return true
end

return ac end function a.C():typeof(__modImpl())local aa=a.cache.C if not aa then aa={c=__modImpl()}a.cache.C=aa end return aa.c end end do local function __modImpl()















local aa=a.l()
local ab=a.x()

local ac={}






local function describe(ad,ae,af)
ae=ae or 0
local ag=typeof(ad)

if ag=="CFrame"or ag=="Vector3"then
local ah=(ag=="CFrame")and ad.Position or ad
local ai=af and(ah-af).Magnitude or nil
return("%s %.0f,%.0f,%.0f%s"):format(ag,ah.X,ah.Y,ah.Z,
ai and("s143"):format(ai)or"")
end

if ag=="Instance"then
local ah=""
if ad:IsA"BasePart"then
ah=("s144"):format(
ad.Position.X,ad.Position.Y,ad.Position.Z,tostring(ad.Size))
elseif ad:IsA"Model"then
local ai,aj=pcall(function()return ad:GetPivot().Position end)
if ai then ah=(" @%.0f,%.0f,%.0f"):format(aj.X,aj.Y,aj.Z)end
end
return("%s[%s]%s"):format(ad.Name,ad.ClassName,ah)
end

if ag=="table"then


if ae>=2 then return"{…}"end
local ah={}
for ai,aj in pairs(ad)do
if#ah>=8 then ah[#ah+1]="…"break end
ah[#ah+1]=tostring(ai).."="..describe(aj,ae+1,af)
end
return"{"..table.concat(ah,", ").."}"
end

return("%s %s"):format(ag,tostring(ad))
end



































local ad={
["spearman strike"]={size=Vector3.new(8.5,72.6,140.0),life=1.2},
["warrior line strike"]={size=Vector3.new(8.5,72.6,83.5),life=1.0},
}



local function foresee(ae,af)
if typeof(af)~="CFrame"then return end
local ag=ad[tostring(ae):lower()]
if not ag then return end
ab.Foresee(af,ag.size,ag.life,"s145"..tostring(ae),0,0,false)

end


















local ae="135528907595387"
local af=Vector3.new(8.5,72.6,140.0)
local ag=0.6
local ah=setmetatable({},{__mode="k"})

local function hookSpearman(ai)
if ah[ai]or ai.Name~="Northern Spearman"then return end
local aj=ai:FindFirstChildOfClass"Humanoid"
local ak=aj and aj:FindFirstChildOfClass"Animator"
if not ak then return end
ah[ai]=true
regConn(ak.AnimationPlayed:Connect(function(al)
if _apelStopped then return end
local am=al and al.Animation
local an=am and tostring(am.AnimationId):match"(%d+)"
if an~=ae then return end
local ao=game.Players.LocalPlayer
local ap=ao.Character and ao.Character:FindFirstChild"HumanoidRootPart"
if not ap or not ai.Parent then return end
local aq=ai:GetPivot().Position
local ar=Vector3.new(aq.X,ap.Position.Y,aq.Z)
local as=Vector3.new(ap.Position.X-aq.X,0,ap.Position.Z-aq.Z)
if as.Magnitude<1 then return end
local au=as.Magnitude
as=as.Unit










local av=math.min(af.Z,au+20)
local aw=Vector3.new(af.X,af.Y,av)
local ax=CFrame.new(ar+as*(av*0.5),ar+as*100)
ab.Foresee(ax,aw,ag,"s146",0,0,false)
end))
end

function ac.Watch()

for ai,aj in ipairs(workspace:GetDescendants())do
if aj:IsA"Model"then hookSpearman(aj)end
end
regConn(workspace.DescendantAdded:Connect(function(ai)
if _apelStopped then return end
if ai:IsA"Model"and ai.Name=="Northern Spearman"then
task.delay(0.3,function()
if not _apelStopped then hookSpearman(ai)end
end)
end
end))

local ai=game:GetService"ReplicatedStorage"
local aj=ai:FindFirstChild"remotes"
local ak=aj and aj:FindFirstChild"northernBossSpecficEvents"
if not ak then return false end

regConn(ak.OnClientEvent:Connect(function(al,am)
if _apelStopped then return end



pcall(foresee,al,am)
if not aa.enabled then return end



local an=game.Players.LocalPlayer.Character
local ao=an and an:FindFirstChild"HumanoidRootPart"
local ap=ao and ao.Position or nil

pcall(describe,am,0,ap)

end))

return true
end

return ac end function a.D():typeof(__modImpl())local aa=a.cache.D if not aa then aa={c=__modImpl()}a.cache.D=aa end return aa.c end end do local function __modImpl()







local aa=a.m()

local ab={}

local function queueGui()
local ac=LocalPlayer:FindFirstChild"PlayerGui"
return ac and ac:FindFirstChild"queueGui"or nil
end

local function chooseDungeon()
local ac=queueGui()
return ac and ac:FindFirstChild"chooseDungeon"or nil
end











function ab.Dungeons(ac)
local ad={}





if IN_LOBBY==false then return ad end

local ae=chooseDungeon()
local af=ae and ae:FindFirstChild"backgroundFillLeft"
local ag=af and af:FindFirstChild"ScrollingFrame"
if not ag then return ad end

for ah,ai in ipairs(ag:GetChildren())do
if ai:IsA"ImageLabel"and(ac or ai.Visible)then
ad[#ad+1]={
name=ai.Name,
order=ai.LayoutOrder or 0,
y=ai.AbsolutePosition.Y,
}
end
end

table.sort(ad,function(ah,ai)
if ah.order~=ai.order then return ah.order<ai.order end
if ah.y~=ai.y then return ah.y<ai.y end
return ah.name<ai.name
end)

local ah={}
for ai,aj in ipairs(ad)do ah[ai]=aj.name end
return ah
end



local ac={Easy=1,Medium=2,Hard=3,Insane=4,Nightmare=5}

local ad={"Easy","Medium","Hard","Insane","Nightmare"}

local function sortDifficulties(ae)
table.sort(ae,function(af,ag)
return(ac[af]or 99)<(ac[ag]or 99)
end)
return ae
end







function ab.Difficulties(ae)
local af=ae and ab.CachedStats(ae)
if af then
local ag={}
for ah,ai in pairs(af)do
if type(ai)=="table"and ai.levelReq~=nil then ag[#ag+1]=ah end
end
if#ag>0 then return sortDifficulties(ag)end
end

local ag={}
for ah,ai in ipairs(ad)do ag[ah]=ai end
return ag
end



















local ae={
["Egg Island"]={Easy=1,Nightmare=1},
["Tutorial Dungeon"]={Easy=1,Medium=6,Hard=12},
["Desert Temple"]={Easy=1,Medium=6,Hard=12,Insane=20,Nightmare=27},
["Winter Outpost"]={Easy=33,Medium=40,Hard=45,Insane=50,Nightmare=55},
["Pirate Island"]={Insane=60,Nightmare=65},
["King's Castle"]={Insane=70,Nightmare=75},
["The Underworld"]={Insane=80,Nightmare=85},
["Samurai Palace"]={Insane=90,Nightmare=95},
["The Canals"]={Insane=100,Nightmare=105},
["Ghastly Harbor"]={Insane=110,Nightmare=115},
["Steampunk Sewers"]={Insane=120,Nightmare=125},
["Orbital Outpost"]={Insane=140,Nightmare=145},
["Volcanic Chambers"]={Insane=150,Nightmare=155},
["Aquatic Temple"]={Insane=160,Nightmare=165},
["Enchanted Forest"]={Insane=170,Nightmare=175},
["Northern Lands"]={Insane=180,Nightmare=185},
["Gilded Skies"]={Insane=190,Nightmare=195},
["Oni Dungeon"]={Insane=195,Nightmare=200},
}

local af={}



local ag={}

for ah,ai in pairs(ae)do
local aj={}
for ak,al in pairs(ai)do
aj[ak]={levelReq=al}
end
af[ah]=aj
ag[ah]=true
end



local function invokeWithTimeout(ah,ai)
local aj,ak=false
task.spawn(function()
local al,am=aa.Invoke("getDungeonStats",ah)
if al then ak=am end
aj=true
end)
local al=0
while not aj and al<(ai or 5)do al=al+task.wait(0.05)end
return aj and ak or nil
end

function ab.CachedStats(ah)
local ai=af[ah]
if ai==nil or ai==false then return nil end
return ai
end

function ab.Stats(ah)
if not ah or ah==""then return nil end
local ai=af[ah]


if ai~=nil and not ag[ah]then return ai or nil end

local aj=invokeWithTimeout(ah,5)
if type(aj)=="table"then
af[ah]=aj
ag[ah]=nil
elseif ai==nil then
af[ah]=false
end

return af[ah]or nil
end


function ab.LevelReq(ah,ai)
local aj=ab.CachedStats(ah)
local ak=aj and aj[ai]
return ak and tonumber(ak.levelReq)or nil
end



ab.warmed=false

function ab.WarmStats()
local ah=ab.Dungeons()
if#ah==0 then return false end
for ai,aj in ipairs(ah)do
if _apelStopped then return false end
if af[aj]==nil then
ab.Stats(aj)
task.wait(0.15)
end
end
ab.warmed=true
return true
end



function ab.BestForLevel(ah,ai)
local aj,ak=(-1)
for al,am in ipairs(ab.Dungeons())do
local an=ab.LevelReq(am,ah)
if an and an<=ai and an>aj then ak,aj=am,an end
end
return ak,aj
end
























local ah={
"Egg Island","Tutorial Dungeon","Desert Temple","Winter Outpost",
"Pirate Island","King's Castle","The Underworld","Samurai Palace",
"The Canals","Ghastly Harbor","Steampunk Sewers","Orbital Outpost",
"Volcanic Chambers","Aquatic Temple","Enchanted Forest","Northern Lands",
"Gilded Skies","Oni Dungeon",
}

local function candidateNames()
local ai=ab.Dungeons()
if#ai>0 then return ai end

local aj={}
for ak,al in ipairs(ah)do
if ae[al]then aj[#aj+1]=al end
end
return aj
end









local ai={
["egg island"]=true,
}



function ab.AllDungeons()
return candidateNames()
end

function ab.BestRunForLevel(aj)
local ak,al,am=(-1)

for an,ao in ipairs(candidateNames())do
local ap=not ai[tostring(ao):lower()]and ab.CachedStats(ao)
if ap then
for aq,ar in pairs(ap)do
if type(ar)=="table"and ar.levelReq~=nil then
local as=tonumber(ar.levelReq)
local au=as and as<=aj and as>ak


local av=as and as==ak
and(ac[aq]or 0)>(ac[am]or 0)
if au or av then
al,am,ak=ao,aq,as
end
end
end
end
end

return al,am,ak
end



function ab.DifficultyRank(aj)
return ac[aj]or 0
end







function ab.BestDifficultyFor(aj,ak)
local al=ab.CachedStats(aj)
if not al then return nil end

local am,an=(-1)
for ao,ap in pairs(al)do
if type(ap)=="table"and ap.levelReq~=nil then
local aq=tonumber(ap.levelReq)
local ar=ab.DifficultyRank(ao)
if aq and aq<=ak and ar>am then
an,am=ao,ar
end
end
end
return an
end






function ab.Open()
local aj={}
local ak=workspace:FindFirstChild"games"
local al=ak and ak:FindFirstChild"inLobby"
if not al then return aj end

for am,an in ipairs(al:GetChildren())do
local ao=an:FindFirstChild"mapName"
if ao then
local ap={}
for aq,ar in ipairs(an:GetChildren())do
if ar~=ao and ar:IsA"ValueBase"then ap[#ap+1]=ar.Name end
end
local function sub(aq,ar)
local as=ao:FindFirstChild(aq)
return as and as.Value or ar
end
aj[#aj+1]={
name=an.Name,
dungeon=tostring(ao.Value),
difficulty=tostring(sub("difficulty","")),
levelReq=tonumber(sub("minLevelReq",0))or 0,
hardcore=sub("hardcore",false)==true,
private=sub("private",false)==true,
waveDefence=sub("waveDefence",false)==true,
players=ap,
}
end
end
return aj
end





function ab.Create(aj,ak,al,am,an,ao)
if not aj or aj==""then return false,"no dungeon selected"end
local ap,aq=aa.Invoke("createLobby",aj,ak,
tonumber(al)or 1,am==true,an==true,ao==true)
if not ap then return false,"createLobby failed"end
return aq==true,aq==true and"created"or"server refused"
end

function ab.Join(aj)
local ak,al=aa.Invoke("joinDungeon",aj)
if not ak then return false,"joinDungeon failed"end
return al==true,al==true and"joined"or"server refused"
end


function ab.Start()
return aa.Fire"startDungeon"
end


function ab.MyLobby()
for aj,ak in ipairs(ab.Open())do
for al,am in ipairs(ak.players)do
if am==LocalPlayer.Name then return ak end
end
end
return nil
end

function ab.Leave()
return aa.Fire"leaveGame"
end


function ab.TravelPart()
local aj=workspace:FindFirstChild"Lobby"
local ak=aj and aj:FindFirstChild"Map"
local al=ak and ak:FindFirstChild"Interactables"
return al and al:FindFirstChild"lobby2TravelPart"or nil
end

return ab end function a.E():typeof(__modImpl())local aa=a.cache.E if not aa then aa={c=__modImpl()}a.cache.E=aa end return aa.c end end do local function __modImpl()

















local aa=a.m()

local ab=game:GetService"Players"local ac=
ab.LocalPlayer

local ad={}












local ae

function ad.SetHold(af)ae=af end

function ad.Holding()
if type(ae)~="function"then return false end
local af,ag=pcall(ae)
return af and ag==true
end










function ad.Present(af)
if type(af)~="string"or af==""then return false end
local ag=af:lower()
for ah,ai in ipairs(ab:GetPlayers())do
if ai.Name:lower()==ag then return true end
local aj,ak=pcall(function()return ai.DisplayName end)
if aj and type(ak)=="string"and ak:lower()==ag then return true end
end
return false
end



function ad.Missing(af)
local ag={}
for ah,ai in ipairs(af or{})do
if not ad.Present(ai)then ag[#ag+1]=ai end
end
return ag
end





function ad.CanHost()
return aa.Get"showJoinRequest"~=nil
end


function ad.CanRequest()
return aa.Get"sendJoinRequest"~=nil
end







function ad.SendRequest(af)
if type(af)~="string"or af==""then return false,nil,"s147"end
return aa.InvokeMulti("sendJoinRequest",(af:gsub("^%s+",""):gsub("%s+$","")))
end




function ad.Answer(af,ag)
return aa.Fire("respondJoinRequest",af,ag==true)
end

return ad end function a.F():typeof(__modImpl())local aa=a.cache.F if not aa then aa={c=__modImpl()}a.cache.F=aa end return aa.c end end do local function __modImpl()












local aa=a.j()
local ab=a.n()
local ac=a.o()
local ad=a.v()
local ae=a.s()
local af=a.x()
local ag=a.y()
local ah=a.z()
local ai=a.A()
local aj=a.B()
local ak=a.C()
local al=a.D()
local am=a.w()
local an=a.E()
local ao=a.F()
local ap=a.q()
local aq=a.l()



local ar=6




local as=0.15










local au=0.6







local av=70
local aw=a.m()

return function(ax)
local ay=ax.Farm
local az=ax.Run
local aA=ax.RunInfo









local aB,aC
local aD
local aE=0
local aF=0
local aG=0
local aH={point=nil,at=0}
local aI=0 local aJ=



{
good=Color3.fromRGB(60,220,90),
zone=Color3.fromRGB(230,70,70),
crowded=Color3.fromRGB(255,170,40),
nofloor=Color3.fromRGB(80,140,255),
}



























local aM,aN,aO=0
local aP=0
local aQ,aR,aS
local aT
local aU=-99









local aV={}

local function clearedRooms()
local aW,aX=0,0
for aY,aZ in ipairs(ac.Rooms())do
if aZ.enemies then
if#ac.AliveIn(aZ)>0 then
aV[aZ.model]=true
end
if aV[aZ.model]then
aX=aX+1
if#ac.AliveIn(aZ)==0 then aW=aW+1 end
end
end
end
return aW,aX
end

local function forgetRooms()aV={}end







local aW={hover=0,topY=0,raiser="-",raiseH=0}











if aq.enabled then
task.spawn(function()
local aX=ReplicatedStorage:FindFirstChild"remotes"
aX=aX and aX:FindFirstChild"sanadaClientEvents"
if not aX or not aX:IsA"RemoteEvent"then return end

local aY={}
regConn(aX.OnClientEvent:Connect(function(aZ,a_)
local a0=tostring(aZ)
local a1=""
if typeof(a_)=="Instance"then
a1=a_.ClassName..":"..a_.Name
elseif typeof(a_)=="table"then
a1="table["..#a_.."]"
elseif a_~=nil then
a1=tostring(a_)
end



local a2=a0:lower()
if a2:find"safe"or a2:find"pylon"or a2:find"mark"
or a2:find"last boss"then

elseif not aY[a0]then
aY[a0]=true

end
end))
end)
end









if aq.enabled then
spawnLoop(function()
local aX={}
while not _apelStopped do
task.wait(1)
local aY=ab.HRP()
if aY and IN_MATCH then





for aZ,a_ in ipairs(workspace:GetChildren())do
local a0=a_:FindFirstChildOfClass"Humanoid"~=nil
if not a0 and a_~=LocalPlayer.Character then
local a1=a_:IsA"BasePart"and{a_}or a_:GetChildren()
for a2,a3 in ipairs(a1)do
if a3:IsA"BasePart"
and math.max(a3.Size.X,a3.Size.Y,a3.Size.Z)>=3
and(a3.Position-aY.Position).Magnitude<70 then
local a4=a_.Name.."/"..a3.Name
local a5=a4:lower()
if not(a5:find"hitbox"or a5:find"precast")
and not aX[a4]then
aX[a4]=true

end
end
end
end
end
end
end
end)
end












local aX=5












local aY=setmetatable({},{__mode="k"})

local function mobShape(aZ)
local a_=tonumber(
aZ:FindFirstChild"meleeDistance"and aZ.meleeDistance.Value)or 0


























local a0,a1
if am.Allows"bodyOnly"then
a0,a1=pcall(function()
local a2=aZ:FindFirstChild"HumanoidRootPart"
if not a2 then return aZ:GetExtentsSize()end
local a3,a4
for a5,a6 in ipairs(aZ:GetDescendants())do
if a6:IsA"BasePart"
and(a6.Position-a2.Position).Magnitude<=15
then
local a7=a6.Size*0.5
local a8,a9=a6.Position-a7,a6.Position+a7
a3=a3 and Vector3.new(math.min(a3.X,a8.X),math.min(a3.Y,a8.Y),
math.min(a3.Z,a8.Z))or a8
a4=a4 and Vector3.new(math.max(a4.X,a9.X),math.max(a4.Y,a9.Y),
math.max(a4.Z,a9.Z))or a9
end
end
if not a3 then return aZ:GetExtentsSize()end
return a4-a3
end)
else
a0,a1=pcall(function()return aZ:GetExtentsSize()end)
end

if a0 and a1 and a1.Y>1 and math.max(a1.X,a1.Z)>1 then
if ext then
a1=Vector3.new(math.min(ext.X,a1.X),math.min(ext.Y,a1.Y),
math.min(ext.Z,a1.Z))
end
ext=a1
aY[aZ]=a1
end
ext=ext or Vector3.new(6,5,3)

local a2=math.max(ext.X,ext.Z)*0.5
local a3=math.max(a_,a2)+aX












local a4=am.Value"minionGuard"
if a4 and a4>0 and not ac.Folder()and aZ.Parent==workspace then
a3=math.max(a3,a4)
end

local a5=math.clamp(math.max(a_+3,ext.Y*0.5+3),6,30)
return a3,a5
end
local aZ,a_={},-99
local a0=-99

local a1,a2,a3=1







local function orbiting()
local a4=am.Value"orbitFor"
local a5=am.Orbit(aB and aB.Name)
if not a4 or not a5 or a5<=0 or not aB then return false end
if type(a4)~="table"then a4={a4}end
local a6=tostring(aB.Name):lower()
for a7,a8 in ipairs(a4)do
if a6:find(tostring(a8),1,true)then return true end
end
return false
end









local function dodgeAllowed()
return not orbiting()
end


local a4,a5,a6=0














local function shelterFromNamed(a7)
local a8=am.Value"dodgeNamed"
local a9=am.Value"dodgeFar"
if not a8 or not a9 then return nil end
local b=ab.HRP()
if not b then return nil end
local ba=b.Position



local bb=am.Allows"dodgeFlat"








if a6 and os.clock()<a4 and a5 then
if af.NamedZoneAt(a5,ar,a8,bb)
and not af.NamedZoneAt(a6,ar,a8,bb)
then
return Vector3.new(a6.X,a7,a6.Z)
end
end
a5,a6,a4=nil,nil,0

local bc,bd=af.NamedZoneAt(ba,ar,a8,bb)
if not bc then return nil end
bd=bd or ba




local be=Vector3.new(ba.X-bd.X,0,ba.Z-bd.Z)
if be.Magnitude<1 then be=Vector3.new(1,0,0)end
be=be.Unit




local bf=am.Active()
for bg=0,11 do
local bh=(bg%2==0 and 1 or-1)*math.rad(30*math.ceil(bg/2))
local bi=CFrame.Angles(0,bh,0)*be
local bj=Vector3.new(bd.X+bi.X*a9,a7,bd.Z+bi.Z*a9)
local bk=not(bf and bf.hardAllow)or bf.hardAllow(bj)
if bk and af.HasFloor(bj)
and not af.CrossesBorder(ba,bj)
and not af.NamedZoneAt(bj,ar,a8,bb)
then
a5,a6=ba,bj
a4=os.clock()+(am.Value"dodgeHold"or 4)
if aq.enabled then

end
return bj
end
end



if aq.enabled then

end
return nil
end
local a7=-99

local function mobGuards()



if am.Allows"noMobGuard"then return{}end
if os.clock()-a_<0.2 then return aZ end
local a8=ab.HRP()
local a9={}
if a8 then







local b=am.Value"minionGuard"
local ba=b==0 and not ac.Folder()

for bb,bc in ipairs(ac.AllAlive())do
local bd=ac.PivotOf(bc)
local be=ba and bc.Parent==workspace

if bd and not be and(bd-a8.Position).Magnitude<90 then
local bf,bg=mobShape(bc)
a9[#a9+1]={


mob=bc,
pos=bd,radius=bf,height=bg,name=bc.Name,
}
end
end
end
aZ,a_=a9,os.clock()
return a9
end




local function crowded(a8)
local a9=am.Value"minionGuard"~=nil
for b,ba in ipairs(mobGuards())do
local bb=Vector3.new(a8.X-ba.pos.X,0,a8.Z-ba.pos.Z).Magnitude
if bb<ba.radius and(a9 or math.abs(a8.Y-ba.pos.Y)<ba.height)then
return true
end
end
return false
end












local function holdingForFriends()
return ao.Holding()
end

local function drop(a8)
if aq.enabled and ae.IsPinning()then

end
aB=nil
aC=nil
aT=nil
ae.EndPin()
end





local a8,a9=0,0










local b=100
local ba,bb=true











local bc=22
local bd=14





local be=1
local bf=3







local bg=6
local bh,bi,bj=1
local bk
local c,d=0,true
local e,f=-1,0


local function planSweep(g,h)
local i={}
for j,k in ipairs(g)do
local l=ac.PivotOf(k)
if l then
local m=false
for n,o in ipairs(i)do
if(o.sum/o.n-l).Magnitude<bc then
o.sum,o.n=o.sum+l,o.n+1
m=true
break
end
end
if not m then i[#i+1]={sum=l,n=1}end
end
end

if#i<2 then return nil end

local j={}
for k,l in ipairs(i)do j[#j+1]=l.sum/l.n end
table.sort(j,function(k,l)
return(k-h).Magnitude<(l-h).Magnitude
end)















local k=(#j>=3)and 2 or 1
local l,m=math.huge
for n,o in ipairs(g)do
local p=ac.PivotOf(o)
if p then
local q=(p-j[k]).Magnitude
if q<l then m,l=o,q end
end
end

return j,m
end







local function enterRoom(g)
local h=g and g.model or nil
if h==bb then return end
bb=h
ba=true
bi,bh,bj,bk=nil,1,nil,nil
c,d=os.clock(),false
e,f=-1,os.clock()
end


local function trySweep(g,h)


if not S.agroSweep then return end
if bi or d then return end
if os.clock()-c>bg then
d=true
if aq.enabled then

end
return
end







local i=h and#h or 0
if i~=e then
e,f=i,os.clock()
return
end
if os.clock()-f<1 then return end

local j=ab.HRP()
local k,l
if j and h then k,l=planSweep(h,j.Position)end
if k then
bi,bh,bj,bk=k,1,nil,l
d=true
if aq.enabled then

end
end
end








local g={
["elder dark mage"]=true,



["azrallik's heart"]=true,











["artillery lava walker"]=true,
}


local function pickTarget(h,i)
local j,k,l=math.huge,false
for m,n in ipairs(h)do
local o=ac.PivotOf(n)
if o then
local p=g[tostring(n.Name):lower()]==true
local q=(o-i).Magnitude


if(p and not k)or(p==k and q<j)then
l,j,k=n,q,p
end
end
end
return l,k
end

local function acquire(h)
aB=h
if aq.enabled then
local i=h:FindFirstChildOfClass"Humanoid"
mobShape(h)
pcall(function()return h:GetExtentsSize()end)
a8,a9=os.clock(),i and i.Health or 0

end
end

local function noteKill(h)
if not aq.enabled or a8==0 then return end
local i=os.clock()-a8
a8=0
if i>0.2 then

end
end



local h=7



















local i=6
local j,k=0,0

local function refuge()
local l=workspace:FindFirstChild"lastBossPylonShootParts"
local m=l and#l:GetChildren()or 0
if m>j then k=os.clock()+i end
j=m
if os.clock()>=k then return nil end

local n=workspace:FindFirstChild"lastBossSafeZones"
if not n then return nil end
local o=ab.HRP()
if not o then return nil end





local p,q=math.huge
for r,s in ipairs(n:GetChildren())do
local u,v=pcall(function()return s:GetPivot()end)
if u and v then
local w=(v.Position-o.Position).Magnitude
if w<p then q,p=v.Position,w end
end
end
return q
end

local l=false
local m=false
local n=false
local o={point=nil}
local p=false

local q,r,s,u=false,0,0,-99
local v=false
local w=0
local x=0
local y=0













if aq.enabled then
local z=0

spawnLoop(function()
local A=false
while not _apelStopped do
task.wait(0.05)
pcall(function()
local B=ab.Char()
local C=B and B:FindFirstChild("arrowDownGui",true)
local D=C~=nil
if D and not A then
z=os.clock()

elseif A and not D then

end
A=D
end)
end
end)

regConn(workspace.DescendantAdded:Connect(function(A)
local B=A.Parent and tostring(A.Parent.Name):lower()or""
if not B:find("finalbossarrowshothitbox",1,true)then return end
if tostring(A.Name):lower()~="hitbox"then return end

local C=ab.HRP()local D=
C and(A.Position-C.Position).Magnitude or-1

end))
end










if aq.enabled then
local z={}
regConn(workspace.ChildAdded:Connect(function(A)
local B=tostring(A.Name):lower()
if not(B:find("thirdboss",1,true)or B:find("cog",1,true)
or B:find("safe",1,true))then
return
end
if z[B]then return end
z[B]=true

task.delay(0.35,function()
pcall(function()
local C=workspace:FindFirstChild"thirdBossMiddlePart"
local D=C and C.Position or Vector3.zero
local E=ab.HRP()




local F={}
for G,H in ipairs(A:GetChildren())do
local I,J=pcall(function()return H:GetPivot().Position end)
if I and J then
local K=Vector3.new(J.X-D.X,0,J.Z-D.Z)
local L=math.deg(math.atan2(K.Z,K.X))
local M=""
if H:IsA"BasePart"then
M=(" size=%s look=%.2f,%.2f"):format(
tostring(H.Size),H.CFrame.LookVector.X,H.CFrame.LookVector.Z)
end
F[#F+1]=("s1"):format(
H.Name,H.ClassName,K.Magnitude,L,M)
end
if#F>=14 then break end
end

local G,H=-1,-999
if E then
local I=Vector3.new(E.Position.X-D.X,0,
E.Position.Z-D.Z)
G=I.Magnitude
H=math.deg(math.atan2(I.Z,I.X))
end










if A.Name=="thirdBossSafeSpots"then
task.delay(0.6,function()
pcall(function()
local I={}
for J=15,90,15 do
local K={}
for L=0,350,20 do
local M=math.rad(L)
local N=Vector3.new(
D.X+math.cos(M)*J,
D.Y+3,
D.Z+math.sin(M)*J)
local O=af.GroundAt(N.X,N.Z,N.Y+20)
if O and af.IsSafe(O,4)then
K[#K+1]=tostring(L)
end
end
I[#I+1]=("R=%d: %s"):format(J,
#K>0 and table.concat(K,",")or"s2")
end

end)
end)
end
end)
end)
end))
end












if aq.enabled then
spawnLoop(function()
local z=0
while not _apelStopped do
task.wait(0.5)
if os.clock()-z>=15 then
pcall(function()
local A=workspace:FindFirstChild"secondBossCrossBeam"
if not A then return end
z=os.clock()

local B,C,D={},{},{}
for E,F in ipairs(A:GetDescendants())do
if F:IsA"BasePart"then
local G=F.Name
C[G]=math.min(C[G]or 9,F.Transparency)
D[G]=math.max(D[G]or-1,F.Transparency)
end
end
for E in pairs(C)do
B[#B+1]=("%s %.2f..%.2f"):format(E,C[E],D[E])
end



local E=os.clock()
task.spawn(function()
while A.Parent and os.clock()-E<30 do task.wait(0.25)end

end)
end)
end
end
end)
end















if aq.enabled then
local z={
"outwardblastsize","crossbeam","bosshorizontalbeam",
"circlehit","bosscannonbeam","bossrandomstrike",
}
local A,B={},{}

local function watched(C)
local D=tostring(C):lower()
for E,F in ipairs(z)do
if D:find(F,1,true)then return F end
end
return nil
end

regConn(workspace.DescendantAdded:Connect(function(C)
if not C:IsA"BasePart"then return end
local D=C.Parent
if not D or B[D]then return end
local E=watched(D.Name)
if not E then return end
local F=os.clock()
if A[E]and F-A[E]<3 then return end
A[E],B[D]=F,true

task.spawn(function()
local G=os.clock()
local H,I,J

while os.clock()-G<6 and D.Parent do
for K,L in ipairs(D:GetChildren())do
if L:IsA"BasePart"then
local M=tostring(L.Name):lower()
if not H and M:find("precast",1,true)then
H=os.clock()-G
end
if not I and M:find("hitbox",1,true)then
I=os.clock()-G
end
if not J and L.Transparency<0.9 then
J=os.clock()-G
end
end
end
task.wait()
end
local K=os.clock()-G
local function t(L)return L and("+%.2f"):format(L)or"s3"end
aq.Timing(("s4"):format(
D.Name,t(H),t(I),t(J),K))
B[D]=nil
end)
end))
end





















if aq.enabled then
local z,A,B=70,1.5,4
local C={}

local function noteBirth(D)
if not D:IsA"BasePart"then return end
local E=os.clock()
task.defer(function()
if not D.Parent then return end
local F=ab.HRP()
if not F then return end
local G,H=pcall(function()return D.Position end)
if not G then return end
local I=(H-F.Position).Magnitude
if I>z then return end
local J=D.Parent
C[#C+1]={
t=E,gap=I,
name=D.Name,
owner=J and J.Name or"?",
grand=J and J.Parent and J.Parent.Name or"?",
size=D.Size,
mat=tostring(D.Material):gsub("Enum.Material.",""),
query=D.CanQuery,collide=D.CanCollide,
clear=D.Transparency,
zone=(function()
local K,L=pcall(af.IsZone,D)
return K and L or false
end)(),
}
if#C>500 then table.remove(C,1)end
end)
end

regConn(workspace.DescendantAdded:Connect(noteBirth))


local function nowLooksLikeAttack(D)
local E={}
for F,G in ipairs(workspace:GetDescendants())do
if G:IsA"BasePart"and not G.CanCollide then
local H,I=pcall(function()return G.Position end)
if H then
local J=(I-D.Position).Magnitude
if J<=30 and math.max(G.Size.X,G.Size.Y,G.Size.Z)>=3 then
E[#E+1]=("s5")
:format(tostring(G.Parent and G.Parent.Name or"?"),G.Name,
tostring(G.Size),J,
tostring(G.Material):gsub("Enum.Material.",""),
G.Transparency,
tostring((select(2,pcall(af.IsZone,G)))or false))
end
end
end
if#E>=12 then break end
end
return E
end

spawnLoop(function()
local D,E
while not _apelStopped do
task.wait(0.2)
local F=ab.Humanoid()
if F and F~=D then
D,E=F,F.Health
regConn(F.HealthChanged:Connect(function(G)
local H=E or G
E=G
if G>=H then return end
local I=ab.HRP()
if not I then return end
local J=os.clock()



local K=0
for L=#C,1,-1 do
local M=C[L]
if J-M.t>A then break end
K=K+1

if K>=10 then break end
end
if K==0 then

end

for L,M in ipairs(nowLooksLikeAttack(I))do

end
end))
end

local G=os.clock()-B
while C[1]and C[1].t<G do table.remove(C,1)end
end
end)
end












if aq.enabled then
task.spawn(function()
local z=game:GetService"ReplicatedStorage"
local A=z:FindFirstChild"Utility"
local B=A and A:FindFirstChild"BridgeNet2"
if not B then
aq.Bridge"s6"
return
end
local C,D=pcall(require,B)
if not C then
aq.Bridge("s7"..tostring(D))
return
end
local E,F=pcall(D.ReferenceBridge,"precastHitbox")
if not E or not F then
aq.Bridge("s8"..tostring(F))
return
end
local G=D.ReferenceIdentifier"action"
aq.Bridge(("s9"):format(
tostring(ac.Name()),game.PlaceId))

local H=0









task.spawn(function()
while not _apelStopped do
task.wait(15)
aq.Bridge(("s10")
:format(H,tostring(ac.Name())))
end
end)
regConn(F:Connect(function(I)
H=H+1
local J=tostring(I and I[G])
local K=I and(I.cframe or I.position)
local L=I and(I.size and tostring(I.size)
or(I.radius and("s11"..tostring(I.radius)))or"?")
local M="?"
if K then
local N=typeof(K)=="CFrame"and K.Position or K
M=("%.0f,%.0f,%.0f"):format(N.X,N.Y,N.Z)
end
local N=ab.HRP()
local O="-"
if N and M~="?"then
local P=typeof(K)=="CFrame"and K.Position or K
O=("%.0f"):format((P-N.Position).Magnitude)
end






local P="-"
if I and tonumber(I.delayUntilAttack)and tonumber(I.startTime)then
P=("%.2f"):format(tonumber(I.delayUntilAttack)
-(workspace:GetServerTimeNow()-tonumber(I.startTime)))
end

local Q=("s12"):format(
H,J,M,L,O,
tostring(I and I.delayUntilAttack),P)
aq.Bridge(Q..(" | start=%s"):format(tostring(I and I.startTime)))








local function show(R,T)
local U=typeof(R)
if U=="table"then
if T<=0 then return"{...}"end
local V={}
for W,X in pairs(R)do
V[#V+1]=tostring(W).."="..show(X,T-1)
end
table.sort(V)
return"{"..table.concat(V," ").."}"
end
if U=="CFrame"then
local V=R.Position
return("CFrame(%.0f,%.0f,%.0f)"):format(V.X,V.Y,V.Z)
end
return("%s(%s)"):format(U,tostring(R))
end
if type(I)=="table"then
aq.Bridge("s13"..show(I,2))
else
aq.Bridge("s13"..show(I,2).."s14")
end
end))
end)
end











if aq.enabled then
spawnLoop(function()
local z={}
while not _apelStopped do
task.wait(2)
local A=ab.HRP()
if A and IN_MATCH then
pcall(function()

local B=ac.Nearest(A.Position,60)
local C=B and ac.PivotOf(B)
if not C then return end

local D={}
for E,F in ipairs(workspace:GetDescendants())do
if F:IsA"BasePart"and not F:IsDescendantOf(B)
and not Players:GetPlayerFromCharacter(F.Parent or F)
then
local G=(F.Position-C).Magnitude


if G<=22 and math.max(F.Size.X,F.Size.Y,F.Size.Z)>=3
and not af.IsZone(F)
then
local H=F.Parent and F.Parent.Name or"?"
local I=H.."/"..F.Name.."/"..tostring(F.Size)
if not z[I]and#D<6 then
z[I]=true
D[#D+1]=("%s %s %s trans=%.2f cq=%s"):format(
I,tostring(F.Material):gsub("Enum.Material.",""),
F.Anchored and"anch"or"free",
F.Transparency,tostring(F.CanQuery))
end
end
end
end
if#D>0 then

end
end)
end
end
end)
end






if aq.enabled then
spawnLoop(function()
while not _apelStopped do
task.wait(2)
local z,A=ab.HRP(),aB
local B=A and ac.PivotOf(A)
if z and B then local C=
Vector3.new(z.Position.X-B.X,0,z.Position.Z-B.Z).Magnitude

end
end
end)
end








if aq.enabled then
spawnLoop(function()
local z=""
while not _apelStopped do
task.wait(3)
local A=ab.HRP()
if A and IN_MATCH then
local B,C={},0
for D,E in ipairs(workspace:GetDescendants())do
if E:IsA"Humanoid"then
local F=E.Parent
local G,H=pcall(function()return F:GetPivot().Position end)
if G and F~=LocalPlayer.Character
and not Players:GetPlayerFromCharacter(F)then
local I=(H-A.Position).Magnitude
if I<=90 then
C=C+1
if#B<12 then
B[#B+1]=("%s @%.0f hp=%.0f [%s]"):format(
F.Name,I,E.Health,
F.Parent and F.Parent:GetFullName():gsub(
"^Workspace%.?","")or"?")
end
end
end
end
end


local D=("s15"):format(C,table.concat(B," ;; "))
if D~=z then
z=D

end
end
end
end)
end









if aq.enabled then
local z=0
regConn(workspace.DescendantAdded:Connect(function(A)
local B=A.Parent and tostring(A.Parent.Name):lower()or""
if not B:find("secondbosscrescent",1,true)then return end
if not A:IsA"BasePart"then return end
if os.clock()-z<5 then return end
z=os.clock()

task.spawn(function()
local C=A.Position
local D=os.clock()
task.wait(0.25)
if not A.Parent then

return
end
local E=math.max(os.clock()-D,0.001)local F=
(A.Position-C).Magnitude/E
ab.HRP()








local G,H,I=math.huge,-math.huge,0
for J,K in ipairs(workspace:GetDescendants())do
if K:IsA"BasePart"and K.Parent
and tostring(K.Parent.Name):lower():find("secondbosscrescent",1,true)
then
I=I+1
G=math.min(G,K.Position.Y-K.Size.Y*0.5)
H=math.max(H,K.Position.Y+K.Size.Y*0.5)
end
end


end)
end))
end
















if aq.enabled then
local z=0



local function beamOf(A)
local B,C=0
for D,E in ipairs(A:GetDescendants())do
if E:IsA"BasePart"then
local F=E.Size.X*E.Size.Y*E.Size.Z
if F>B then C,B=E,F end
end
end
return C
end


































regConn(workspace.DescendantAdded:Connect(function(A)
local B=A.Parent and tostring(A.Parent.Name):lower()or""
if B~="bossrifleprecast"then return end
if os.clock()-z<3 then return end
z=os.clock()
local C=A.Parent

task.spawn(function()

task.wait(0.05)
if not C.Parent then return end
local D=beamOf(C)
local E=ab.HRP()
if not D or not E then return end
local F,G=D.CFrame,D.Size








local H=os.clock()+3
local I
while os.clock()<H do
for J,K in ipairs(workspace:GetChildren())do
if K:IsA"Model"and tostring(K.Name):lower()=="bossrifleshot"then
I=beamOf(K)
break
end
end
if I then break end
task.wait(0.03)
end

local J=ab.HRP()
if not I or not J then

return
end




local function longDir(K,L)
if L.X>=L.Y and L.X>=L.Z then return K.RightVector end
if L.Z>=L.Y then return K.LookVector end
return K.UpVector
end
local K=longDir(F,G)
local L=longDir(I.CFrame,I.Size)
math.clamp(math.abs(K:Dot(L)),-1,1)

end)
end))
end












if aq.enabled then
local z=0
regConn(workspace.DescendantAdded:Connect(function(A)
local B=tostring(A.Name):lower()
if B:find("finalbossrotatingcircle",1,true)then
z=os.clock()+9

return
end
if os.clock()>=z then return end

if B=="apelmark"then return end
local C=ab.HRP()
local D=-1
if C and A:IsA"BasePart"then
D=(A.Position-C.Position).Magnitude
end

end))
end









if ak.Watch()and aq.enabled then

end




if al.Watch()and aq.enabled then

end



ae.SetFloorFilter(af.FloorIgnore)

ae.SetTrace(aq.enabled and aq.Log or nil)






ae.SetGroundClamp(function(z)
if not am.Allows"ground"then return z end
local A=am.Active()

















if A and A.floorY and A.ceiling then
local B=A.lift or 0
local C=A.floorY+B
local D=A.floorY+A.ceiling+B
if z.Y>=C and z.Y<=D then return z end
local E=af.GroundAt(z.X,z.Z,A.floorY+30)
if E then
local F=math.clamp(E.Y+B,C,D)
return Vector3.new(z.X,F,z.Z)
end
return Vector3.new(z.X,math.clamp(z.Y,C,D),z.Z)
end

local B=A and A.center.Y or z.Y
local C=af.GroundAt(z.X,z.Z,B)
if C and z.Y>C.Y+3 then return C end
return z
end)

regConn(RunService.Heartbeat:Connect(function(z)
if _apelStopped then return end


ae.SetVoidGuard(am.Allows"noVoid")



if ae.RescueFromVoid()and aq.enabled then

end

if not S.autoFarm then
if ae.IsPinning()then
drop(not S.autoFarm and"s17"or"s18")
end
return
end



















































local A=af.SafeSpot()
if A then
if not aO then
aO=os.clock()
if aq.enabled then end
end
aN=A
aP=os.clock()



aM=os.clock()+2.2
elseif aO and(os.clock()-aP)>0.5 then
if aq.enabled then

end
aO=nil
end














local B=aO~=nil and(os.clock()-aO)<3.4













local C=aN and((af.CleanNear(aN)or aN)
+Vector3.new(0,3,0))or nil














local D=am.Value"haven"
if D then
local E=ab.HRP()
local F=am.Value"havenWhen"
local G,H=false
if E then G,H=af.TimerRing(F,E.Position)end
if G then
if r==0 then s=os.clock()end
r=os.clock()
end

local I=am.Value"havenTail"or 1.5
local J=r>0 and(os.clock()-r)<I
if E and J then local
K=af.HavenSpot(D,E.Position)
if K then



local L=K+Vector3.new(0,3,0)
if not q then
q=true
if aq.enabled then

end
end
ae.Where"s19"
ae.Pin(L,L+Vector3.new(0,0,1))
return
elseif aq.enabled and(os.clock()-u)>2 then


u=os.clock()

end
end




if not J and r>0 then
if q and aq.enabled then

end
q=false
r,s=0,0
end
end

if am.Allows"gears"and aj.Step(o)then
if not n then
n=true
if aq.enabled then end
end
return
elseif n then
n=false
if aq.enabled then end
end









if am.Allows"cannon"and ai.Step()then
if not m then
m=true
if aq.enabled then end
end
return
elseif m then
m=false
if aq.enabled then end
end












if C and not aO and not af.IsSafe(C,0)then
C=nil
end

if C and not B and os.clock()<aM then
if not p then
p=true
if aq.enabled then end
end











ae.Where"s20"
ae.Pin(C,C+Vector3.new(0,0,1))
return
end
if p then
p=false
if aq.enabled then end
end
aN=nil











if am.Allows"dome"then






local E=af.HasDome()
local F=ab.HRP()
local G,H
if not E then G,H=af.SafeDome()end


if aq.enabled and os.clock()-y>1 then
local I=af.DomeReport()
if#I>0 then
y=os.clock()

end
end












if E then
v=false
elseif not G then
w,x=0,0
end
if G and w==0 then w=os.clock()end

if G and F then










local I=2











local J=G












local K=math.abs(G.Y-F.Position.Y)<=60



if K and not af.IsSafe(J,I)then
J=af.CleanNear(J)or J
end





















local L=not af.IsSafe(J,I)
if K and L and(os.clock()-w)<1.5 then


ae.Where"s21"
ae.Pin(F.Position,F.Position+Vector3.new(0,0,1))
return
end

if K then

if not v then
v=true
if aq.enabled then local M=
(G-F.Position).Magnitude

end
end


ae.Where"s22"
ae.Pin(J,J+Vector3.new(0,0,1))


















local M=(G-F.Position).Magnitude
if M<=8 and x==0 then
x=os.clock()
end

if H and M<=12 then


if type(firetouchinterest)=="function"then
local N=ab.Char()
for O,P in ipairs(N and N:GetChildren()or{})do
if P:IsA"BasePart"then
pcall(firetouchinterest,P,H,0)
pcall(firetouchinterest,P,H,1)
end
end
end



if x>0 and(os.clock()-x)>=0.8 then
af.MarkDomeUsed(H)
x=0
if aq.enabled then

end
end
end
return
end
end
end

local E=refuge()









if E and am.Active()then E=nil end



if E and not af.IsSafe(E+Vector3.new(0,3,0),ar)then
E=nil
end

if E then
local F=E+Vector3.new(0,3,0)
aC=F
if not l then
l=true
if aq.enabled then

end
end



local G=am.Active()
if G and G.groundOnly then
local H=af.GroundAt(F.X,F.Z,G.center.Y)
if H and F.Y>H.Y+3 then F=H end
end
ae.Pin(F,F+Vector3.new(0,-1,0))
return
end
if l then
l=false
if aq.enabled then end
end

local F

if bi then
local G=ab.HRP()and ab.HRP().Position
local H=bi[bh]
if G and H then
local I=Vector3.new(G.X-H.X,0,G.Z-H.Z).Magnitude
if I<bd then
bj=bj or os.clock()
local J=(bh==1)and bf or be
if os.clock()-bj>=J then
bh,bj=bh+1,nil
if aq.enabled then

end
end
end
end

if bh>#bi and bk and ac.IsAlive(bk)then
local I=ac.PivotOf(bk)
if I and G then
local J=Vector3.new(G.X-I.X,0,G.Z-I.Z).Magnitude
if J>=bd then
F=I
H=I
else
bk=nil
if aq.enabled then end
end
else
bk=nil
end
end

if bh>#bi and not bk then
bi=nil






aB=nil
if aq.enabled then end
elseif bh<=#bi then


F=bi[bh]
end
end

if not F then F=aB and ac.PivotOf(aB)or nil end











if not F then








if aC then








local G=am.Active()
if not af.IsSafe(aC,ar)then
local H
if G then











H=af.SafePointAround(aC,{
from=aC,min=6,max=64,
margin=ar,baseY=aC.Y})
else
H=af.SafePoint(aC,ar)
end
if H then aC=H end
end





if af.IsSafe(aC,ar)then aD=nil end
ae.Where"s23"
ae.Pin(aC,aC-Vector3.new(0,1,0))
else














local G=ab.HRP()
if G and IN_MATCH and ac.Started()and ae.IsPinning()then
ae.Where"s24"
ae.Pin(G.Position,G.Position+Vector3.new(0,0,1))
end
end
return
end

































local G=af.TargetedRecently(1.4)

local H=aB or ac.Nearest(F,40)
local I,J=9,7
if H then I,J=mobShape(H)end














local K=am.Allows"close"

local L=math.clamp(I,6,30)


local M=am.Value"keepAway"
if type(M)=="number"then L=math.max(L,M)end







local N=am.Value"stand"
if type(N)=="number"then L=N end


















local O=K and math.min(J+1,8)or(J+1)






local P=am.Value"hover"
if type(P)=="number"then O=P end
















local Q=F.Y+O
aW.hover,aW.raiser,aW.raiseH=O,"-",0
for R,T in ipairs(mobGuards())do






local U=K and H~=nil and T.mob==H
local V=U and math.huge
or Vector3.new(F.X-T.pos.X,0,F.Z-T.pos.Z).Magnitude


if V<T.radius+4 then
local W=T.pos.Y+T.height+1
if W>Q then
Q=W
aW.raiser,aW.raiseH=T.name or"?",T.height
end
end
end



local R=am.Active()


local T=not(R and R.groundOnly)
and af.CeilingNear(F,L+26)or nil
local U=false
if T and T+3>Q then
Q=T+3
U=true
end

aW.topY=Q




















local V

local W=false
if R and R.groundOnly then
local X=ab.HRP()and ab.HRP().Position or F

local Y=Vector3.new(X.X-F.X,0,X.Z-F.Z)
if Y.Magnitude<1 then Y=Vector3.new(1,0,0)end
Y=Y.Unit

if G then L=L+40 end
for Z=0,11 do
local _=(Z%2==0 and 1 or-1)*math.rad(30*math.ceil(Z/2))
local bl=CFrame.Angles(0,_,0)*Y
local bm=af.GroundAt(F.X+bl.X*L,
F.Z+bl.Z*L,F.Y)
if bm and R.allow(bm)then V=bm break end
end

V=V or af.GroundAt(F.X,F.Z,F.Y)







if not V or(R.hardAllow and not R.hardAllow(V))then
V=af.GroundAt(R.center.X,R.center.Z,R.center.Y)
or V or Vector3.new(F.X,Q,F.Z)
end
else


if G then
local bl=ab.HRP()and ab.HRP().Position or F
local bm=Vector3.new(bl.X-F.X,0,bl.Z-F.Z)
if bm.Magnitude<1 then bm=Vector3.new(1,0,0)end
bm=bm.Unit*(L+46)
V=Vector3.new(F.X+bm.X,Q,F.Z+bm.Z)
else
V=Vector3.new(F.X,Q,F.Z)





























local bl,bm,X,Y,Z=
am.Orbit(aB and aB.Name)
if bl and bl>0 and orbiting()then
W=Z==true
local _=am.Active()



local bn=Q+(X or 0)

local function spot(bo,bp)
bp=bp or bl
local bq=Vector3.new(
F.X+math.cos(bo)*bp,bn,F.Z+math.sin(bo)*bp)
if _ and _.hardAllow and not _.hardAllow(bq)then
return nil
end
return bq
end



if a3~=aB or not a2 then
local bo=ab.HRP()and ab.HRP().Position or F
local bp=Vector3.new(bo.X-F.X,0,bo.Z-F.Z)
a2=(bp.Magnitude>0.1)
and math.atan2(bp.Z,bp.X)or 0
a1=a1 or 1
a3=aB
end

local bo=(bm/bl)*math.clamp(z or 1.6666666666666665E-2,0,0.1)






local bp=math.max(bo*30,0.35)

local function clearAhead(bq,br)
for bs=1,4 do
local bt=spot(a2+bq*bp*bs/4,br)
if not bt or not af.IsSafe(bt,ar)or crowded(bt)then
return false
end
end
return true
end





























local bq=shelterFromNamed(bn)
if bq then
V=bq
a2=nil
elseif Y then
a2=a2+a1*bo
local br=spot(a2,bl)
if br then
V=br
else
a1=-a1
end
elseif not clearAhead(a1,bl)then
if clearAhead(-a1,bl)then
a1=-a1
else





for br,bs in ipairs{bl+12,bl-8,bl+22}do
if bs>4 and clearAhead(a1,bs)then
bl=bs
break
end
end
end
end









if not Y and not bq then
a2=a2+a1*bo
local br=spot(a2,bl)
if br then
V=br
else


a1=-a1
end
end
end














local bn=not(bl and bl>0 and orbiting())and am.Value"sideStep"or nil
if bn and bn>0 then
local bo=ab.HRP()and ab.HRP().Position or F
local bp=Vector3.new(bo.X-F.X,0,bo.Z-F.Z)
if bp.Magnitude<1 then bp=Vector3.new(1,0,0)end
bp=bp.Unit*bn
V=Vector3.new(F.X+bp.X,Q,F.Z+bp.Z)
end
end
end
local bl=aC
and Vector3.new(V.X-aC.X,0,V.Z-aC.Z).Magnitude
or math.huge








if W or bl>h then
aC=V
else
aC=Vector3.new(aC.X,V.Y,aC.Z)
end
local bm=aC


























if am.Allows"perch"or type(am.Value"floorWhen")=="string"then












local bn=am.Value"upWhen"
if type(bn)=="string"then







if af.HasZoneNamed(bn)then













local bo=bm
if not af.IsSafe(bo,ar)or crowded(bo)then
bo=nil
local bp=am.Value"reach"
if type(bp)~="number"then bp=22 end
for bq=6,bp,2 do
local br=math.max(8,math.floor(2*math.pi*bq/3))
for bs=0,br-1 do
local bt=math.rad((360/br)*bs)
local X=Vector3.new(
F.X+math.cos(bt)*bq,
bm.Y,
F.Z+math.sin(bt)*bq)
if af.IsSafe(X,ar)and not crowded(X)then
bo=X
break
end
end
if bo then break end
end
end

if bo then
ah.Clear(aH)
aC=bo
ae.Where"s25"
ae.Pin(bo,F)
return
end
end
end












local bo=am.Value"floorWhen"
local bp=am.Allows"floor"
if not bp and type(bo)=="string"then
if af.HasZoneNamed(bo)then
aI=os.clock()+(am.Value"floorHold"or 2.5)
end
bp=os.clock()<aI
end



if not bp and not af.IsSafe(bm,ar)then
bp=true
end

if bp then
local bq=am.Value"reach"
if type(bq)~="number"then bq=22 end
local br=am.Value"floorMargin"
if type(br)~="number"then br=3 end

ae.Where"s26"
aC=ah.Step{
pos=F,
here=ab.HRP()and ab.HRP().Position or F,
reach=bq,
margin=br,
crowded=crowded,
state=aH,














escape=function()
if af.IsSafe(bm,ar)and not crowded(bm)then
return bm
end
local bs=ab.HRP()and ab.HRP().Position or F
local bt=af.GroundAt(F.X,F.Z,F.Y)
return af.SafePointAround(F,{
from=bs,
min=L,
max=bq+30,
margin=br,
baseY=bt and bt.Y or bs.Y,
guards=mobGuards(),
})
end,


mark=nil,
log=aq.enabled and aq.Log or nil,
}
return
end



ah.Clear(aH)



if am.Allows"perch"then
aC=bm
ae.Where"s27"
ae.Pin(bm,F)
return
end
end








do
local bn=ab.HRP()and ab.HRP().Position or nil


local bo















local bp=L+26




local bq=am.Value"reach"
if type(bq)=="number"then bp=bq end








local br=af.SpinRadius()
if br then bp=math.max(bp,br+25)end










local bs=(R and R.groundOnly)and 140 or av
if br then bs=math.max(bs,br+40)end
























if am.Allows"legacy"then
local bt={dodgeAt=aU,dodgeStand=aT}
ae.Where"s28"
bm=ag.Step{
stand=bm,pos=F,here=bn,
keepAway=L,reach=bp,margin=ar,
hold=as,crowded=crowded,guards=mobGuards,
state=bt,


keepFar=am.Allows"keepFar",
log=aq.enabled and aq.Log or nil,
}
aU,aT=bt.dodgeAt,bt.dodgeStand
aC=bm
return
end

local bt=(os.clock()-aU)<as















local function findEscape()
local X=os.clock()
if aQ and X-aQ<0.05 then
return aR,aS
end
aQ=X















local Y=am.Value"minimalDodge"
if Y then
local Z=bn or bm







local _,bu=pcall(af.EscapeStep,Z,1,Y)
if not _ then bu=nil end

local bv=am.Active()
local bw=not(bv and bv.hardAllow)
or(bu and bv.hardAllow(bu))
if bu and bw
and af.HasFloor(bu)


and not af.CrossesBorder(Z,bu)
and not crowded(bu)then
aR,aS=bu,af.IsSafe(bu,ar)



if aq.enabled and(os.clock()-a7)>0.5 then
a7=os.clock()

end
return aR,aS
end
end

aR,aS=af.SafePointAround(F,{
from=bn or bm,
min=L,
max=bp,
margin=ar,
baseY=bm.Y,
guards=mobGuards(),
})
return aR,aS
end














if dodgeAllowed()then
if bt and aT then






























local bu=am.Value"minionGuard"~=nil
if af.IsSafe(aT,ar)
and not(bu and crowded(aT))then
bm=aT
else


















local bv=af.ZoneAt(aT,0)~=nil
local bw,X=findEscape()
local Y=false
if bw and(bw-F).Magnitude<=bs then
Y=X or bv
or af.ThreatAt(bw,ar)
<af.ThreatAt(aT,ar)
end
if Y then
aT,bm=bw,bw
aU=os.clock()
aE=os.clock()








if aq.enabled and(os.clock()-a0)>0.5 then
a0=os.clock()

end
else
bo=bw
and(("s29")
:format(tostring(X),(bw-F).Magnitude))
or"s30"
bm=aT
end
end
elseif not bt and af.IsSafe(bm,ar)and not crowded(bm)then
aT=nil
elseif aT
and af.IsSafe(aT,ar)
and not crowded(aT)
and(aT-F).Magnitude<=bp
then
bm=aT
elseif not af.IsSafe(bm,ar)or crowded(bm)then



local bu,bv=findEscape()

aU=os.clock()+(bv and 0 or(au-as))
if bu and(bu-F).Magnitude>bs then
if aq.enabled then

end
bo=("s31"):format(
(bu-F).Magnitude,bs)
bu=nil
end
if not bu then
bo="s32"
end
if bu then
aT=bu
bm=bu
aE=os.clock()
if aq.enabled then


local bw="-"
local X=workspace:Raycast(bu,Vector3.new(0,-300,0))
if X then
bw=("%.0f"):format(bu.Y-X.Position.Y)
end

end
end
else
aT=nil
end
end







if af.IsSafe(bm,ar)then
if aD and aq.enabled then
local bu=(os.clock()-aD)*1000
if bu>120 then

end
end
aD=nil
elseif not aD then
aD=os.clock()
end
end













local bn=bm
local bo=ab.HRP()and ab.HRP().Position or nil



local bp=aT~=nil or U or ba or bi==nil
if bo and not bp then
local bq=bn-bo
local br=b*z
if bq.Magnitude>br then bn=bo+bq.Unit*br end
end
ba=false


















local bq=12
if bn.Y<F.Y-bq then
if aq.enabled then

end
bn=Vector3.new(bn.X,F.Y,bn.Z)
aT=nil
end







































if aq.enabled and af.ZoneAt(bn,0)
and(os.clock()-aG)>1 then
aG=os.clock()

end

if am.Allows"rescue"and dodgeAllowed()
and af.ZoneAt(bn,0)and(os.clock()-aF)>0.15 then
local br=af.SafePoint(bn,ar)
if br and not af.IsSafe(br,ar)then br=nil end
if br then
aF=os.clock()
if aq.enabled then

end
bn=br
end
end










if af.TargetedRecently(1.4)then
local br=ac.Nearest(bn,90)
local bs=br and ac.PivotOf(br)or nil
if bs then
local bt=Vector3.new(bn.X-bs.X,0,bn.Z-bs.Z)
if bt.Magnitude<1 then bt=Vector3.new(1,0,0)end
bt=bt.Unit*70
local bu=Vector3.new(bs.X+bt.X,bn.Y,bs.Z+bt.Z)
if af.HasFloor(bu)then bn=bu end
end
end

local br=am.Active()









if br and br.hardAllow and not br.hardAllow(bn)then
local bs=br.center
local bt=Vector3.new(bn.X-bs.X,0,bn.Z-bs.Z)
local bu=bt.Magnitude
if bu>1 then
bt=bt.Unit
for bv,bw in ipairs{0.75,0.5,0.3,0.15}do
local X=Vector3.new(bs.X+bt.X*bu*bw,bn.Y,
bs.Z+bt.Z*bu*bw)
local Y=af.GroundAt(X.X,X.Z,bs.Y)
if Y and br.hardAllow(Y)then
bn=Y
break
end
end
end
if not br.hardAllow(bn)then
bn=af.GroundAt(bs.X,bs.Z,bs.Y)or bn
end
if aq.enabled then

end
end

































local bs=F
local bt=LocalPlayer:FindFirstChild"PlayerGui"
if bt and bt:FindFirstChild"firstBossLookAwayGui"then
bs=bn+(bn-F)
if aq.enabled then end
end


ae.Pin(bn,bs)
end))













local bl,bm
















local function setWalkFarm(bn)












if S.walkSet then S.walkSet(bn)else S.testWalk=bn end
if S.hopSet then S.hopSet(bn)else S.testHop=bn end


local bo=getgenv and getgenv().ApelHub
local bp=bo and bo.Window and bo.Window.Flags
local bq=bp and bp.TestWalk
local br=bp and bp.TestHop
if bq and bq.SetValue then pcall(bq.SetValue,bq,bn)end
if br and br.SetValue then pcall(br.SetValue,br,bn)end
end

bl=ay:Toggle{
Name="Auto Farm",
Desc="walks to mobs along a path and dodges attacks",
Default=false,Flag="AutoFarm",
Callback=function(bn)
S.autoFarm=false
setWalkFarm(bn)
if not bn then drop"s33"end
end,
}








bm=ay:Toggle{
Name="Auto Dodge",
Desc="steps out of attack zones",
Default=true,Flag="AutoDodge",
Callback=function(bn)
S.autoDodge=bn
af.SetEnabled(bn)
end,
}























































regConn(RunService.Heartbeat:Connect(function()
if _apelStopped then return end
if not(S.autoFarm and S.autoDodge)then return end



if am.Allows"noBlindDodge"then return end

if aB or ae.IsPinning()then return end
local bn=ab.HRP()
if not bn or not IN_MATCH or not ac.Started()then return end
if af.IsSafe(bn.Position,ar)then return end

ae.Where"s34"
local bo=af.SafePoint(bn.Position,ar)








bo=ae.Fit(bo)

local bp=am.Allows"noVoid"
if bo~=bn.Position and(not bp or ae.Grounded(bo))then

ae.Pin(bo,bo+bn.CFrame.LookVector)
end
end))




if aq.enabled then
spawnLoop(function()
while not _apelStopped do
task.wait(2)
local bn,bo=ab.HRP(),aB and ac.PivotOf(aB)or nil
if bn and bo then








am.Active()
local bp="-"
local bq=workspace:Raycast(bn.Position,Vector3.new(0,-300,0))
if bq then bp=("%.0f"):format(bn.Position.Y-bq.Position.Y)end

end
end
end)
end






ay:Slider{
Name="Cast Only Within",
Desc="uses abilities only when the target is this close — 0 casts at any range",
Default=0,Min=0,Max=80,Decimals=0,
Flag="CastReach",
Callback=function(bn)S.castReach=bn end,
}











local bn,bo

local function dropCastRing()
if bn then bn:Destroy()bn=nil end
bo=nil
end

local function buildCastRing(bp)
dropCastRing()


for bq,br in ipairs(workspace:GetChildren())do
if br.Name=="ApelCastRing"then pcall(function()br:Destroy()end)end
end

local bq=Instance.new"Model"
bq.Name="ApelCastRing"

local br=48
local bs=(2*math.pi)/br

local bt=2*bp*math.sin(bs/2)+0.2

for bu=1,br do
local bv=bu*bs
local bw=Vector3.new(math.cos(bv)*bp,0,math.sin(bv)*bp)
local z=Instance.new"Part"
z.Name="ApelMark"
z.Size=Vector3.new(bt,0.3,0.3)

z.CFrame=CFrame.lookAt(bw,bw+Vector3.new(math.cos(bv),0,math.sin(bv)))
z.Anchored,z.CanCollide=true,false
z.CanQuery,z.CanTouch=false,false
z.Material=Enum.Material.Neon
z.Color=Color3.fromRGB(255,60,60)
z.Transparency=0.25
z.Parent=bq
end

bq.WorldPivot=CFrame.new()
bq.Parent=workspace
bn,bo=bq,bp
end

ay:Toggle{
Name="Show Cast Range",
Desc="draws a red circle at the Cast Only Within distance",
Default=false,Flag="ShowCastRange",
Callback=function(bp)
S.showCastRange=bp
if not bp then dropCastRing()end
end,
}

regConn(RunService.Heartbeat:Connect(function()
if _apelStopped then return end

local bp=tonumber(S.castReach)or 0
local bq=ab.HRP()

if not S.showCastRange or bp<=0 or not bq then
if bn then dropCastRing()end
return
end



if bo~=bp then buildCastRing(bp)end
if bn then
bn:PivotTo(CFrame.new(bq.Position.X,bq.Position.Y-2.5,bq.Position.Z))
end
end))






ay:Dropdown{
Name="Cast First",
Desc="which ability slot goes first — put your damage buff here",
Options={"Any","Q first","E first"},
Default="Any",
Flag="CastFirst",
Callback=function(bp)S.castFirst=bp end,
}

ay:Toggle{
Name="Agro All Mob Stacks First",
Desc="flies over every group in the room to pull them into one pile before killing",
Default=false,Flag="AgroSweep",
Callback=function(bp)
S.agroSweep=bp
if not bp then bi,bk=nil,nil end
end,
}











local function stallLeft()
if not S.stall then return 0 end
local bp=tonumber(S.stallSeconds)or 0
if bp<=0 then return 0 end
local bq=ac.Elapsed()
if not bq then return bp end
return math.max(0,bp-bq)
end

local bp=ay:Label"Idle"









if IN_MATCH then af.Watch()end











local bq,br,bs=-99,"none"

regConn(RunService.Heartbeat:Connect(function()
if _apelStopped then return end
local bt=ab.HRP()
if not bt then return end
local bu=af.ZoneAt(bt.Position,0)
if bu then
bq=os.clock()
if typeof(bu)=="Instance"then
bs=bu
br=("%s/%s"):format(bu.Parent and bu.Parent.Name or"?",bu.Name)
else
br="s35"..tostring(bu.name)
end
end
end))

spawnLoop(function()
local bt,bu
while not _apelStopped do
task.wait(0.25)
local bv=ab.Humanoid()
if bv and bv~=bt then
bt,bu=bv,bv.Health
regConn(bv.HealthChanged:Connect(function(bw)
local z=bu or bw
bu=bw
if bw>=z then return end

local A=ab.HRP()
local B,C=(-1)
if A then C,B=ac.Nearest(A.Position)end




local D=A and A.Position.Y or 0
local E=-1
if A then
local F=RaycastParams.new()
F.FilterType=Enum.RaycastFilterType.Exclude
F.FilterDescendantsInstances={LocalPlayer.Character}
local G=workspace:Raycast(A.Position,Vector3.new(0,-200,0),F)
E=G and(A.Position.Y-G.Position.Y)or-1
end



local F="-"
local G=workspace:FindFirstChild"firstBossMiddlePart"
if G and A then
F=("%.0f"):format(Vector3.new(
A.Position.X-G.Position.X,0,
A.Position.Z-G.Position.Z).Magnitude)
end






local H="-"
local I=am.Value"dodgeNamed"
if I then
H=af.NamedReport(A.Position,I)
end



local J="-"
if A and ac.AllAlive then
local K={}
for L,M in ipairs(ac.AllAlive())do
local N=ac.PivotOf and ac.PivotOf(M)
if N then
local O=(Vector3.new(N.X,0,N.Z)
-Vector3.new(A.Position.X,0,A.Position.Z)).Magnitude
if O<=70 then K[#K+1]=("%s@%.0f"):format(M.Name,O)end
end
end
table.sort(K)
if#K>0 then J=table.concat(K," ")end
end

local K=A and("%.0f,%.0f,%.0f"):format(
A.Position.X,A.Position.Y,A.Position.Z)or"-"

local L=("s36"):format(
z-bw,bw,
os.clock()-bq,br,
af.PartInfo and af.PartInfo(bs)or"-",
K,
C and C.Name or"s3",B or-1,
af.Count(),J,
af.NotesText and af.NotesText()or"-",
D,E,F,
tostring(bv:GetState()):gsub("Enum.HumanoidStateType.",""),
H,
((af.SafeTrail and af.SafeTrail(1.5)or"-")
..(af.SinceHop and("s37"):format(af.SinceHop())or"")))




if bw<=0 then
aq.Death(L.." | "..(workspace:FindFirstChild"dungeon"
and"s38"or"s39"))
end







local M=aB or ac.Nearest(A and A.Position or Vector3.zero,120)
if M then
local N=M:FindFirstChildWhichIsA"Humanoid"
local O={}
if N then
local P,Q=pcall(function()
return N:GetPlayingAnimationTracks()end)
if P then
for R,T in ipairs(Q)do
O[#O+1]=("%s(%.2f)"):format(
T.Name~=""and T.Name
or tostring(T.Animation and T.Animation.AnimationId),
T.TimePosition)
end
end
end

end








if A then
af.ZoneAt(A.Position,0)
af.ZoneAt(A.Position,ar)

end








if aq.enabled then

end

if bw<=0 and A then
for N,O in ipairs(af.NearestZones(A.Position,6))do

end
end

if bw<=0 then
local N=af.RecentAdds(2)

for O=1,math.min(#N,20)do

end
end







if A and bw<=0 then



local function isPlayerPart(N)
for O,P in ipairs(Players:GetPlayers())do
if P.Character and N:IsDescendantOf(P.Character)then
return true
end
end
return false
end





local N={}
for O,P in ipairs(workspace:GetDescendants())do
if P:IsA"BasePart"and P.Name~="ApelMark"
and not isPlayerPart(P)then
local Q=(P.Position-A.Position).Magnitude
if Q<=45 then
N[#N+1]={gap=Q,part=P}
end
end
end
table.sort(N,function(O,P)return O.gap<P.gap end)

for O=1,math.min(#N,30)do local P=
N[O].part

end
end





end))
end
end
end)



aa:Register("AutoFarm",60,function()
return S.autoFarm and IN_MATCH and ab.Alive()
and ac.Started()and ac.CountdownFinished()and not ac.Finished()
end)

spawnLoop(function()
while not _apelStopped do
task.wait(0.2)

if not(S.autoFarm and IN_MATCH)then
drop"s40"
elseif not aa:IsTop"AutoFarm"then




drop(not ab.Alive()and"s41"
or ac.Finished()and"s42"
or not ac.Started()and"s43"
or"s44")
elseif not ab.Alive()then
drop"s41"
bp:Set"Dead — waiting to respawn"
else








if not aB and not ae.IsPinning()then
local bt=ab.HRP()
if bt and not af.HasFloor(bt.Position)then
local bu=ac.NextRoomWithEnemies(false)or ac.Rooms()[1]
local bv=bu and bu.startPart
if bv then
local bw=bv.Position+Vector3.new(0,4,0)



aC=bw
ae.Pin(bw,bw+bt.CFrame.LookVector)
bp:Set"Stepped off the map — recovering"
end
end
end
pcall(function()













if aB and not g[tostring(aB.Name):lower()]then
local bt=ab.HRP()
if bt then
local bu,bv=pickTarget(ac.Targets(),bt.Position)
if bv and bu and bu~=aB then
acquire(bu)
if aq.enabled then

end
end
end
end

if aB and not ac.IsAlive(aB)then
noteKill(aB)
aB=nil
end



local bt=stallLeft()

do
local bu,bv=ac.NextRoomWithEnemies(bt>0)
if bu then
enterRoom(bu)
trySweep(bu,bv)
end
end










if not aB and#ac.Rooms()==0 then
local bu=ab.HRP()



local bv=ac.Targets()
local bw=bu and pickTarget(bv,bu.Position)or nil
if bw then
acquire(bw)
bp:Set(("Wave %d — %d left"):format(ac.Wave(),#bv))
end
end

if not aB then
local bu,bv=ac.NextRoomWithEnemies(bt>0)
if bu then
local bw=ab.HRP()
local z,A=false
if bw then A,z=pickTarget(bv,bw.Position)end
if A then
acquire(A)
bp:Set(("Clearing %s — %d left%s"):format(
bu.name,#bv,z and"  ·  priority target"or""))
end
elseif bt>0 then
bp:Set(("Stalling — %d s before the boss"):format(
math.ceil(bt)))
end
end

if aB then
ad.Swing()
ad.CastReady(aB,tonumber(S.castReach)or 0,{
first=(S.castFirst=="Q first"and"q")
or(S.castFirst=="E first"and"e")or nil,
})
return
end



if ac.Finished()then
bp:Set"Dungeon finished"
return
end

local bu=ac.Rooms()
local bv=bu[#bu]
local bw=ab.HRP()
if bv and bv.startPart and bw then
bp:Set(ac.FightingBoss()and"Waiting for the boss to spawn"
or"Moving to the boss room")






local z=bv.startPart.Position+Vector3.new(0,4,0)
aC=z
ae.Pin(z,z+bw.CFrame.LookVector)
else
bp:Set"Nothing to clear"
end
end)
end
end
end)









az:Toggle{
Name="Auto Replay",
Default=false,Flag="AutoReplay",
Callback=function(bt)S.autoReplay=bt end,
}

az:Button{Name="Replay Now",Text="Replay",Callback=function()
task.spawn(function()
if not ac.IsOwner()then return Notify"Only the player who created the run can replay it"end
aw.Fire("replayDungeon",ac.ReplayData())
Notify"Replay requested"
end)
end}







az:Toggle{
Name="Stall Before Boss",
Desc="clears the dungeon as usual but waits before starting the last fight",
Default=false,Flag="Stall",
Callback=function(bt)S.stall=bt end,
}

az:Input{
Name="Stall Until (seconds)",
Desc="counted from the start of the run — 120 means the boss fight begins at 2:00",
Default="120",Placeholder="120",
Flag="StallSeconds",
Callback=function(bt)
local bu=tonumber(tostring(bt):match"%d+%.?%d*"or"")
S.stallSeconds=bu and math.max(0,bu)or 0
end,
}

az:Toggle{
Name="Auto Ready Up",
Desc="presses Ready as soon as the pre-run screen shows up",
Default=false,Flag="AutoReady",
Callback=function(bt)S.autoReady=bt end,
}

az:Toggle{
Name="Auto Start Dungeon",
Desc="presses Start — only the player who created the run has this button",
Default=false,Flag="AutoStartRun",
Callback=function(bt)S.autoStart=bt end,
}







local bt

local function gearGui()
local bu=LocalPlayer:FindFirstChild"PlayerGui"
return bu and bu:FindFirstChild"selectClassGui"or nil
end

local function gearOptions()
local bu={}
local bv=gearGui()
local bw=bv and bv:FindFirstChild"Frame"
if bw then
for z,A in ipairs(bw:GetChildren())do
if A:FindFirstChild"button"then bu[#bu+1]=A.Name end
end
end
table.sort(bu)
return bu
end

bt=az:Dropdown{
Name="Gear Set",
Desc="event dungeons ask which kit you take; this answers for you",
Options=gearOptions(),
CacheOptions=true,
Flag="GearSet",
Callback=function(bu)S.gearSet=bu end,
}

az:Toggle{
Name="Auto Gear Select",
Default=false,Flag="AutoGear",
Callback=function(bu)S.autoGear=bu end,
}

az:Button{Name="Refresh Gear List",Text="Refresh",Callback=function()
local bu=gearOptions()
pcall(function()bt:SetOptions(bu)end)
Notify(#bu>0 and("%d gear sets"):format(#bu)or"No gear selection here")
end}







local function gearPending()
if not(S.autoGear and S.gearSet)then return false end
local bu=gearGui()
return bu~=nil and bu.Enabled==true
end

local bu=0

local function answerGear()
if not(S.autoGear and S.gearSet)then return false end
if Window:IsLoadingConfig()then return false end
local bv=gearGui()
if not(bv and bv.Enabled)then return false end
if(os.clock()-bu)<2 then return false end

bu=os.clock()
aw.Fire("equipSet",S.gearSet)
bv.Enabled=false
return true
end


spawnLoop(function()
while not _apelStopped do
task.wait(0.25)
pcall(answerGear)
end
end)


spawnLoop(function()
local bv=false
while not _apelStopped and not bv do
task.wait(2)
local bw=gearOptions()
if#bw>0 then
pcall(function()bt:SetOptions(bw)end)
bv=true
end
end
end)

az:Button{Name="Return To Lobby",Text="Leave",Callback=function()
S.autoFarm=false
drop()
aw.Fire"ReturnToLobbyEvent"
end}




aw.OnClient("showReadyGui",function()
task.delay(1,function()
if S.autoReady and not Window:IsLoadingConfig()then aw.Fire"readyUp"end
end)
end)

aw.OnClient("showStartButton",function()
task.delay(1.5,function()
if not(S.autoStart and not Window:IsLoadingConfig()and ac.IsOwner())then return end

answerGear()
if gearPending()then return end
if holdingForFriends()then return end
aw.Fire"changeStartValue"
end)
end)

spawnLoop(function()
local bv,bw=0,0
while not _apelStopped do
task.wait(1)
if IN_MATCH and not Window:IsLoadingConfig()then
local z=LocalPlayer:FindFirstChild"PlayerGui"
if z then


if S.autoReady and z:FindFirstChild"readyButton"and(os.clock()-bv)>3 then
bv=os.clock()
aw.Fire"readyUp"
end
if S.autoStart and z:FindFirstChild"startButton"and(os.clock()-bw)>3
and ac.IsOwner()and not gearPending()and not holdingForFriends()then
bw=os.clock()
aw.Fire"changeStartValue"
end
end
end
end
end)













if aq.enabled then
spawnLoop(function()
local bv=false
while not _apelStopped do
task.wait(1)
local bw=IN_MATCH and ac.Started()and not ac.Finished()
if bw and not bv then

end
bv=bw
end
end)
end

local function afterRun()

















local bv=S.smartDungeon and S.autoStartLobby
if not(S.autoReplay or bv)then return end









if bv then
local bw=an.BestDifficultyFor(ac.Name(),ab.Level())
local z=ac.Difficulty()









if z~=""and ap.Rejects(ac.Name(),z,ac.Hardcore())then
Notify"Smart Dungeon: this run keeps failing — rebuilding it in the lobby"
drop()
aw.Fire"ReturnToLobbyEvent"
return
end
if bw and z~=""and an.DifficultyRank(bw)>an.DifficultyRank(z)then
Notify(("Smart Dungeon: %s is unlocked — returning to the lobby"):format(bw))
drop()
aw.Fire"ReturnToLobbyEvent"
return
end
end

local bw=ac.ReplayData()
if not bw.dungeonName or bw.dungeonName==""then return end

if not ac.IsOwner()then
Notify"Replay: only the run owner can replay this dungeon"
return
end

drop()
aw.Fire("replayDungeon",bw)
end



















































































spawnLoop(function()
local bv
while not _apelStopped do
task.wait(2)
if IN_MATCH and S.smartDungeon then
local bw=ac.Name()
if bw~=""and bw~=bv then
bv=bw
pcall(function()an.Stats(bw)end)
end
end
end
end)



local bv=aA:Label"Waiting for a dungeon"

spawnLoop(function()
while not _apelStopped do
task.wait(1)
if IN_MATCH then
pcall(function()









local bw=ac.Rooms()
local z,A=0,0
for B,C in ipairs(bw)do
if C.enemies then
z=z+1
A=A+#ac.AliveIn(C)
end
end






if not ac.Started()or ac.Finished()then forgetRooms()end
local B=clearedRooms()
local C=ac.TimeLeft()
bv:Set(table.concat({
("<b>%s</b>%s"):format(ac.Name()~=""and ac.Name()or"—",
ac.Hardcore()and"  ·  Hardcore"or""),
("Rooms %d/%d   ·   Enemies left %d"):format(B,z,A),
("Time left %d:%02d   ·   %s"):format(math.floor(C/60),C%60,
ac.Finished()and"finished"or(ac.FightingBoss()and"boss fight"
or(ac.Started()and"in progress"or"waiting"))),
},"\n"))
end)
else
bv:Set"Not in a dungeon"
end
end
end)

return afterRun
end end function a.G():typeof(__modImpl())local aa=a.cache.G if not aa then aa={c=__modImpl()}a.cache.G=aa end return aa.c end end do local function __modImpl()







local aa=a.m()
local ab=a.n()

local ac={}

local function info()
local ad,ae=pcall(function()
return require(ReplicatedStorage:WaitForChild("modules",10):WaitForChild("BossRaidInfo",10))
end)
return ad and ae or nil
end

function ac.RaidNames()
local ad=info()
if ad and ad.getRaidNames then
local ae,af=pcall(ad.getRaidNames)
if ae and type(af)=="table"then return af end
end
return{}
end

function ac.IsRaidName(ad)
local ae=info()
if ae and ae.isBossRaidName then
local af,ag=pcall(ae.isBossRaidName,ad)
if af then return ag==true end
end
return false
end

function ac.MaxTier()
local ad=info()
if ad and ad.getMaxTier then
local ae,af=pcall(ad.getMaxTier)
if ae then return tonumber(af)or 30 end
end
return 30
end



function ac.Tiers()
local ad,ae={},{}
local af=LocalPlayer:FindFirstChild"PlayerGui"
local ag=af and af:FindFirstChild"bossQueueGui"
local ah=ag and ag:FindFirstChild"chooseBoss"
local ai=ah and ah:FindFirstChild"backgroundFillLeft"
local aj=ai and ai:FindFirstChild"ScrollingFrame"

if aj then
for ak,al in ipairs(aj:GetChildren())do
local am=al:FindFirstChild"tier"
local an=am and tonumber(am.Value)
if an and not ae[an]then ae[an]=true;ad[#ad+1]=an end
end
end

if#ad==0 then
for ak,al in ipairs((ab.Keys()))do
if not ae[al]then ae[al]=true;ad[#ad+1]=al end
end
end

table.sort(ad)
return ad
end


function ac.Create(ad,ae,af)
local ag=tonumber(ad)
if not ag then return false,"no tier selected"end
local ah,ai=aa.Invoke("createBossLobby",ag,ae==true,tonumber(af)or 1)
if not ah then return false,"createBossLobby failed"end
return ai==true,ai==true and"created"or"server refused (no key for this tier?)"
end

function ac.Join(ad)
local ae,af=aa.Invoke("playerJoinBossLobby",ad)
if not ae then return false,"playerJoinBossLobby failed"end
return af==true,af==true and"joined"or"server refused"
end

function ac.Start()
return aa.Fire"startBossRaid"
end

function ac.Leave()
return aa.Fire"leaveBossLobby"
end


function ac.NextTierStatus()
local ad,ae=aa.Invoke"checkNextTierKey"
if not ad or type(ae)~="table"then return false,"check failed"end
return ae.eligible==true,ae.reason
end



function ac.Replay(ad,ae)
local af={}
for ag,ah in pairs(ad or{})do af[ag]=ah end
if ae then af.advanceTier=true end
return aa.Fire("replayDungeon",af)
end

return ac end function a.H():typeof(__modImpl())local aa=a.cache.H if not aa then aa={c=__modImpl()}a.cache.H=aa end return aa.c end end do local function __modImpl()






local aa=a.E()
local ab=a.H()
local ac=a.n()
local ad=a.q()

local function set(ae)
local af={}
for ag,ah in pairs(ae or{})do if ah then af[ag]=true end end
return af
end

return function(ae)
local af=ae.Create
local ag=ae.Join
local ah=ae.Raid



local ai,aj,ak




local function refreshDifficulties()
if not aj then return end
local al=aa.Difficulties(S.lobbyDungeon)
pcall(function()aj:SetOptions(al)end)

local am=false
for an,ao in ipairs(al)do if ao==S.lobbyDifficulty then am=true end end
if not am and#al>0 then
S.lobbyDifficulty=al[#al]
pcall(function()aj:Set(S.lobbyDifficulty)end)
end
end




local function chosenRun()
if S.smartDungeon then










local al,am=aa.BestRunForLevel(ac.Level())







if al and am then
am=ad.Adjust(al,am,aa.Difficulties(al))
end
return al,am,true
end
return S.lobbyDungeon,S.lobbyDifficulty,false
end








local function chosenHardcore(al,am)
if not S.lobbyHardcore then return false end
if S.smartDungeon then return false end
return true
end




local function wrongLobby(al,am,an,ao)
local ap=tostring(al.dungeon or""):lower()
local aq=tostring(al.difficulty or""):lower()
if ap==""or aq==""then return false end
if ap~=tostring(am):lower()or aq~=tostring(an):lower()then
return true
end












return al.hardcore==true and ao==false
end

local function refreshLevelLine()
if not ak then return end
local al,am,an=chosenRun()
local ao=aa.LevelReq(al,am)
if S.smartDungeon and not al then
ak:Set(aa.warmed and"No dungeon is open to you at this level yet"
or"Reading dungeon requirements from the server...")
elseif not al then
ak:Set"Pick a dungeon to see its recommended level"
else



local ap=""
if an and al then local
aq, ar=aa.BestRunForLevel(ac.Level())
if ar and ar~=am then
ap=("\nlowered from %s after 3 failed runs here"):format(tostring(ar))
elseif S.lobbyHardcore then


ap="\nhardcore is off: Smart Dungeon never queues hardcore"
end
end

if ao then
ak:Set(("%s%s %s — needs level <b>%d</b>, you are %d%s")
:format(an and"Smart pick: "or"",tostring(al),
tostring(am),ao,ac.Level(),ap))
else
ak:Set(("%s%s %s%s"):format(an and"Smart pick: "or"",
tostring(al),tostring(am),ap))
end
end
end

af:Toggle{
Name="Smart Dungeon",
Desc="ignores both pickers below and queues the hardest run your level is allowed into",
Default=false,Flag="SmartDungeon",
Callback=function(al)
S.smartDungeon=al


if al and not aa.warmed then
task.spawn(function()pcall(aa.WarmStats);refreshDifficulties();refreshLevelLine()end)
end
end,
}

ai=af:Dropdown{
Name="Dungeon",
Desc="the same list the game shows in its queue; hidden event dungeons are left out",
Options=aa.Dungeons(),
Search=true,
CacheOptions=true,
Flag="LobbyDungeon",
Callback=function(al)
S.lobbyDungeon=al
refreshDifficulties()
refreshLevelLine()
end,
}

aj=af:Dropdown{
Name="Difficulty",
Options=aa.Difficulties(S.lobbyDungeon),
Default="Nightmare",
CacheOptions=true,
Flag="LobbyDifficulty",
Callback=function(al)S.lobbyDifficulty=al;refreshLevelLine()end,
}

af:Slider{
Name="Minimum Level",Default=1,Min=1,Max=250,Decimals=0,
Desc="level gate for players who want to join you",
Flag="LobbyLevelReq",
Callback=function(al)S.lobbyLevelReq=al end,
}

af:Toggle{Name="Hardcore",Default=false,Flag="LobbyHardcore",
Callback=function(al)S.lobbyHardcore=al end}
af:Toggle{Name="Private",Default=false,Flag="LobbyPrivate",
Callback=function(al)S.lobbyPrivate=al end}
af:Toggle{Name="Wave Defence",Default=false,Flag="LobbyWaveDefence",
Callback=function(al)S.lobbyWaveDefence=al end}

ak=af:Label"Pick a dungeon to see its recommended level"

af:Toggle{
Name="Auto Start Dungeon",
Desc="opens a lobby with the settings above and starts it, over and over",
Default=false,Flag="AutoStartLobby",
Callback=function(al)S.autoStartLobby=al end,
}

af:Button{Name="Refresh Lists",Text="Refresh",Callback=function()
pcall(function()ai:SetOptions(aa.Dungeons())end)
refreshDifficulties()
refreshLevelLine()
Notify"Dungeon list refreshed"
end}



local al,am,an

al=ag:Dropdown{
Name="Dungeons",
Desc="leave empty to accept any dungeon",
Options=aa.Dungeons(),Multi=true,Search=true,CacheOptions=true,
Flag="JoinDungeons",
Callback=function(ao)S.joinDungeons=set(ao)end,
}

am=ag:Dropdown{
Name="Difficulties",
Desc="leave empty to accept any difficulty",
Options=aa.Difficulties(),Multi=true,CacheOptions=true,
Flag="JoinDifficulties",
Callback=function(ao)S.joinDifficulty=set(ao)end,
}

ag:Toggle{Name="Hardcore Only",Default=false,Flag="JoinHardcoreOnly",
Callback=function(ao)S.joinHardcoreOnly=ao end}

ag:Toggle{
Name="Auto Join Lobby",
Desc="joins the first open lobby that matches the filters above",
Default=false,Flag="AutoJoinLobby",
Callback=function(ao)S.autoJoin=ao end,
}

an=ag:Label"No open lobbies"



local function matches(ao)
if ao.private then return false end
if ao.levelReq>ac.Level()then return false end
if S.joinHardcoreOnly and not ao.hardcore then return false end
if next(S.joinDungeons or{})and not S.joinDungeons[ao.dungeon]then return false end
if next(S.joinDifficulty or{})and not S.joinDifficulty[ao.difficulty]then return false end
return true
end

ag:Button{Name="Join Best Now",Text="Join",Callback=function()
task.spawn(function()
for ao,ap in ipairs(aa.Open())do
if matches(ap)then
local aq,ar=aa.Join(ap.name)
return Notify(aq and("Joined "..ap.name)or("Join failed — "..tostring(ar)))
end
end
Notify"No open lobby matches the filters"
end)
end}

ag:Button{Name="Leave Lobby",Text="Leave",Callback=function()aa.Leave()end}

ag:Button{Name="Refresh Lobby List",Text="Refresh",Callback=function()
pcall(function()
al:SetOptions(aa.Dungeons())
am:SetOptions(aa.Difficulties())
end)
Notify"Lobby filters refreshed"
end}



local ao

ao=ah:Dropdown{
Name="Tier",
Desc="only the tiers your keys unlock are listed",
Options=(function()
local ap={}
for aq,ar in ipairs(ab.Tiers())do ap[#ap+1]=tostring(ar)end
return ap
end)(),
CacheOptions=true,
Flag="RaidTier",
Callback=function(ap)S.raidTier=tonumber(ap)or 1 end,
}

ah:Toggle{Name="Private Raid",Default=false,Flag="RaidPrivate",
Callback=function(ap)S.raidPrivate=ap end}

ah:Slider{Name="Minimum Level",Default=1,Min=1,Max=250,Decimals=0,
Flag="RaidLevelReq",Callback=function(ap)S.raidLevelReq=ap end}

ah:Toggle{
Name="Auto Boss Raid",
Desc="keeps a raid lobby of the selected tier open and starts it",
Default=false,Flag="AutoBossRaid",
Callback=function(ap)S.autoRaid=ap end,
}

local ap=ah:Label"Keys: —"

ah:Button{Name="Refresh Tiers",Text="Refresh",Callback=function()
task.spawn(function()
ac.InvalidateInventory()
local aq={}
for ar,as in ipairs(ab.Tiers())do aq[#aq+1]=tostring(as)end
pcall(function()ao:SetOptions(aq)end)
Notify(("%d tier%s available"):format(#aq,#aq==1 and""or"s"))
end)
end}





spawnLoop(function()
task.wait(4)
if IN_LOBBY and not _apelStopped then
pcall(aa.WarmStats)
pcall(refreshDifficulties)
pcall(refreshLevelLine)
end
end)



spawnLoop(function()
while not _apelStopped do
task.wait(2)
if IN_LOBBY then
pcall(function()
local aq=aa.Open()
if#aq==0 then
an:Set"No open lobbies right now"
else
local ar,as={},0
for au,av in ipairs(aq)do
if as>=6 then
ar[#ar+1]=("… and %d more"):format(#aq-as)
break
end
as=as+1
ar[#ar+1]=("<b>%s</b> %s · lvl %d · %d player%s%s%s"):format(
av.dungeon,av.difficulty,av.levelReq,
#av.players,#av.players==1 and""or"s",
av.hardcore and" · HC"or"",
av.private and" · private"or"")
end
an:Set(table.concat(ar,"\n"))
end

refreshLevelLine()

local ar,as=ac.Keys()
ap:Set(("Keys: %s   ·   highest tier reached: %s"):format(
#ar>0 and table.concat(ar,", ")or"none",tostring(as)))
end)
end
end
end)



spawnLoop(function()
local aq=0
while not _apelStopped do
task.wait(1)
if IN_LOBBY and not Window:IsLoadingConfig()and(os.clock()-aq)>4 then
pcall(function()
local ar=aa.MyLobby()

if S.autoJoin and not ar then
for as,au in ipairs(aa.Open())do
if matches(au)then
aq=os.clock()
aa.Join(au.name)
return
end
end
end

if S.autoRaid then
aq=os.clock()
if not ar then ab.Create(S.raidTier,S.raidPrivate,S.raidLevelReq)end
ab.Start()
return
end




if S.autoStartLobby then
local as,au=chosenRun()

if not ar then
if as then
aq=os.clock()
aa.Create(as,au,S.lobbyLevelReq,
chosenHardcore(as,au),
S.lobbyPrivate,S.lobbyWaveDefence)
end
elseif ar.name==LocalPlayer.Name then
aq=os.clock()





if as and au
and wrongLobby(ar,as,au,
chosenHardcore(as,au))then
aa.Leave()
else
aa.Start()
end
end
end
end)
end
end
end)
end end function a.I():typeof(__modImpl())local aa=a.cache.I if not aa then aa={c=__modImpl()}a.cache.I=aa end return aa.c end end do local function __modImpl()














local aa=a.F()
local ab=a.E()
local ac=a.m()
local ad=a.l()

local ae=10

return function(af)
local ag=af.Hoster
local ah=af.Joining





S.hostNames=S.hostNames or{}

local function wanted()
local ai,aj={},{}
for ak=1,ae do
local al=S.hostNames[ak]
al=type(al)=="string"and al:gsub("^%s+",""):gsub("%s+$","")or""
if al~=""and not aj[al:lower()]then
aj[al:lower()]=true
ai[#ai+1]=al
end
end
return ai
end

for ai=1,ae do
ag:Input{
Name="Player "..ai,
Default="",Placeholder="username",
Flag="HostName"..ai,
Callback=function(aj)S.hostNames[ai]=tostring(aj or"")end,
}
end

ag:Toggle{
Name="Wait For Them",
Desc="accepts join requests from the names above and holds the run until they are all here",
Default=false,Flag="HostWait",
Callback=function(ai)
S.hostWait=ai
if ai and not aa.CanHost()then
Notify"Joiner: requests arrive inside the dungeon — start it first"
end
end,
}

local ai=ag:Label"No names yet"


local function stillWaiting()
if not S.hostWait then return false,nil end
local aj=wanted()
if#aj==0 then return false,nil end
local ak=aa.Missing(aj)
if#ak==0 then return false,nil end
return true,ak
end



aa.SetHold(stillWaiting)


ac.OnClient("showJoinRequest",function(aj,ak,al)
if _apelStopped or not S.hostWait then return end
if al=="close"or type(ak)~="string"or aj==nil then return end

local am=false
for an,ao in ipairs(wanted())do
if ao:lower()==ak:lower()then am=true break end
end







if not am then
if ad.enabled then

end
return
end



task.delay(0.3,function()
if _apelStopped then return end
aa.Answer(aj,true)
Notify("Joiner: accepted "..ak)
end)
end)

spawnLoop(function()
while not _apelStopped do
if ai then
local aj=wanted()
if#aj==0 then
ai:Set"No names yet"
elseif not S.hostWait then
ai:Set(("%d names, waiting is off"):format(#aj))
else
local ak,al=stillWaiting()
ai:Set(ak
and("waiting for %d: %s"):format(#al,table.concat(al,", "))
or"everyone is here — the run can start")
end
end
task.wait(1)
end
end)



local aj
local ak,al=0,false

ah:Input{
Name="Host",
Default="",Placeholder="username to join",
Flag="JoinHost",
Callback=function(am)S.joinHost=tostring(am or"")end,
}

local function askOnce()
local am=S.joinHost
am=type(am)=="string"and am:gsub("^%s+",""):gsub("%s+$","")or""
if am==""then
Notify"Joiner: type a host name first"
return
end
if not aa.CanRequest()then
Notify"Joiner: requests can only be sent from the lobby"
return
end
task.spawn(function()
al=true
local an,ao,ap=aa.SendRequest(am)
al=false
if aj then
aj:Set(not an and"request failed"
or ao and("waiting for "..am.." to accept")
or("refused: "..tostring(ap or"?")))
end
end)
end

ah:Button{Name="Send Request",Text="Send",Callback=askOnce}

ah:Toggle{
Name="Auto Request",
Desc="keeps asking the host to let you in while you sit in the lobby",
Default=false,Flag="JoinerOn",
Callback=function(am)S.joinerOn=am end,
}

ah:Slider{
Name="Leave After",Default=30,Min=10,Max=180,Decimals=0,
Desc="seconds without the host in your dungeon before going back to the lobby",
Flag="JoinerPatience",
Callback=function(am)S.joinerPatience=am end,
}

aj=ah:Label"Idle"



spawnLoop(function()
while not _apelStopped do
local am=S.joinHost
am=type(am)=="string"and am:gsub("^%s+",""):gsub("%s+$","")or""

if S.joinerOn and am~=""and not al
and aa.CanRequest()and not Window:IsLoadingConfig()
and(os.clock()-ak)>10
then


local an=false
for ao,ap in ipairs(ab.Open()or{})do
if tostring(ap.name):lower()==am:lower()then
ab.Join(am)
an=true
if aj then aj:Set("joining "..am.." here")end
break
end
end

if not an then
ak=os.clock()
al=true
local ao,ap,aq=aa.SendRequest(am)
al=false
if aj then
aj:Set(not ao and"request failed"
or ap and("waiting for "..am.." to accept")
or("refused: "..tostring(aq or"?")))
end


if ap then ak=os.clock()+15 end
end
end
task.wait(1)
end
end)





spawnLoop(function()
local am
while not _apelStopped do
local an=S.joinHost
an=type(an)=="string"and an:gsub("^%s+",""):gsub("%s+$","")or""
local ao=tonumber(S.joinerPatience)or 30

if S.joinerOn and an~=""and not aa.CanRequest()then
if aa.Present(an)then
am=nil
else
am=am or os.clock()
local ap=os.clock()-am
if aj then
aj:Set(("%s is not here — %.0fs of %.0f")
:format(an,ap,ao))
end
if ap>ao then
am=nil
Notify("Joiner: "..an.." never showed up, going back")
ac.Fire"ReturnToLobbyEvent"
end
end
else
am=nil
end
task.wait(1)
end
end)
end end function a.J():typeof(__modImpl())local aa=a.cache.J if not aa then aa={c=__modImpl()}a.cache.J=aa end return aa.c end end do local function __modImpl()






















local aa={}

local ab=9000
local ac=1500
local ad=4
local ae=300
local af=3
local ag=15
local ah=6
local ai=10
local aj=3
local ak=0.5
local al=13
local am=5









local an=1

local ao={
"wallbothcolumn","column","union","wedge",
"rubble","standingfires","dummy",
}
local ap={"barrier","boundary","boundaries"}

local aq,ar,as,au
local av,aw,ax={},false
local ay

local az=RaycastParams.new()
az.FilterType=Enum.RaycastFilterType.Exclude
az.IgnoreWater=true

local function isCreature(aA)
local aB=aA:FindFirstAncestorWhichIsA"Model"
while aB do
if aB:FindFirstChildOfClass"Humanoid"then return true end
aB=aB:FindFirstAncestorWhichIsA"Model"
end
return false
end

local function targets()
local aA={}
for aB,aC in ipairs{"dungeon","Map"}do
local aD=workspace:FindFirstChild(aC)
if aD then aA[#aA+1]=aD end
end
return aA
end



local function matches(aA,aB)
local aC=aA
for aD=1,4 do
if not aC or aC==workspace then break end
local aE=tostring(aC.Name):lower()
for aF,aG in ipairs(aB)do
if aE:find(aG,1,true)then return true end
end
aC=aC.Parent
end
return false
end

local function sideBoundary(aA)
return math.min(aA.Size.X,aA.Size.Z)<=am
end

local function keepAsIs(aA)
if not matches(aA,ap)then return false end


if tostring(aA.Name):lower():find("boundary",1,true)
and not sideBoundary(aA)then
return false
end
return true
end

local function mine(aA)
if aq and aA:IsDescendantOf(aq)then return true end
if ar and aA:IsDescendantOf(ar)then return true end
return false
end

local function killable(aA)
if not aA:IsA"BasePart"then return false end
if mine(aA)then return false end
if keepAsIs(aA)then return false end
if LocalPlayer.Character and aA:IsDescendantOf(LocalPlayer.Character)then
return false
end
return not isCreature(aA)
end



local function collectBounds()
av={}
for aA,aB in ipairs(targets())do
for aC,aD in ipairs(aB:GetDescendants())do



if aD:IsA"BasePart"
and tostring(aD.Name):lower():find("boundary",1,true)
and sideBoundary(aD)
then
av[#av+1]=aD
end
end
end
end



local function paintBounds()
for aA,aB in ipairs(av)do
if aB.Parent and aB.Transparency>0.9 then
aB.Transparency=ak
aB.Color=Color3.fromRGB(255,255,255)
aB.Material=Enum.Material.SmoothPlastic
end
end
end

local function nearBoundary(aA)
for aB,aC in ipairs(av)do
if aC.Parent then

local aD=aC.CFrame:PointToObjectSpace(aA.Position)
local aE=aC.Size*0.5
if math.abs(aD.X)<=aE.X+al
and math.abs(aD.Y)<=aE.Y+al
and math.abs(aD.Z)<=aE.Z+al
then
return true
end
end
end
return false
end

local function isWall(aA,aB)
local aC=aA.Size
if math.max(aC.X,aC.Y,aC.Z)<aj then return false end
if matches(aA,ao)then return false end


if not aA.CanCollide then return false end
if aC.Y<ah then return false end
if math.max(aC.X,aC.Z)<ai then return false end
if nearBoundary(aA)then return false end

local aD=aA.Position.Y+aC.Y*0.5
local aE=aA.Position.Y-aC.Y*0.5
return aD>aB+af and aE<aB+ag
end

local function raise(aA)
local aB=Instance.new"Part"
aB.Size=aA.Size
aB.CFrame=aA.CFrame
aB.Anchored,aB.CanCollide,aB.CanQuery=true,true,true
aB.Material=Enum.Material.SmoothPlastic
aB.Color=Color3.fromRGB(255,255,255)
aB.Transparency=ak
aB.TopSurface,aB.BottomSurface=Enum.SurfaceType.Smooth,Enum.SurfaceType.Smooth
aB.Parent=ar
end

local function floorUnder(aA)
az.FilterDescendantsInstances={LocalPlayer.Character,aq}
local aB=workspace:Raycast(aA+Vector3.new(0,10,0),
Vector3.new(0,-500,0),az)
return aB and aB.Position.Y or nil
end


local function handle(aA,aB)
if not killable(aA)then return false end
if isWall(aA,aB)then raise(aA)end
pcall(function()aA:Destroy()end)
return true
end

function aa.Running()return aw end






function aa.Ground()return ay end

function aa.Stop()
aw=false
if as then as:Disconnect()as=nil end
au=nil


end

function aa.Build()
if aw then return false,"s57"end
local aA=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
if not aA then return false,"s58"end

local aB=floorUnder(aA.Position)
if not aB then return false,"s59"end







ax=aB
ay=aB-an













local aC,aD,aE={},{}
for aF,aG in ipairs(workspace:GetChildren())do
if aG.Name=="ApelArenaFloor"then aC[#aC+1]=aG
elseif aG.Name=="ApelArenaWalls"then
if not aE then aE=aG else aD[#aD+1]=aG end
end
end

aq=Instance.new"Folder"
aq.Name="ApelArenaFloor"
aq.Parent=workspace

local aF=math.ceil(ab/ac)
local aG=(aF-1)/2
for aH=0,aF-1 do
for aI=0,aF-1 do
local aJ=Instance.new"Part"
aJ.Size=Vector3.new(ac,ad,ac)
aJ.Position=Vector3.new(
aA.Position.X+(aH-aG)*ac,
ay-ad/2,
aA.Position.Z+(aI-aG)*ac)
aJ.Anchored,aJ.CanCollide,aJ.CanQuery=true,true,true
aJ.Material=Enum.Material.SmoothPlastic
aJ.Color=Color3.fromRGB(45,65,95)
aJ.Parent=aq
end
end

if aE then
ar=aE


for aH,aI in ipairs(aD)do
for aJ,aM in ipairs(aI:GetChildren())do
pcall(function()aM.Parent=ar end)
end
pcall(function()aI:Destroy()end)
end
else
ar=Instance.new"Folder"
ar.Name="ApelArenaWalls"
ar.Parent=workspace
end


for aH,aI in ipairs(aC)do pcall(function()aI:Destroy()end)end

aw=true
collectBounds()
paintBounds()

local aH=0
for aI,aJ in ipairs(targets())do
for aM,aN in ipairs(aJ:GetDescendants())do
if handle(aN,aB)then
aH=aH+1
if aH%ae==0 then task.wait()end
end
end
end


as=regConn(workspace.DescendantAdded:Connect(function(aI)
if not aw or not aI:IsA"BasePart"then return end
local aJ=false
for aM,aN in ipairs(targets())do
if aI:IsDescendantOf(aN)then aJ=true break end
end
if not aJ then return end


task.defer(function()
if aw and aI.Parent then handle(aI,ax or 0)end
end)
end))



au=spawnLoop(function()
while aw and not _apelStopped do
task.wait(1)
if not aw then break end
collectBounds()
paintBounds()
for aI,aJ in ipairs(targets())do
if not aw then break end
for aM,aN in ipairs(aJ:GetDescendants())do
if not aw then break end
handle(aN,ax or 0)
end
end
end
end)

return true,aH
end

return aa end function a.K():typeof(__modImpl())local aa=a.cache.K if not aa then aa={c=__modImpl()}a.cache.K=aa end return aa.c end end do local function __modImpl()














































local aa={}

local ab=3
local ac=4
local ad=3







local ae=0.002
local af=1e-6

local ag,ah={},{}
local ai,aj,ak={},{},{}
local al,am=0,0
local an,ao=false,false
local ap,aq=-1,0




local ar,as,au=1
local av=6
local aw=5







local ax={150,400,math.huge}
local ay=16
local az=4



local aA=az*az











local aB=5






local function segHitsBox(aC,aD,aE)
local aF,aG,aH=aD.X,aD.Y,aD.Z
local aI,aJ,aM=aE.X,aE.Y,aE.Z
if(aF<aC.minX and aI<aC.minX)or(aF>aC.maxX and aI>aC.maxX)then return false end
if(aG<aC.minY and aJ<aC.minY)or(aG>aC.maxY and aJ>aC.maxY)then return false end
if(aH<aC.minZ and aM<aC.minZ)or(aH>aC.maxZ and aM>aC.maxZ)then return false end

local aN=aC.cf:PointToObjectSpace(aD)












if math.abs(aN.X)<=aC.hx and math.abs(aN.Y)<=aC.hy
and math.abs(aN.Z)<=aC.hz then
return false
end

local aO=aC.cf:PointToObjectSpace(aE)
local aP,aQ=0,1

local aR,aS,aT=aN.X,aO.X-aN.X,aC.hx
if math.abs(aS)<af then
if aR<-aT or aR>aT then return false end
else
local aU=1/aS
local aV,aW=(-aT-aR)*aU,(aT-aR)*aU
if aV>aW then aV,aW=aW,aV end
if aV>aP then aP=aV end
if aW<aQ then aQ=aW end
if aP>aQ then return false end
end

aR,aS,aT=aN.Y,aO.Y-aN.Y,aC.hy
if math.abs(aS)<af then
if aR<-aT or aR>aT then return false end
else
local aU=1/aS
local aV,aW=(-aT-aR)*aU,(aT-aR)*aU
if aV>aW then aV,aW=aW,aV end
if aV>aP then aP=aV end
if aW<aQ then aQ=aW end
if aP>aQ then return false end
end

aR,aS,aT=aN.Z,aO.Z-aN.Z,aC.hz
if math.abs(aS)<af then
if aR<-aT or aR>aT then return false end
else
local aU=1/aS
local aV,aW=(-aT-aR)*aU,(aT-aR)*aU
if aV>aW then aV,aW=aW,aV end
if aV>aP then aP=aV end
if aW<aQ then aQ=aW end
if aP>aQ then return false end
end

return true
end

local function boxOf(aC)
local aD=aC.Size
local aE,aF,aG=aD.X*0.5+ab,aD.Y*0.5+ab,aD.Z*0.5+ab
local aH=aC.Position


local aI=math.max(aE,aF,aG)*1.7321
return{
part=aC,cf=aC.CFrame,hx=aE,hy=aF,hz=aG,
minX=aH.X-aI,maxX=aH.X+aI,
minY=aH.Y-aI,maxY=aH.Y+aI,
minZ=aH.Z-aI,maxZ=aH.Z+aI,
}
end






local function kindOf(aC)
if not aC:IsA"BasePart"then return nil end
local aD=tostring(aC.Name):lower()
if aD:find("barrier",1,true)then return"door"end


if aD:find("boundary",1,true)and math.min(aC.Size.X,aC.Size.Z)<=5 then
return"wall"
end
return nil
end

local function collect()
ag,ah={},{}








for aC,aD in ipairs(workspace:GetChildren())do
if aD.Name=="ApelArenaWalls"then
for aE,aF in ipairs(aD:GetChildren())do
if aF:IsA"BasePart"then ag[#ag+1]=boxOf(aF)end
end
end
end

local aC=workspace:FindFirstChild"dungeon"
if aC then
for aD,aE in ipairs(aC:GetDescendants())do
local aF=kindOf(aE)
if aF=="door"then ah[#ah+1]=boxOf(aE)
elseif aF=="wall"then ag[#ag+1]=boxOf(aE)end
end
end
end

local function blockedByWalls(aC,aD)
for aE=1,#ag do
if segHitsBox(ag[aE],aC,aD)then return true end
end
return false
end


local function blockedByDoors(aC,aD)
for aE=1,#ah do
local aF=ah[aE]
local aG=aF.part
if aG.Parent and aG.CanCollide and segHitsBox(aF,aC,aD)then return true end
end
return false
end

function aa.Clear(aC,aD)
return not blockedByWalls(aC,aD)and not blockedByDoors(aC,aD)
end

local function insideAnyWall(aC)
for aD=1,#ag do
local aE=ag[aD]
local aF=aE.cf:PointToObjectSpace(aC)
if math.abs(aF.X)<=aE.hx and math.abs(aF.Y)<=aE.hy
and math.abs(aF.Z)<=aE.hz then
return true
end
end
return false
end












function aa.RoomAt(aC,aD)
for aE=1,#ag do
local aF=ag[aE]
if not(aC.X<aF.minX-aD or aC.X>aF.maxX+aD
or aC.Y<aF.minY-aD or aC.Y>aF.maxY+aD
or aC.Z<aF.minZ-aD or aC.Z>aF.maxZ+aD)then
local aG=aF.cf:PointToObjectSpace(aC)
local aH=math.abs(aG.X)-aF.hx
local aI=math.abs(aG.Y)-aF.hy
local aJ=math.abs(aG.Z)-aF.hz
if aH<0 then aH=0 end
if aI<0 then aI=0 end
if aJ<0 then aJ=0 end
if aH*aH+aI*aI+aJ*aJ<aD*aD then return false end
end
end
return true
end

function aa.Ready()return an end
function aa.Building()return ao end

function aa.Stats()
return("s156"):format(#ag,#ah,al)
end






local function buildGraph(aC)
am=aC+ad
local aD=os.clock()
local function breathe()
if os.clock()-aD>ae then
task.wait()
aD=os.clock()
end
end


ai={}
for aE=1,#ag do
local aF=ag[aE]
local aG,aH=aF.hx+ac,aF.hz+ac
for aI,aJ in ipairs{-1,1}do
for aM,aN in ipairs{-1,1}do
local aO=(aF.cf*CFrame.new(aJ*aG,0,aN*aH)).Position
local aP=Vector3.new(aO.X,am,aO.Z)





local aQ=false
for aR=1,#ai do
local aS=ai[aR]
local aT,aU=aS.X-aP.X,aS.Z-aP.Z
if aT*aT+aU*aU<aA then aQ=true break end
end
if not aQ and not insideAnyWall(aP)then
ai[#ai+1]=aP
end
end
end
breathe()
end
al=#ai
if al==0 then
aj,ak,an={},{},true
return
end


aj={}
for aE=1,al do aj[aE]={}end
for aE=1,al-1 do
local aF=ai[aE]
for aG=aE+1,al do
local aH=ai[aG]
if not blockedByWalls(aF,aH)then
local aI=(aF-aH).Magnitude
local aJ=aj[aE]
local aM=aj[aG]
aJ[#aJ+1]={aG,aI}
aM[#aM+1]={aE,aI}
end
end
breathe()
end

















ak={}
local aE=math.huge
local aF,aG={},{}
for aH=1,al do
local aI=(aH-1)*al
for aJ=1,al do ak[aI+aJ]=aE end
ak[aI+aH]=0

local aJ=1
aF[1],aG[1]=0,aH

while aJ>0 do
local aM,aN=aF[1],aG[1]
local aO,aP=aF[aJ],aG[aJ]
aJ=aJ-1
if aJ>0 then
aF[1],aG[1]=aO,aP
local aQ=1
while true do
local aR,aS=aQ*2,aQ*2+1
local aT=aQ
if aR<=aJ and aF[aR]<aF[aT]then aT=aR end
if aS<=aJ and aF[aS]<aF[aT]then aT=aS end
if aT==aQ then break end
aF[aT],aF[aQ]=aF[aQ],aF[aT]
aG[aT],aG[aQ]=aG[aQ],aG[aT]
aQ=aT
end
end

if aM<=ak[aI+aN]then
for aQ,aR in ipairs(aj[aN])do
local aS,aT=aR[1],aR[2]
local aU=aM+aT
if aU<ak[aI+aS]then
ak[aI+aS]=aU
aJ=aJ+1
local aV=aJ
aF[aV],aG[aV]=aU,aS
while aV>1 do
local aW=aV//2
if aF[aW]<=aF[aV]then break end
aF[aW],aF[aV]=aF[aV],aF[aW]
aG[aW],aG[aV]=aG[aV],aG[aW]
aV=aW
end
end
end
end
end
breathe()
end

an=true
end

function aa.Rebuild(aC)
if ao then return end
ao=true
an=false
as,au,ar=nil,nil,1
task.spawn(function()
local aD,aE=pcall(function()
collect()


ap=#ag+#ah
buildGraph(aC or 0)
end)
ao=false
if not aD then
an=false
if type(dbg)=="function"then dbg("s157"..tostring(aE))end
end
end)
end











function aa.Refresh(aC)
if ao then return end

local aD=0
for aE,aF in ipairs(workspace:GetChildren())do
if aF.Name=="ApelArenaWalls"then
for aG,aH in ipairs(aF:GetChildren())do
if aH:IsA"BasePart"then aD=aD+1 end
end
end
end
local aE=workspace:FindFirstChild"dungeon"
if aE then
for aF,aG in ipairs(aE:GetDescendants())do
if kindOf(aG)then aD=aD+1 end
end
end

if aD==ap then return end
if os.clock()-aq<3 then return end
aq=os.clock()
aa.Rebuild(aC)
end


local function visibleAround(aC,aD,aE)
local aF={}
for aG,aH in ipairs(ax)do
aF={}
for aI=1,al do
local aJ=ai[aI]
local aM=(aC-aJ).Magnitude
if aM<=aH and(not aE or aM>aB)then
local aN
if aD then aN=aa.Clear(aC,aJ)else aN=not blockedByWalls(aC,aJ)end
if aN then aF[#aF+1]={aI,aM}end
end
end
if#aF>0 then break end
end
if#aF>ay then
table.sort(aF,function(aG,aH)return aG[2]<aH[2]end)
for aG=#aF,ay+1,-1 do aF[aG]=nil end
end
return aF
end















function aa.Path(aC,aD)
if aa.Clear(aC,aD)then return{aD},"direct"end
if not an or al==0 then return nil,"no graph"end

local aE=Vector3.new(aC.X,am,aC.Z)
local aF=Vector3.new(aD.X,am,aD.Z)

local aG=visibleAround(aE,true,true)
if#aG==0 then return nil,"we are boxed in"end
local aH=visibleAround(aF,false)
if#aH==0 then return nil,"target boxed in"end

local aI,aJ,aM=math.huge
for aN,aO in ipairs(aG)do
local aP,aQ=aO[1],aO[2]
local aR=(aP-1)*al
for aS,aT in ipairs(aH)do
local aU=aQ+ak[aR+aT[1] ]+aT[2]
if aU<aI then aI,aJ,aM=aU,aP,aT[1]end
end
end
if not aJ then return nil,"no path"end

local aN={}
local aO,aP=aJ,0
while aO~=aM and aP<al do
aN[#aN+1]=ai[aO]
local aQ,aR=math.huge
for aS,aT in ipairs(aj[aO])do
local aU,aV=aT[1],aT[2]
local aW=aV+ak[(aU-1)*al+aM]
if aW<aQ then aQ,aR=aW,aU end
end
if not aR then break end
aO=aR
aP=aP+1
end
aN[#aN+1]=ai[aM]
aN[#aN+1]=aD
return aN,"via corners"
end











function aa.Step(aC,aD)
if aa.Clear(aC,aD)then
as,au=nil,nil
return aD,"direct"
end
if not an or al==0 then return nil,"no graph"end

local aE=Vector3.new(aC.X,am,aC.Z)

local function advance()
while ar<=#as do
local aF=as[ar]
if(Vector3.new(aF.X,am,aF.Z)-aE).Magnitude>aw then break end
ar=ar+1
end
end


if as and au and(aD-au).Magnitude<=av then
advance()
if ar<=#as and aa.Clear(aC,as[ar])then
return as[ar],"via corner"
end
end

local aF=aa.Path(aC,aD)
if not aF or#aF==0 then return nil,"no path"end
as,au,ar=aF,aD,1
advance()

if ar>#as then return aD,"direct"end
return as[ar],"via corner"
end

return aa end function a.L():typeof(__modImpl())local aa=a.cache.L if not aa then aa={c=__modImpl()}a.cache.L=aa end return aa.c end end do local function __modImpl()






































local aa=a.l()

local ab={}

local ac=4
local ad=3














local ae=6













local af=6
local ag=4












local ah=2.5
local ai=20











local aj=12
local ak=3






local al=90










local am=8000






local an=700
local ao=0.002






local ap=40

local aq=120
local ar=3







local as=0.5




local au=5
local av=6

local aw={}











local ax,ay={},{}
local az=0
local aA,aB=false,false
local aC,aD=0,0
local aE=0
local aF=0
local aG,aH,aI=1
local aJ=0
local aM
local aN,aO=0

local aP





function ab.SetFloorFilter(aQ)
LPH_ATTRIBUTES(VM(NONE))aP=aQ end

local aQ={
"ApelArenaFloor","ApelArenaWalls","ApelCastRing",
"ApelEditFloor","ApelEditWalls","ApelNavDots","ApelStepProbe",
}


local aR={}
local aS={}

local aT=RaycastParams.new()
aT.FilterType=Enum.RaycastFilterType.Exclude
aT.IgnoreWater=true

local function refreshFilter()
LPH_ATTRIBUTES(VM(NONE))
local aU={}
local aV=LocalPlayer and LocalPlayer.Character
if aV then aU[#aU+1]=aV end
for aW,aX in ipairs(aQ)do
local aY=workspace:FindFirstChild(aX)
if aY then aU[#aU+1]=aY end
end
if aP then
local aW,aX=pcall(aP)
if aW and type(aX)=="table"then
for aY,aZ in ipairs(aX)do aU[#aU+1]=aZ end
end
end
aS=aU
aT.FilterDescendantsInstances=aU

aR={}
end






local function addSkip(aU)
LPH_ATTRIBUTES(VM(NONE))
aS[#aS+1]=aU
local aV=pcall(function()aT:AddToFilter(aU)end)
if not aV then aT.FilterDescendantsInstances=aS end
end














local aU
local aV,aW={},-99
local aX=0.1
local aY=90

function ab.SetDanger(aZ)
LPH_ATTRIBUTES(VM(NONE))aU=aZ end







local aZ

function ab.SetNoGo(a_)
LPH_ATTRIBUTES(VM(NONE))aZ=(a_ and#a_>0)and a_ or nil end

local function inNoGo(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
if not aZ then return false end
for a1,a2 in ipairs(aZ)do
if a_>=a2[1]and a_<=a2[2]and a0>=a2[3]and a0<=a2[4]then return true end
end
return false
end

function ab.InNoGo(a_)
LPH_ATTRIBUTES(VM(NONE))return inNoGo(a_.X,a_.Z)end

local function cellOf(a_)
LPH_ATTRIBUTES(VM(NONE))return math.floor(a_/ac+0.5)end
local function worldOf(a_)
LPH_ATTRIBUTES(VM(NONE))return a_*ac end

local function at(a_,a0)
LPH_ATTRIBUTES(VM(NONE))
local a1=aw[a_]
return a1 and a1[a0]or nil
end


































local function passThrough(a_)
LPH_ATTRIBUTES(VM(NONE))
return a_:IsA"BasePart"and not a_.CanCollide and a_~=workspace.Terrain
end

local function liveRoot(a_)
LPH_ATTRIBUTES(VM(NONE))
local a0=aR[a_]
if a0~=nil then return a0 or nil end
local a1=false
local a2=a_
while a2 and a2~=workspace do
if a2:IsA"Model"and a2:FindFirstChildOfClass"Humanoid"then
a1=a2
break
end
a2=a2.Parent
end
aR[a_]=a1
return a1 or nil
end


local a_=4

local function castFloor(a0,a1)
LPH_ATTRIBUTES(VM(NONE))
for a2=1,a_ do
local a3=workspace:Raycast(a0,Vector3.new(0,-a1,0),aT)
if not a3 then return nil end
local a4=liveRoot(a3.Instance)
if not a4 and not passThrough(a3.Instance)then return a3.Position.Y end
addSkip(a4 or a3.Instance)
end
return nil
end


local function probe(a0,a1,a2)
LPH_ATTRIBUTES(VM(NONE))
return castFloor(Vector3.new(worldOf(a0),a2+ad,worldOf(a1)),
ad+ae)
end














local a0=2.22






local a1=3.8













local a2=2.0

local a3=true








local a4=false








local function blocked(a5,a6,a7,a8,a9,b)
LPH_ATTRIBUTES(VM(NONE))
local ba=math.max(a7,b or a7)+a2
local bb=Vector3.new(worldOf(a5),ba+a1/2,worldOf(a6))
local bc=Vector3.new(a8*ac,0,a9*ac)

for bd=1,a_ do
local be
if a4 or not a3 then
be=workspace:Raycast(bb,bc,aT)
else
local bf,bg=pcall(function()
return workspace:Blockcast(CFrame.new(bb),
Vector3.new(a0,a1,a0),bc,aT)
end)
if bf then
be=bg
else
a3=false

be=workspace:Raycast(bb,bc,aT)
end
end
if not be then return false end
local bf=liveRoot(be.Instance)
if not bf and not passThrough(be.Instance)then return true end
addSkip(bf or be.Instance)
end
return true
end


local function probeDeep(a5,a6,a7)
LPH_ATTRIBUTES(VM(NONE))
return castFloor(Vector3.new(worldOf(a5),a7+ad,worldOf(a6)),
ad+ai)
end


local function probeMid(a5,a6,a7,a8,a9)
LPH_ATTRIBUTES(VM(NONE))
return castFloor(Vector3.new((worldOf(a5)+worldOf(a7))*0.5,a9+ad,
(worldOf(a6)+worldOf(a8))*0.5),ad+ai)
end

local a5={{1,0},{-1,0},{0,1},{0,-1}}


local a6=ac*1.4142135623731
local a7={
{1,0,ac},{-1,0,ac},{0,1,ac},{0,-1,ac},
{1,1,a6},{1,-1,a6},{-1,1,a6},{-1,-1,a6},
}

local function edgeGet(a8,a9,b)
LPH_ATTRIBUTES(VM(NONE))
local ba=a8[a9]
return ba and ba[b]
end




local function linked(a8,a9,b,ba)
LPH_ATTRIBUTES(VM(NONE))
if b==1 then return edgeGet(ax,a8,a9)==true end
if b==-1 then return edgeGet(ax,a8-1,a9)==true end
if ba==1 then return edgeGet(ay,a8,a9)==true end
return edgeGet(ay,a8,a9-1)==true
end















local function flood(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
local b,ba,bb={},{},{}
local bc=0

local function gAt(bd,be)
local bf=b[bd]
return bf and bf[be]or nil
end
local function gPut(bd,be,bf)
local bg=b[bd]
if not bg then bg={}b[bd]=bg end
if bg[be]==nil then bc=bc+1 end
bg[be]=bf
end
local function gEdge(bd,be,bf,bg,bh,bi)
local bj,bk,bl
if bf==1 then bj,bk,bl=ba,bd,be
elseif bf==-1 then bj,bk,bl=ba,bd-1,be
elseif bg==1 then bj,bk,bl=bb,bd,be
else bj,bk,bl=bb,bd,be-1 end
local bm=bj[bk]
if not bm then bm={}bj[bk]=bm end
local bn=bm[bl]
if bn~=nil then return bn end
bn=not blocked(bd,be,bh,bf,bg,bi)
bm[bl]=bn
return bn
end

local bd,be=cellOf(a8.X),cellOf(a8.Z)
local bf=probe(bd,be,a8.Y-ak)
if not bf then


for bg,bh in ipairs(a5)do
bf=probe(bd+bh[1],be+bh[2],a8.Y-ak)
if bf then bd,be=bd+bh[1],be+bh[2]break end
end
end
if not bf then return false,"s130"end

local bg,bh=bd,be
gPut(bd,be,bf)

local bi,bj={bd},{be}
local bk=1
local bl={[bd]={[be]=true}}
local bm=os.clock()







local bn,bo
if a9 then bn,bo=cellOf(a9.X),cellOf(a9.Z)end
local bp

while bk<=#bi do
local bq,br=bi[bk],bj[bk]
bk=bk+1
local bs=gAt(bq,br)












for bt,bu in ipairs(a5)do
local bv,bw=bq+bu[1],br+bu[2]


if math.abs(bv-bg)<=al and math.abs(bw-bh)<=al
and not inNoGo(worldOf(bv),worldOf(bw))then
local c=bl[bv]
if not c then c={}bl[bv]=c end

local d=gAt(bv,bw)
local e=d or probe(bv,bw,bs)

if not e then e=probeDeep(bv,bw,bs)end
if e then
local f=e-bs
local g=f<=ad and f>=-ae
if not g and f<=ad and f>=-ai then


local h=probeMid(bq,br,bv,bw,bs)
g=h~=nil and math.abs(h-(bs+e)*0.5)<=ah
end
if g then


local h=gEdge(bq,br,bu[1],bu[2],bs,e)
if h and not c[bw]then
c[bw]=true
gPut(bv,bw,e)
bi[#bi+1],bj[#bj+1]=bv,bw
end
end
end
end
end

if bc>=am then break end


if bn and not bp and gAt(bn,bo)then
bp=#bi+an
end
if bp and bk>bp then break end

if os.clock()-bm>ao then
task.wait()
bm=os.clock()
if _apelStopped then return false,"s131"end
end
end















local bq={}
for br,bs in pairs(b)do
for bt,bu in pairs(bs)do









local bv=false
for bw,c in ipairs(a5)do
local d,e=br+c[1],bt+c[2]
local f=b[d]and b[d][e]
if f then
if bu-f>af then bv=true break end
else














local g=castFloor(
Vector3.new(worldOf(d),bu+ad,worldOf(e)),
ad+af+2)
if not g and not blocked(br,bt,bu,c[1],c[2],nil)then
bv=true
break
end
end
end






















if bv and not(br==bd and bt==be)then
local bw=0
for c,d in ipairs(a5)do
if b[br+d[1] ]and b[br+d[1] ][bt+d[2] ]then bw=bw+1 end
end
if bw>=3 then bq[#bq+1]={br,bt}end
end
end
end
for br,bs in ipairs(bq)do
local bt=b[bs[1] ]
if bt and bt[bs[2] ]~=nil then bt[bs[2] ]=nil bc=bc-1 end
end







if bc<ap and not a4 then
a4=true
local br,bs=flood(a8,a9)
a4=false
return br,bs
end











if bc<ap and az>=ap and at(cellOf(a8.X),cellOf(a8.Z))then
return false,("s132"):format(bc)
end

aw,az,ax,ay=b,bc,ba,bb
aC,aD=bg,bh
return true
end



function ab.Ready()
LPH_ATTRIBUTES(VM(NONE))return aA end
function ab.Building()
LPH_ATTRIBUTES(VM(NONE))return aB end

function ab.Stats()
LPH_ATTRIBUTES(VM(NONE))
return("s133"):format(
az,aC,aD,al*ac)
end



function ab.HeightAt(a8)
LPH_ATTRIBUTES(VM(NONE))
return at(cellOf(a8.X),cellOf(a8.Z))
end









function ab.Reachable(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
if not aA then return false end
local b,ba=cellOf(a8.X),cellOf(a8.Z)
local bb=a9 or 3
for bc=-bb,bb do
for bd=-bb,bb do
if at(b+bc,ba+bd)then return true end
end
end
return false
end


















function ab.Clear(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
if not aA then return false end


local b,ba=a8.X/ac+0.5,a8.Z/ac+0.5
local bb,bc=a9.X/ac+0.5,a9.Z/ac+0.5

local bd,be=math.floor(b),math.floor(ba)
local bf,bg=math.floor(bb),math.floor(bc)

local bh=at(bd,be)
if not bh then return false end
if bd==bf and be==bg then return true end

local bi,bj=bb-b,bc-ba
local bk=bi>0 and 1 or-1
local bl=bj>0 and 1 or-1

local bm,bn=math.huge,math.huge
if bi~=0 then
local bo=bi>0 and(bd+1)or bd
bm=(bo-b)/bi
bn=1/math.abs(bi)
end
local bo,bp=math.huge,math.huge
if bj~=0 then
local bq=bj>0 and(be+1)or be
bo=(bq-ba)/bj
bp=1/math.abs(bj)
end

for bq=1,4096 do
local br,bs=0,0
if bm<bo then
br=bk
bm=bm+bn
else
bs=bl
bo=bo+bp
end

if not linked(bd,be,br,bs)then return false end
local bt,bu=bd+br,be+bs
local bv=at(bt,bu)
if not bv then return false end













local bw=bv-bh
if bw>ad or bw<-af then return false end
bd,be,bh=bt,bu,bv
if bd==bf and be==bg then return true end
end
return false
end













function ab.ClearSafe(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
if not ab.Clear(a8,a9)then return false end
local b,ba=cellOf(a8.X),cellOf(a8.Z)
local bb,bc=cellOf(a9.X),cellOf(a9.Z)
local bd=math.max(math.abs(bb-b),math.abs(bc-ba))
for be=0,bd do
local bf=b+math.floor((bb-b)*be/math.max(1,bd)+0.5)
local bg=ba+math.floor((bc-ba)*be/math.max(1,bd)+0.5)
if not at(bf+1,bg)or not at(bf-1,bg)
or not at(bf,bg+1)or not at(bf,bg-1)then
return false
end
end
return true
end









function ab.NearestWhere(a8,a9,b)
LPH_ATTRIBUTES(VM(NONE))
if not aA then return nil end
local ba,bb=cellOf(a8.X),cellOf(a8.Z)
local bc=math.max(1,math.floor((a9 or 40)/ac+0.5))
for bd=1,bc do
for be=-bd,bd do
for bf=-bd,bd do
if math.abs(be)==bd or math.abs(bf)==bd then
local bg=at(ba+be,bb+bf)
if bg then
local bh=Vector3.new(worldOf(ba+be),bg+ak,worldOf(bb+bf))
if b(bh)then return bh end
end
end
end
end
end
return nil
end




function ab.RoomAt(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
if not aA then return false end
local b,ba=cellOf(a8.X),cellOf(a8.Z)
local bb=at(b,ba)
if not bb then return false end
local bc=math.max(1,math.floor(a9/ac+0.5))
for bd=-bc,bc do
for be=-bc,bc do
if bd*bd+be*be<=bc*bc then
local bf=at(b+bd,ba+be)
if not bf then return false end
if math.abs(bf-bb)>ad+ae then return false end
end
end
end
return true
end



local function nearestCell(a8,a9)
LPH_ATTRIBUTES(VM(NONE))
local b,ba=cellOf(a8.X),cellOf(a8.Z)
if at(b,ba)then return b,ba end
for bb=1,a9 do
for bc=-bb,bb do
for bd=-bb,bb do
if math.abs(bc)==bb or math.abs(bd)==bb then
if at(b+bc,ba+bd)then return b+bc,ba+bd end
end
end
end
end
return nil
end






local function hotCells()
LPH_ATTRIBUTES(VM(NONE))
if os.clock()-aW<aX then return aV end
aW=os.clock()
aV={}
if not aU then return aV end
local a8,a9=pcall(aU)
if not a8 or type(a9)~="table"then return aV end

for b,ba in ipairs(a9)do
local bb,bc=ba.cf,ba.size
if bb and bc then
local bd=bc.Y*0.5

local be=math.abs(bb.RightVector.X)*bc.X*0.5
+math.abs(bb.UpVector.X)*bc.Y*0.5
+math.abs(bb.LookVector.X)*bc.Z*0.5
local bf=math.abs(bb.RightVector.Z)*bc.X*0.5
+math.abs(bb.UpVector.Z)*bc.Y*0.5
+math.abs(bb.LookVector.Z)*bc.Z*0.5
local bg,bh=cellOf(bb.Position.X-be),cellOf(bb.Position.X+be)
local bi,bj=cellOf(bb.Position.Z-bf),cellOf(bb.Position.Z+bf)

if(bh-bg)*(bj-bi)<=4000 then
local bk=ba.cylinder and(bc.Y*0.5)or nil
for bl=bg,bh do
local bm=aw[bl]
if bm then
for bn=bi,bj do
local bo=bm[bn]
if bo then
local bp=Vector3.new(worldOf(bl),bo+ak,worldOf(bn))
local bq
if bk then
local br=Vector3.new(bp.X-bb.Position.X,0,bp.Z-bb.Position.Z)
bq=br.Magnitude<=bk
and math.abs(bp.Y-bb.Position.Y)<=bc.X*0.5
else
local br=bb:PointToObjectSpace(bp)
bq=math.abs(br.X)<=bc.X*0.5
and math.abs(br.Y)<=bd
and math.abs(br.Z)<=bc.Z*0.5
end
if bq then aV[bl*1000000+bn]=true end
end
end
end
end
end
end
end
return aV
end

function ab.HotAt(a8)
LPH_ATTRIBUTES(VM(NONE))
local a9=hotCells()
return a9[cellOf(a8.X)*1000000+cellOf(a8.Z)]==true
end



























local a8=12

local function segHot(a9,b,ba)
LPH_ATTRIBUTES(VM(NONE))
if not aU then return false end
local bb=hotCells()
local bc,bd=b.X-a9.X,b.Z-a9.Z
local be=math.sqrt(bc*bc+bd*bd)
if be<=0.1 then return bb[cellOf(a9.X)*1000000+cellOf(a9.Z)]==true end
if ba and be>ba then
local bf=ba/be
bc,bd,be=bc*bf,bd*bf,ba
end
local bf=math.min(64,math.ceil(be/ac))











local bg=false
for bh=1,bf do
local bi=bh/bf
local bj=bb[cellOf(a9.X+bc*bi)*1000000+cellOf(a9.Z+bd*bi)]
if not bj then
bg=true
elseif bg then
return true
end
end
return false
end

local function astar(a9,b,ba,bb)
LPH_ATTRIBUTES(VM(NONE))
local bc=hotCells()
local bd,be,bf={},{},{}
local bg=0
local bh,bi,bj={},{},{}
local bk={}

local function key(bl,bm)return bl*1000000+bm end

local function push(bl,bm,bn)
bg=bg+1
bd[bg],be[bg],bf[bg]=bl,bm,bn
local bo=bg
while bo>1 do
local bp=math.floor(bo/2)
if bf[bp]<=bf[bo]then break end
bd[bp],bd[bo]=bd[bo],bd[bp]
be[bp],be[bo]=be[bo],be[bp]
bf[bp],bf[bo]=bf[bo],bf[bp]
bo=bp
end
end

local function pop()
local bl,bm=bd[1],be[1]
bd[1],be[1],bf[1]=bd[bg],be[bg],bf[bg]
bg=bg-1
local bn=1
while true do
local bo,bp,bq=bn*2,bn*2+1,bn
if bo<=bg and bf[bo]<bf[bq]then bq=bo end
if bp<=bg and bf[bp]<bf[bq]then bq=bp end
if bq==bn then break end
bd[bq],bd[bn]=bd[bn],bd[bq]
be[bq],be[bn]=be[bn],be[bq]
bf[bq],bf[bn]=bf[bn],bf[bq]
bn=bq
end
return bl,bm
end




local function heur(bl,bm)
local bn,bo=math.abs(bl-ba),math.abs(bm-bb)
local bp=math.min(bn,bo)
return(bn+bo-2*bp)*ac+bp*a6
end

bh[key(a9,b)]=0
push(a9,b,heur(a9,b))

while bg>0 do
local bl,bm=pop()
local bn=key(bl,bm)
if not bk[bn]then
bk[bn]=true
if bl==ba and bm==bb then
local bo={}
local bp,bq=bl,bm
while bp do
bo[#bo+1]=Vector3.new(worldOf(bp),at(bp,bq)+ak,worldOf(bq))
local br=key(bp,bq)
bp,bq=bi[br],bj[br]
end

local br={}
for bs=#bo,1,-1 do br[#br+1]=bo[bs]end
return br
end
local bo=at(bl,bm)









for bp,bq in ipairs(a7)do
local br,bs=bl+bq[1],bm+bq[2]
local bt=at(br,bs)
local bu=false
if bt then
if bq[1]==0 or bq[2]==0 then
bu=linked(bl,bm,bq[1],bq[2])
else
bu=linked(bl,bm,bq[1],0)and linked(bl,bm,0,bq[2])
and at(bl+bq[1],bm)and at(bl,bm+bq[2])
and linked(bl+bq[1],bm,0,bq[2])
end
end
if bu then
local bv=bt-bo
if bv<=ad and bv>=-ae then
local bw=key(br,bs)
if not bk[bw]then


local c=bv<-af and(-bv-af)or 0


local d=0
if not at(br+1,bs)then d=d+1 end
if not at(br-1,bs)then d=d+1 end
if not at(br,bs+1)then d=d+1 end
if not at(br,bs-1)then d=d+1 end

local e=bh[bn]+bq[3]
+c*ag+d*aj
+(bc[bw]and aY or 0)
if e<(bh[bw]or math.huge)then
bh[bw]=e
bi[bw],bj[bw]=bl,bm
push(br,bs,e+heur(br,bs))
end
end
end
end
end
end
end
return nil
end




local function simplify(a9)
LPH_ATTRIBUTES(VM(NONE))
if#a9<=2 then return a9 end
local b={a9[1]}
local ba=1
for bb=3,#a9 do
if not ab.ClearSafe(a9[ba],a9[bb])or segHot(a9[ba],a9[bb],a8)then
b[#b+1]=a9[bb-1]
ba=bb-1
end
end
b[#b+1]=a9[#a9]
return b
end

function ab.Path(a9,b)
LPH_ATTRIBUTES(VM(NONE))
aM=b
aN=(Vector3.new(b.X,0,b.Z)-Vector3.new(a9.X,0,a9.Z)).Magnitude
if not aA then return nil,"s134"end

local ba,bb=nearestCell(a9,4)
if not ba then aJ=os.clock()aO="s135"return nil,aO end
local bc,bd=nearestCell(b,8)









local be=false
if not bc then
aJ=os.clock()
aO="s136"
ab.Grow()

local bf,bg,bh=math.huge
for bi,bj in pairs(aw)do
for bk in pairs(bj)do
local bl,bm=worldOf(bi)-b.X,worldOf(bk)-b.Z
local bn=bl*bl+bm*bm
if bn<bf then bf,bg,bh=bn,bi,bk end
end
end
if not bg then return nil,aO end
bc,bd,be=bg,bh,true
end

local bf=astar(ba,bb,bc,bd)
if not bf then
aJ=os.clock()
aO="s137"
ab.Grow()
return nil,aO
end

local bg=simplify(bf)




if not be then bg[#bg]=b end







local bh=(Vector3.new(b.X,0,b.Z)-Vector3.new(a9.X,0,a9.Z)).Magnitude
local bi=(#bf-1)*ac
if bh>12 and bi>bh*1.6 then

end
return bg,be and"s138"or"ok"
end

function ab.Step(a9,b)
LPH_ATTRIBUTES(VM(NONE))






















local ba=false
if aU then
local bb=hotCells()
local bc,bd=b.X-a9.X,b.Z-a9.Z
local be=math.sqrt(bc*bc+bd*bd)
if be>0.1 then
local bf=math.min(64,math.ceil(be/ac))
for bg=0,bf do
local bh=bg/bf
local bi,bj=a9.X+bc*bh,a9.Z+bd*bh
if bb[cellOf(bi)*1000000+cellOf(bj)]then ba=true break end
end
end
end

if not ba and ab.Clear(a9,b)then
aH,aI=nil,nil
return b,"direct"
end
if not aA then
if ab.Clear(a9,b)then return b,"s139"end
return nil,"s134"
end

local function advance()
while aG<=#aH do
local bb=aH[aG]
local bc,bd=bb.X-a9.X,bb.Z-a9.Z
if math.sqrt(bc*bc+bd*bd)>au then break end
aG=aG+1
end
end














local function furthest()
local bb






for bc=aG,#aH do
if ab.ClearSafe(a9,aH[bc])and not segHot(a9,aH[bc],a8)then
bb=bc
else break end
end
if bb then return bb end


























if aH[aG]and not segHot(a9,aH[aG],a8)then
if aa.enabled then

end
return aG
end
if aH[aG]and aa.enabled then

end
for bc=aG,#aH do
if ab.ClearSafe(a9,aH[bc])then bb=bc else break end
end
if bb then return bb end
for bc=aG,#aH do
if ab.Clear(a9,aH[bc])then bb=bc else break end
end
return bb
end












local bb=math.max(av,(b-a9).Magnitude*0.1)
if aH and aI and(b-aI).Magnitude<=bb then
advance()
local bc=aG<=#aH and furthest()or nil
if bc then
aG=bc
return aH[bc],"via cell"
end
end

local bc=ab.Path(a9,b)
if not bc or#bc==0 then


if ab.Clear(a9,b)then
return b,ba and"s140"or"s141"
end
return nil,"s142"
end
aH,aI,aG=bc,b,1
advance()
if aG>#aH then return b,"direct"end
local bd=furthest()
if bd then aG=bd end










return aH[aG],"via cell"
end



function ab.Rebuild(a9,b)
LPH_ATTRIBUTES(VM(NONE))
if aB then return end
aB=true






task.spawn(function()


tick()local
ba=pcall(function()
local ba=LocalPlayer and LocalPlayer.Character
local bb=ba and ba:FindFirstChild"HumanoidRootPart"
if not bb then error"s58"end
refreshFilter()
local bc,bd=flood(bb.Position,b)
if not bc then error(bd)end
end)
aB=false
aA=az>0
if ba then


aH,aI,aG=nil,nil,1


end
end)
end

















function ab.Grow()
LPH_ATTRIBUTES(VM(NONE))
if aB or not aA then return end
if os.clock()-aF<as then return end
aF=os.clock()



ab.Rebuild(nil,aM)
end

function ab.Refresh(a9)
LPH_ATTRIBUTES(VM(NONE))
if aB then return end
if os.clock()-aE<ar then return end

local b=LocalPlayer and LocalPlayer.Character
local ba=b and b:FindFirstChild"HumanoidRootPart"
if not ba then return end

local bb=(cellOf(ba.Position.X)-aC)*ac
local bc=(cellOf(ba.Position.Z)-aD)*ac
local bd=math.sqrt(bb*bb+bc*bc)







local be=(os.clock()-aJ)<ar



local bf=ab.HeightAt(ba.Position)==nil
if not be and bd<aq and not bf then return end

aE=os.clock()



ab.Rebuild(a9)
end

function ab.Clear_Held()
LPH_ATTRIBUTES(VM(NONE))
aH,aI,aG=nil,nil,1
end

return ab end function a.M():typeof(__modImpl())local aa=a.cache.M if not aa then aa={c=__modImpl()}a.cache.M=aa end return aa.c end end do local function __modImpl()

local aa={}
function aa.Start()end
function aa.Stop()end
return aa end function a.N():typeof(__modImpl())local aa=a.cache.N if not aa then aa={c=__modImpl()}a.cache.N=aa end return aa.c end end do local function __modImpl()



































local aa=a.x()

local ab=game:GetService"ReplicatedStorage"

local ac={}








local ad=0.25
local ae=0.1















local af=3.5

local ag,ah,ai
local aj,ak,al,am=0,0,0,0
local an,ao

function ac.Running()return ag~=nil end

function ac.Stats()
if not ag then return"s149"end
return("s150")
:format(aj,ak,al,am,
an and("s85"):format(an)or"-",
ao and("s85"):format(ao)or"-")
end

local function onSignal(ap)
local aq=ap[ai]
local ar=tonumber(ap.startTime)or 0
local as=tonumber(ap.delayUntilAttack)or 0


local au=as-(workspace:GetServerTimeNow()-ar)
aj=aj+1
an=au
if not ao or au<ao then ao=au end
if au<=0 then am=am+1 end

local av=math.max(au,0)+ad
if av<ae then av=ae end

if aq=="Circle"then
local aw,ax=ap.position,tonumber(ap.radius)
if typeof(aw)~="Vector3"or not ax then return end
al=al+1



local ay=CFrame.new(aw)*CFrame.Angles(0,0,math.pi/2)
aa.Foresee(ay,Vector3.new(0.5,ax*2,ax*2),
av,"s151",0,af,true)
return
end

local aw,ax=ap.cframe,ap.size
if typeof(aw)~="CFrame"or typeof(ax)~="Vector3"then return end
ak=ak+1
aa.Foresee(aw,ax,av,"s152",0,af,false)
end

function ac.Start()
if ag then return true,"s153"end

local ap,aq=pcall(function()
local ap=ab:WaitForChild("Utility",5)
local aq=ap and ap:FindFirstChild"BridgeNet2"
if not aq then error"s154"end
local ar=require(aq)
ah=ar.ReferenceBridge"precastHitbox"
ai=ar.ReferenceIdentifier"action"


ag=ah:Connect(onSignal)
end)

if not ap then
ag=nil
return false,tostring(aq)
end
aj,ak,al,am=0,0,0,0
an,ao=nil,nil
return true,"s155"
end

function ac.Stop()
if ag then
pcall(function()ag:Disconnect()end)
ag=nil
end
end

return ac end function a.O():typeof(__modImpl())local aa=a.cache.O if not aa then aa={c=__modImpl()}a.cache.O=aa end return aa.c end end do local function __modImpl()
























local aa=a.o()
local ab=a.n()
local ac=a.v()
local ad=a.x()
local ae=a.K()
local af=a.L()
local ag=a.M()a.N()

local ah=a.O()
local ai=a.l()

local aj=game:GetService"RunService"

local ak=32
local al=1.2
local am=14















local an=3





























local ao={king=
{{-33,-24,-17,8}},
}

local ap={
["Spider Queen"]=Vector3.new(-205,237,-868),
}















local aq=45

local ar={







["Northern Warrior"]=20,
}

local as={
["Ice Elemental"]=true,




["Spider Queen"]=true,


["Captain Blackbeard"]=true,


["Beast Master"]=true,
}
















local au={25,35,50}

local av=4









local aw=0.5







local ax=16










local ay={
["Northern Warrior"]=true,
}

local az=16
local aA=3



















































local aB=0






























local aC=3














local aD=13





















local aE=3

local aF=4










local aG=6







local aH=1.5



local aI=60
local aJ=12

local aM=0.4









local aN=60


local aO=55
local aP=200



















math.rad(50)























local aQ=8














local aR=0.35

local aS=0.2



























local aT=2
local aU=1.5








local aV=5
local aW=10






local aX={8,5,3,0}
















local aY=1.6
local aZ=2



















local a_=0.5

local a0=1.5

local a1=4

local a2=6












local a3=25
local a4=5

local a5=4




local a6=0.5








local a7=0.66


































local function showDots()
LPH_ATTRIBUTES(VM(NONE))
if ai.enabled then return S.testDots==true end
return S.testWalk==true
end







local function showRoute()
LPH_ATTRIBUTES(VM(NONE))
if ai.enabled then return S.testDots==true end
return S.testWalk==true
end
local function showZones()
LPH_ATTRIBUTES(VM(NONE))return ai.enabled and S.testZones==true end

local a8=0
local a9=0
local b=0

local ba=0






local bb,bc={},0







local bd,be,bf=0,0






local bg,bh,bi={},{},{}
local bj=0












local bk=0.2















local function Plan()
LPH_ATTRIBUTES(VM(NONE))
return S.testArena and af or ag
end












ag.SetFloorFilter(ad.FloorIgnore)






ag.SetDanger(function()
LPH_ATTRIBUTES(VM(NONE))
local bl=ab.HRP()
if not bl then return{}end
return ad.ZoneShapes(bl.Position,150,0)
end)

return function(bl)
LPH_ATTRIBUTES(VM(NONE))






spawnLoop(function()
local bm=false
while not _apelStopped do
if not bm then
local bn=tostring(aa.Name and aa.Name()or""):lower()
for bo,bp in pairs(ao)do
if bn~=""and bn:find(bo,1,true)then
ag.SetNoGo(bp)
bm=true

break
end
end
end
task.wait(2)
end
end)


local bm,bn={}










local bo={}

local function mobPoints()
local bp={}
for bq,br in ipairs(bo)do
if br.Parent then
local bs=aa.PivotOf(br)
if bs then bp[#bp+1]=Vector3.new(bs.X,0,bs.Z)end
end
end
return bp
end local bp=


































math.huge
































































































local function mobKeeps()
local bq={}
for br,bs in ipairs(bo)do
if bs.Parent then
local bt=aa.PivotOf(bs)
if bt then













bq[#bq+1]={
at=Vector3.new(bt.X,0,bt.Z),
keep=ar[bs.Name]or 0,
}
end
end
end
return bq
end






local function freshFolder(bq)
for br,bs in ipairs(workspace:GetChildren())do
if bs.Name==bq then pcall(function()bs:Destroy()end)end
end
local br=Instance.new"Folder"
br.Name=bq
br.Parent=workspace
return br
end

local bq

local br=RaycastParams.new()
br.FilterType=Enum.RaycastFilterType.Exclude
br.IgnoreWater=true

local function floorAt(bs,bt,bu)





if ae.Running()then
local bv=ae.Ground()
if bv then return bv end
end








if ag.Ready()then
local bv=ag.HeightAt(Vector3.new(bs,0,bt))
if bv then return bv end
end


br.FilterDescendantsInstances={LocalPlayer.Character,bn}
local bv=workspace:Raycast(Vector3.new(bs,(bu or 0)+8,bt),
Vector3.new(0,-300,0),br)
return bv and bv.Position.Y or nil
end



local function ensureDots()
if bn and bn.Parent then return end
bn=freshFolder"ApelTestDots"
bm={}
for bs=1,ak*(#au+1)do
local bt=Instance.new"Part"









bt.Name="ApelMark"
bt.Size=Vector3.new(al,al,al)
bt.Anchored,bt.CanCollide,bt.CanQuery,bt.CanTouch=true,false,false,false
bt.Material=Enum.Material.Neon
bt.Transparency=0.3
bt.Parent=bn
bm[bs]=bt
end
end











local bs,bt={}

local function clearRoute()
if bt then bt:Destroy()bt=nil end
bs={}
end

local function drawRoute(bu,bv)
if not showRoute()or not bv or#bv==0 then
for bw,c in ipairs(bs)do c.Transparency=1 end
return
end
if not bt or not bt.Parent then
bt=freshFolder"ApelRouteView"
bs={}
end

local bw=0
local function put(c,d)
bw=bw+1
local e=bs[bw]
if not e or not e.Parent then
e=Instance.new"Part"
e.Name="ApelMark"
e.Anchored,e.CanCollide=true,false
e.CanQuery,e.CanTouch=false,false
e.Material=Enum.Material.Neon
e.Parent=bt
bs[bw]=e
end

e.Size=d and Vector3.new(1.6,1.6,1.6)or Vector3.new(0.7,0.7,0.7)
e.Color=d and Color3.fromRGB(255,150,40)
or Color3.fromRGB(255,220,120)
e.Transparency=0.3
e.Position=c
end

local c=bu
for d,e in ipairs(bv)do
local f=(e-c).Magnitude
if f>0.01 then
local g=math.floor(f/av)
for h=1,g do
put(c:Lerp(e,(h*av)/f),false)
end
end
put(e,true)
c=e
if bw>200 then break end
end
for d=bw+1,#bs do bs[d].Transparency=1 end
end

local function clearMarks()
if bn then bn:Destroy()bn=nil end
bm={}
clearRoute()
end







local bu={}



local bv={}






local function legClear(bw,c)
local d=Vector3.new(c.X-bw.X,0,c.Z-bw.Z)
local e=math.min(d.Magnitude,a3)
if e<0.5 then return true end
local f=d.Unit
local g=a4
while g<=e do
local h=bw+f*g
if not ad.IsSafe(Vector3.new(h.X,bw.Y,h.Z),aB)then return false end
g=g+a4
end
return true
end















local function legOut(bw,c)
local d=Vector3.new(c.X-bw.X,0,c.Z-bw.Z)
local e=math.min(d.Magnitude,a3)
if e<0.5 then return true end
local f=d.Unit











local g=ab.Humanoid()
local h=math.max((g and g.WalkSpeed)or az,1)
local i,j=a4,false
while i<=e do
local k=bw+f*i
local l=ad.PassAt(Vector3.new(k.X,bw.Y,k.Z),aB,i/h)
if l then
j=true
elseif j then
return false
end
i=i+a4
end
return true
end











local function pathGap(bw,c,d)
local e,f=bw.X-d.X,bw.Z-d.Z
local g,h=c.X-d.X,c.Z-d.Z
local i,j=g-e,h-f
local k=i*i+j*j
if k<1e-6 then return math.sqrt(e*e+f*f)end
local l=-(e*i+f*j)/k
if l<0 then l=0 elseif l>1 then l=1 end
local m,n=e+i*l,f+j*l
return math.sqrt(m*m+n*n)
end








local bw,c,d={},0
local e,f,g,h,i=0,0,0,0,0
local j=0
local k=0
local l=0
local m=0
local n=0
local o,p,q=0,0,0






local r=0
local s,u={},0
local v=-99










local w,x,y=0












local function drawZones(z)
if not d or not d.Parent then
d=freshFolder"ApelZoneView"
bw={}
end

local A=ad.ZoneShapes(z,90,aB)
for B,C in ipairs(A)do
local D=bw[B]
if not D or not D.Parent then
D=Instance.new"Part"
D.Name="ApelMark"
D.Anchored,D.CanCollide=true,false
D.CanQuery,D.CanTouch=false,false
D.Material=Enum.Material.ForceField
D.Parent=d
bw[B]=D
end
D.Shape=C.cylinder and Enum.PartType.Cylinder or Enum.PartType.Block
D.Size=C.size
D.CFrame=C.cf

D.Color=C.ghost and Color3.fromRGB(90,160,255)
or Color3.fromRGB(255,220,60)
D.Transparency=0.75
end
for B=#A+1,#bw do
if bw[B]then bw[B].Transparency=1 end
end
end


















local z=6
local A=false












local function hopSpot(B,C,D)
local E,F=math.huge
local G=mobPoints()
mobKeeps()
local H=C and z or aD
local I=C and(A and 0 or aE)or aF
I=I+(D or 0)
for J=6,aQ,2 do
for K=1,16 do
local L=(K/16)*math.pi*2
local M=B.X+math.cos(L)*J
local N=B.Z+math.sin(L)*J
local O=floorAt(M,N,B.Y)
if O then
local P=Vector3.new(M,O+aA,N)






local Q=not ag.InNoGo(P)
and ad.IsSafe(P,I)and Plan().Clear(B,P)
and(A or Plan().RoomAt(P,aG))
if Q then
for R,T in ipairs(G)do
if(Vector3.new(P.X,0,P.Z)-T).Magnitude<H then
Q=false break
end
end
end
if Q and J<E then F,E=P,J end
end
end

if F then break end
end
return F
end




local function hopSpotDeep(B,C)

















for D,E in ipairs(aX)do
local F=hopSpot(B,C,E)
if F and ad.RoomSafe(F,2.5)then return F,E end
end
for D,E in ipairs(aX)do
local F=hopSpot(B,C,E)
if F then return F,E end
end
if not C then return nil end
A=true
local D=hopSpot(B,C,0)
A=false
return D,false
end




local function leastThreat(B)
local C=ad.ThreatAt(B,0)
if C<=0 then return nil end
local D,E=C
local F=mobPoints()
mobKeeps()
for G=6,aQ,2 do
for H=1,16 do
local I=(H/16)*math.pi*2
local J=B.X+math.cos(I)*G
local K=B.Z+math.sin(I)*G
local L=floorAt(J,K,B.Y)
if L then
local M=Vector3.new(J,L+aA,K)
if Plan().Clear(B,M)and not ag.InNoGo(M)then
local N=true
for O,P in ipairs(F)do
if(Vector3.new(M.X,0,M.Z)-P).Magnitude<z then
N=false break
end
end


if N then
local O=ad.ThreatAt(M,0)
if O<D-1 then E,D=M,O end
end
end
end
end
end
return E
end



local function groundNow()
if ae.Running()then
local B=ae.Ground()
if B then return B end
end
local B=ab.HRP()
if not B then return nil end
return floorAt(B.Position.X,B.Position.Z,B.Position.Y)
end










local function pickSpot(B,C,D,E)
local F=ab.HRP()and ab.HRP().Position
if not F then return nil end
if showDots()then ensureDots()end












local G=not ad.IsSafe(F,0)
local H=G and 200 or 8















local I,J,K=-1,math.huge
table.clear(bv)
local L,M=math.huge

table.clear(bu)
bu.total,bu.unsafe,bu.blocked=0,0,0
bu.tight,bu.close,bu.crossed,bu.nofloor=0,0,0,0
bu.legcut=0









local N=mobPoints()
local O=mobKeeps()
local P=math.huge
for Q,R in ipairs(N)do
local T=(Vector3.new(F.X,0,F.Z)-R).Magnitude
if T<P then P=T end
end
if P==math.huge then
P=(Vector3.new(F.X,0,F.Z)-Vector3.new(B.X,0,B.Z)).Magnitude
end
local Q=math.min(aD,P)










local R={D}
if E then
for T,U in ipairs(au)do
if math.abs(U-D)>1 then R[#R+1]=U end
end
end

for T=1,#R do
local U=R[T]
for V=1,ak do
local W=(T-1)*ak+V
local X=(V/ak)*math.pi*2
local Y=B.X+math.cos(X)*U
local Z=B.Z+math.sin(X)*U
local _=floorAt(Y,Z,B.Y)

local bx=_ and Vector3.new(Y,_+aA,Z)or nil

if bx and ag.InNoGo(bx)then bx=nil end
bu.total=bu.total+1
if not bx then bu.nofloor=bu.nofloor+1 end
local by=bx~=nil and ad.IsSafe(bx,aB)
if bx and not by then bu.unsafe=bu.unsafe+1 end








local bz=by and Plan().Clear(F,bx)



local bA=bx~=nil
if bx then
local bB=Vector3.new(bx.X,0,bx.Z)
for bC,bD in ipairs(O)do



local bE=bD.keep or 0
if bE>0 and(bB-bD.at).Magnitude<bE then
bA=false break
end
end
end
local bB=by and bz

if showDots()and bm[W]then
local bC=bm[W]
if bx then
bC.Position=bx
bC.Transparency=0.3


if bB then
bC.Color=Color3.fromRGB(60,235,110)
elseif by then
bC.Color=Color3.fromRGB(80,140,255)
else
bC.Color=Color3.fromRGB(255,70,70)
end
else


bC.Transparency=1
end
end

if bx and by and not bz then
bu.blocked=bu.blocked+1
end

if bB then











local bC=0


local bD=false
for bE,bF in ipairs(N)do
if pathGap(F,bx,bF)<Q then bD=true break end
end
if bD then
bC=bC-5000
bu.crossed=bu.crossed+1
end
if ad.IsSafe(bx,aF)then bC=bC+1000
elseif ad.IsSafe(bx,aE)then


bC=bC+400
bu.tight=bu.tight+1
else bu.tight=bu.tight+1 end
if bA then bC=bC+500
else bu.close=bu.close+1 end






















local bE=0
local bF=Vector3.new(bx.X,0,bx.Z)
for bG,bH in ipairs(N)do
if(bF-bH).Magnitude<=aO then
bE=bE+1
end
end
if bE>1 then
bC=bC-math.min(bE-1,4)*aP
end


















if legClear(F,bx)then bC=bC+600
else
bC=bC-5000
bu.legcut=(bu.legcut or 0)+1
end





if Plan().RoomAt(bx,aG)then bC=bC+1200
else bC=bC-800 end



























local bG=(bx-F).Magnitude
bC=bC-bG*H



bv[#bv+1]={score=bC,far=bG}

local bH=bC>I
or(bC==I and bG<J)
if K==nil or bH then
K,I,J=bx,bC,bG
bu.crowd=bE
end
elseif by then






local bC=(bx-F).Magnitude
if bC<L then M,L=bx,bC end
end
end
end
bu.best=I
bu.picked=K and"s48"or(M and"s49"or"s50")
bu.at=K or M
return K or M
end

local function walkSet(bx)
S.testWalk=bx
if bx then


S.autoFarm=false
S.speedOn=false








local by,bz=ah.Start()
if not by then
warn("s51"..tostring(bz))
end







Plan().Rebuild(groundNow())
else
ah.Stop()
bq=nil
clearMarks()
local by=ab.Humanoid()
if by then
by.WalkSpeed=16
by.AutoRotate=true
end
end
end
S.walkSet=walkSet














local function hopSet(bx)
S.testHop=bx
end
S.hopSet=hopSet




local bx










local by
local bz=0



local bA
spawnLoop(function()
while not _apelStopped do
task.wait(1)






if S.testWalk and not S.testArena then
ag.Refresh()
end

if S.testArena then






if ae.Running()then af.Refresh(ae.Ground())end










local bB=tostring(aa.Name())
local bC=workspace:FindFirstChild"dungeon"
if bB:lower():find("desert temple",1,true)
and bC and bA~=bC
then






ae.Stop()
local bD,bE=ae.Build()







if bD then
bA=bC

af.Rebuild(ae.Ground())
end
if bx then
bx:Set(bD
and("Map rebuilt on "..bB..", "..tostring(bE).." parts")
or("Rebuild waiting: "..tostring(bE)))
end
end
end
end
end)

local bB,bC
local bD=false
local bE,bF=0,0
local bG=false

local bH

local B=0












local C=0.35












local D,E,F=0
local G=0

local H=0












local I,J,K
local L,M=0,0

local function watchDamage(N)
if J==N and I then return end
if I then I:Disconnect()I=nil end
J,K=N,N.Health
I=regConn(N.HealthChanged:Connect(function(O)
local P=K or O
K=O
if O>=P then return end
local Q=ab.HRP()
if not Q then return end

local R=ad.ZoneAt(Q.Position,1.5)~=nil
if R then M=M+1 else L=L+1 end

local T=-1
if bB and bB.Parent then
local U=aa.PivotOf(bB)
if U then
T=(Vector3.new(U.X,0,U.Z)
-Vector3.new(Q.Position.X,0,Q.Position.Z)).Magnitude
end
end
("s52")
:format(P-O,R and"s53"or"s54",T,M,L)




local U=ad.NearestZones(Q.Position,3)
if type(U)=="table"then
for V,W in ipairs(U)do local X=
type(W)=="table"and(W.text or tostring(W.gap))or tostring(W)

end
end
end))
end local

N, O=0






local function tryHop(P,Q,R)


r=r*0.98+(Q and 0.02 or 0)
if Q then
if o==0 then
o=P



if ai.enabled and p>0 then

end
end
else

if o>0 and ai.enabled and p<o
and(P-o)<a_ then

end
o=0
end

















local T,U=math.huge
for V,W in ipairs(bo)do
local X=ar[W.Name]
if X and W.Parent then
local Y=aa.PivotOf(W)
if Y then
local Z=(Vector3.new(Y.X,0,Y.Z)
-Vector3.new(R.Position.X,0,R.Position.Z)).Magnitude
if Z<X and Z<T then U,T=Y,Z end
end
end
end

local V=S.testHop and Q and o>0
and(P-p)>aR
and P>=u


local W=false
if not V and U and S.testHop and not Q
and(P-p)>aY and P>=u then
local X=0
for Y,Z in ipairs(s)do
if P-Z<=aW then X=X+1 end
end
if X<=(aV-aZ)then
V,W=true,true
end
end




if V then
while s[1]and(P-s[1])>aW do
table.remove(s,1)
end
local X=0
for Y,Z in ipairs(s)do
if P-Z<=aU then X=X+1 end
end

local Y
if X>=aT then
Y=("s55"):format(X,aU)
elseif#s>=aV then
Y=("s56"):format(#s,aW)
end
if Y then
V=false
if ai.enabled and(P-j)>2 then
j=P

end
end
end
if not V then return end

local X,Y=hopSpotDeep(R.Position,true)












if U then
local Z=Vector3.new(U.X,0,U.Z)
local _,bI=T
for bJ=aQ,6,-2 do
for bK=1,16 do
local bL=(bK/16)*math.pi*2
local bM=R.Position.X+math.cos(bL)*bJ
local bN=R.Position.Z+math.sin(bL)*bJ
local bO=floorAt(bM,bN,R.Position.Y)
if bO then
local bP=Vector3.new(bM,bO+aA,bN)
local bQ=(Vector3.new(bM,0,bN)-Z).Magnitude
if bQ>_ and ad.IsSafe(bP,aE)
and not ag.InNoGo(bP)and Plan().Clear(R.Position,bP)then
bI,_=bP,bQ
end
end
end
end
if bI then
X,Y=bI,0
if ai.enabled and(P-n)>2 then
n=P

end
elseif W then

return
end
end

















local bI
if not X and(P-v)>a1 then
X=leastThreat(R.Position)
if X then bI,v=true,P end
end
if not X then
if ai.enabled then

end
return
end local bJ=



(Vector3.new(X.X,0,X.Z)
-Vector3.new(R.Position.X,0,R.Position.Z)).Magnitude local bK=
P-o


local bL=R.Position
R.CFrame=CFrame.new(X)*(R.CFrame-R.CFrame.Position)
R.AssemblyLinearVelocity=Vector3.zero
R.AssemblyAngularVelocity=Vector3.zero
p,o=P,0
s[#s+1]=P
if ad.NoteHop then ad.NoteHop()end
x,w,y=X,P,ad.ZoneAt(bL,0)



if ai.enabled then
local bM=X
task.delay(aS,function()
local bN=ab.HRP()
if not bN then return end
local bO=(Vector3.new(bN.Position.X,0,bN.Position.Z)
-Vector3.new(bL.X,0,bL.Z)).Magnitude
local bP=(Vector3.new(bN.Position.X,0,bN.Position.Z)
-Vector3.new(bM.X,0,bM.Z)).Magnitude
if bO<3 and bP>4 then

u=os.clock()+a0

end
end)
end
q=q+1
if ai.enabled then

end
end

regConn(aj.Heartbeat:Connect(function()
if _apelStopped or not S.testWalk then return end

local bI,bK=ab.HRP(),ab.Humanoid()
if not bI or not bK or not ab.Alive()then return end
watchDamage(bK)






















local bL=(bB and ay[bB.Name])and ax or az
if bK.WalkSpeed~=bL then bK.WalkSpeed=bL end







if bK.AutoRotate then bK.AutoRotate=false end











local bM=os.clock()





if showRoute()and bq and(bM-e)>0.2 then
e=bM
drawRoute(bI.Position,(Plan().Path(bI.Position,bq)))
end

if showZones()and(bM-c)>0.1 then
c=bM
drawZones(bI.Position)
end

if by and(bM-bz)>0.5 then
bz=bM








if ad.Enabled()then
by:Set("Signal: "..ah.Stats())
else
by:Set("Signal: "..ah.Stats()
.." | DODGE OFF — turn on Auto Dodge, nothing is dodged")
end
end











if not bB or not bB.Parent or(bM-bE)>bk then
bE=bM
bB=aa.Nearest(bI.Position)













if not S.testArena and ag.Ready()then






































local bN=60
local bO=25
local bP,bQ,P=math.huge,math.huge
local Q=0
local R,T=math.huge
local U=aa.AllAlive()



local V={}
for W,X in ipairs(U)do
local Y=aa.PivotOf(X)
V[W]=Y and Vector3.new(Y.X,0,Y.Z)or nil
end
for W,X in ipairs(U)do
local Y=aa.PivotOf(X)
if Y and V[W]and ag.Reachable(Y,3)then
local Z=(Y-bI.Position).Magnitude
local _=0
for bR=1,#U do
if bR~=W and V[bR]
and(V[bR]-V[W]).Magnitude<=bN then
_=_+1
end
end
local bR=Z+_*bO
if bR<bQ then
P,bP,bQ=X,Z,bR
Q=_
end
if ar[X.Name]and Z<=aq and Z<R then
T,R=X,Z
end
end
end
if T then P,bP,Q=T,R,-1 end














local bR,W=math.huge
for X,Y in ipairs(U)do
if Y.Name=="Northern Warrior"and V[X]then
local Z=aa.PivotOf(Y)
if Z and ag.Reachable(Z,3)then
local _=(Z-bI.Position).Magnitude
if _<bR then W,bR=Y,_ end
end
end
end
if W then P,bP,Q=W,bR,-1 end
if ai.enabled and P and(bM-a8)>2 then
a8=bM

end
if P then
bB=P
bD=false
else




bD=true
end
end






bo={}
local bN=Vector3.new(bI.Position.X,0,bI.Position.Z)
for bO,bP in ipairs(aa.AllAlive())do
local bQ=aa.PivotOf(bP)
if bQ and(Vector3.new(bQ.X,0,bQ.Z)-bN).Magnitude<=aN then
bo[#bo+1]=bP
end
end
end
if not bB then







local bN=os.clock()
local bO=not ad.IsSafe(bI.Position,aB)
or not ad.BoxSafe(bI.Position)
if bO then









local bP=ad.EscapeStep(bI.Position,aB,aC)





if bP and not ad.BoxSafe(bP)then bP=nil end
if not bP then
for bQ,bR in ipairs{6,10,14}do
for P=0,15 do
local Q=P*math.pi/8
local R=Vector3.new(
bI.Position.X+math.cos(Q)*bR,
bI.Position.Y,
bI.Position.Z+math.sin(Q)*bR)
if ad.BoxSafe(R)and ad.IsSafe(R,0)then
bP=R
break
end
end
if bP then break end
end
if bP and ai.enabled and(bN-a9)>1 then
a9=bN

end
end
if bP then bK:MoveTo(bP)end
if bx then bx:Set"No mob nearby — stepping out of an attack"end
else
if bx then bx:Set"No mob nearby"end
end
tryHop(bN,bO,bI)
bq=nil
clearMarks()
return
end

local bN=aa.PivotOf(bB)
if not bN then return end



local bO=ap[bB.Name]
if bO and not ag.HeightAt(bO)then bO=nil end
if bO and(bM-h)>5 and ai.enabled then
h=bM

end



local bP=Vector3.new(bN.X,bI.Position.Y,bN.Z)
if(bP-bI.Position).Magnitude>0.1 then
bI.CFrame=CFrame.new(bI.Position,bP)
end






















local bQ=not ad.IsSafe(bI.Position,aB)
or not ad.BoxSafe(bI.Position)













local bR=ad.IsSafe(bI.Position,aF)



if bQ then
if o==0 then o=bM end
else
o=0
end

















if not bO then tryHop(bM,bQ,bI)end










local P=(Vector3.new(bN.X,0,bN.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude







local Q=mobPoints()
local R=P
do
local T=Vector3.new(bI.Position.X,0,bI.Position.Z)
for U,V in ipairs(Q)do
local W=(V-T).Magnitude
if W<R then R=W end
end
end








local T=0
if O then
local U=bM-N
if U>0.01 then T=(O-R)/U end
end
if not O or(bM-N)>0.05 then
O,N=R,bM
end


local U=math.huge
if T>0.5 then U=(R-am)/T end












local V=am+an+10



local W,X=true
for Y,Z in ipairs(aa.AllAlive())do
local _=aa.PivotOf(Z)
if _ then
local bS=(Vector3.new(_.X,0,_.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude
if bS<=R+1 then
X=X or Z.Name
if not as[Z.Name]then W=false break end
end
end
end




















local bS=am
for Y,Z in ipairs(aa.AllAlive())do
local _=ar[Z.Name]
if _ and _>bS then
local bT=aa.PivotOf(Z)
if bT then
local bU=(Vector3.new(bT.X,0,bT.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude
if bU<_ then bS=_ end
end
end
end
if X and(ar[X]or 0)>bS then
bS=ar[X]
end
local bT=bS+an



















if bG then
if R>=bT or W then bG=false end
elseif not W
and(R<bS or(U<aw and R<V))then
bG=true
end









local bU=bG and bT or am
local Y=bB and ad.HazardRadius and ad.HazardRadius(bB)
if Y and Y+aE>bU then
bU=Y+aE
end
local Z=bB and ar[bB.Name]
if Z and Z>bU then bU=Z end








if bQ then end


bj=bj%128+1
bg[bj],bh[bj],bi[bj]=bI.Position,bM,bQ
local _,bV,bW=false
for bX=1,128 do
local bY=bh[bX]
if bY and(bM-bY)<=0.5 then
if not bW or bY<bW then bV,bW=bg[bX],bY end
if bi[bX]then _=true end
end
end
local bX=false
if bV and bW and(bM-bW)>0.4 and _ then
local bY=(Vector3.new(bI.Position.X,0,bI.Position.Z)
-Vector3.new(bV.X,0,bV.Z)).Magnitude
bX=bY<2
if bX and ai.enabled and(bM-be)>1 then
be=bM

end
end


if bQ then
if bd==0 then
bd,bf=bM,bI.Position
elseif(bM-bd)>0.4 and bf then
local bY=(Vector3.new(bI.Position.X,0,bI.Position.Z)
-Vector3.new(bf.X,0,bf.Z)).Magnitude
if bY<1.5 and ai.enabled and(bM-be)>1 then
be=bM local bZ=
bq and(Vector3.new(bq.X,0,bq.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude or-1

end
end
else
bd,bf=0,nil
end
if ai.enabled and(bM-bc)>30 then
bc=bM
local bY={}
for bZ,b_ in pairs(bb)do bY[#bY+1]=("%s=%d"):format(bZ,b_)end
table.sort(bY)
if#bY>0 then

end
bb={}
end

if(bQ or not bR)and ai.enabled and(bM-f)>1 then
f=bM



table.sort(bv,function(bY,bZ)return bY.score>bZ.score end)
local bY={}
for bZ=1,math.min(5,#bv)do
bY[#bY+1]=("%d@%.0f"):format(bv[bZ].score,bv[bZ].far)
end
if#bY>0 then

end


end












if not S.testArena then

if E then






local bY
if typeof(F)=="Instance"then
bY=not F.Parent or not ad.IsZone(F)
else

bY=not bQ
end







local bZ=false
if typeof(F)=="Instance"then
local b_=F.Parent
local b0=tostring(b_ and b_.Name or F.Name):lower()
bZ=ad.NamedZoneAt(E,0,b0)and true or false
end
















if bY or bQ or(bM-D)>aJ or bZ then
if ai.enabled then

end
E,F=nil,nil
end
end
















local bY=am+an
local bZ=Vector3.new(bN.X,0,bN.Z)
local b_=E
and(Vector3.new(E.X,0,E.Z)-bZ).Magnitude>bY

if bQ and(not E or b_)
and(not bq or not ad.IsSafe(bq,0))
and(bM-G)>aM then
G=bM












local function pick(b0,b1,b2)
return ag.NearestWhere(bI.Position,aI,function(b3)
if not ad.IsSafe(b3,b0)then return false end
if b1 and not ag.RoomAt(b3,aG)then return false end
if b2 and(Vector3.new(b3.X,0,b3.Z)-bZ).Magnitude>bY then
return false
end
return true
end)
end

local b0=pick(aE,true,true)
or pick(aF,true,false)
or pick(aE,false,false)
or pick(0,false,false)


local b1=b0

if b1 and ag.Path(bI.Position,b1)then

E,D=b1,bM
F=ad.ZoneAt(bI.Position,0)or F
if ai.enabled then

end
elseif b1 and ai.enabled then

end
end
end

local bY=false
if not bQ then bH=nil end



if bO then
bq,H,bF,bC=bO,bM,bM,bN
bY=true
if bQ then end
bH,E,F=nil,nil,nil
elseif E then


bq,H,bF,bC=E,D,bM,bN
bY=true
if bQ then end
end













if bQ and bH then
local bZ=(Vector3.new(bH.X,0,bH.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude<=a5
local b_=(bM-B)>C
if bZ or not Plan().Clear(bI.Position,bH)
or not legOut(bI.Position,bH)
or(b_ and not ad.IsSafe(bH,aB))then
bH=nil
else
bq,bF,bC=bH,bM,bN
bY=true

end
end

if bQ and not bY then





local bZ=ad.EscapeStep(bI.Position,aB,aC)
local b_=false
















if r>a7 then
local b0,b1=Vector3.zero,0
for b2,b3 in ipairs(ad.ZoneShapes(bI.Position,60,0)or{})do
local b4=b3.cf and b3.cf.Position
if b4 then
b0,b1=b0+Vector3.new(b4.X,0,b4.Z),b1+1
end
end
if b1>0 then
local b2=b0/b1
local b3=Vector3.new(bI.Position.X,0,bI.Position.Z)
local b4,b5=(b3-b2).Magnitude
for b6=aQ,6,-2 do
for b7=1,16 do
local b8=(b7/16)*math.pi*2
local b9=bI.Position.X+math.cos(b8)*b6
local ca=bI.Position.Z+math.sin(b8)*b6
local cb=(Vector3.new(b9,0,ca)-b2).Magnitude
if cb>b4 then
local cc=floorAt(b9,ca,bI.Position.Y)
if cc then
local cd=Vector3.new(b9,cc+aA,ca)
if not ag.InNoGo(cd)and Plan().Clear(bI.Position,cd)
and ad.IsSafe(cd,0)then
b5,b4=cd,cb
end
end
end
end
end
if b5 then
bZ,b_=b5,true
if ai.enabled and(bM-m)>2 then
m=bM

end
end
end
end



























if bZ then













local b0=Vector3.new(bZ.X-bI.Position.X,0,bZ.Z-bI.Position.Z)
if b0.Magnitude>0.1 and not ad.IsSafe(bZ,aF)then
for b1,b2 in ipairs{4,8,12}do
local b3=bZ+b0.Unit*b2
local b4=floorAt(b3.X,b3.Z,bZ.Y)
if b4 then
local b5=Vector3.new(b3.X,b4+aA,b3.Z)
if ad.IsSafe(b5,aF)and not ag.InNoGo(b5)
and Plan().Clear(bI.Position,b5)then
bZ=b5
break
end
end
end
end

local b1
for b2,b3 in ipairs{aF,2,0}do
if ad.IsSafe(bZ,b3)then b1=b3 break end
end

























if not b_ and(not b1 or b1<aF)
and(bM-l)>0.3 then
l=bM




local b2,b3,b4=math.huge
for b5,b6 in ipairs{aF,2}do
for b7=6,aQ,2 do
for b8=1,16 do
local b9=(b8/16)*math.pi*2
local ca=bI.Position.X+math.cos(b9)*b7
local cb=bI.Position.Z+math.sin(b9)*b7
local cc=floorAt(ca,cb,bI.Position.Y)
if cc then
local cd=Vector3.new(ca,cc+aA,cb)
if b7<b2 and ad.IsSafe(cd,b6)
and not ag.InNoGo(cd)
and Plan().Clear(bI.Position,cd)then
b3,b2,b4=cd,b7,b6
end
end
end
if b3 then break end
end
if b3 then break end
end
if b3 then
bZ,b1=b3,b4
if ai.enabled and(bM-k)>1 then
k=bM

end
end
end

if not b1 then bZ=nil end
if bZ and ai.enabled and b1<aF and(bM-k)>1 then
k=bM

end
end







if not bZ then
local b0=ad.ZoneAt(bI.Position,0)




local b1=(typeof(b0)=="Instance"and b0:IsA"BasePart")and b0 or nil
local b2
if b1 then b2=b1.Position
elseif typeof(b0)=="table"and b0.cf then b2=b0.cf.Position
elseif typeof(b0)=="Instance"and b0:IsA"Model"then
local b3,b4=pcall(function()return b0:GetPivot().Position end)
b2=b3 and b4 or nil
end
if b2 then












local b3=b1 and b1.Size or(typeof(b0)=="table"and b0.size or nil)
local b4=b1 and b1.CFrame or(typeof(b0)=="table"and b0.cf or nil)
local b5,b6
local b7=Vector3.new(bI.Position.X-b2.X,0,bI.Position.Z-b2.Z)
local b8=b3 and math.abs(b3.Z-b3.Y)<1 and b3.X<=8
if b3 and b4 and not b8 then
local b9=b4:PointToObjectSpace(bI.Position)
local ca,cb=b3.X*0.5,b3.Z*0.5

if(ca-math.abs(b9.X))<=(cb-math.abs(b9.Z))then
b5=b4.RightVector*(b9.X>=0 and 1 or-1)
b6=ca
else
b5=b4.LookVector*(b9.Z>=0 and 1 or-1)
b6=cb
end
b5=Vector3.new(b5.X,0,b5.Z)
end
if not b5 or b5.Magnitude<0.1 then
b5=b7
b6=b3 and math.max(b3.X,b3.Z)*0.5 or 17
end
if b5.Magnitude<0.5 then
b5=Vector3.new(bI.CFrame.LookVector.X,0,bI.CFrame.LookVector.Z)
end
if b5.Magnitude>0.1 then
local b9=Vector3.new(b2.X,0,b2.Z)+b5.Unit*((b6 or 17)+6)
local ca=floorAt(b9.X,b9.Z,bI.Position.Y)
if ca then
local cb=Vector3.new(b9.X,ca+aA,b9.Z)
if not ag.InNoGo(cb)and Plan().Clear(bI.Position,cb)then
bZ=cb
if ai.enabled and(bM-k)>1 then
k=bM

end
end
end
end
end
end









if bZ then
local b0=Vector3.new(bZ.X,0,bZ.Z)
local b1=Vector3.new(bN.X,0,bN.Z)
if(b0-b1).Magnitude<aD then
local b2=b0-b1
if b2.Magnitude<0.1 then
b2=Vector3.new(bI.Position.X-bN.X,0,bI.Position.Z-bN.Z)
end
if b2.Magnitude>0.1 then
local b3=b1+b2.Unit*aD
local b4=Vector3.new(b3.X,bZ.Y,b3.Z)
if ad.IsSafe(b4,aB)and Plan().Clear(bI.Position,b4)then
bZ=b4
end
end
end
end


















if bZ and ad.BoxSafe(bZ)and not ad.RoomSafe(bZ,2.5)then
local b0
for b1,b2 in ipairs{3,2,1}do
local b3=ad.EscapeStep(bI.Position,aB,aC+b2)
if b3 and ad.BoxSafe(b3)and ad.RoomSafe(b3,b2)then
b0=b3
break
end
end
if b0 then
bZ=b0
if ai.enabled and(bM-ba)>2 then
ba=bM

end
end
end
if bZ and Plan().Clear(bI.Position,bZ)and legOut(bI.Position,bZ)
and ad.BoxSafe(bZ)then
bq,bF,bC=bZ,bM,bN
bH,B,bY=bZ,bM,true
elseif bZ and ai.enabled and(bM-ba)>1 then
ba=bM

end
end


















local bZ=false
if bq and not bY then
local b_=(Vector3.new(bq.X,0,bq.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude<=a5







local b0=false
for b1,b2 in ipairs(Q)do
if(Vector3.new(bq.X,0,bq.Z)-b2).Magnitude<aD then
b0=true break
end
end
























local b1=(bM-H)<a6
bZ=not b_
and not b0
and Plan().Clear(bI.Position,bq)
and(bM-H)<aH
and legClear(bI.Position,bq)
and(b1 or ad.IsSafe(bq,aB))


and not bQ
end



if x then









local b_
if typeof(y)=="Instance"then
b_=not y.Parent or not ad.IsZone(y)
else
b_=not bQ
end















if bQ or not ad.IsSafe(x,aB)or(bM-w)>a2 then
x,y=nil,nil
elseif b_ then
x,y=nil,nil
else
bq,H,bY=x,w,true
if bQ then end
if ai.enabled and(bM-i)>2 then
i=bM

end
end
end



















if not bY and not bZ then
bF,bC=bM,bN


local b_=pickSpot(bN,bQ or not bR,bU,bQ or bG or not bR)




















if b_ and ad.BoxSafe(b_)and not ad.RoomSafe(b_,2.5)then
local b0=pickSpot(bN,true,bU,true)
if b0 and ad.RoomSafe(b0,2.5)then b_=b0 end
end
if b_ and not ad.BoxSafe(b_)then
if ai.enabled and(bM-a9)>1 then
a9=bM

end
b_=nil
end
if b_ then
bq,H=b_,bM
if bQ then end
elseif bQ then
bq=nil
if ai.enabled and(bM-a9)>1 then
a9=bM

end
end
end





local b_=getgenv().ApelHub
if b_ then
b_.TestBrain={
hurt=bQ,roomy=bR,backing=bG,
mobDist=P,mob=bB and bB.Name or nil,
here=bI.Position,goal=bq,ring=bU,
escaped=bY,fleeTo=bH,
pick={
total=bu.total,unsafe=bu.unsafe,
blocked=bu.blocked,tight=bu.tight,
close=bu.close,crossed=bu.crossed,
best=bu.best,picked=bu.picked,
at=bu.at,
},
}
end




























if not bq and bQ then
local b0
for b1,b2 in ipairs{6,10,14}do
for b3=0,15 do
local b4=b3*math.pi/8
local b5=Vector3.new(
bI.Position.X+math.cos(b4)*b2,
bI.Position.Y,
bI.Position.Z+math.sin(b4)*b2)
if ad.BoxSafe(b5)and ad.IsSafe(b5,0)
and Plan().Clear(bI.Position,b5)then
b0=b5
break
end
end
if b0 then break end
end
if b0 then
bq=b0
if ai.enabled and(bM-a9)>1 then
a9=bM

end
end
end

if not bq then






bK:MoveTo(bI.Position)
clearRoute()
if ai.enabled and(bM-a9)>1 then
a9=bM

end
if bx then bx:Set"Nowhere clean to stand"end
return
end

local b0=(Vector3.new(bq.X,0,bq.Z)
-Vector3.new(bI.Position.X,0,bI.Position.Z)).Magnitude













local b1,b2=bB,P
if E then
local b3=Vector3.new(bI.Position.X,0,bI.Position.Z)
for b4,b5 in ipairs(bo)do
local b6=aa.PivotOf(b5)
if b6 then
local b7=(Vector3.new(b6.X,0,b6.Z)-b3).Magnitude
if b7<b2 then b1,b2=b5,b7 end
end
end
if b1~=bB then
local b4=aa.PivotOf(b1)
local b5=b4 and Vector3.new(b4.X,bI.Position.Y,b4.Z)
if b5 and(b5-bI.Position).Magnitude>0.1 then
bI.CFrame=CFrame.new(bI.Position,b5)
end
if ai.enabled and(bM-g)>1 then
g=bM

end
end
end









local b3=ad.HazardRadius and ad.HazardRadius(b1)or nil




local b4=math.max(am+an,(b3 or 0)+6,
(ar[b1.Name]or 0)+4)











if b2<=b4 or(bO and b0<=a5)then
ac.Swing()
end







if ad.IsSafe(bI.Position,0)then
ac.CastReady(b1,tonumber(S.castReach)or 0,{})
end




















local b5=not ad.RoomSafe(bI.Position,2.5)
if b5 and ai.enabled and(bM-b)>2 then
b=bM

end
if b0<=a5 and(bO or E or x
or(not bQ and bR and not bG and not b5))then
bK:MoveTo(bI.Position)
clearRoute()
if bx then
bx:Set(("Fighting %s — %.0f studs"):format(bB.Name,P))
end
return
end





local b6,b7=Plan().Step(bI.Position,bq)
if b6 then
bK:MoveTo(b6)
if bx then
bx:Set(("Running to %s — %.0f studs (%s)"):format(bB.Name,b0,b7))
end
elseif S.testArena then



bK:MoveTo(bq)
if bx then
bx:Set(("Running to %s — %.0f studs (%s)")
:format(bB.Name,b0,b7 or"direct"))
end
else








if bQ then
local b8
for b9,ca in ipairs{6,10,14}do
for cb=0,15 do
local cc=cb*math.pi/8
local cd=Vector3.new(
bI.Position.X+math.cos(cc)*ca,
bI.Position.Y,
bI.Position.Z+math.sin(cc)*ca)
if ad.BoxSafe(cd)and ad.IsSafe(cd,0)then
b8=cd
break
end
end
if b8 then break end
end
if b8 then
bK:MoveTo(b8)
if ai.enabled and(bM-a9)>1 then
a9=bM

end
if bx then bx:Set"Dodging without route"end
return
end
end









bK:MoveTo(bI.Position)
clearRoute()
if bx then
bx:Set(("No route to %s — %.0f studs (%s)")
:format(bB.Name,b0,b7 or"no path"))
end
end
end))
end end function a.P():typeof(__modImpl())local aa=a.cache.P if not aa then aa={c=__modImpl()}a.cache.P=aa end return aa.c end end do local function __modImpl()













local aa={}

function aa.At(ab,ac,ad)
ab=tonumber(ab)or 0
ac=tonumber(ac)or 0
ad=tonumber(ad)or 0
if ad<=ac then return ab end

local ae,af=ab,ac
while ae<200 and af<ad do
if ae<20 then
ae=ae+1
else
ae=ae+math.floor(ae/20)
end
af=af+1
end
return ae+(ad-af)*10
end



function aa.OfItem(ab,ac)
if type(ab)~="table"then return 0 end
return aa.At(ab[ac],ab.currentUpgrade,ab.maxUpgrades)
end

return aa end function a.Q():typeof(__modImpl())local aa=a.cache.Q if not aa then aa={c=__modImpl()}a.cache.Q=aa end return aa.c end end do local function __modImpl()








local aa=a.m()
local ab=a.n()
local ac=a.Q()

local ad={}



function ad.Interactables()
local ae=workspace:FindFirstChild"Lobby"
local af=ae and ae:FindFirstChild"Map"
return af and af:FindFirstChild"Interactables"or nil
end

function ad.Part(ae)
local af=ad.Interactables()
local ag=af and af:FindFirstChild(ae)
return(ag and ag:IsA"BasePart")and ag or nil
end





function ad.StepOn(ae)
local af=ab.HRP()
if not af or not ae then return false end
af.CFrame=CFrame.new(ae.Position+Vector3.new(0,3.5,0))
if type(firetouchinterest)=="function"then
pcall(function()
firetouchinterest(af,ae,0)
task.wait(0.05)
firetouchinterest(af,ae,1)
end)
end
return true
end




function ad.OpenBlacksmithUi()
local ae=LocalPlayer:FindFirstChild"PlayerGui"
if not ae then return false,"no PlayerGui"end
local af=ReplicatedStorage:FindFirstChild"ui"
local ag=af and af:FindFirstChild"blacksmith"
if not ag then return false,"this place has no blacksmith UI"end








local ah=ae:FindFirstChild"blacksmith"
if ah then pcall(function()ah:Destroy()end)end

local ai=pcall(function()
local ai=ag:Clone()
if ai:IsA"ScreenGui"then ai.Enabled=true end
ai.Parent=ae
end)
return ai,ai and"opened"or"could not open"
end







function ad.OpenSellUi()
local ae=LocalPlayer:FindFirstChild"PlayerGui"
if not ae then return false,"no PlayerGui"end
local af=ae:FindFirstChild"sellShop"
if not af then return false,"this place has no sell UI"end








local ag=LocalPlayer:FindFirstChild"PlayerScripts"
local ah=ag and ag:FindFirstChild"Ui"
local ai=ah and ah:FindFirstChild"sellShop"
if ai then
local aj,ak=pcall(require,ai)
if aj and type(ak)=="table"and type(ak.Open)=="function"then
local al=pcall(ak.Open)
if al then return true,"opened"end
end
end


local aj=af:FindFirstChild"Frame"
if not aj then return false,"sell UI has no Frame"end
local ak=pcall(function()
if af:IsA"ScreenGui"then af.Enabled=true end
aj.Visible=true
end)
return ak,ak and"s124"or"could not open"
end






function ad.Sell(ae)
local af={weapon={},ability={},chest={},helmet={}}
local ag=0
for ah,ai in ipairs(ae or{})do
local aj=af[ai.type]
if aj then
aj[#aj+1]=ai.num
ag=ag+1
end
end
if ag==0 then return 0 end
aa.Fire("sellItemEvent",af)
ab.InvalidateInventory()
return ag
end








function ad.SellCandidates(ae)
ae=ae or{}
local af=ae.mode or"Rarity"
local ag=ae.rarities or{}
local ah=ae.categories or{}
local ai=ae.hold or{}
local aj=tonumber(ae.maxLevel)or 0








local ak=next(ah)==nil

local al=ab.Items(true)
local am={}













local an=ae.keepUpgraded~=false

if ae.keepBest then
local ao={weapon=true,helmet=true,chest=true}
local ap={"physicalDamage","physicalPower","spellPower","health"}



















local aq={}
for ar,as in ipairs(al)do
local au=(tonumber(as.data.currentUpgrade)or 0)>0
if ao[as.type]and not as.equipped
and not(an and au)then
for av,aw in ipairs(ap)do
local ax=tonumber(as.data[aw])
if ax then
local ay=as.type.."/"..aw
local az=aq[ay]
if not az or ax>(tonumber(az.data[aw])or 0)then
aq[ay]=as
end
end
end
end
end
for ar,as in pairs(aq)do am[as.key]=true end
end

local ao={}
for ap,aq in ipairs(al)do
local ar=(tonumber(aq.data.currentUpgrade)or 0)>0
if not aq.equipped and not am[aq.key]and not ai[aq.name]
and not(an and ar)
and(ak or ah[aq.type])then
local as=ag[aq.rarity]==true
local au=aj>0 and(tonumber(aq.data.levelReq)or 0)<aj

local av
if af=="Level"then av=au
elseif af=="Both"then av=as and au
else av=as end

if av then ao[#ao+1]=aq end
end
end
return ao
end


function ad.OwnedNames()
local ae,af={},{}
for ag,ah in ipairs(ab.Items())do
if not ae[ah.name]then ae[ah.name]=true;af[#af+1]=ah.name end
end
table.sort(af)
return af
end





function ad.Equip(ae,af)
if af then
return(aa.Invoke("equipItem",ae.type,ae.num,af))
end
return(aa.Invoke("equipItem",ae.type,ae.num))
end

function ad.Unequip(ae)
return(aa.Invoke("unequipItem",ae.type,ae.num))
end



ad.EQUIP_STATS={["Spell Power"]="spellPower",["Physical Damage"]="physicalDamage"}



ad.ARMOR_STATS={Health=
"health",
["Spell Power"]="spellPower",
["Physical Power"]="physicalPower",
}
ad.ARMOR_SLOTS={"helmet","chest"}






local function scoreOf(ae,af,ag)
if ag then return ac.OfItem(ae,af)end
return tonumber(ae[af])or 0
end

function ad.BestWeapon(ae,af)
local ag=ad.EQUIP_STATS[ae]or"spellPower"
local ah=ab.Level()
local ai,aj,ak=(-1)

for al,am in ipairs(ab.Items())do
if am.type=="weapon"then
local an=tonumber(am.data.levelReq)or 0
local ao=scoreOf(am.data,ag,af)
if am.equipped then ak=am end
if an<=ah and ao>ai then aj,ai=am,ao end
end
end
return aj,ak,ai
end



function ad.BestArmor(ae,af,ag)
local ah=ad.ARMOR_STATS[af]or"health"
local ai=ab.Level()
local aj,ak,al=(-1)

for am,an in ipairs(ab.Items())do
if an.type==ae then
local ao=tonumber(an.data.levelReq)or 0
local ap=scoreOf(an.data,ah,ag)
if an.equipped then al=an end
if ao<=ai and ap>aj then ak,aj=an,ap end
end
end
return ak,al,aj
end



function ad.Score(ae,af,ag)
if not ae or not af then return 0 end
return scoreOf(ae.data,af,ag)
end











ad.UPGRADE_STATS={
["Spell Power"]="spell",
["Physical Damage"]="physical",Health=
"health",
}



function ad.UpgradeCost(ae)
ae=math.max(0,math.floor(tonumber(ae)or 0))
if ae==0 then return 100 end
if ae>466 then return 100000 end
local af=100
for ag=1,ae do
if af*1.06+50-af>220 then
af=af+220
else
af=af*1.06+50
end
end
return math.floor(af>100000 and 100000 or af)
end




function ad.AffordableUpgrades(ae,af,ag)
local ah=tonumber(ae.data.currentUpgrade)or 0
local ai=(tonumber(ae.data.maxUpgrades)or 0)-ah
if ag then ai=math.min(ai,ag)end

local aj,ak=tonumber(af)or 0,0
for al=0,ai-1 do
local am=ad.UpgradeCost(ah+al)
if am>aj then break end
aj=aj-am
ak=ak+1
end
return ak
end

function ad.Upgrade(ae,af,ag)
local ah=tonumber(ae.data.currentUpgrade)or 0
local ai=(tonumber(ae.data.maxUpgrades)or 0)-ah
if ai<=0 then return false,"already maxed"end

local aj,ak=1
if ag=="10x"then
aj,ak=10,"10x"
elseif ag=="spendAll"then
aj,ak=ai,"spendAll"
end

local al=ad.AffordableUpgrades(ae,ab.Gold(),aj)
if al<=0 then
return false,("need %d gold"):format(ad.UpgradeCost(ah))
end

aa.Fire("upgradeItem",ae.type,ae.num,af,al,ak)
ab.InvalidateInventory()
return true,("+%d %s"):format(al,af)
end

function ad.EquippedWeapon()
for ae,af in ipairs(ab.Items())do
if af.type=="weapon"and af.equipped then return af end
end
return nil
end









local ae={weapon=1,helmet=2,chest=3}

function ad.EquippedGear()
local af={}
for ag,ah in ipairs(ab.Items())do
if ah.equipped and ae[ah.type]then af[#af+1]=ah end
end
table.sort(af,function(ag,ah)return ae[ag.type]<ae[ah.type]end)
return af
end


function ad.UpgradeTargets(af)
local ag=ad.EquippedGear()
if af~="All"then return ag end

local ah={}
local ai={}
for aj,ak in ipairs(ag)do
ah[#ah+1]=ak
ai[ak]=true
end
for aj,ak in ipairs(ab.Items())do
if not ai[ak]and not ak.equipped and ae[ak.type]
and(tonumber(ak.data.maxUpgrades)or 0)>(tonumber(ak.data.currentUpgrade)or 0)then
ah[#ah+1]=ak
end
end
return ah
end




ad.SKILL_STATS={
["Spell Power"]="spellPower",
["Physical Power"]="physicalPower",Stamina=
"stamina",
}

function ad.SpendSkill(af,ag)
local ah=math.max(1,math.floor(tonumber(ag)or 1))
return aa.Fire("spendSkillPoint",af,ah)
end

function ad.ResetSkills()
return aa.Fire"resetSkillPoints"
end

function ad.SwapAbilitySet()
return aa.Fire"swapAbilitySet"
end

return ad end function a.R():typeof(__modImpl())local aa=a.cache.R if not aa then aa={c=__modImpl()}a.cache.R=aa end return aa.c end end do local function __modImpl()










local aa=a.n()
local ab=a.R()
local ac=a.m()



local ad={Weapons=
"weapon",Abilities=
"ability",Helmets=
"helmet",Chests=
"chest",
}



local function plain(ae)
local af=tostring(ae):gsub("<[^>]->","")
return(af:gsub("^%s+",""):gsub("%s+$",""))
end

local function rarityOptions()
local ae={}
for af,ag in ipairs(aa.RARITIES)do
ae[#ae+1]=('<font color="%s">%s</font>'):format(aa.RARITY_COLOR[ag]or"#FFFFFF",ag)
end
return ae
end

return function(ae)
local af=ae.Sell
local ag=ae.Equip
local ah=ae.Smith
local ai=ae.Skills



local function sellOpts()
return{
mode=S.sellMode,
rarities=S.sellRarities or{},
categories=S.sellCategories or{},
hold=S.sellHold or{},
maxLevel=S.sellBelowLevel,
keepBest=S.sellKeepBest,
keepUpgraded=S.sellKeepUpgraded~=false,
}
end

af:Dropdown{
Name="Sell By",
Desc="Rarity uses the rarity list, Level dumps gear you have outgrown, Both needs the two to agree",
Options={"Rarity","Level","Both"},
Default="Rarity",
Flag="SellMode",
Callback=function(aj)S.sellMode=aj end,
}

af:Dropdown{
Name="Sell Rarities",
Desc="nothing is sold while this is empty and the mode uses rarity",
Options=rarityOptions(),Multi=true,
Flag="SellRarities",
Callback=function(aj)
local ak={}
for al,am in pairs(aj or{})do
if am then ak[plain(al)]=true end
end
S.sellRarities=ak
end,
}

af:Slider{
Name="Sell Below Level",
Desc="sells items whose level requirement is under this — set it to your own level to dump outgrown gear",
Default=1,Min=1,Max=250,Decimals=0,
Flag="SellBelowLevel",
Callback=function(aj)S.sellBelowLevel=aj end,
}

af:Dropdown{
Name="Sell Categories",
Desc="leave empty to allow every category",
Options={"Weapons","Abilities","Helmets","Chests"},Multi=true,
Flag="SellCategories",
Callback=function(aj)
local ak={}
for al,am in pairs(aj or{})do
if am and ad[al]then ak[ad[al] ]=true end
end
S.sellCategories=ak
end,
}

local aj
aj=af:Dropdown{
Name="Hold List",
Desc="items picked here are never sold, whatever the filters say",
Options=ab.OwnedNames(),Multi=true,Search=true,CacheOptions=true,
Flag="SellHold",
Callback=function(ak)
local al={}
for am,an in pairs(ak or{})do if an then al[am]=true end end
S.sellHold=al
end,
}

af:Toggle{
Name="Keep Best Weapon",
Desc="never sell the strongest weapon by spell power or by physical damage",
Default=true,Flag="SellKeepBest",
Callback=function(ak)S.sellKeepBest=ak end,
}

af:Toggle{
Name="Keep Upgraded",
Desc="never sell anything you have poured gold into",
Default=true,Flag="SellKeepUpgraded",
Callback=function(ak)S.sellKeepUpgraded=ak end,
}

af:Button{Name="Open Sell Menu",Text="Open",Callback=function()
local ak,al=ab.OpenSellUi()
Notify(ak and("Sell menu "..tostring(al))or("Could not open — "..tostring(al)))
end}

af:Toggle{
Name="Auto Sell",
Desc="sells everything matching the filters, anywhere — town or dungeon",
Default=false,Flag="AutoSell",
Callback=function(ak)S.autoSell=ak end,
}

local ak=af:Label"Nothing matches the sell filters"

local function sellNow()
local al=ab.SellCandidates(sellOpts())
if#al==0 then return 0 end
return ab.Sell(al)
end

af:Button{Name="Sell Now",Text="Sell",Callback=function()
task.spawn(function()
local al=sellNow()
Notify(al>0 and("Sold %d item%s"):format(al,al==1 and""or"s")
or"Nothing matches the sell filters")
end)
end}

af:Button{Name="Refresh Hold List",Text="Refresh",Callback=function()
task.spawn(function()
aa.InvalidateInventory()
local al=ab.OwnedNames()
pcall(function()aj:SetOptions(al)end)
Notify(("%d item name%s in your inventory"):format(#al,#al==1 and""or"s"))
end)
end}

spawnLoop(function()
while not _apelStopped do
task.wait(3)
pcall(function()
local al=ab.SellCandidates(sellOpts())
local am=0
for an,ao in ipairs(al)do am=am+(tonumber(ao.data.sellPrice)or 0)end
ak:Set(#al==0 and"Nothing matches the sell filters"
or("%d item%s matching · %d gold"):format(#al,#al==1 and""or"s",am))
end)

if S.autoSell and not Window:IsLoadingConfig()then
pcall(sellNow)
end
end
end)



ag:Dropdown{
Name="Weapon By",
Options={"Spell Power","Physical Damage"},
Default="Spell Power",
Flag="EquipBy",
Callback=function(al)S.equipBy=al end,
}

ag:Dropdown{
Name="Armor By",
Desc="Health is the tank pick; the other two scale your damage instead",
Options={"Health","Spell Power","Physical Power"},
Default="Health",
Flag="EquipArmorBy",
Callback=function(al)S.equipArmorBy=al end,
}

ag:Toggle{
Name="Auto Equip Best",
Desc="swaps weapon, helmet and chest to the strongest you can wear at your level",
Default=false,Flag="AutoEquipBest",
Callback=function(al)S.autoEquipBest=al end,
}

ag:Toggle{
Name="Judge By Max Upgrades",
Desc="compares what items will be when fully upgraded, not what they are now",
Default=false,Flag="EquipByPotential",
Callback=function(al)S.equipByPotential=al end,
}

ag:Slider{
Name="Only If Better By",
Desc="how much stronger a candidate must be before it replaces what you wear",
Default=0,Min=0,Max=100,Decimals=0,Suffix="%",
Flag="EquipGainPct",
Callback=function(al)S.equipGainPct=tonumber(al)or 0 end,
}

local al=ag:Label"Equipped: —"










local function worthSwap(am,an,ao)
if not am then return false end
if an and an.key==am.key then return false end
if not an then return true end

local ap=tonumber(S.equipGainPct)or 0
if ap<=0 then return true end

local aq=ab.Score(an,ao,S.equipByPotential)
local ar=ab.Score(am,ao,S.equipByPotential)
if aq<=0 then return true end
return ar>=aq*(1+ap/100)
end

local function equipBest()
local am={}
local an=S.equipByPotential==true

local ao=ab.EQUIP_STATS[S.equipBy]or"spellPower"
local ap,aq=ab.BestWeapon(S.equipBy,an)
if worthSwap(ap,aq,ao)then
ab.Equip(ap)
am[#am+1]=ap.name
end

local ar=ab.ARMOR_STATS[S.equipArmorBy]or"health"
for as,au in ipairs(ab.ARMOR_SLOTS)do
local av,aw=ab.BestArmor(au,S.equipArmorBy,an)
if worthSwap(av,aw,ar)then
ab.Equip(av)
am[#am+1]=av.name
end
end

if#am>0 then aa.InvalidateInventory()end
return am
end

ag:Button{Name="Equip Best Now",Text="Equip",Callback=function()
task.spawn(function()
local am=equipBest()
Notify(#am>0 and("Equipped "..table.concat(am,", "))
or"Already wearing the best you own")
end)
end}

ag:Button{Name="Swap Ability Set",Text="Swap",Callback=function()
ab.SwapAbilitySet()
Notify"Ability set swapped"
end}








local function equipNow()
if not S.autoEquipBest then return end
if Window:IsLoadingConfig()then return end
aa.InvalidateInventory()
pcall(equipBest)
end

for am,an in ipairs{"reloadInventory","updateLocalInventoryTable"}do
ac.OnClient(an,function()task.spawn(equipNow)end)
end

spawnLoop(function()
while not _apelStopped do
task.wait(1)

if S.autoEquipBest and not Window:IsLoadingConfig()then pcall(equipBest)end
end
end)

spawnLoop(function()
while not _apelStopped do
task.wait(4)
pcall(function()local
am, an=ab.BestWeapon(S.equipBy)local
ao, ap=ab.BestArmor("helmet",S.equipArmorBy)local
aq, ar=ab.BestArmor("chest",S.equipArmorBy)
al:Set(("Weapon: <b>%s</b>\nHelmet: %s   ·   Chest: %s"):format(
an and an.name or"—",
ap and ap.name or"—",
ar and ar.name or"—"))
end)
end
end)



ah:Dropdown{
Name="Upgrade",
Desc="Equipped pours gold into what you are wearing; All spreads it over everything unmaxed",
Options={"Equipped","All"},
Default="Equipped",
Flag="UpgradeScope",
Callback=function(an)S.upgradeScope=an end,
}

ah:Dropdown{
Name="Upgrade Stat",
Desc="health cannot be upgraded on a weapon — the game refuses it",
Options={"Spell Power","Physical Damage","Health"},
Default="Spell Power",
Flag="UpgradeStat",
Callback=function(an)S.upgradeStat=ab.UPGRADE_STATS[an]or"spell"end,
}

ah:Dropdown{
Name="Upgrade Amount",
Options={"1x","10x","Spend All"},
Default="Spend All",
Flag="UpgradeMode",
Callback=function(an)
S.upgradeMode=(an=="10x"and"10x")or(an=="Spend All"and"spendAll")or nil
end,
}

ah:Toggle{
Name="Auto Upgrade",
Desc="keeps pouring gold into your gear anywhere, town or dungeon",
Default=false,Flag="AutoUpgrade",
Callback=function(an)S.autoUpgrade=an end,
}

local an=ah:Label"Nothing equipped"


local function upgradeNow()
local ap=ab.UpgradeTargets(S.upgradeScope)
if#ap==0 then return false,"nothing to upgrade"end

local aq,ar=0
for as,au in ipairs(ap)do


local av=S.upgradeStat or"spell"
if av=="health"and au.type=="weapon"then av="spell"end

local aw,ax=ab.Upgrade(au,av,S.upgradeMode)
if aw then aq,ar=aq+1,ax else ar=ax end
task.wait(0.35)
aa.InvalidateInventory()

if not aw and type(ax)=="string"and ax:find"need"then break end
end

if aq>0 then
return true,("%d item%s, last %s"):format(aq,aq==1 and""or"s",tostring(ar))
end
return false,tostring(ar)
end

ah:Button{Name="Upgrade Now",Text="Upgrade",Callback=function()
task.spawn(function()
local ap,aq=upgradeNow()
Notify(ap and("Upgraded — "..tostring(aq))or("Upgrade skipped — "..tostring(aq)))
end)
end}



ah:Button{Name="Open Game Upgrade Menu",Text="Open",Callback=function()
local ap,aq=ab.OpenBlacksmithUi()
Notify(ap and("Blacksmith menu "..tostring(aq))or("Could not open — "..tostring(aq)))
end}

spawnLoop(function()
while not _apelStopped do
task.wait(5)
pcall(function()



local ap={}
for aq,ar in ipairs(ab.EquippedGear())do
local as=tonumber(ar.data.currentUpgrade)or 0
local au=tonumber(ar.data.maxUpgrades)or 0
ap[#ap+1]=as>=au
and("<b>%s</b> — maxed (%d/%d)"):format(ar.name,as,au)
or("<b>%s</b> — %d/%d, next %d gold")
:format(ar.name,as,au,ab.UpgradeCost(as))
end
if#ap>0 then
ap[#ap+1]=("Gold %d"):format(aa.Gold())
an:Set(table.concat(ap,"\n"))
else
an:Set"Nothing equipped"
end
end)


if S.autoUpgrade and not Window:IsLoadingConfig()then
pcall(upgradeNow)
end
end
end)



ai:Dropdown{
Name="Spend Into",
Options={"Spell Power","Physical Power","Stamina"},
Default="Spell Power",
Flag="SkillStat",
Callback=function(ap)S.skillStat=ab.SKILL_STATS[ap]or"spellPower"end,
}

ai:Toggle{
Name="Auto Spend Skill Points",
Desc="spends every point you earn into the stat above",
Default=false,Flag="AutoSkill",
Callback=function(ap)S.autoSkill=ap end,
}

local ap=ai:Label"Points: 0"

ai:Button{Name="Spend All Now",Text="Spend",Callback=function()
task.spawn(function()
local aq=aa.SkillPoints()
if aq<=0 then return Notify"No skill points to spend"end
ab.SpendSkill(S.skillStat or"spellPower",aq)
Notify(("Spent %d point%s"):format(aq,aq==1 and""or"s"))
end)
end}



ai:Button{Name="Reset Skill Points",Text="Reset",Callback=function()
Window:Dialog{
Title="Reset skill points?",
Text="Every point goes back into the pool. Without a free reset the game charges you for it.",
Buttons={
{Name="Cancel"},
{Name="Reset",Primary=true,Callback=function()ab.ResetSkills()end},
},
}
end}

spawnLoop(function()
while not _apelStopped do
task.wait(2)
pcall(function()
ap:Set(("Points: <b>%d</b>   ·   spell %s · physical %s · stamina %s"):format(
aa.SkillPoints(),tostring(aa.Val("spellPower",0)),
tostring(aa.Val("physicalPower",0)),tostring(aa.Val("stamina",0))))
end)

if S.autoSkill and not Window:IsLoadingConfig()then
local aq=aa.SkillPoints()
if aq>0 then pcall(ab.SpendSkill,S.skillStat or"spellPower",aq)end
end
end
end)
end end function a.S():typeof(__modImpl())local aa=a.cache.S if not aa then aa={c=__modImpl()}a.cache.S=aa end return aa.c end end do local function __modImpl()






local aa=a.s()

return function(ab)
local ac=ab.Move

ac:Toggle{
Name="Speed",
Desc="holds your walk speed every frame — the game resets it on its own otherwise",
Default=false,Flag="SpeedOn",
Callback=function(ad)
S.speedOn=ad
if not ad then
local ae=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass"Humanoid"
if ae then ae.WalkSpeed=16 end
end
end,
}




ac:Slider{
Name="Speed Value",Default=20,Min=16,Max=20,Decimals=0,
Desc="twenty is as high as the server accepts",
Flag="SpeedValue",
Callback=function(ad)S.speedValue=ad end,
}



aa.Watch()
end end function a.T():typeof(__modImpl())local aa=a.cache.T if not aa then aa={c=__modImpl()}a.cache.T=aa end return aa.c end end do local function __modImpl()





















local aa=a.m()a.l()


local ab=game:GetService"TeleportService"

local ac={}



ac.KEYS={"rare","epic","legendary"}

ac.CASE_LABEL={
rare="Rare Case",
epic="Epic Case",
legendary="Legendary Case",
}



local ad={
armors="armor",
weapons="weapon",
enchants="enchant",
titles="title",
}

local ae
local af={}



function ac.Configs(ag)
if ae and not ag then return ae end

local ah,ai={},{}
for aj,ak in ipairs(ac.KEYS)do
local al,an=aa.Invoke("getCaseConfig",ak)
if al and type(an)=="table"and type(an.items)=="table"then
ah[ak]=an
else
ai[#ai+1]=ak
end
end

if#ai>0 then

end



if not next(ah)then return nil end

ae=ah
return ae
end

function ac.Invalidate()
ae=nil
end







function ac.Key(ag,ah)
return tostring(ag).."/"..tostring(ah)
end


function ac.Owned()
local ag={}
local ah,ai=aa.Invoke"getPlayerCosmetics"
if not ah or type(ai)~="table"then

return ag,false
end
for aj,ak in pairs(ai)do
if type(ak)=="table"then
for al,an in ipairs(ak)do ag[ac.Key(aj,an)]=true end
end
end
return ag,true
end










function ac.BestFor(ag)
local ah=ac.Configs()
if not ah then return nil end

local ai={}
for aj,ak in ipairs(ag)do ai[ac.Key(ak.type,ak.name)]=true end

local aj
for ak,al in ipairs(ac.KEYS)do
local an=ah[al]
local ap,aq=0,0
for ar,as in ipairs((an and an.items)or{})do
if ai[ac.Key(as.type,as.name)]then
ap=ap+(tonumber(as.percent)or 0)
aq=aq+1
end
end
if aq>0 then
local ar=tonumber(an.price)or 0
if not aj or ap>aj.percent
or(ap==aj.percent and ar<aj.price)then
aj={key=al,percent=ap,price=ar,hits=aq}
end
end
end
return aj
end



function ac.Pool()
local ag=ac.Configs()
af={}
if not ag then return{}end

local ah={}
for ai,aj in ipairs(ac.KEYS)do
for ak,al in ipairs((ag[aj]and ag[aj].items)or{})do
local an=ac.Key(al.type,al.name)
if not ah[an]then
ah[an]=true
local ap=("%s · %s %s"):format(al.name,tostring(al.rarity),
ad[al.type]or tostring(al.type))
af[ap]={name=al.name,type=al.type,rarity=al.rarity}
end
end
end

local ai={}
for aj in pairs(af)do ai[#ai+1]=aj end
table.sort(ai)
return ai
end



function ac.Item(ag)
if not ag or ag==""then return nil end
local ah=af[ag]
if ah then return ah end



ac.Pool()
return af[ag]
end



function ac.Ready()
local ag=LocalPlayer:FindFirstChild"leaderstats"
if not ag or not ag:FindFirstChild"Gems"then return false end
return aa.Get"purchaseCase"~=nil and aa.Get"casePurchaseResult"~=nil
end






function ac.Buy(ag,ah)
local ai=aa.Get"purchaseCase"
local aj=aa.Get"casePurchaseResult"
if not ai or not aj then return nil,"s63"end

local ak
local al=aj.OnClientEvent:Connect(function(al)
if ak==nil then ak=al or false end
end)

local an=pcall(function()ai:FireServer(ag)end)
if not an then
al:Disconnect()
return nil,"s64"
end

local ap=os.clock()+(ah or 15)
while ak==nil and os.clock()<ap and not _apelStopped do
task.wait(0.05)
end
al:Disconnect()

if ak==nil then return nil,"s65"end
if type(ak)~="table"then return nil,"s66"end
return ak
end



function ac.Award(ag)
return aa.Fire("awardCaseCosmetic",ag.cosmetic,ag.cosmeticType,ag.transactionId)
end



function ac.Rejoin()
return(pcall(function()
ab:Teleport(game.PlaceId,LocalPlayer)
end))
end

return ac end function a.U():typeof(__modImpl())local aa=a.cache.U if not aa then aa={c=__modImpl()}a.cache.U=aa end return aa.c end end do local function __modImpl()


local aa=a.n()
local ab=a.b()
local ac=a.R()
local ad=a.r()
local ae=a.U()
local af=a.s()a.l()







local ag={}

local function restoreNames()
for ah,ai in pairs(ag)do
pcall(function()
if not ah.Parent then return end
if type(ai)=="boolean"then ah.Enabled=ai else ah.Text=ai end
end)
end
table.clear(ag)
end

local function hideNames()
local ah,ai=LocalPlayer.Name,LocalPlayer.DisplayName

local aj=LocalPlayer.Character
if aj then
for ak,al in ipairs(aj:GetDescendants())do
if al:IsA"BillboardGui"and al.Enabled then
if ag[al]==nil then ag[al]=al.Enabled end
al.Enabled=false
end
end
end

local ak=LocalPlayer:FindFirstChild"PlayerGui"
if ak then
for al,an in ipairs(ak:GetDescendants())do
if an:IsA"TextLabel"or an:IsA"TextButton"then
local ap=an.Text
if ap==ah or ap==ai then
if ag[an]==nil then ag[an]=ap end
an.Text="Hidden"
end
end
end
end
end

return function(ah)
local ai=ah.Stats
local aj=ah.Hook


local ak=ah.Util

ak:Toggle{
Name="Noclip",
Desc="walk through walls; collisions come back when you turn it off",
Default=false,Flag="NoclipOn",
Callback=function(al)
S.noclip=al
if not al then af.RestoreNoclip()end
end,
}


local al=ah.Perf

al:Toggle{
Name="Performance Mode",
Desc="strips materials, textures and particles — rejoin to restore",
Default=false,Flag="PerformanceMode",
Callback=function(an)
S.perfMode=an


if an then task.spawn(ab.Boost)end
end,
}

al:Toggle{
Name="Ultra Performance Mode",
Desc="everything above plus 3D rendering off and a black screen",
Default=false,Flag="UltraPerformanceMode",
Callback=function(an)
S.ultraPerf=an
if an then
task.spawn(function()
ab.Set3D(false)
ab.BuildScreen()
ab.Boost()
end)
else
ab.Set3D(true)
ab.KillScreen()
end
end,
}

ab.Watch()



local an=ai:Label"Loading..."

ai:Toggle{
Name="Hide Name",
Desc="blanks your own nameplate and every label in the interface that shows your nick",
Default=false,Flag="HideName",
Callback=function(ap)
S.hideName=ap
if ap then hideNames()else restoreNames()end
end,
}



spawnLoop(function()
while not _apelStopped do
task.wait(2)
if S.hideName then pcall(hideNames)end

pcall(function()
local ap=ac.EquippedWeapon()
local aq=aa.Items()
an:Set(table.concat({
("Level <b>%d</b>   ·   XP %s/%s"):format(aa.Level(),
tostring(aa.Val("XP",0)),tostring(aa.Val("XPNeeded",0))),
("Gold %s   ·   Gems %s   ·   Points %d"):format(
tostring(aa.Gold()),tostring(aa.Gems()),aa.SkillPoints()),
("Physical %s   ·   Spell %s   ·   Stamina %s"):format(
tostring(aa.Val("physicalPower",0)),tostring(aa.Val("spellPower",0)),
tostring(aa.Val("stamina",0))),
("Weapon %s   ·   %d item%s in the bag"):format(
ap and ap.name or"—",#aq,#aq==1 and""or"s"),
},"\n"))
end)
end
end)



aj:Toggle{Name="Enable Webhook",Default=false,Flag="WebhookOn",
Desc="nothing is posted while this is off",
Callback=function(ap)S.webhookOn=ap end}

aj:Input{Name="Webhook URL",Default="",Placeholder="https://discord.com/api/webhooks/...",
Flag="WebhookURL",Callback=function(ap)S.webhookUrl=tostring(ap or"")end}

aj:Dropdown{
Name="Ping On Rarity",
Desc="ping only when the run dropped one of these; leave empty to ping every report",
Options=(function()
local ap={}
for aq,ar in ipairs(aa.RARITIES)do
ap[#ap+1]=('<font color="%s">%s</font>'):format(aa.RARITY_COLOR[ar]or"#FFFFFF",ar)
end
return ap
end)(),
Multi=true,
Flag="WebhookPingRarities",
Callback=function(ap)
local aq={}
for ar,as in pairs(ap or{})do
if as then
local au=tostring(ar):gsub("<[^>]->","")
aq[(au:gsub("^%s+",""):gsub("%s+$",""))]=true
end
end
S.pingRarities=aq
end,
}

aj:Input{Name="Discord User ID",Default="",Placeholder="ping you on every post",
Numeric=true,Flag="WebhookUserId",
Callback=function(ap)S.webhookUserId=tostring(ap or"")end}

aj:Toggle{Name="Mention @everyone",Default=false,Flag="WebhookEveryone",
Callback=function(ap)S.webhookEveryone=ap end}



aj:Button{Name="Send Test Post",Text="Send",Callback=function()
task.spawn(function()
if tostring(S.webhookUrl or"")==""then return Notify"Paste a webhook URL first"end
local ap,aq=ad.Test()
if aq then
Notify("Webhook failed: "..tostring(aq))
else
Notify(S.webhookOn and("Webhook OK (HTTP "..tostring(ap)..")")
or("Webhook OK (HTTP "..tostring(ap)..") — posting is still off"))
end
end)
end}

aj:SubLabel"Send Test Post works even while Enable Webhook is off, so you can check the URL first."











local ap=ah.Cosmetic

local aq,ar
local as=ap:Label"Loading the crate list..."



local function pending()
local au,av={},0
local aw=ae.Owned()
for ax,ay in ipairs(S.cosmeticTargets or{})do
local az=ae.Item(ay)
if az then
if aw[ae.Key(az.type,az.name)]then
av=av+1
else
au[#au+1]=az
end
end
end
return au,av
end



local function describe()
if#(S.cosmeticTargets or{})==0 then
return as:Set"Pick one or more cosmetics to hunt"
end

local au,av=pending()
if#au==0 then
return as:Set(("You already own all %d pick%s"):format(av,av==1 and""or"s"))
end

local aw=ae.BestFor(au)
if not aw then
return as:Set"Nothing you picked drops from the crates any more"
end

local ax={}
for ay=1,math.min(3,#au)do ax[ay]=au[ay].name end
if#au>3 then ax[#ax+1]=("+%d more"):format(#au-3)end

as:Set(("<b>%d left</b> · %s · %.3f%% a spin · %d gems\n%s"):format(
#au,ae.CASE_LABEL[aw.key]or aw.key,aw.percent,aw.price,
table.concat(ax,", ")))
end

local function refreshCosmetics()
ae.Invalidate()
local au=ae.Pool()
pcall(function()aq:SetOptions(au)end)
describe()
return#au
end

aq=ap:Dropdown{
Name="Cosmetics",
Desc="tick everything you want; the hub spins whichever crate covers most of them",



Options={},Multi=true,Search=true,CacheOptions=true,
Flag="CosmeticTargets",
Callback=function(au)
local av={}
for aw,ax in pairs(au or{})do if ax then av[#av+1]=aw end end
table.sort(av)
S.cosmeticTargets=av


task.spawn(describe)
end,
}

ap:Button{Name="Refresh Cosmetic List",Text="Refresh",Callback=function()
task.spawn(function()
local au=refreshCosmetics()
Notify(au>0 and("%d cosmetic%s still up for grabs"):format(au,au==1 and""or"s")
or"No crate list here — the purchase remotes are missing")
end)
end}

ar=ap:Toggle{
Name="Auto Open Crates",
Desc="spins the best crate for the picks above; a wrong roll is thrown away by rejoining",
Default=false,Flag="CosmeticGetter",
Callback=function(au)
S.cosmeticGet=au


if au and not S.autoExecTP then
Notify"Turn on Auto Execute on Teleport, or the hub will not come back after a rejoin"
end
end,
}

local function stopHunt(au)
S.cosmeticGet=false
pcall(function()ar:Set(false)end)

Notify(au)
end

local function huntStep()
if#(S.cosmeticTargets or{})==0 then return stopHunt"Pick a cosmetic first"end



if not ae.Ready()then

return
end

local au,av=pending()
if#au==0 then
refreshCosmetics()
return stopHunt(("Got everything you picked — %d cosmetic%s"):format(av,av==1 and""or"s"))
end



ae.Invalidate()
local aw=ae.BestFor(au)
if not aw then
return stopHunt"Nothing you picked drops from the crates any more"
end

local ax=aa.Gems()
if ax<aw.price then
return stopHunt(("%s costs %d gems, you have %d")
:format(ae.CASE_LABEL[aw.key]or aw.key,aw.price,ax))
end

local ay={}
for az,aA in ipairs(au)do ay[#ay+1]=aA.type.."/"..aA.name end


local az,aA=ae.Buy(aw.key)
if not az then return stopHunt("Crate spin failed: "..tostring(aA))end
if not az.success then
return stopHunt("Crate spin refused: "..tostring(az.message))
end




local aB=false
for aC,aD in ipairs(au)do
if az.cosmetic==aD.name and az.cosmeticType==aD.type then aB=true break end
end

if aB then



ae.Award(az)

Notify(("Got %s — %d pick%s left"):format(az.cosmetic,#au-1,#au-1==1 and""or"s"))
task.wait(1)
refreshCosmetics()
return
end


if not ae.Rejoin()then
return stopHunt"Teleport refused — hunt stopped"
end
end

local au=false
spawnLoop(function()
while not _apelStopped do
task.wait(1)
if S.cosmeticGet and not au then
au=true local
av=pcall(huntStep)
au=false
if not av then end
end
end
end)

task.spawn(function()
refreshCosmetics()

end)
end end function a.V():typeof(__modImpl())local aa=a.cache.V if not aa then aa={c=__modImpl()}a.cache.V=aa end return aa.c end end do local function __modImpl()


return function(aa,ab,ac)

local ad=ab.KeyTimerSection:Label"No key timer set"
aa:OnKeyTimer(function(ae)
ad:Set(ae or"No key timer set")
end)



aa:SetKeyTimerVisible(false)




local ae="ApelHub/Saved Key.txt"
ab.KeyTimerSection:Button{
Name="Delete Saved Key",
Text="Forget key",
Callback=function()
if type(isfile)~="function"or type(delfile)~="function"then
ac"This executor cannot manage files"
return
end

local af=false
pcall(function()af=isfile(ae)==true end)
if not af then
ac"There is no saved key to delete"
return
end


aa:Dialog{
Title="Delete saved key?",
Text=[[You will have to enter your key again the next time you launch the hub. The current session keeps running.]]
,
Buttons={
{Name="Cancel"},
{
Name="Delete",
Primary=true,
Callback=function()
local ag=pcall(function()
if isfile(ae)then delfile(ae)end
end)
ac(ag
and"Saved key deleted. You will be asked for it on the next launch"
or"Could not delete the saved key")
end
},
}
}
end
}
end end function a.W():typeof(__modImpl())local aa=a.cache.W if not aa then aa={c=__modImpl()}a.cache.W=aa end return aa.c end end do local function __modImpl()







local aa=game:GetService"HttpService"
local ab=game:GetService"TeleportService"
local ac=game:GetService"Players"
local ad=ac.LocalPlayer

local ae={}

local af="https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"

function ae.Pool()
local ag={}
pcall(function()
local ah=game:HttpGet(af:format(game.PlaceId))
local ai=aa:JSONDecode(ah)
for aj,ak in ipairs((type(ai)=="table"and ai.data)or{})do
if ak.id and ak.id~=game.JobId
and(tonumber(ak.playing)or 0)<(tonumber(ak.maxPlayers)or 0)then
ag[#ag+1]=ak.id
end
end
end)
return ag
end


function ae.Hop()
local ag=ae.Pool()
if#ag>0 then
local ah=ag[math.random(1,#ag)]
local ai=pcall(function()
ab:TeleportToPlaceInstance(game.PlaceId,ah,ad)
end)
if ai then return true,("picked 1 of %d servers"):format(#ag)end
end

local ah=pcall(function()ab:Teleport(game.PlaceId,ad)end)
return ah,ah and"no server list, blind teleport"or"teleport refused"
end

return ae end function a.X():typeof(__modImpl())local aa=a.cache.X if not aa then aa={c=__modImpl()}a.cache.X=aa end return aa.c end end do local function __modImpl()



local aa=a.X()

return function(ab,ac)





local function isDisconnected()
local ad=false
pcall(function()
local ae=game:GetService"GuiService":GetErrorCode()
if ae~=nil and ae~=Enum.ConnectionError.OK then ad=true end
end)
if ad then return true end
pcall(function()
local ae=game:GetService"CoreGui":FindFirstChild"RobloxPromptGui"
ae=ae and ae:FindFirstChild"promptOverlay"
for af,ag in ipairs((ae and ae:GetChildren())or{})do
if ag.Name=="ErrorPrompt"and ag.Visible~=false then ad=true break end
end
end)
return ad
end

rejoinOnKick=false
ac.SettingsSection3:Toggle{
Name="Rejoin on game kick",
Desc="On a kick or a lost connection, hops to a different server",
Default=false,
Flag="RejoinOnKick",
Callback=function(ad)rejoinOnKick=ad end
}



spawnLoop(function()
local ad,ae=0,false
while not _apelStopped do
if rejoinOnKick and isDisconnected()then


ad+=1
if not ae and ad>=2 then
ae=true
pcall(aa.Hop)
end
else
ad,ae=0,false
end
task.wait(1)
end
end)
end end function a.Y():typeof(__modImpl())local aa=a.cache.Y if not aa then aa={c=__modImpl()}a.cache.Y=aa end return aa.c end end do local function __modImpl()


return function(aa,ab,ac)
local ad=ac.HUB_URL












local ae=ac.DEV_URL or""

local af=[==[
	local URL, DEV, TPL = %q, %q, %q
	local q = queue_on_teleport or queueonteleport
	if q then pcall(q, string.format(TPL, URL, DEV, TPL)) end
	if getgenv then getgenv()._ApelHub_Queued = true end
	repeat task.wait() until game:IsLoaded()
	local src
	if DEV ~= "" then
	    local ok, body = pcall(function() return game:HttpGet(DEV) end)
	    if ok and type(body) == "string" and #body > 100 then src = body end
	end
	if not src then src = game:HttpGet(URL) end
	loadstring(src)()
	]==]

local function autoExecPayload()
return string.format(af,ad,ae,af)
end

ab.SettingsSection3:Toggle{
Name="Auto Execute on Teleport",
Desc="Re-runs the hub after a teleport to another server",
Default=false,
Flag="AutoExecTP",
Callback=function(ag)
S.autoExecTP=ag
local ah=queue_on_teleport or queueonteleport
if not ah then
if ag then
aa:Notify{Title="Apel Hub",
Description="This executor has no queue_on_teleport"}
end
return
end









if ag then
if not getgenv()._ApelHub_Queued then
getgenv()._ApelHub_Queued=true
pcall(ah,autoExecPayload())
end
else
getgenv()._ApelHub_Queued=nil
pcall(ah,"")
end
end
}
end end function a.Z():typeof(__modImpl())local aa=a.cache.Z if not aa then aa={c=__modImpl()}a.cache.Z=aa end return aa.c end end do local function __modImpl()


return function(aa,ab,ac,ad)
local ae=ad.GameName




local af="-- APELCFG:"

local function httpRequest()
return(syn and syn.request)or http_request or(http and http.request)or request
end







ab.SettingsSection4:Dropdown{
Name="Auto Save Mode",
Desc="Shared — one config for the game, Per Account — a separate one for each account",
Options={"Shared","Per Account"},
Default="Shared",
Flag="ConfigMode",
Callback=function(ag)
aa:SetConfigMode(ag=="Per Account"and"perUser"or"shared")







if aa:IsLoadingConfig()then return end
local ah=aa:GetAutoload()
if ah then aa:SaveConfig(ah)end
end
}




local ag=ab.SettingsSection4:Section("Config Export",{Open=false})
local ah=ab.SettingsSection4:Section("Config Import",{Open=false})



ag:Button{
Name="Copy Config to Clipboard",
Text="Copy",
Callback=function()
local ai=game:GetService"HttpService"
local aj,ak=pcall(function()
return ai:JSONEncode(aa:GetConfig())
end)
if not aj then ac"Could not encode the config"return end
local al=setclipboard or toclipboard
if not al then ac"This executor has no clipboard"return end
al(af..tostring(ae).."\n"..ak)
ac"Config copied to clipboard"
end
}

ag:Button{
Name="Export Config",
Text="Upload and copy link",
Callback=function()
local ai=game:GetService"HttpService"
local aj,ak=pcall(function()
return ai:JSONEncode(aa:GetConfig())
end)
if not aj then ac"Could not encode the config"return end
local al=af..tostring(ae).."\n"..ak
local an=httpRequest()
local ap=setclipboard or toclipboard

task.spawn(function()
local aq
if an then
pcall(function()
local ar=an{Url="https://paste.rs/",Method="POST",
Headers={["Content-Type"]="text/plain"},Body=al}
local as=ar and(ar.Body or ar.body)
if as then aq=as:match"(https://paste%.rs/%S+)"end
end)
end
if aq then
if ap then ap(aq)end
ac("Link copied:\n"..aq)
elseif ap then
ap(al)
ac"Upload failed, config copied to clipboard instead"
else
ac"This executor has no HTTP and no clipboard"
end
end)
end
}

configImportURL=""
ah:Input{
Name="Import URL",
Placeholder="paste.rs or .json link",
Flag="ConfigImportURL",
IgnoreConfig=true,
Callback=function(ai)configImportURL=ai or""end
}

ah:Button{
Name="Import Config",
Text="Download and apply",
Callback=function()
local ai=tostring(configImportURL or""):gsub("^%s+",""):gsub("%s+$","")
if ai==""then ac"Paste a config link first"return end
local aj=httpRequest()
if not aj then ac"This executor has no HTTP"return end
task.spawn(function()
local ak,al=pcall(aj,{Url=ai,Method="GET",
Headers={["User-Agent"]="ApelHub-ConfigImport"}})
local an=ak and al and(al.Body or al.body)
if not an or an==""then ac"Import failed: nothing came back"return end
local ap=an:match"^%-%-%s*APELCFG:([^\r\n]+)"
an=an:gsub("^%-%-[^\r\n]*\r?\n","")
local aq,ar=pcall(function()
return game:GetService"HttpService":JSONDecode(an)
end)
if not(aq and type(ar)=="table"and type(ar.objects)=="table")then
ac"Import failed: not a valid config"
return
end


aa:LoadConfig(ar)
ac(("Imported %d settings%s"):format(#ar.objects,
ap and(" from "..ap)or""))
end)
end
}







ab.SettingsSection4:Button{
Name="Reset Script Config",
Desc="Deletes every saved setting and unloads the hub. Run the script again for a clean start.",
Text="Reset config",
Callback=function()
aa:Dialog{
Title="Reset script config?",
Text=[[Every saved setting is deleted and the menu unloads. Run the script again and it starts with defaults.]]
,
Buttons={
{Name="Cancel"},
{
Name="Reset",
Primary=true,
Callback=function()


aa.AutoSaveEnabled=false
local ai=false
pcall(function()
local aj=aa:GetAutoload()



if aj then ai=aa:DeleteConfig(aj)end
aa:RemoveAutoload()
end)
ac(ai and"Config deleted, unloading"
or"No saved config found, unloading")
task.wait(0.6)
pcall(function()aa:Destroy()end)
end
},
}
}
end
}
end end function a._():typeof(__modImpl())local aa=a.cache._ if not aa then aa={c=__modImpl()}a.cache._=aa end return aa.c end end do local function __modImpl()






















local aa=a.Q()

local ab=game:GetService"Players"
local ac=game:GetService"RunService"
local ad=ab.LocalPlayer


local ae=Color3.fromRGB(26,26,26)
local af=Color3.fromRGB(44,43,43)
local ag=Color3.fromRGB(226,132,19)
local ah=Color3.fromRGB(163,162,165)
local ai=Font.new"rbxasset://fonts/families/Code.json"
local aj="rbxassetid://60358188"



local function upgradeCost(ak,al)
local an=0
if ak<24 then
if ak==0 and al>0 then an=100 end
local ap=100

for aq=1,math.min(23,al-1)do
ap=ap*1.06+50
if aq>=ak then an=an+math.floor(ap)end
end
end
local ap=ak<24 and 24 or(ak>466 and 466 or ak)
local aq=al<24 and 24 or(al>466 and 466 or al)
an=an+(aq-ap)*(110*(aq+ap)-2445)
ap=ak<466 and 466 or ak
aq=al<466 and 466 or al
an=an+(aq-ap)*100000
return an
end


local function commas(ak)
local al=tostring(math.floor(ak))
local an=al:reverse():gsub("(%d%d%d)","%1 "):reverse()
return(an:gsub("^%s+",""))
end



local function num(ak)
if not ak then return nil end
return tonumber((tostring(ak.Text):gsub("[^%d%-]","")))
end











local ak={"inventory","sellShop","blacksmith","tradingGui"}

local function openMenu()
local al=ad:FindFirstChild"PlayerGui"
if not al then return nil,nil end
for an,ap in ipairs(ak)do
local aq=al:FindFirstChild(ap)
local ar=aq and aq:FindFirstChild"itemStatFrame"
if ar and ar.Visible then return aq,ar end
end
return nil,nil
end


local function readTooltip()local
al, an=openMenu()
if not an then return nil end

for ap,aq in ipairs{"weaponMain","armorMain","petMain"}do
local ar=an:FindFirstChild(aq)
if ar and ar.Visible then
local as=ar:FindFirstChild"upgrades"
local au,av=tostring(as and as.Text or""):match"(%d+)%s*/%s*(%d+)"
if not au then return nil end
return{
card=ar,
name=tostring(ar:FindFirstChild"name"and ar.name.Text or"?"),
done=tonumber(au),max=tonumber(av),
phys=num(ar:FindFirstChild"physicalDamage"),
spell=num(ar:FindFirstChild"spellPower"),
health=num(ar:FindFirstChild"health"),
}
end
end
return nil
end



return function()

local al=(gethui and gethui())or ad:WaitForChild"PlayerGui"
local an=al:FindFirstChild"ApelPredictor"
if an then an:Destroy()end

local ap=Instance.new"ScreenGui"
ap.Name="ApelPredictor"
ap.ResetOnSpawn=false
ap.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ap.DisplayOrder=50
ap.Parent=al

local aq=Instance.new"Frame"
aq.Name="panel"
aq.BackgroundColor3=ae
aq.BackgroundTransparency=0.1
aq.BorderSizePixel=0
aq.Visible=false
aq.Size=UDim2.fromOffset(250,176)
aq.Parent=ap

local ar=Instance.new"UICorner"
ar.CornerRadius=UDim.new(0,6)
ar.Parent=aq

local as=Instance.new"UIStroke"
as.Color=af
as.Thickness=1
as.Parent=aq

local au=Instance.new"Frame"
au.BackgroundColor3=af
au.BorderSizePixel=0
au.Size=UDim2.new(1,0,0,26)
au.Parent=aq
local av=ar:Clone()
av.Parent=au

local aw=Instance.new"Frame"
aw.BackgroundColor3=af
aw.BorderSizePixel=0
aw.Position=UDim2.new(0,0,1,-6)
aw.Size=UDim2.new(1,0,0,6)
aw.Parent=au

local ax=Instance.new"TextLabel"
ax.BackgroundTransparency=1
ax.FontFace=ai
ax.TextSize=15
ax.TextColor3=ag
ax.TextXAlignment=Enum.TextXAlignment.Left
ax.Position=UDim2.fromOffset(10,0)
ax.Size=UDim2.new(1,-20,1,0)
ax.Text="Potential Predictor"
ax.ZIndex=2
ax.Parent=au

local ay=Instance.new"Frame"
ay.BackgroundTransparency=1
ay.Position=UDim2.fromOffset(10,32)
ay.Size=UDim2.new(1,-20,1,-42)
ay.Parent=aq

local az=Instance.new"UIListLayout"
az.Padding=UDim.new(0,4)
az.SortOrder=Enum.SortOrder.LayoutOrder
az.Parent=ay


local function row(aA)
local aB=Instance.new"Frame"
aB.BackgroundTransparency=1
aB.Size=UDim2.new(1,0,0,18)
aB.LayoutOrder=aA
aB.Parent=ay

local aC=Instance.new"TextLabel"
aC.BackgroundTransparency=1
aC.FontFace=ai
aC.TextSize=14
aC.TextColor3=ah
aC.TextXAlignment=Enum.TextXAlignment.Left
aC.Size=UDim2.new(0.42,0,1,0)
aC.Parent=aB

local aD=Instance.new"TextLabel"
aD.BackgroundTransparency=1
aD.FontFace=ai
aD.TextSize=14
aD.TextColor3=Color3.new(1,1,1)
aD.TextXAlignment=Enum.TextXAlignment.Right
aD.Position=UDim2.new(0.42,0,0,0)
aD.Size=UDim2.new(0.58,0,1,0)
aD.Parent=aB

return{holder=aB,left=aC,right=aD}
end

local aA=row(1)
local aB=row(2)
local aC=row(3)
local aD=row(4)


local aE=Instance.new"Frame"
aE.BackgroundTransparency=1
aE.Size=UDim2.new(1,0,0,22)
aE.LayoutOrder=5
aE.Parent=ay

local aF=Instance.new"ImageLabel"
aF.BackgroundTransparency=1
aF.Image=aj
aF.Size=UDim2.fromOffset(16,16)
aF.Position=UDim2.fromOffset(0,3)
aF.Parent=aE

local aG=Instance.new"TextLabel"
aG.BackgroundTransparency=1
aG.FontFace=ai
aG.TextSize=14
aG.TextColor3=ag
aG.TextXAlignment=Enum.TextXAlignment.Right
aG.Position=UDim2.fromOffset(20,0)
aG.Size=UDim2.new(1,-20,1,0)
aG.Parent=aE





local aH=true
local aI=""

local aJ
local function buildSettings()
if aJ and aJ.Parent then return end




local aM=select(1,openMenu())
local aN=aM and(aM:FindFirstChild"mainBackground"
or aM:FindFirstChild"Frame")
if not aN then return end



local aO=aN:FindFirstChild"ApelPredictorSettings"
if aO then aO:Destroy()end

aJ=Instance.new"Frame"
aJ.Name="ApelPredictorSettings"
aJ.BackgroundColor3=ae
aJ.BackgroundTransparency=0.1
aJ.BorderSizePixel=0
aJ.AnchorPoint=Vector2.new(0.5,1)
aJ.Position=UDim2.new(0.5,0,0,-6)
aJ.Size=UDim2.new(0.62,0,0,30)
aJ.Parent=aN

local aP=Instance.new"UICorner"
aP.CornerRadius=UDim.new(0,6)
aP.Parent=aJ
local aQ=Instance.new"UIStroke"
aQ.Color=af
aQ.Parent=aJ

local aR=Instance.new"TextLabel"
aR.BackgroundTransparency=1
aR.FontFace=ai
aR.TextSize=14
aR.TextColor3=ag
aR.TextXAlignment=Enum.TextXAlignment.Left
aR.Position=UDim2.fromOffset(10,0)
aR.Size=UDim2.new(0.4,0,1,0)
aR.Text="Potential Predictor"
aR.Parent=aJ

local aS=Instance.new"TextButton"
aS.BackgroundColor3=af
aS.BorderSizePixel=0
aS.FontFace=ai
aS.TextSize=13
aS.TextColor3=Color3.new(1,1,1)
aS.AnchorPoint=Vector2.new(1,0.5)
aS.Position=UDim2.new(1,-10,0.5,0)
aS.Size=UDim2.fromOffset(46,20)
aS.Text="ON"
aS.Parent=aJ
local aT=Instance.new"UICorner"
aT.CornerRadius=UDim.new(0,4)
aT.Parent=aS

local aU=Instance.new"TextBox"
aU.BackgroundColor3=af
aU.BorderSizePixel=0
aU.FontFace=ai
aU.TextSize=13
aU.TextColor3=Color3.new(1,1,1)
aU.PlaceholderText="max"
aU.Text=""
aU.ClearTextOnFocus=false
aU.AnchorPoint=Vector2.new(1,0.5)
aU.Position=UDim2.new(1,-62,0.5,0)
aU.Size=UDim2.fromOffset(64,20)
aU.Parent=aJ
local aV=Instance.new"UICorner"
aV.CornerRadius=UDim.new(0,4)
aV.Parent=aU

local aW=Instance.new"TextLabel"
aW.BackgroundTransparency=1
aW.FontFace=ai
aW.TextSize=12
aW.TextColor3=ah
aW.TextXAlignment=Enum.TextXAlignment.Right
aW.AnchorPoint=Vector2.new(1,0.5)
aW.Position=UDim2.new(1,-130,0.5,0)
aW.Size=UDim2.fromOffset(120,20)
aW.Text="upgrade to:"
aW.Parent=aJ

regConn(aS.MouseButton1Click:Connect(function()
aH=not aH
aS.Text=aH and"ON"or"OFF"
aS.TextColor3=aH and Color3.new(1,1,1)or ah
if not aH then aq.Visible=false end
end))

regConn(aU.FocusLost:Connect(function()
aI=tostring(aU.Text):gsub("[^%d]","")
aU.Text=aI
end))
end



local aM

local function refresh()
buildSettings()
if not aH then aq.Visible=false return end

local aN=readTooltip()
if not aN then aq.Visible=false aM=nil return end


local aO=tonumber(aI)
if not aO or aO>aN.max then aO=aN.max end
if aO<aN.done then aO=aN.done end

local aP=("%s|%d|%d|%s|%s|%s"):format(aN.name,aN.done,aO,
tostring(aN.phys),tostring(aN.spell),tostring(aN.health))
if aP~=aM then
aM=aP

aA.left.Text="Upgrades"
aA.right.Text=("%d  →  %d"):format(aN.done,aO)

local function fill(aQ,aR,aS)
if not aS then aQ.holder.Visible=false return end
aQ.holder.Visible=true
local aT=aa.At(aS,aN.done,aO)
aQ.left.Text=aR
aQ.right.Text=("%s  →  %s"):format(commas(aS),commas(aT))
end

fill(aB,"Physical",aN.phys)
fill(aC,"Spell",aN.spell)
fill(aD,"Health",aN.health)

aG.Text=commas(upgradeCost(aN.done,aO))


local aQ=2
if aN.phys then aQ=aQ+1 end
if aN.spell then aQ=aQ+1 end
if aN.health then aQ=aQ+1 end
aq.Size=UDim2.fromOffset(250,42+aQ*22)
end


local aQ=aN.card.AbsolutePosition
local aR=aN.card.AbsoluteSize
aq.Position=UDim2.fromOffset(aQ.X+aR.X+8,aQ.Y)
aq.Visible=true
end

regConn(ac.Heartbeat:Connect(function()
if _apelStopped then return end
pcall(refresh)
end))
end end function a.aa():typeof(__modImpl())local aa=a.cache.aa if not aa then aa={c=__modImpl()}a.cache.aa=aa end return aa.c end end do local function __modImpl()





















local aa=a.n()

local ab=game:GetService"Players"
game:GetService"RunService"
local ac=ab.LocalPlayer


local ad=Color3.fromRGB(26,26,26)
local ae=Color3.fromRGB(44,43,43)
local af=Color3.fromRGB(226,132,19)
local ag=Color3.fromRGB(163,162,165)
local ah=Font.new"rbxasset://fonts/families/Code.json"



local ai={}
for aj,ak in ipairs(aa.RARITIES)do ai[ak]=aj end
ai.dev=#aa.RARITIES+1

local aj={"Off","Rarity","Level","Phys","Spell"}








local ak="ApelHub/DQR_inventory_sort.json"

local function canFile()
return type(writefile)=="function"and type(isfile)=="function"
and type(readfile)=="function"
end

local function loadChoice()
if not canFile()then return nil,nil end
local al,an
pcall(function()
if not isfile(ak)then return end
local ap=game:GetService"HttpService":JSONDecode(readfile(ak))
if type(ap)~="table"then return end
for aq,ar in ipairs(aj)do
if ap.mode==ar then al=ar end
end
if type(ap.best)=="boolean"then an=ap.best end
end)
return al,an
end

local function saveChoice(al,an)
if not canFile()then return end
pcall(function()
if type(isfolder)=="function"and type(makefolder)=="function"
and not isfolder"ApelHub"then
makefolder"ApelHub"
end
writefile(ak,game:GetService"HttpService":JSONEncode{
mode=al,best=an,
})
end)
end

return function()
local al,an=loadChoice()
local ap=al or"Off"
local aq=an~=false














local ar={"inventory","sellShop","blacksmith","tradingGui"}












local as=setmetatable({},{__mode="k"})

local function findGrid(au)
for av,aw in ipairs(au:GetDescendants())do
if aw:IsA"ScrollingFrame"then
for ax,ay in ipairs(aw:GetChildren())do
if ay:IsA"GuiObject"and ay:FindFirstChild"itemType"then
return aw
end
end
end
end
return nil
end

local function gridIn(au)
local av=as[au]
if av and av.Parent and av:IsDescendantOf(au)then
return av
end
local aw=findGrid(au)
as[au]=aw
return aw
end


local function openMenus()
local au=ac:FindFirstChild"PlayerGui"
local av={}
if not au then return av end
for aw,ax in ipairs(ar)do
local ay=au:FindFirstChild(ax)
if ay and(not ay:IsA"ScreenGui"or ay.Enabled)then
local az=gridIn(ay)
local aA=ay:FindFirstChild"mainBackground"
or ay:FindFirstChild"Frame"
if az and aA then
av[#av+1]={name=ax,grid=az,anchor=aA}
end
end
end
return av
end







local function keyOf(au)
local av=au:FindFirstChild"itemType"
if not av then return nil end
local aw=av:FindFirstChild"uniqueItemNum"
if not aw then return nil end
return tostring(av.Value).."_"..tostring(aw.Value)
end

local function itemIndex()
local au={}
for av,aw in ipairs(aa.Items())do
au[aw.type.."_"..tostring(aw.num)]=aw
end
return au
end











local au={"physicalDamage","physicalPower"}

local function statOf(av,aw)
for ax,ay in ipairs(aw)do
local az=tonumber(av[ay])
if az then return az end
end
return 0
end


local function weightOf(av)
if not av then return-1 end
local aw=av.data or{}
if ap=="Rarity"then return ai[av.rarity]or 0 end
if ap=="Level"then return tonumber(aw.levelReq)or 0 end
if ap=="Phys"then return statOf(aw,au)end
if ap=="Spell"then return tonumber(aw.spellPower)or 0 end
return 0
end

local av




local function applySort()
local aw=openMenus()
if#aw==0 then return end
local ax=(ap~="Off")and itemIndex()or nil
for ay,az in ipairs(aw)do
av(az.grid,ax)
end
end







local aw=false

local function queueSort()
if ap=="Off"or aw then return end
aw=true
task.defer(function()
aw=false
pcall(applySort)
end)
end

av=function(ax,ay)
if not ax then return end

if ap=="Off"then


for az,aA in ipairs(ax:GetChildren())do
if aA:IsA"GuiObject"then
aA.LayoutOrder=tonumber(aA.Name)or aA.LayoutOrder
end
end
return
end

ay=ay or itemIndex()
local az={}
for aA,aB in ipairs(ax:GetChildren())do
if aB:IsA"GuiObject"and aB:FindFirstChild"itemType"then
local aC=keyOf(aB)






az[#az+1]={
slot=aB,
w=weightOf(aC and ay[aC]or nil),
home=tonumber(aB.Name)or 0,
}
end
end

table.sort(az,function(aA,aB)
if aA.w~=aB.w then
if aq then return aA.w>aB.w end
return aA.w<aB.w
end


return aA.home<aB.home
end)

for aA,aB in ipairs(az)do aB.slot.LayoutOrder=aA end
end









local ax={}

local function paint()
for ay,az in pairs(ax)do
for aA,aB in pairs(az.buttons)do
local aC=(aA==ap)
aB.TextColor3=aC and af or ag
aB.BackgroundColor3=aC and ae or ad
end
if az.dir then az.dir.Text=aq and"best top"or"best last"end
end
end

local function buildFor(ay)
local az=ax[ay.name]
if az and az.strip.Parent then return end







local aA=ay.anchor:FindFirstChild"ApelInventorySort"
if aA then aA:Destroy()end

local aB=Instance.new"Frame"
aB.Name="ApelInventorySort"
aB.BackgroundColor3=ad
aB.BackgroundTransparency=0.1
aB.BorderSizePixel=0
aB.AnchorPoint=Vector2.new(0.5,1)

aB.Position=UDim2.new(0.5,0,0,-42)
aB.Size=UDim2.new(0.62,0,0,30)
aB.Parent=ay.anchor

local aC=Instance.new"UICorner"
aC.CornerRadius=UDim.new(0,6)
aC.Parent=aB
local aD=Instance.new"UIStroke"
aD.Color=ae
aD.Parent=aB

local aE=Instance.new"TextLabel"
aE.BackgroundTransparency=1
aE.FontFace=ah
aE.TextSize=14
aE.TextColor3=af
aE.TextXAlignment=Enum.TextXAlignment.Left
aE.Position=UDim2.fromOffset(10,0)
aE.Size=UDim2.fromOffset(60,30)
aE.Text="Sort"
aE.Parent=aB

local aF=Instance.new"Frame"
aF.BackgroundTransparency=1
aF.Position=UDim2.fromOffset(70,5)
aF.Size=UDim2.new(1,-150,0,20)
aF.Parent=aB

local aG=Instance.new"UIListLayout"
aG.FillDirection=Enum.FillDirection.Horizontal
aG.Padding=UDim.new(0,4)
aG.SortOrder=Enum.SortOrder.LayoutOrder
aG.Parent=aF

local aH={}
for aI,aJ in ipairs(aj)do
local aM=Instance.new"TextButton"
aM.BackgroundColor3=ad
aM.BorderSizePixel=0
aM.AutoButtonColor=false
aM.FontFace=ah
aM.TextSize=13
aM.TextColor3=ag
aM.Text=aJ
aM.LayoutOrder=aI
aM.Size=UDim2.fromOffset(58,20)
aM.Parent=aF
local aN=Instance.new"UICorner"
aN.CornerRadius=UDim.new(0,4)
aN.Parent=aM
aH[aJ]=aM

regConn(aM.MouseButton1Click:Connect(function()
ap=aJ
saveChoice(ap,aq)
paint()
applySort()
end))
end


local aI=Instance.new"TextButton"
aI.BackgroundColor3=ae
aI.BorderSizePixel=0
aI.AutoButtonColor=false
aI.FontFace=ah
aI.TextSize=13
aI.TextColor3=Color3.new(1,1,1)
aI.AnchorPoint=Vector2.new(1,0.5)
aI.Position=UDim2.new(1,-10,0.5,0)
aI.Size=UDim2.fromOffset(64,20)
aI.Text=aq and"best top"or"best last"
aI.Parent=aB
local aJ=Instance.new"UICorner"
aJ.CornerRadius=UDim.new(0,4)
aJ.Parent=aI

regConn(aI.MouseButton1Click:Connect(function()
aq=not aq
saveChoice(ap,aq)
paint()
applySort()
end))

ax[ay.name]={strip=aB,buttons=aH,dir=aI}
paint()


regConn(ay.grid.ChildAdded:Connect(queueSort))
end

local function build()
for ay,az in ipairs(openMenus())do
buildFor(az)
end
end




spawnLoop(function()
while not _apelStopped do
pcall(function()
build()


if ap~="Off"then applySort()end
end)
task.wait(0.5)
end
end)
end end function a.ab():typeof(__modImpl())local aa=a.cache.ab if not aa then aa={c=__modImpl()}a.cache.ab=aa end return aa.c end end end






















if not LPH_OBFUSCATED then
function LPH_ATTRIBUTES()end
function VM()end
NONE=nil
end

local aa=a.a()

local ab=a.c()
local ac=a.d()
local ad=a.e()
local ae=a.f()
local af=a.g()

local ag=a.h()
local ah=a.i()
local ai=a.k()

local aj=a.l()
local ak=a.p()
local al=a.q()
local an=a.r()
local ap=a.s()
local aq=a.t()
local ar=a.u()

local as=a.G()
local au=a.I()
local av=a.J()
local aw=a.P()
local ax=a.S()
local ay=a.T()
local az=a.V()
local aA=a.W()
local aB=a.Y()
local aC=a.Z()
local aD=a._()
local aE=a.aa()
local aF=a.ab()


ab.begin()


local aG=ac()
ad(aa)
aj.Init(aa.Debug)
local aH=ae()local


aI, aJ=ag(aG,aa,aH)


af()




local aM=as(aJ)
au(aJ)
av(aJ)
aw(aJ)
ax(aJ)
ay(aJ)
az(aJ)

aE()
aF()










ak.Prefetch=an.Prefetch


ak.WantReport=function()return S.webhookOn==true end



ak.OnOutcome=al.Note







if aH then
aq.Start()



ar.Start()

ak.Watch(
function(aN)
if S.webhookOn then pcall(an.Run,aN)end
end,
function()
if aM then pcall(aM)end
end
)
end

local aN=Window:CreateMinimizer{
Size=UDim2.fromOffset(50,50),
Position=UDim2.new(1,-10,0.5,0),
Icon="rbxassetid://138310609771261",
}

local aO=ah(Window,aJ,aN)
aA(Window,aJ,aO)
aB(Window,aJ)
aC(Window,aJ,aa)
aD(Window,aJ,aO,aa)


ai(Window)



if getgenv then
getgenv().ApelHub={
Build="04.09 05:32:10",
S=S,
Window=Window,
Priority=a.j(),
Dungeon=a.o(),
Danger=a.x(),


Route=a.L(),

Nav=a.M(),
Items=a.R(),
Lobby=a.E(),


Cases=a.U(),
Character=ap,
Webhook=an,
Run=ak,
}
end


Window:SetFolder(aa.ConfigFolder)
task.spawn(function()Window:LoadAutoLoadConfig()end)

Window:Select"Information"

task.spawn(function()
task.wait(0.5)
if _G.KeyExpiresAt then Window:SetKeyTimer(_G.KeyExpiresAt)end
print"Apel Hub loaded!"
end)




Window:OnUnload(function()
S.autoFarm,S.noclip,S.speedOn=false,false,false
S.autoReplay=false
S.autoSell,S.autoUpgrade=false,false
S.autoJoin,S.autoRaid,S.autoStartLobby=false,false,false

pcall(ap.Stop)
pcall(ar.Restore)
end)

ab.install(Window)
