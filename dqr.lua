local a={cache={}::any}do do local function __modImpl()

return{
GameName="Dungeon Quest Reborn",





HUB_URL="https://apelhub.com/loader.lua",






DEV_URL="http://localhost:8081/DQR.lua",


ConfigFolder="ApelHub",




Debug=true,
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



Test=Window:Page"Test",
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












HostCtl=tabs.Joiner:Section("Party",{Side="Left"}),
Hoster=tabs.Joiner:Section("Hoster",{Side="Left",Scroll=true,Height=0.55}),
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








Cosmetic=tabs.Misc:Section("Cosmetic Getter",{Side="Right",Scope="lobby"}),



Test=tabs.Test:Section("Walk Farm",{Side="Left"}),

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









local b={enabled=false}

local c="ApelHub/DQR_debug.txt"










local d=4194304
local e="ApelHub/DQR_debug.prev.txt"



local function canWrite()
return type(writefile)=="function"and type(isfile)=="function"
end

function b.Init(f)
b.enabled=f==true
if not b.enabled or not canWrite()then return end
pcall(function()
if type(isfolder)=="function"and type(makefolder)=="function"and not isfolder"ApelHub"then
makefolder"ApelHub"
end
if isfile(c)and type(readfile)=="function"then
local g=readfile(c)
if#g>d then
writefile(e,g)
writefile(c,"")
end
end
end)
b.Log("=== start · place",game.PlaceId,"· job",tostring(game.JobId):sub(1,8))
end







local f,g={},0

local function flush()
if#f==0 then return end
local h=table.concat(f)
table.clear(f)
pcall(function()
if type(appendfile)=="function"then
appendfile(c,h)
else
local i=isfile(c)and readfile(c)or""
writefile(c,i..h)
end
end)
end

function b.Flush()flush()end









local h="ApelHub/DQR_deaths.txt"



local i="ApelHub/DQR_bridge.txt"



local j="ApelHub/DQR_timing.txt"

function b.Death(k)
if not b.enabled or not canWrite()then return end
pcall(function()
local l=os.date"[%d.%m %H:%M:%S] "..tostring(k).."\n"
if type(appendfile)=="function"then
appendfile(h,l)
else
local m=isfile(h)and readfile(h)or""
writefile(h,m..l)
end
end)
end








function b.Bridge(k)
if not b.enabled or not canWrite()then return end
pcall(function()
local l=os.date"[%d.%m %H:%M:%S] "..tostring(k).."\n"
if type(appendfile)=="function"then
appendfile(i,l)
else
local m=isfile(i)and readfile(i)or""
writefile(i,m..l)
end
end)
end

function b.Timing(k)
if not b.enabled or not canWrite()then return end
pcall(function()
local l=os.date"[%H:%M:%S] "..tostring(k).."\n"
if type(appendfile)=="function"then
appendfile(j,l)
else
local m=isfile(j)and readfile(j)or""
writefile(j,m..l)
end
end)
end











local k,l,m=0,0
local n=5

local function push(o)
f[#f+1]=("[%s] %s\n"):format(os.date"%H:%M:%S",o)
end

local function collapse(o)
if o==m then
k=k+1
if os.clock()-l<n then return false end
push(("    ↑ повторилось %d раз за %.0f с, продолжается"):format(k,os.clock()-l))
k,l=0,os.clock()
return true
end
if k>0 then
push(("    ↑ повторилось %d раз за %.1f с"):format(k,os.clock()-l))
end
m,k,l=o,0,os.clock()
push(o)
return true
end

function b.Log(...)
if not b.enabled or not canWrite()then return end
local o={}
for p,q in ipairs{...}do o[#o+1]=tostring(q)end
if not collapse(table.concat(o," "))then return end



local p=os.clock()
if#f>=40 or p-g>1 then
g=p
flush()
end
end

function b.Dump(o,p,q)
p=p or 0
q=q or""
local r=typeof(o)

if r=="Instance"then
local s={}
for u,v in ipairs(o:GetChildren())do
s[#s+1]=v.Name.."("..v.ClassName
..(v:IsA"ValueBase"and("="..tostring(v.Value))or"")..")"
end
return("Instance<%s '%s'>{%s}"):format(o.ClassName,o.Name,table.concat(s,", "))
end

if r=="table"then
if p>3 then return"{...}"end
local s={}
for u,v in pairs(o)do
s[#s+1]=("%s  %s = %s"):format(q,tostring(u),b.Dump(v,p+1,q.."  "))
end
if#s==0 then return"{}"end
return"{\n"..table.concat(s,",\n").."\n"..q.."}"
end

return tostring(o)
end

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
r(("ПЕРЕНОС [%s] %.0f,%.0f,%.0f -> %.0f,%.0f,%.0f | прыжок %.0f | пол под целью %s"):format(
p,
w.Position.X,w.Position.Y,w.Position.Z,
u.X,u.Y,u.Z,
x==math.huge and-1 or x,
hasGroundUnder(u)and"есть"or"НЕТ"))
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













local b=a.l()

local c={}

local d=2.5
local e=90
local f=600
local g=1

local h={}
local i=false


local function ours(j)
local k=j:GetFullName()
return k:find("Apel",1,true)~=nil
or(LocalPlayer and k:find(LocalPlayer.Name,1,true)~=nil)
end

function c.Start()
if i then return end
i=true

regConn(workspace.DescendantAdded:Connect(function(j)
if not j:IsA"BasePart"then return end
h[#h+1]={at=os.clock(),part=j}
if#h>f then table.remove(h,1)end
end))

spawnLoop(function()
local j
while not _apelStopped do
task.wait(0.05)

local k=LocalPlayer and LocalPlayer.Character
local l=k and k:FindFirstChildOfClass"Humanoid"
local m=k and k:FindFirstChild"HumanoidRootPart"
if not l or not m then
j=nil
else
local n=l.Health
if j and n<j-g then
local o=os.clock()
local p={}
for q,r in ipairs(h)do
local s=r.part
if o-r.at<=d and s.Parent and not ours(s)then
local u=(s.Position-m.Position).Magnitude
if u<=e then
p[#p+1]=("%s [%.2fс, %.1fx%.1fx%.1f, %s, d=%.0f]")
:format(s:GetFullName(),o-r.at,
s.Size.X,s.Size.Y,s.Size.Z,s.Material.Name,u)
end
end
end
b.Log(("СЛЕЖКА: удар -%.0f hp | появилось за %.1fс: %s")
:format(j-n,d,
#p>0 and("\n    "..table.concat(p,"\n    "))or"НИЧЕГО"))
end
j=n
end


local n=os.clock()
while h[1]and n-h[1].at>d do table.remove(h,1)end
end
end)
end

return c end function a.t():typeof(__modImpl())local b=a.cache.t if not b then b={c=__modImpl()}a.cache.t=b end return b.c end end do local function __modImpl()













local b=a.o()
local c=a.l()

local d={}



local e={pirate=
{{"room5","barrier"}},
}















local f={ghastly=
{"Anchor2_Circle"},
}


local g={}

local function pathTo(h)
local i=workspace:FindFirstChild"dungeon"
for j,k in ipairs(h)do
if not i then return nil end
i=i:FindFirstChild(k)
end
return i
end




local h

local function openDecor(i)
local j
for k,l in pairs(f)do
if i:find(k,1,true)then j=l break end
end
if not j then return end


for k in pairs(g)do
if k.Parent and k.CanCollide then k.CanCollide=false end
end
if h==i then return end
h=i

local k=0
for l,m in ipairs(workspace:GetDescendants())do
if m:IsA"BasePart"and m.CanCollide then
for n,o in ipairs(j)do
if m.Name:find(o,1,true)then
g[m]=true
m.CanCollide=false
k=k+1
break
end
end
end
end
if k>0 then
c.Log(("БАРЬЕР: снял коллизию с %d украшений (%s) — они стоят в проходе")
:format(k,table.concat(j,", ")))
end
end

local function openOnce()
local i=tostring(b.Name()or""):lower()
openDecor(i)

local j
for k,l in pairs(e)do
if i:find(k,1,true)then j=l break end
end
if not j then return end

for k,l in ipairs(j)do
local m=pathTo(l)
if m and m:IsA"BasePart"and m.CanCollide then
g[m]=true
m.CanCollide=false
c.Log(("БАРЬЕР: снял коллизию с %s (%.0fx%.0fx%.0f)")
:format(m:GetFullName(),m.Size.X,m.Size.Y,m.Size.Z))
end
end
end

function d.Start()






spawnLoop(function()
while not _apelStopped do
pcall(openOnce)
task.wait(2)
end
end)
end

function d.Restore()
for i in pairs(g)do
pcall(function()if i.Parent then i.CanCollide=true end end)
end
table.clear(g)
h=nil
end

return d end function a.u():typeof(__modImpl())local b=a.cache.u if not b then b={c=__modImpl()}a.cache.u=b end return b.c end end do local function __modImpl()













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











dodgeNamed={"rockfall","камень"},









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
name=A and"рейд · арена"or"Aquatic Temple · первый босс",
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





local f={}

local function sight(g,h,i)
LPH_ATTRIBUTES(VM(NONE))
if not b.enabled then return end
local j=g.."|"..h
if f[j]then return end
f[j]=true
b.Log(("ZONE %s: %s %s"):format(g,h,i or""))
end








local function isTelegraphName(g)
LPH_ATTRIBUTES(VM(NONE))
local h=tostring(g):lower()















return h:find("hitbox",1,true)~=nil
or h:find("precast",1,true)~=nil
or h:find("hitindicator",1,true)~=nil
end



















local g={
poisonBomb=13,
iceBomb=20,
explosiveBomb=18,












["Ice Minion"]=7,











["Flame Cyclone"]=30,












["Infected Pirate"]=7,































































["Northern Warrior"]=13,
}











local function hazardRadius(h,i)
LPH_ATTRIBUTES(VM(NONE))
local j=h:FindFirstChildWhichIsA"UnionOperation"
if j then
local k=j.Size



if math.min(k.X,k.Y,k.Z)<2 then
local l=math.max(k.X,k.Y,k.Z)
if l>4 then return l*0.5 end
end
end
return i
end












































local h=1.365






local i=4







local j=0.3














local k={
outwardblastsize=0.15,
}
















local l={
crossbeam=0.9,
}




















local m={
silkblast=5.5,













northernwarriorcirclestrike=1.5,





















}






























local n={}


local function dangerLifeFor(o)
LPH_ATTRIBUTES(VM(NONE))
local p=m[tostring(o.Name):lower()]
if p then return p end
local q=o.Parent
return q and m[tostring(q.Name):lower()]or nil
end

local function dangerDelayFor(o)
LPH_ATTRIBUTES(VM(NONE))
local p=l[tostring(o.Name):lower()]
if p then return p end
local q=o.Parent
return q and l[tostring(q.Name):lower()]or nil
end

local function ghostLifeFor(o)
LPH_ATTRIBUTES(VM(NONE))
local p=tostring(o or""):lower()
for q,r in pairs(k)do
if p:find(q,1,true)then return r end
end
return j
end

local o={}













local p={}

function d.Note(q,r)
LPH_ATTRIBUTES(VM(NONE))
p[q]=r
end

function d.NotesText()
LPH_ATTRIBUTES(VM(NONE))
local q={}
for r,s in pairs(p)do q[#q+1]=("%s=%s"):format(r,tostring(s))end
table.sort(q)
return#q>0 and table.concat(q," ")or"-"
end


function d.PartInfo(q)
LPH_ATTRIBUTES(VM(NONE))
if typeof(q)~="Instance"or not q:IsA"BasePart"then return"-"end
local r=o[q]
local s=(type(r)=="table"and r.born)and(os.clock()-r.born)or-1
local u=isCylinder(q)and"цилиндр"or"блок"






local v=""
if s<0 then
v=q.Parent and" [нет в зонах]"or" [деталь уничтожена игрой]"
end
return("%s/%s %s %.1fx%.1fx%.1f возраст %.2fс%s"):format(
q.Parent and q.Parent.Name or"?",q.Name,u,
q.Size.X,q.Size.Y,q.Size.Z,s,v)
end

function d.TimeToHit(q)
LPH_ATTRIBUTES(VM(NONE))
local r=o[q]
if type(r)~="table"or not r.born then return nil end
local s=tostring(q.Parent and q.Parent.Name or q.Name):lower()
local u=n[s]or n[tostring(q.Name):lower()]
if not u then return nil end
return u-(os.clock()-r.born)
end

local q={}











local r={cyclone=46}

local s={}
local u=0

local function updateSpins()
LPH_ATTRIBUTES(VM(NONE))
local v=os.clock()
if v-u<0.12 then return end
u=v



local w=c.Value"spin"
if not w then
if next(s)then table.clear(s)end
return
end

for x,y in pairs(s)do
if y.expires<=v or not x.Parent then s[x]=nil end
end

local x=game.Players.LocalPlayer.Character
local y=x and x:FindFirstChild"HumanoidRootPart"
local z=workspace:FindFirstChild"dungeon"
if not y or not z then return end










for A,B in ipairs(z:GetChildren())do
local C=B:FindFirstChild"enemyFolder"
if C then
for D,E in ipairs(C:GetChildren())do
if E:IsA"Model"then
local F,G=pcall(function()return E:GetPivot().Position end)
if F and(G-y.Position).Magnitude<130 then
local H=E:FindFirstChildWhichIsA"Humanoid"
if H then
local I,J=pcall(function()
return H:GetPlayingAnimationTracks()end)
if I then
for K,L in ipairs(J)do
local M=r[tostring(L.Name):lower()]
if M then


if type(w)=="number"then
M=w
end


s[E]={radius=M,expires=v+1}
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
local v={}












local w=setmetatable({},{__mode="k"})















local x={
secondbossdamageparts=true,
miyamotoflames=true,
}

local y,z=0

local function revealableParts()
LPH_ATTRIBUTES(VM(NONE))
if z and os.clock()-y<5 then return z end
local A={}
for B,C in ipairs(workspace:GetChildren())do
if x[tostring(C.Name):lower()]then
for D,E in ipairs(C:GetDescendants())do
if E:IsA"BasePart"then A[#A+1]=E end
end
end
end
z,y=A,os.clock()
return A
end

local function updateRevealed()
LPH_ATTRIBUTES(VM(NONE))
for A,B in ipairs(revealableParts())do
if B.Parent and B.Transparency<0.95 then
if not o[B]then o[B]={flat=0,vert=0}end
elseif o[B]then
o[B]=nil
end
end
end



















local A={}

local function kinOf(B)
LPH_ATTRIBUTES(VM(NONE))
local C=B.Parent
return(C and C:IsA"Model")and C or nil
end

local function modelLit(B)
LPH_ATTRIBUTES(VM(NONE))
for C,D in ipairs(B:GetChildren())do
if D:IsA"BasePart"and D.Transparency<0.95 then return true end
end
return false
end



























local B={
northernMageShot=true,
spearmanStrikeHitbox=true,
northernWarriorCircleStrike=true,
northernWarriorLineStrike=true,
}

local function neverSleep(C)
LPH_ATTRIBUTES(VM(NONE))
local D=C and C.Parent
return D~=nil and B[D.Name]==true
end

local function zoneDark(C,D)
LPH_ATTRIBUTES(VM(NONE))















return type(C)=="table"and C.dark==true
end






local C=8

local D=18



local E=0.45












local F={
secondbosscrescent=2.5,





harpoonmodel=2,


steampunkrangemobshot=2,

}

local function lookaheadOf(G)
LPH_ATTRIBUTES(VM(NONE))
local H=G.Parent and tostring(G.Parent.Name):lower()or""
return F[H]or F[tostring(G.Name):lower()]or E
end



local G=0

















local H={["flame cyclone"]=true}
local I=8






















local J={}
local K=20











local L={}







local M=800



















local N=setmetatable({},{__mode="k"})







local O=setmetatable({},{__mode="k"})
local P,Q=0
local R,T=0,0

function d.HitStats()
LPH_ATTRIBUTES(VM(NONE))
return R,T
end




local U

local function noteTrail()
LPH_ATTRIBUTES(VM(NONE))
local V=LocalPlayer.Character
local W=V and V:FindFirstChild"HumanoidRootPart"
if not W then return end
table.insert(J,1,W.Position)
if#J>K then table.remove(J)end

local X=d.ZoneAt(W.Position,0)
table.insert(L,1,{
t=os.clock(),
p=W.Position,
safe=X==nil,
name=X and("%s/%s"):format(
(X.Parent and X.Parent.Name)or(X.name and tostring(X.name))or"?",
X.Name or"слепок")or nil,
})
if#L>M then table.remove(L)end
end









local V=0

function d.NoteHop()
LPH_ATTRIBUTES(VM(NONE))
V=os.clock()
end

function d.SinceHop()
LPH_ATTRIBUTES(VM(NONE))
return V>0 and(os.clock()-V)or-1
end

function d.SafeTrail(W)
LPH_ATTRIBUTES(VM(NONE))
local X=os.clock()
local Y,Z,_=0,0,{}
local aa
for ab,ac in ipairs(L)do
if X-ac.t>(W or 1.5)then break end
Z=Z+1
if not ac.safe then
Y=Y+1
aa=X-ac.t
if ac.name and not _[ac.name]then _[ac.name]=0 end
if ac.name then _[ac.name]=_[ac.name]+1 end
end
end
if Z==0 then return"хроники нет"end
if Y==0 then




local ab=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
local ac="?"
if ab then
local ad=d.NearestZones(ab.Position,1)
ac=(type(ad)=="table"and ad[1])or"зон рядом нет вовсе"
end








local ad=""
if ab then
local ae,af=1e9
for ag,ah in ipairs(workspace:GetChildren())do
local ai=ah.Name
if ai=="groundAura"or ai=="spearmanStrike"then
for aj,ak in ipairs(ah:GetDescendants())do
if ak:IsA"BasePart"then
local al=ak.CFrame:PointToObjectSpace(ab.Position)
local am=ak.Size*0.5
local an=Vector3.new(
math.max(math.abs(al.X)-am.X,0),
math.max(math.abs(al.Y)-am.Y,0),
math.max(math.abs(al.Z)-am.Z,0)).Magnitude
if an<ae then
ae,af=an,("%s (%s)"):format(ai,tostring(ak.Size))
end
end
end
end
end
if af then
ad=(" | вне зон рядом: %s снаружи на %.1f"):format(af,ae)
end
end
return("хроника %.1fс: под ударом 0 из %d кадров — удар пришёл в ЧИСТОЕ место | ближайшая зона: %s%s")
:format(W or 1.5,Z,ac,ad)
end
local ab={}
for ac,ad in pairs(_)do ab[#ab+1]=("%s x%d"):format(ac,ad)end






local ac,ad=0,0
local ae,af=0,0
local ag,ah,ai
for aj,ak in ipairs(L)do
if X-ak.t>(W or 1.5)then break end
if ak.p then
if ag then
local al=(Vector3.new(ak.p.X,0,ak.p.Z)-Vector3.new(ag.X,0,ag.Z)).Magnitude
if al<8 then
ac=ac+al


if not ak.safe then
ae=ae+al
af=af+math.abs((ah or ak.t)-ak.t)
end
end
end
ag,ah=ak.p,ak.t
ai=ai or ak.p
end
end
if ai and ag then
ad=(Vector3.new(ai.X,0,ai.Z)-Vector3.new(ag.X,0,ag.Z)).Magnitude
end






local aj=""
do



local ak=L[1]and L[1].p
local al=ak and{Position=ak}or nil
if al then


local am
for an,ao in pairs(o)do
if an.Parent and not zoneDark(ao,an)then
local ap=(type(ao)=="table"and ao.flat or 0)
local aq=an.CFrame:PointToObjectSpace(al.Position)
local ar=an.Size*0.5+Vector3.new(ap,0,ap)
if math.abs(aq.X)<=ar.X and math.abs(aq.Z)<=ar.Z
and math.abs(aq.Y)<=ar.Y then
local as=math.min(ar.X-math.abs(aq.X),ar.Z-math.abs(aq.Z))
if not am or as<am then am=as end
end
end
end
if am then aj=(" | до выхода было %.1f студа"):format(am)end
end
end
return("хроника %.1fс: под ударом %d из %d кадров, самый ранний за %.2fс до удара (%s) | ногами прошёл %.1f, сместился %.1f | ПОД УДАРОМ прошёл %.1f за %.2fс (%.1f студ/с)"..aj)
:format(W or 1.5,Y,Z,aa or 0,table.concat(ab,", "),ac,ad,
ae,af,af>0.01 and(ae/af)or 0)
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
if ai and(ai.Position-ae).Magnitude<=I then return true end
local aj,ak=pcall(function()return ah:GetPivot().Position end)
if aj and(ak-ae).Magnitude<=I then return true end
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
if ag:IsA"Model"and H[tostring(ag.Name):lower()]then
if not ac[ag]then
local ah,ai=pcall(function()return ag:GetPivot().Position end)
if ah and ridesPlayer(ai)then
ac[ag]=true
for aj,ak in ipairs(ag:GetDescendants())do o[ak]=nil end
end
end












if ac[ag]then q[ag]=nil end
end
end
end

local function updateMotion()
LPH_ATTRIBUTES(VM(NONE))
local ae=os.clock()
local af=ae-G
if af<1.1111111111111112E-2 then return end
G=ae

for ag in pairs(o)do
if ag.Parent then
local ah=w[ag]
local ai=ag.Position
if ah and ah.pos and af>0 then














if ah.cfPrev then
local aj,ak=pcall(function()
local aj=ag.CFrame*ah.cfPrev:Inverse()local
ak, al=aj:ToAxisAngle()


if math.abs(al)<0.002 then return nil end
local am=ag.CFrame
for an=1,C do am=aj*am end
return am
end)
ah.future=aj and ak or nil
end
ah.cfPrev=ag.CFrame
local aj=(ai-ah.pos)/af
local ak=aj.Magnitude
ah.pos=ai



ah.speed=ak
if ak>=D then
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
w[ag]={pos=ai}
end
else
w[ag]=nil
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
local as=ar.Name:lower()
if not an[as]then ak[as]=true end
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
v[#v+1]={
cf=al,size=am,cylinder=an,
flat=ap or 0,vert=aq or 0,
name=ao,expires=os.clock()+ghostLifeFor(ao),
}
end
























function d.Foresee(al,am,an,ao,ap,aq,ar)
LPH_ATTRIBUTES(VM(NONE))
if typeof(al)~="CFrame"or typeof(am)~="Vector3"then return end
v[#v+1]={
cf=al,size=am,cylinder=ar or false,
flat=ap or 0,vert=aq or 0,
name=ao or"предвидение",expires=os.clock()+(an or 1),
}
end

local function consider(al)
LPH_ATTRIBUTES(VM(NONE))
if not al:IsA"BasePart"then return end
local am=al.Parent and al.Parent.Name or"?"


if isIgnoredAttack(al)then
sight("игнор",am.."/"..al.Name,tostring(al.Size))
return
end




if al:IsDescendantOf(workspace)
and al:FindFirstAncestor"secondBossSafeSpots"then
sight("укрытие",am.."/"..al.Name,"не опасность")
return
end








if al.Name=="ApelMark"then return end



if ag[tostring(al.Name):lower()]
or ag[tostring(am):lower()]then
sight("укрытие",am.."/"..al.Name,tostring(al.Size))
return
end

if isOwnProjectile(al)then
sight("своё",am.."/"..al.Name,tostring(al.Size))
return
end
if not(isTelegraphName(al.Name)or isTelegraphName(am)
or isAttackModelPart(al)or isBlastPart(al)or isPrecastNeon(al)
or isLooseAttackPart(al))then
return
end
if ownedByEnemy(al)then


sight("отброшено-моб",am.."/"..al.Name,tostring(al.Size))
return
end









if ae[am:lower()]and isTelegraphName(al.Name)then
local an=game.Players.LocalPlayer.Character
local ao=an and an:FindFirstChild"HumanoidRootPart"
if ao then







af=os.clock()
sight("нацелен",am.."/"..al.Name,"включаю отход")
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
sight("наводка",am.."/"..al.Name,"родилась на нас, отхожу")
end
end
end

sight("принято",am.."/"..al.Name,tostring(al.Size))
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
ao=math.max(ao,i)
end
elseif al.Size.Y<=2 then
ao=math.max(ao,i)
end

local ap=dangerDelayFor(al)
local aq=dangerLifeFor(al)
o[al]={






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
local am=g[al.Name]
if am then
am=hazardRadius(al,am)
q[al]=am
sight("угроза",al.Name,("радиус %.0f"):format(am))
elseif b.enabled and al:IsA"Model"then






if al==LocalPlayer.Character then return end
local an=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
local ao=an and al:FindFirstChildWhichIsA("BasePart",true)
if an and ao and(ao.Position-an.Position).Magnitude<60 then



local ap,aq={},0
for ar,as in ipairs(al:GetDescendants())do
if as:IsA"BasePart"and aq<5 then
aq=aq+1
ap[#ap+1]=("%s %s"):format(as.Name,tostring(as.Size))
end
end
sight("рядом-неизвестное",al.Name,table.concat(ap," | "))
end
end
end










local al={}












local am={}

function d.CoverReport()
LPH_ATTRIBUTES(VM(NONE))
if#am==0 then return"накрытий не было"end
local an,ao=os.clock(),{}
for ap=#am,1,-1 do
local aq=am[ap]
ao[#ao+1]=("%s: за %.2fс до, внутри %s"):format(
aq.name,an-aq.born,
aq.left and("%.2fс"):format(aq.left)or"ВСЁ ЕЩЁ ВНУТРИ")
if#ao>=5 then break end
end
return("%d накрытий | %s"):format(#am,table.concat(ao," ;; "))
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
local as=an.Size*0.5
if not(math.abs(ar.X)<=as.X and math.abs(ar.Y)<=as.Y
and math.abs(ar.Z)<=as.Z)then
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
local as=an.Size*0.5
local W=math.abs(ar.X)<=as.X
and math.abs(ar.Y)<=as.Y
and math.abs(ar.Z)<=as.Z

if W and b.enabled then watchCover(an)end

al[#al+1]={
t=os.clock(),gap=aq,
name=tostring(an.Parent and an.Parent.Name).."/"..tostring(an.Name),
size=tostring(an.Size),
mat=tostring(an.Material):gsub("Enum.Material.",""),
taken=o[an]~=nil,
covered=W,
}


if#al>1200 then table.remove(al,1)end
end



function d.MotionInfo()
LPH_ATTRIBUTES(VM(NONE))
local an,ao,ap=0,0
for aq,ar in pairs(w)do
if aq.Parent and ar.cf then
local as=ar.size and ar.size.Z or 0
local W=as>0 and(as/E)or 0
if W>an then ap,an,ao=aq,W,as end
end
end
if not ap then return"движущихся зон нет"end
return("%s | скорость ~%.0f студ/с | коридор %.0f студов"):format(
tostring(ap.Parent and ap.Parent.Name).."/"..tostring(ap.Name),
an,ao)
end








function d.RecentAdds(an)
LPH_ATTRIBUTES(VM(NONE))
local ao,ap=os.clock(),an or 2
local aq={}
for ar=#al,1,-1 do
local as=al[ar]
if ao-as.t>ap then break end
aq[#aq+1]=as
end
table.sort(aq,function(ar,as)
if ar.covered~=as.covered then return ar.covered end
return ar.t>as.t
end)

local ar={}
for as,W in ipairs(aq)do
ar[#ar+1]=("%.2fс назад | %.1f студ | %s | %s | %s | принято=%s | НАКРЫЛА=%s"):format(
ao-W.t,W.gap,W.name,W.size,W.mat,tostring(W.taken),tostring(W.covered))
end
return ar
end


















local an=7
local ao=110
local ap=0.9
local aq=0

local ar=0
local function projectMageBeam(as)
LPH_ATTRIBUTES(VM(NONE))
local W=os.clock()
ar=ar+1
if ar%20==1 and b.enabled then
b.Log(("КОРИДОР: попытка %d"):format(ar))
end
if W-aq<0.4 then return end

local X,Y=1e9
local Z=workspace:FindFirstChild"dungeon"
if not Z then return end
for _,au in ipairs(Z:GetChildren())do
local av=au:FindFirstChild"enemyFolder"
if av then
for aw,ax in ipairs(av:GetChildren())do
if ax.Name=="Northern Mage"then
local ay,az=pcall(function()return ax:GetPivot().Position end)
if ay then
local aA=(az-as.Position).Magnitude
if aA<X then Y,X=az,aA end
end
end
end
end
end
if not Y or X<5 or X>130 then return end

local au=Vector3.new(as.Position.X-Y.X,0,as.Position.Z-Y.Z)
if au.Magnitude<1 then return end
au=au.Unit

local av=ao-X
if av<10 then return end
local aw=as.Position+au*(av*0.5)
aq=W
d.Foresee(CFrame.new(aw,aw+au),Vector3.new(an,6,av),
ap,"коридор мага",0,0,false)
if b.enabled then
b.Log(("КОРИДОР МАГА: остаток %.0f студов, коробка в %.0f от мага"):format(av,X))
end
end



local function updatePooled()
LPH_ATTRIBUTES(VM(NONE))
local as=os.clock()
















for au,av in pairs(o)do
if not au.Parent then
o[au]=nil
elseif type(av)=="table"and not av.dark then
if av.over and as>av.over then
av.dark=true
sight("отработала",("%s/%s"):format(
au.Parent and au.Parent.Name or"?",au.Name),"срок вышел")
elseif av.seen and au.Transparency>0.95 and not neverSleep(au)then
av.dark=true
sight("погасла",("%s/%s"):format(
au.Parent and au.Parent.Name or"?",au.Name),"усыплена до следующего замаха")
end
end
end

for au,av in pairs(o)do
local aw=type(av)=="table"and av.kin or nil
if aw and aw.Parent and au.Parent then
if modelLit(aw)then
A[aw.Name]=true










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
sight("зажглась",au.Name,"замах пошёл заново")
end
elseif A[aw.Name]and not av.dark and not neverSleep(au)then




av.dark=true
av.wasLit=nil
sight("догорела",("%s/%s"):format(au.Parent and au.Parent.Name or"?",au.Name),"модель погасла целиком")
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
U()
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
if o[as]then


local au=o[as]
o[as]=nil
remember(as.CFrame,as.Size,isCylinder(as),
("%s/%s"):format(as.Parent and as.Parent.Name or"?",as.Name),
type(au)=="table"and au.flat or 0,
type(au)=="table"and au.vert or 0)
end
q[as]=nil
end))
regConn(workspace.ChildAdded:Connect(considerHazard))
regConn(workspace.ChildRemoved:Connect(function(as)
local au=q[as]
if not au then return end
q[as]=nil

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
for au=#v,1,-1 do
if v[au].expires<=as then table.remove(v,au)end
end
end

function d.Count()
LPH_ATTRIBUTES(VM(NONE))






sweepGhosts()

local as=0
for au,av in pairs(o)do
if not au.Parent then o[au]=nil
elseif not zoneDark(av,au)then as=as+1 end
end
for au in pairs(q)do
if au.Parent then as=as+1 else q[au]=nil end
end
return as+#v
end


















local as=2






local function penetrationOf(au,av,aw,ax,ay,az)
LPH_ATTRIBUTES(VM(NONE))
local aA=au:PointToObjectSpace(ax)
local W=ay
local X=az

if aw then
local Y=av.Y*0.5+W


local Z=av.X*0.5+X
local _=math.sqrt(aA.Y^2+aA.Z^2)
if math.abs(aA.X)>Z or _>Y then return nil end
return Y-_
end

local Y=av*0.5+Vector3.new(W,X,W)
if math.abs(aA.X)>Y.X then return nil end
if math.abs(aA.Y)>Y.Y then return nil end
if math.abs(aA.Z)>Y.Z then return nil end
return math.min(Y.X-math.abs(aA.X),Y.Z-math.abs(aA.Z))
end

local function penetration(au,av,aw)
LPH_ATTRIBUTES(VM(NONE))







local ax=o[au]
local ay=type(ax)=="table"and ax.flat or 0
local az=type(ax)=="table"and ax.vert or 0
















local aA=w[au]
local W=(aA and aA.size)and aA.size.Z or 0
local X=au.Size
local Y=au.Position
local Z=av.Y-Y.Y
local _=X.Y*0.5+math.min(aw,as)+az
+W+6
if Z<-_ or Z>_ then return nil end

local aB,aC=av.X-Y.X,av.Z-Y.Z
local aD=math.max(X.X,X.Z)*0.71+aw+ay+W+6
if aB*aB+aC*aC>aD*aD then return nil end
local aE=aw+ay
local aF=math.min(aw,as)+az
local aG=penetrationOf(au.CFrame,au.Size,isCylinder(au),av,aE,aF)
if aG then return aG end






if aA and aA.future then
local aH=penetrationOf(aA.future,au.Size,isCylinder(au),av,aE,aF)
if aH then return aH end
end

if aA and aA.cf then
return penetrationOf(aA.cf,aA.size,false,av,aE+2,aF+1)
end
return nil
end


local function hazardAt(au,av)
LPH_ATTRIBUTES(VM(NONE))
for aw,ax in pairs(q)do
if aw.Parent then
local ay=hazardPoint(aw)


if ay then
local az=Vector3.new(au.X-ay.X,0,au.Z-ay.Z)
if az.Magnitude<=ax+av then return aw end
end
else
q[aw]=nil
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

aw[#aw+1]=("y=%.0f до нас %.0f | ближний %s (%.0f) | %s | поворот %.3f | пол %s | вниз %s"):format(
ay.Position.Y,aC,
az and az.Name or"никто",aA,
domeMoves(ay)and"ЕДЕТ = отметка"or"лежит = подбор",
aF,
aD and"есть"or"НЕТ",
aE and"УЕХАЛ"or"нет")
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
local aE=math.max(aC.Size.X,aC.Size.Z)*0.5+h
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
local aG,aH
if aF and aF:IsA"BasePart"then
aG,aH=aF.Position,math.max(aF.Size.X,aF.Size.Z)*0.5
elseif aE:IsA"BasePart"then
aG,aH=aE.Position,math.max(aE.Size.X,aE.Size.Z)*0.5
else
local W,X=pcall(function()return aE:GetPivot().Position end)
if W then aG,aH=X,6 end
end
if aG then
local W=ay and(Vector3.new(ay.X-aG.X,0,ay.Z-aG.Z).Magnitude)or 0
if W<aA then aB,aA,aC=aG,W,aH end
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











for aC in pairs(o)do
if aC.Parent and not zoneDark(o[aC],aC)
and(named(aC.Parent.Name)or named(aC.Name))then
local aD=o[aC]
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
for aD,aE in ipairs(v)do
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
for ay in pairs(o)do
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
for ay,az in pairs(s)do
if ay.Parent and(not ax or az.radius>ax)then ax=az.radius end
end
return ax
end

local function spinThreat(ax,ay)
LPH_ATTRIBUTES(VM(NONE))
local az=0
for aA,aB in pairs(s)do
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

local aH,W=aD.Y,aD.Z
if aG<0.01 then aH,W,aG=1,0,0.01 end
local X=(ax.YVector*(aH/aG))+(ax.ZVector*(W/aG))
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

for aF,aG in pairs(o)do
if aF.Parent then
local aH=az+(type(aG)=="table"and aG.flat or 0)
local W=math.min(az,as)
+(type(aG)=="table"and aG.vert or 0)


if not zoneDark(aG,aF)then
local X,Y=exitVector(aF.CFrame,aF.Size,isCylinder(aF),
ay,aH,W)
if X then note(X,Y)end
end
end
end

local aF=os.clock()
for aG,aH in ipairs(v)do
if aH.expires>aF then
local W,X=exitVector(aH.cf,aH.size,aH.cylinder,ay,
az+(aH.flat or 0),
math.min(az,as)+(aH.vert or 0))
if W then note(W,X)end
end
end













for aG,aH in pairs(q)do
if aG.Parent then
local W=hazardPoint(aG)
if W then
local X=Vector3.new(ay.X-W.X,0,ay.Z-W.Z)
local Y=X.Magnitude
if Y<=aH+az and Y>0.1 then
note(X.Unit,math.min(aH+az-Y,4))
end
end
end
end

if aE>1 then
local aG=Vector3.new(aC.X,0,aC.Z)


if aG.Magnitude/aE>=ax then
sight("выход","равнодействующая",
("зон %d, согласие %.2f, худшая цена %.1f"):format(
aE,aG.Magnitude/aE,aD))
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
local aH=aG.Magnitude
if aH<0.01 then return nil end
local W=math.min((aF+aA)/aH,(aF+aA)*5)
aB=aB+aG.Unit*W
aC=aC+W
end










return nil
end

function d.ZoneAt(ay,az)
LPH_ATTRIBUTES(VM(NONE))







if not e then return nil end
az=az or 0
local aA=os.clock()
for aB,aC in pairs(o)do
if not aB.Parent then
o[aB]=nil
elseif zoneDark(aC,aB)then

elseif type(aC)=="table"and aC.seen and aB.Transparency>0.95
and not neverSleep(aB)then















aC.dark=true
sight("погасла",("%s/%s"):format(aB.Parent and aB.Parent.Name or"?",aB.Name),"усыплена до следующего замаха")
elseif type(aC)=="table"and aC.over and aA>aC.over then


















aC.dark=true
sight("отработала",("%s/%s"):format(aB.Parent and aB.Parent.Name or"?",aB.Name),"усыплена до следующего замаха")
else
local aD=not(type(aC)=="table"and aC.active and aA<aC.active)
if aD and penetration(aB,ay,az)then return aB end
end
end
local aB=os.clock()
for aC,aD in ipairs(v)do
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
local aB=o[aA]
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







if not e then return true end
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

local aH,W=pcall(function()
return workspace:GetPartBoundsInBox(CFrame.new(aE),ay,az)
end)
local X,Y=true
if aH and type(W)=="table"then
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







if not e then return true end
aF=aF or 2.5
local aG=LocalPlayer.Character
if not aG then return true end
if aG~=aA then
aA=aG
az.FilterDescendantsInstances={aG}
end
local aH=Vector3.new(ay.X+aF*2,ay.Y,ay.Z+aF*2)
local W,X=pcall(function()
return workspace:GetPartBoundsInBox(CFrame.new(aE),aH,az)
end)
if not W or type(X)~="table"then return true end
for Y,Z in ipairs(X)do
if attackPart(Z)then return false,Z end
end
return true
end












local aE=0.2

function d.PassAt(aF,aG,aH)
LPH_ATTRIBUTES(VM(NONE))







if not e then return true end
aG=aG or 0
local W=os.clock()
for X,Y in pairs(o)do
if X.Parent and not zoneDark(Y,X)then
local Z=not(type(Y)=="table"and Y.active and W<Y.active)
local _=type(Y)=="table"and Y.over and W>Y.over
if Z and not _ and penetration(X,aF,aG)then
local aI=d.TimeToHit(X)
if not(aI and aH<aI-aE)then
return false,X
end
end
end
end
for aI,X in ipairs(v)do
if X.expires>W and penetrationOf(X.cf,X.size,X.cylinder,aF,
aG+(X.flat or 0),math.min(aG,as)+(X.vert or 0))then
return false,X
end
end
if hazardAt(aF,aG)then return false,nil end
return true
end

U=function()
LPH_ATTRIBUTES(VM(NONE))
local aF=LocalPlayer.Character
if aF~=Q then
Q=aF
P=os.clock()
N=setmetatable({},{__mode="k"})
end
if not aF then return end
local aG=aF:FindFirstChild"HumanoidRootPart"
local aH=aF:FindFirstChildOfClass"Humanoid"
if not aG or not aH or aH.Health<=0 then return end

local aI=aG.Position
local W=os.clock()


for X,Y in pairs(O)do
local Z=false
if X.Parent then
for _,aJ in ipairs(X:GetDescendants())do
if aJ:IsA"BasePart"and o[aJ]and not zoneDark(o[aJ],aJ)
and penetration(aJ,aI,0)then
Z=true
break
end
end
end
if not Z then
b.Log(("ВЫШЕЛ ИЗ НАКРЫТИЯ: %s за %.2fс"):format(Y.name,W-Y.t0))
O[X]=nil
end
end

for aJ,X in pairs(o)do
local Y=aJ.Parent
if aJ.Parent and Y and not N[Y]and not zoneDark(X,aJ)then
local Z=not(type(X)=="table"and X.active and W<X.active)
local _=type(X)=="table"and X.over and W>X.over
if Z and not _ and penetration(aJ,aI,0)then
N[Y]=true
O[Y]={t0=W,name=("%s/%s"):format(Y.Name,aJ.Name)}
R=R+1
local aK=aH.Health
local aL=W-P








local aM=("%s/%s"):format(Y.Name,aJ.Name)









local aN=aF:FindFirstChildOfClass"ForceField"~=nil
local aO=(type(X)=="table"and X.born)and(W-X.born)or-1
task.delay(1,function()
local aP=aH.Health
if aP>=aK then T=T+1 end
b.Log(("ПОПАДАНИЕ: %s | возраст зоны %.2fс | спавн %.1fс назад | щит %s | hp %.0f -> %.0f | %s"):format(
aM,aO,aL,aN and"ЕСТЬ"or"нет",aK,aP,
aP<aK and"УБИЛО"or"ПЕРЕЖИЛИ"))
end)
end
end
end
end





local function threatAt(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
aG=aG+h
local aH=spinThreat(aF,aG)
local aI=os.clock()
for aJ,aK in pairs(o)do
if aJ.Parent
and not(type(aK)=="table"and aK.active and aI<aK.active)
and not(type(aK)=="table"and aK.over and aI>aK.over)
and not zoneDark(aK,aJ)
and not(type(aK)=="table"and aK.seen and aJ.Transparency>0.95)then
local aL=penetration(aJ,aF,aG)
if aL and aL>aH then aH=aL end
end
end
local aJ=os.clock()
for aK,aL in ipairs(v)do
if aL.expires>aJ then
local aM=penetrationOf(aL.cf,aL.size,aL.cylinder,aF,
aG+(aL.flat or 0),math.min(aG,as)+(aL.vert or 0))
if aM and aM>aH then aH=aM end
end
end
for aK,aL in pairs(q)do
if aK.Parent then
local aM=hazardPoint(aK)
if aM then
local aN=Vector3.new(aF.X-aM.X,0,aF.Z-aM.Z)
local aO=aL+aG-aN.Magnitude
if aO>aH then aH=aO end
end
end
end
return aH
end






function d.IsZone(aF)
LPH_ATTRIBUTES(VM(NONE))
return o[aF]~=nil
end

function d.ThreatAt(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
if not e then return 0 end
return threatAt(aF,aG)
end

function d.IsSafe(aF,aG)
LPH_ATTRIBUTES(VM(NONE))
if not e then return true end
aG=(aG or 6)+h
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



local aK,aL=(-99)

local function floorIgnore()
LPH_ATTRIBUTES(VM(NONE))
if aL and os.clock()-aK<0.5 then return aL end
local aM={LocalPlayer.Character}
local aN=workspace:FindFirstChild"dungeon"
if aN then

for aO,aP in ipairs(aN:GetChildren())do
local W=aP:FindFirstChild"enemyFolder"
if W then aM[#aM+1]=W end
end
end
















local aO=workspace:FindFirstChild"enemies"
if aO then aM[#aM+1]=aO end
for aP,W in ipairs(workspace:GetChildren())do
if W~=LocalPlayer.Character and W:IsA"Model"
and W:FindFirstChildWhichIsA"Humanoid"then
aM[#aM+1]=W
end
end









for aP,W in ipairs(workspace:GetChildren())do
if ac[W]or isOwnProjectile(W)then aM[#aM+1]=W end
end










for aP in pairs(o)do
if aP.Parent then aM[#aM+1]=aP end
end
aL,aK=aM,os.clock()
return aM
end











local aM=RaycastParams.new()
aM.FilterType=Enum.RaycastFilterType.Include
aM.IgnoreWater=true

local aN,aO=(-99)





local function borderParts()
LPH_ATTRIBUTES(VM(NONE))
if aO and os.clock()-aN<5 then return aO end

local aP={}
local function take(W)
if W:IsA"BasePart"then
aP[#aP+1]=W
return
end
for X,Y in ipairs(W:GetDescendants())do
if Y:IsA"BasePart"then aP[#aP+1]=Y end
end
end










for W,X in ipairs(workspace:GetChildren())do
local Y=tostring(X.Name):lower()
if Y=="borders"or Y:find("inviswall",1,true)then
take(X)
end
end

aO,aN=aP,os.clock()
return aP
end

local function crossesBorder(aP,W)
LPH_ATTRIBUTES(VM(NONE))
local X=borderParts()
if#X==0 then return false end
aM.FilterDescendantsInstances=X
local Y=W-aP
if Y.Magnitude<0.01 then return false end
return workspace:Raycast(aP,Y,aM)~=nil
end

function d.CrossesBorder(aP,W)
LPH_ATTRIBUTES(VM(NONE))
return crossesBorder(aP,W)
end

local function hasFloor(aP)
LPH_ATTRIBUTES(VM(NONE))
aJ.FilterDescendantsInstances=floorIgnore()
return workspace:Raycast(aP,Vector3.new(0,-aI,0),aJ)~=nil
end












function d.FloorIgnore()
LPH_ATTRIBUTES(VM(NONE))
return floorIgnore()
end



function d.HazardRadius(aP)
LPH_ATTRIBUTES(VM(NONE))
return aP and q[aP]or nil
end

function d.HasFloor(aP)
LPH_ATTRIBUTES(VM(NONE))
return hasFloor(aP)
end

local function ringPoints(aP,W)
LPH_ATTRIBUTES(VM(NONE))
local X={}
for Y=0,aF-1 do
local Z=(Y/aF)*math.pi*2
X[#X+1]=aP+Vector3.new(math.cos(Z)*W,0,math.sin(Z)*W)
end
return X
end



local aP,W=(-99)





















local function atStandHeight(X,Y)
LPH_ATTRIBUTES(VM(NONE))
if not X then return nil end
local Z=Y and Y.lift
if not Z or Z==0 then return X end
return X+Vector3.new(0,Z,0)
end

local function shelterSpot(X,Y,Z)
LPH_ATTRIBUTES(VM(NONE))
if not(X and X.safeSpots)then return nil end
local _,aQ=math.huge
for aR,aS in ipairs(X.safeSpots)do
local aT=atStandHeight(aS,X)or aS
if d.ZoneAt(aT,Z)==nil then
local aU=(aT-Y).Magnitude
if aU<_ then aQ,_=aT,aU end
end
end
return aQ
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
local X=aU and aU.ceiling
local Y=aU and aU.floorY
if not(X and Y)then return aS,aT end







local Z=Y+X+(aU.lift or 0)
local _=aS

if _.Y>Z then



local aV=d.GroundAt(_.X,_.Z,Y+30)
if aV and aV.Y<=Z then
_=aV
aQ=aR.." +потолок"
else
_=Vector3.new(_.X,Z,_.Z)
aQ=aR.." +потолок(срез)"
end
end

return _,aT
end













function d.SafePoint(aR,aS)
LPH_ATTRIBUTES(VM(NONE))
if not e then return aR end
aS=aS or 6
sweepGhosts()
if d.IsSafe(aR,aS)then return pick("уже чисто",aR)end

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
for aV,X in ipairs(ringPoints(aR,aU))do
local Y=onGround(X)
if d.IsSafe(Y,aS)and hasFloor(Y)and permitted(Y)then
return pick("кольцо на своей высоте",Y)
end
end
end

if W and os.clock()-aP<0.35 then return pick("повтор прошлого",W)end




if hasFloor(aR)and not(aT and aT.groundOnly)then
for aU,aV in ipairs{20,45,80}do
local X=aR+Vector3.new(0,aV,0)
if d.IsSafe(X,aS)and permitted(X)then
W,aP=X,os.clock()
return pick("подъём над собой",X)
end
end
end















local aU=shelterSpot(aT,aR,aS)
if aU then
W,aP=aU,os.clock()
return pick("убежище",aU)
end

local aV=aT and aT.cleanOnly
local X,Y=aR,threatAt(aR,aS)
local Z=(aT and aT.groundOnly)and{0}or{0,22,48}
for _,aW in ipairs(Z)do
for aX=aG*2,aH,aG*2 do
for aY,aZ in ipairs(ringPoints(aR,aX))do
local a_=onGround(aZ+Vector3.new(0,aW,0))
local a0=threatAt(a_,aS)
if a0<Y and hasFloor(a_)and permitted(a_)
and not(aV and d.ZoneAt(a_,0)~=nil)then
X,Y=a_,a0
end
end
end
end

W,aP=X,os.clock()
return pick("наименее простреливаемое (без цели)",X)
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


if not e then return pick("уклонение выключено",aY.from or aX,true)end
local aZ=aY.from
local a_,a0=aY.min,aY.max
local X=aY.margin or 6






local Y=aY.baseY or aZ.Y
local Z=aY.guards

local _=c.Active()















local a1=_ and _.minionGuard~=nil

local function tooCloseToMob(a2)
if not Z then return false end
for a3,a4 in ipairs(Z)do
local a5=Vector3.new(a2.X-a4.pos.X,0,a2.Z-a4.pos.Z).Magnitude
if a5<a4.radius and(a1 or math.abs(a2.Y-a4.pos.Y)<a4.height)then
return true
end
end
return false
end

sweepGhosts()









local a2={}
local a3={}
































local a4=c.Allows"close"and aT or aU
local a5=_ and _.groundOnly
local a6=a5 and math.max(a0*1.8,64)or a0*1.8

local function offer(a7,a8,a9)











if _ and _.groundOnly then
local ba=math.sqrt((a7-aX.X)^2+(a8-aX.Z)^2)
if ba<=a6 then
a2[#a2+1]={x=a7,z=a8,d=ba,lazy=true}
end
return
end

for ba,bb in ipairs(aS)do
local bc=Vector3.new(a7,Y+bb,a8)




if(bc-aX).Magnitude<=a6 then











local bd={
p=bc,
d=(bc-aX).Magnitude
+math.abs(bc.Y-aX.Y)*a4,
}







if _ and not _.allow(bc)then
a3[#a3+1]=bd
else
a2[#a2+1]=bd
end
end
end
end





offer(aX.X,aX.Z,0)











local a7=3



















local a8=(_ and _.dirs)or aR
local function ring(a9)
for ba=0,a8-1 do
local bb=(ba/a8)*math.pi*2
offer(aX.X+math.cos(bb)*a9,
aX.Z+math.sin(bb)*a9,a9)
end
end

for a9=a_,a0,a7 do ring(a9)end



for a9=a0+4,a6,(a5 and 5 or 8)do ring(a9)end














if _ and _.hopNear then
local a9=aZ
table.sort(a2,function(ba,bb)
local bc=(ba.p and(ba.p-a9).Magnitude)
or math.sqrt((ba.x-a9.X)^2+(ba.z-a9.Z)^2)
local bd=(bb.p and(bb.p-a9).Magnitude)
or math.sqrt((bb.x-a9.X)^2+(bb.z-a9.Z)^2)
return bc<bd
end)
else
table.sort(a2,function(a9,ba)return a9.d<ba.d end)
end
















local a9=260
if _ and _.dirs then
a9=math.floor(a9*(_.dirs/aR))
end
local ba,bb=0,0







local bc=_ and _.leash
if bc then






































local bd={}
for be,bf in ipairs(a2)do
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
if d.IsSafe(bj,X)and _.allow(bj)then
return pick("рядом и чисто",bj,true)
end
local bk=threatAt(bj,X)
if bk<bg then bh,bg=bj,bk end
end
end
if bh then












return pick(("рядом, зазор %d"):format(bf),bh,false)
end
end

end

for bd,be in ipairs(a2)do
local bf=be.p
if be.lazy then
if a9<=0 then break end
a9=a9-1
ba=ba+1
bf=atStandHeight(
d.GroundAt(be.x,be.z,_.center.Y),_)





be.p=bf


if not bf then

elseif not _.hardAllow(bf)then
note(bf,"rules")
elseif tooCloseToMob(bf)then
note(bf,"mob")
elseif not d.IsSafe(bf,X)then
elseif _.allow(bf)then
return pick("чистая",bf,true)
else
note(bf,"spare")
a3[#a3+1]={p=bf,d=be.d}
end
bf=nil
elseif tooCloseToMob(bf)then
note(bf,"mob")
elseif not d.IsSafe(bf,X)then
note(bf,"dirty")
elseif not hasFloor(bf)then
note(bf,"nofloor")
else
return pick("чистая-прямая",bf,true)
end
end










if _ and _.groundOnly and#a3==0 then
for bd,be in ipairs{X*0.5,1}do
local bf=0
for bg,bh in ipairs(a2)do

if bh.p and bf<160 then
bf=bf+1
if _.hardAllow(bh.p)and not tooCloseToMob(bh.p)
and d.IsSafe(bh.p,be)then
return pick("ослабленный запас",bh.p,true)
end
end
end
end
end







if#a3>0 then

local bd=_ and _.cleanOnly
local be,bf=math.huge
for bg,bh in ipairs(a3)do
if not(bd and d.ZoneAt(bh.p,0)~=nil)then
local bi=threatAt(bh.p,X)
if bi<be then bf,be=bh.p,bi end
end
end
if bf then return pick("у стены",bf,false)end
end


local bd=shelterSpot(_,aZ,X)
if bd then return pick("убежище",bd,true)end











for be,bf in ipairs(_ and _.groundOnly and{}or{30,55,85,115})do
local bg=Vector3.new(aZ.X,aX.Y+bf,aZ.Z)
if d.IsSafe(bg,X)then return pick("аварийный подъём",bg,true)end
end




local be,bf=math.huge
for bg,bh in ipairs(a2)do




















if bh.p and not tooCloseToMob(bh.p)
and(not _ or not _.hardAllow or _.hardAllow(bh.p))then
local bi=threatAt(bh.p,X)
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
if _ and _.groundOnly and b.enabled and ba>0 then
b.Log(("ПОИСК ПРОВАЛЕН: разобрано %d точек из %d, чистых %d, запасных %d")
:format(ba,#a2,bb,#a3))
end



return pick("наименее простреливаемое",bf,false)
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

for a2,a3 in pairs(o)do
if a2.Parent and not zoneDark(a3,a2)and(ceilingForced(a2)
or(a2.Size.Y>=aX and isBlocky(a2.Size)))then
local a4=Vector3.new(a_.X-a2.Position.X,0,a_.Z-a2.Position.Z).Magnitude
if a4<=a0+math.max(a2.Size.X,a2.Size.Z)*0.5 then



local a5=o[a2]
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
for a2,a3 in pairs(o)do
if a2.Parent and not zoneDark(a3,a2)then
local a4=a2.CFrame:PointToObjectSpace(a_)
local a5=a2.Size*0.5
local a6=Vector3.new(
math.max(math.abs(a4.X)-a5.X,0),
math.max(math.abs(a4.Y)-a5.Y,0),
math.max(math.abs(a4.Z)-a5.Z,0)).Magnitude
local a7=w[a2]
a1[#a1+1]={
gap=a6,
text=("%s/%s %s | снаружи на %.1f | скорость %.0f | запас %.0f/%.0f"):format(
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







if not e then return{}end
a0=a0 or 80
a1=(a1 or 0)+h
local a2={}

for a3,a4 in pairs(o)do
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
for a4,a5 in ipairs(v)do
if a5.expires>a3 and(a5.cf.Position-a_).Magnitude<=a0 then
local a6=a1+(a5.flat or 0)
local a7=math.min(a1,as)+(a5.vert or 0)
a2[#a2+1]={
cf=a5.cf,
size=a5.size+Vector3.new(a6*2,a7*2,a6*2),
raw=a5.size,
cylinder=a5.cylinder,
name="след:"..tostring(a5.name),
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

for a2,a3 in pairs(o)do
if a2.Parent and not zoneDark(a3,a2)then
local a4=(a2.Position-a_).Magnitude
if a4<=a0 then
a1[#a1+1]=("%s/%s@%.0f"):format(
a2.Parent and a2.Parent.Name or"?",a2.Name,a4)
end
end
end

local a2=os.clock()
for a3,a4 in ipairs(v)do
if a4.expires>a2 then
local a5=(a4.cf.Position-a_).Magnitude
if a5<=a0 then a1[#a1+1]=("след:%s@%.0f"):format(a4.name,a5)end
end
end

for a3 in pairs(q)do
if a3.Parent then
local a4=hazardPoint(a3)
if a4 then
local a5=(a4-a_).Magnitude
if a5<=a0 then a1[#a1+1]=("%s@%.0f"):format(a3.Name,a5)end
end
end
end

table.sort(a1)
return#a1>0 and table.concat(a1," ")or"пусто"
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
a2[#a2+1]=("%s гор=%.0f/%.0f верт=%+.0f"):format(
a3,a7,a8,a_.Y-a4.Y)
end

for a3 in pairs(o)do
if a3.Parent and not zoneDark(o[a3],a3)
and(named(a3.Parent.Name)or named(a3.Name))then
local a4=o[a3]
add(a3.Name,a3.Position,a3.Size,
type(a4)=="table"and a4.flat or 0)
end
end
local a3=os.clock()
for a4,a5 in ipairs(v)do
if a5.expires>a3 and named(a5.name)then
add("след:"..tostring(a5.name),a5.cf.Position,a5.size,a5.flat or 0)
end
end
if#a2==0 then return"нет"end
table.sort(a2)
return table.concat(a2," ")
end


function d.Describe(a_)
LPH_ATTRIBUTES(VM(NONE))
local a0={}
for a1,a2 in pairs(o)do
if a1.Parent and not zoneDark(a2,a1)and penetration(a1,a_,0)then
a0[#a0+1]=("%s/%s"):format(a1.Parent and a1.Parent.Name or"?",a1.Name)
end
end
local a1=os.clock()
for a2,a3 in ipairs(v)do
if a3.expires>a1 and penetrationOf(a3.cf,a3.size,a3.cylinder,a_,0,0)then
a0[#a0+1]="след:"..a3.name
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
ad.log(("DODGE -> %.0f,%.0f,%.0f | до цели %.0f | из %s | зон=%d"):format(
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
or"столб"
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
aj.log(("НАЗЕМНАЯ СТОЙКА: проверено %d, %s | бракует: %s"):format(
as,ar and"нашёл"or"НЕ НАШЁЛ",
#av>0 and table.concat(av,", ")or"-"))
end











if not ar and aj.escape then
ar=aj.escape()
if ar and aj.log then
aj.log"НАЗЕМНАЯ СТОЙКА: на полу чисто негде, ушёл обычным уклонением"
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


ab.Where(ad.Carrying()and"пушка: несу ядро"or"пушка: иду за ядром")
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
ab.Where"шестерёнки: за укрытием"
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
if ab.enabled then
local ai=ae.Position
ab.Log(("ВУЛКАН: %s -> %.0f,%.0f,%.0f | размер %.0f | на %.1fс"):format(
ah,ai.X,ai.Y,ai.Z,af.X,ag))
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






mark(aj,Vector3.new(15,15,15),1.1,"артиллерия")
end

elseif ah=="Second Boss Rock Fall"then

if typeof(ai)=="CFrame"then
mark(ai,Vector3.new(42,42,42),2.2,"камень")
end

elseif ah=="First Boss Sky Shot"then

if typeof(ai)=="Vector3"then
mark(CFrame.new(ai),Vector3.new(25,60,25),3.0,"небесный луч")
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
ai and(" (до нас %.0f)"):format(ai)or"")
end

if ag=="Instance"then
local ah=""
if ad:IsA"BasePart"then
ah=(" @%.0f,%.0f,%.0f размер %s"):format(
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
ab.Foresee(af,ag.size,ag.life,"сигнал:"..tostring(ae),0,0,false)
aa.Log(("СЕВЕР ЗАРАНЕЕ: %s помечен на %.1f с, коробка %.0fx%.0fx%.0f")
:format(tostring(ae),ag.life,ag.size.X,ag.size.Y,ag.size.Z))
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
ab.Foresee(ax,aw,ag,"анимация:Spearman Strike",0,0,false)
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

local aq,ar=pcall(describe,am,0,ap)
aa.Log(("СЕВЕР: %s | %s"):format(
tostring(al),aq and ar or"пейлоад не разобрался"))
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
if type(af)~="string"or af==""then return false,nil,"пустой ник"end
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



























local aK,aL,aM=0
local aN=0
local aO,aP,aQ
local aR
local aS=-99









local aT={}

local function clearedRooms()
local aU,aV=0,0
for aW,aX in ipairs(ac.Rooms())do
if aX.enemies then
if#ac.AliveIn(aX)>0 then
aT[aX.model]=true
end
if aT[aX.model]then
aV=aV+1
if#ac.AliveIn(aX)==0 then aU=aU+1 end
end
end
end
return aU,aV
end

local function forgetRooms()aT={}end







local aU={hover=0,topY=0,raiser="-",raiseH=0}











if aq.enabled then
task.spawn(function()
local aV=ReplicatedStorage:FindFirstChild"remotes"
aV=aV and aV:FindFirstChild"sanadaClientEvents"
if not aV or not aV:IsA"RemoteEvent"then return end

local aW={}
regConn(aV.OnClientEvent:Connect(function(aX,aY)
local aZ=tostring(aX)
local a_=""
if typeof(aY)=="Instance"then
a_=aY.ClassName..":"..aY.Name
elseif typeof(aY)=="table"then
a_="table["..#aY.."]"
elseif aY~=nil then
a_=tostring(aY)
end



local a0=aZ:lower()
if a0:find"safe"or a0:find"pylon"or a0:find"mark"
or a0:find"last boss"then
aq.Log("MAPEVENT! "..aZ..(a_~=""and(" | "..a_)or""))
elseif not aW[aZ]then
aW[aZ]=true
aq.Log("MAPEVENT "..aZ..(a_~=""and(" | "..a_)or""))
end
end))
end)
end









if aq.enabled then
spawnLoop(function()
local aV={}
while not _apelStopped do
task.wait(1)
local aW=ab.HRP()
if aW and IN_MATCH then





for aX,aY in ipairs(workspace:GetChildren())do
local aZ=aY:FindFirstChildOfClass"Humanoid"~=nil
if not aZ and aY~=LocalPlayer.Character then
local a_=aY:IsA"BasePart"and{aY}or aY:GetChildren()
for a0,a1 in ipairs(a_)do
if a1:IsA"BasePart"
and math.max(a1.Size.X,a1.Size.Y,a1.Size.Z)>=3
and(a1.Position-aW.Position).Magnitude<70 then
local a2=aY.Name.."/"..a1.Name
local a3=a2:lower()
if not(a3:find"hitbox"or a3:find"precast")
and not aV[a2]then
aV[a2]=true
aq.Log(("НЕВИДИМО %s %s neon=%s anch=%s cq=%s"):format(
a2,tostring(a1.Size),
tostring(a1.Material==Enum.Material.Neon),
tostring(a1.Anchored),tostring(a1.CanQuery)))
end
end
end
end
end
end
end
end)
end












local aV=5












local aW=setmetatable({},{__mode="k"})

local function mobShape(aX)
local aY=tonumber(
aX:FindFirstChild"meleeDistance"and aX.meleeDistance.Value)or 0


























local aZ,a_
if am.Allows"bodyOnly"then
aZ,a_=pcall(function()
local a0=aX:FindFirstChild"HumanoidRootPart"
if not a0 then return aX:GetExtentsSize()end
local a1,a2
for a3,a4 in ipairs(aX:GetDescendants())do
if a4:IsA"BasePart"
and(a4.Position-a0.Position).Magnitude<=15
then
local a5=a4.Size*0.5
local a6,a7=a4.Position-a5,a4.Position+a5
a1=a1 and Vector3.new(math.min(a1.X,a6.X),math.min(a1.Y,a6.Y),
math.min(a1.Z,a6.Z))or a6
a2=a2 and Vector3.new(math.max(a2.X,a7.X),math.max(a2.Y,a7.Y),
math.max(a2.Z,a7.Z))or a7
end
end
if not a1 then return aX:GetExtentsSize()end
return a2-a1
end)
else
aZ,a_=pcall(function()return aX:GetExtentsSize()end)
end

if aZ and a_ and a_.Y>1 and math.max(a_.X,a_.Z)>1 then
if ext then
a_=Vector3.new(math.min(ext.X,a_.X),math.min(ext.Y,a_.Y),
math.min(ext.Z,a_.Z))
end
ext=a_
aW[aX]=a_
end
ext=ext or Vector3.new(6,5,3)

local a0=math.max(ext.X,ext.Z)*0.5
local a1=math.max(aY,a0)+aV












local a2=am.Value"minionGuard"
if a2 and a2>0 and not ac.Folder()and aX.Parent==workspace then
a1=math.max(a1,a2)
end

local a3=math.clamp(math.max(aY+3,ext.Y*0.5+3),6,30)
return a1,a3
end
local aX,aY={},-99
local aZ=-99

local a_,a0,a1=1







local function orbiting()
local a2=am.Value"orbitFor"
local a3=am.Orbit(aB and aB.Name)
if not a2 or not a3 or a3<=0 or not aB then return false end
if type(a2)~="table"then a2={a2}end
local a4=tostring(aB.Name):lower()
for a5,a6 in ipairs(a2)do
if a4:find(tostring(a6),1,true)then return true end
end
return false
end









local function dodgeAllowed()
return not orbiting()
end


local a2,a3,a4=0














local function shelterFromNamed(a5)
local a6=am.Value"dodgeNamed"
local a7=am.Value"dodgeFar"
if not a6 or not a7 then return nil end
local a8=ab.HRP()
if not a8 then return nil end
local a9=a8.Position



local b=am.Allows"dodgeFlat"








if a4 and os.clock()<a2 and a3 then
if af.NamedZoneAt(a3,ar,a6,b)
and not af.NamedZoneAt(a4,ar,a6,b)
then
return Vector3.new(a4.X,a5,a4.Z)
end
end
a3,a4,a2=nil,nil,0

local ba,bb=af.NamedZoneAt(a9,ar,a6,b)
if not ba then return nil end
bb=bb or a9




local bc=Vector3.new(a9.X-bb.X,0,a9.Z-bb.Z)
if bc.Magnitude<1 then bc=Vector3.new(1,0,0)end
bc=bc.Unit




local bd=am.Active()
for be=0,11 do
local bf=(be%2==0 and 1 or-1)*math.rad(30*math.ceil(be/2))
local bg=CFrame.Angles(0,bf,0)*bc
local bh=Vector3.new(bb.X+bg.X*a7,a5,bb.Z+bg.Z*a7)
local bi=not(bd and bd.hardAllow)or bd.hardAllow(bh)
if bi and af.HasFloor(bh)
and not af.CrossesBorder(a9,bh)
and not af.NamedZoneAt(bh,ar,a6,b)
then
a3,a4=a9,bh
a2=os.clock()+(am.Value"dodgeHold"or 4)
if aq.enabled then
aq.Log(("УКРЫТИЕ ОТ АТАКИ: %.0f,%.0f,%.0f -> %.0f,%.0f,%.0f | ")
:format(a9.X,a9.Y,a9.Z,bh.X,bh.Y,bh.Z)
..("центр %.0f,%.0f | ушли на %.0f студа | от центра %.0f | держим %.1fс")
:format(bb.X,bb.Z,(bh-a9).Magnitude,a7,
a2-os.clock()))
end
return bh
end
end



if aq.enabled then
aq.Log"УКРЫТИЕ ОТ АТАКИ: некуда уйти, остаёмся на орбите"
end
return nil
end
local a5=-99

local function mobGuards()



if am.Allows"noMobGuard"then return{}end
if os.clock()-aY<0.2 then return aX end
local a6=ab.HRP()
local a7={}
if a6 then







local a8=am.Value"minionGuard"
local a9=a8==0 and not ac.Folder()

for b,ba in ipairs(ac.AllAlive())do
local bb=ac.PivotOf(ba)
local bc=a9 and ba.Parent==workspace

if bb and not bc and(bb-a6.Position).Magnitude<90 then
local bd,be=mobShape(ba)
a7[#a7+1]={


mob=ba,
pos=bb,radius=bd,height=be,name=ba.Name,
}
end
end
end
aX,aY=a7,os.clock()
return a7
end




local function crowded(a6)
local a7=am.Value"minionGuard"~=nil
for a8,a9 in ipairs(mobGuards())do
local b=Vector3.new(a6.X-a9.pos.X,0,a6.Z-a9.pos.Z).Magnitude
if b<a9.radius and(a7 or math.abs(a6.Y-a9.pos.Y)<a9.height)then
return true
end
end
return false
end












local function holdingForFriends()
return ao.Holding()
end

local function drop(a6)
if aq.enabled and ae.IsPinning()then
aq.Log("DROP удержание снято: "..tostring(a6 or"без причины"))
end
aB=nil
aC=nil
aR=nil
ae.EndPin()
end





local a6,a7=0,0










local a8=100
local a9,b=true











local ba=22
local bb=14





local bc=1
local bd=3







local be=6
local bf,bg,bh=1
local bi
local bj,bk=0,true
local c,d=-1,0


local function planSweep(e,f)
local g={}
for h,i in ipairs(e)do
local j=ac.PivotOf(i)
if j then
local k=false
for l,m in ipairs(g)do
if(m.sum/m.n-j).Magnitude<ba then
m.sum,m.n=m.sum+j,m.n+1
k=true
break
end
end
if not k then g[#g+1]={sum=j,n=1}end
end
end

if#g<2 then return nil end

local h={}
for i,j in ipairs(g)do h[#h+1]=j.sum/j.n end
table.sort(h,function(i,j)
return(i-f).Magnitude<(j-f).Magnitude
end)















local i=(#h>=3)and 2 or 1
local j,k=math.huge
for l,m in ipairs(e)do
local n=ac.PivotOf(m)
if n then
local o=(n-h[i]).Magnitude
if o<j then k,j=m,o end
end
end

return h,k
end







local function enterRoom(e)
local f=e and e.model or nil
if f==b then return end
b=f
a9=true
bg,bf,bh,bi=nil,1,nil,nil
bj,bk=os.clock(),false
c,d=-1,os.clock()
end


local function trySweep(e,f)


if not S.agroSweep then return end
if bg or bk then return end
if os.clock()-bj>be then
bk=true
if aq.enabled then
aq.Log(("SWEEP %s: маршрута нет, комната одной кучкой"):format(
tostring(e and e.name)))
end
return
end







local g=f and#f or 0
if g~=c then
c,d=g,os.clock()
return
end
if os.clock()-d<1 then return end

local h=ab.HRP()
local i,j
if h and f then i,j=planSweep(f,h.Position)end
if i then
bg,bf,bh,bi=i,1,nil,j
bk=true
if aq.enabled then
aq.Log(("SWEEP %s: кучек %d (живых %d), возврат к %s (кучка %d)"):format(
tostring(e and e.name),#i,g,
j and j.Name or"—",(#i>=3)and 2 or 1))
end
end
end








local e={
["elder dark mage"]=true,



["azrallik's heart"]=true,











["artillery lava walker"]=true,
}


local function pickTarget(f,g)
local h,i,j=math.huge,false
for k,l in ipairs(f)do
local m=ac.PivotOf(l)
if m then
local n=e[tostring(l.Name):lower()]==true
local o=(m-g).Magnitude


if(n and not i)or(n==i and o<h)then
j,h,i=l,o,n
end
end
end
return j,i
end

local function acquire(f)
aB=f
if aq.enabled then
local g=f:FindFirstChildOfClass"Humanoid"
local h,i=mobShape(f)
local j,k=pcall(function()return f:GetExtentsSize()end)
a6,a7=os.clock(),g and g.Health or 0
aq.Log(("HOLD %s | размер %s | melee=%s | столб r=%.0f h=%.0f | высота=%.0f"):format(
f.Name,
j and("%.0f/%.0f/%.0f"):format(k.X,k.Y,k.Z)or"?",
tostring(f:FindFirstChild"meleeDistance"and f.meleeDistance.Value),
h,i,i+2))
end
end

local function noteKill(f)
if not aq.enabled or a6==0 then return end
local g=os.clock()-a6
a6=0
if g>0.2 then
aq.Log(("KILL %s | %.0f hp за %.1fс = %.0f dps"):format(
f.Name,a7,g,a7/g))
end
end



local f=7



















local g=6
local h,i=0,0

local function refuge()
local j=workspace:FindFirstChild"lastBossPylonShootParts"
local k=j and#j:GetChildren()or 0
if k>h then i=os.clock()+g end
h=k
if os.clock()>=i then return nil end

local l=workspace:FindFirstChild"lastBossSafeZones"
if not l then return nil end
local m=ab.HRP()
if not m then return nil end





local n,o=math.huge
for p,q in ipairs(l:GetChildren())do
local r,s=pcall(function()return q:GetPivot()end)
if r and s then
local u=(s.Position-m.Position).Magnitude
if u<n then o,n=s.Position,u end
end
end
return o
end

local j=false
local k=false
local l=false
local m={point=nil}
local n=false

local o,p,q,r=false,0,0,-99
local s=false
local u=0
local v=0
local w=0













if aq.enabled then
local x=0

spawnLoop(function()
local y=false
while not _apelStopped do
task.wait(0.05)
pcall(function()
local z=ab.Char()
local A=z and z:FindFirstChild("arrowDownGui",true)
local B=A~=nil
if B and not y then
x=os.clock()
aq.Log"СТРЕЛКА: появилась над нами"
elseif y and not B then
aq.Log(("СТРЕЛКА: пропала, провисела %.2fс"):format(
os.clock()-x))
end
y=B
end)
end
end)

regConn(workspace.DescendantAdded:Connect(function(y)
local z=y.Parent and tostring(y.Parent.Name):lower()or""
if not z:find("finalbossarrowshothitbox",1,true)then return end
if tostring(y.Name):lower()~="hitbox"then return end

local A=ab.HRP()
local B=A and(y.Position-A.Position).Magnitude or-1
aq.Log(("СТРЕЛА: прилетела в %.0f студах, стрелка была за %.2fс до неё"):format(
B,x>0 and(os.clock()-x)or-1))
end))
end










if aq.enabled then
local x={}
regConn(workspace.ChildAdded:Connect(function(y)
local z=tostring(y.Name):lower()
if not(z:find("thirdboss",1,true)or z:find("cog",1,true)
or z:find("safe",1,true))then
return
end
if x[z]then return end
x[z]=true

task.delay(0.35,function()
pcall(function()
local A=workspace:FindFirstChild"thirdBossMiddlePart"
local B=A and A.Position or Vector3.zero
local C=ab.HRP()




local D={}
for E,F in ipairs(y:GetChildren())do
local G,H=pcall(function()return F:GetPivot().Position end)
if G and H then
local I=Vector3.new(H.X-B.X,0,H.Z-B.Z)
local J=math.deg(math.atan2(I.Z,I.X))
local K=""
if F:IsA"BasePart"then
K=(" size=%s look=%.2f,%.2f"):format(
tostring(F.Size),F.CFrame.LookVector.X,F.CFrame.LookVector.Z)
end
D[#D+1]=("%s[%s] R=%.0f угол=%.0f%s"):format(
F.Name,F.ClassName,I.Magnitude,J,K)
end
if#D>=14 then break end
end

local E,F=-1,-999
if C then
local G=Vector3.new(C.Position.X-B.X,0,
C.Position.Z-B.Z)
E=G.Magnitude
F=math.deg(math.atan2(G.Z,G.X))
end

aq.Log(("УЛЬТА3: появилось %s, детей %d | центр %.0f,%.0f,%.0f | мы R=%.0f угол=%.0f"):format(
y.Name,#y:GetChildren(),
B.X,B.Y,B.Z,E,F))
aq.Log("УЛЬТА3: "..table.concat(D," ;; "))







if y.Name=="thirdBossSafeSpots"then
task.delay(0.6,function()
pcall(function()
local G={}
for H=15,90,15 do
local I={}
for J=0,350,20 do
local K=math.rad(J)
local L=Vector3.new(
B.X+math.cos(K)*H,
B.Y+3,
B.Z+math.sin(K)*H)
local M=af.GroundAt(L.X,L.Z,L.Y+20)
if M and af.IsSafe(M,4)then
I[#I+1]=tostring(J)
end
end
G[#G+1]=("R=%d: %s"):format(H,
#I>0 and table.concat(I,",")or"нигде")
end
aq.Log("УЛЬТА3 чисто: "..table.concat(G," | "))
end)
end)
end
end)
end)
end))
end












if aq.enabled then
spawnLoop(function()
local x=0
while not _apelStopped do
task.wait(0.5)
if os.clock()-x>=15 then
pcall(function()
local y=workspace:FindFirstChild"secondBossCrossBeam"
if not y then return end
x=os.clock()

local z,A,B={},{},{}
for C,D in ipairs(y:GetDescendants())do
if D:IsA"BasePart"then
local E=D.Name
A[E]=math.min(A[E]or 9,D.Transparency)
B[E]=math.max(B[E]or-1,D.Transparency)
end
end
for C in pairs(A)do
z[#z+1]=("%s %.2f..%.2f"):format(C,A[C],B[C])
end



local C=os.clock()
task.spawn(function()
while y.Parent and os.clock()-C<30 do task.wait(0.25)end
aq.Log(("КРЕСТ: прожил %.1fс, прозрачность %s"):format(
os.clock()-C,table.concat(z,", ")))
end)
end)
end
end
end)
end















if aq.enabled then
local x={
"outwardblastsize","crossbeam","bosshorizontalbeam",
"circlehit","bosscannonbeam","bossrandomstrike",
}
local y,z={},{}

local function watched(A)
local B=tostring(A):lower()
for C,D in ipairs(x)do
if B:find(D,1,true)then return D end
end
return nil
end

regConn(workspace.DescendantAdded:Connect(function(A)
if not A:IsA"BasePart"then return end
local B=A.Parent
if not B or z[B]then return end
local C=watched(B.Name)
if not C then return end
local D=os.clock()
if y[C]and D-y[C]<3 then return end
y[C],z[B]=D,true

task.spawn(function()
local E=os.clock()
local F,G,H

while os.clock()-E<6 and B.Parent do
for I,J in ipairs(B:GetChildren())do
if J:IsA"BasePart"then
local K=tostring(J.Name):lower()
if not F and K:find("precast",1,true)then
F=os.clock()-E
end
if not G and K:find("hitbox",1,true)then
G=os.clock()-E
end
if not H and J.Transparency<0.9 then
H=os.clock()-E
end
end
end
task.wait()
end
local I=os.clock()-E
local function t(J)return J and("+%.2f"):format(J)or"нет"end
aq.Timing(("%s | precast %s | hitBox %s | видно %s | прожил %.2f"):format(
B.Name,t(F),t(G),t(H),I))
z[B]=nil
end)
end))
end





















if aq.enabled then
local x,y,z=70,1.5,4
local A={}

local function noteBirth(B)
if not B:IsA"BasePart"then return end
local C=os.clock()
task.defer(function()
if not B.Parent then return end
local D=ab.HRP()
if not D then return end
local E,F=pcall(function()return B.Position end)
if not E then return end
local G=(F-D.Position).Magnitude
if G>x then return end
local H=B.Parent
A[#A+1]={
t=C,gap=G,
name=B.Name,
owner=H and H.Name or"?",
grand=H and H.Parent and H.Parent.Name or"?",
size=B.Size,
mat=tostring(B.Material):gsub("Enum.Material.",""),
query=B.CanQuery,collide=B.CanCollide,
clear=B.Transparency,
zone=(function()
local I,J=pcall(af.IsZone,B)
return I and J or false
end)(),
}
if#A>500 then table.remove(A,1)end
end)
end

regConn(workspace.DescendantAdded:Connect(noteBirth))


local function nowLooksLikeAttack(B)
local C={}
for D,E in ipairs(workspace:GetDescendants())do
if E:IsA"BasePart"and not E.CanCollide then
local F,G=pcall(function()return E.Position end)
if F then
local H=(G-B.Position).Magnitude
if H<=30 and math.max(E.Size.X,E.Size.Y,E.Size.Z)>=3 then
C[#C+1]=("%s/%s %s | в %.1f | %s | видимость %.2f | зона %s")
:format(tostring(E.Parent and E.Parent.Name or"?"),E.Name,
tostring(E.Size),H,
tostring(E.Material):gsub("Enum.Material.",""),
E.Transparency,
tostring((select(2,pcall(af.IsZone,E)))or false))
end
end
end
if#C>=12 then break end
end
return C
end

spawnLoop(function()
local B,C
while not _apelStopped do
task.wait(0.2)
local D=ab.Humanoid()
if D and D~=B then
B,C=D,D.Health
regConn(D.HealthChanged:Connect(function(E)
local F=C or E
C=E
if E>=F then return end
local G=ab.HRP()
if not G then return end
local H=os.clock()

aq.Log(("УРОН -%.0f hp | модель %s | зон рядом %s")
:format(F-E,
af.ZoneAt(G.Position,1.5)and"НАКРЫТ"or"чисто",
tostring(af.Count and select(1,af.Count())or"?")))

local I=0
for J=#A,1,-1 do
local K=A[J]
if H-K.t>y then break end
I=I+1
aq.Log(("   за %.2fс: %s/%s/%s %s | в %.1f | %s | query=%s collide=%s видимость %.2f | ЗОНА=%s")
:format(H-K.t,K.grand,K.owner,K.name,
tostring(K.size),K.gap,K.mat,
tostring(K.query),tostring(K.collide),K.clear,
tostring(K.zone)))
if I>=10 then break end
end
if I==0 then
aq.Log"   за 1.5с рядом НЕ ПОЯВИЛОСЬ НИЧЕГО"
end

for J,K in ipairs(nowLooksLikeAttack(G))do
aq.Log("   сейчас рядом: "..K)
end
end))
end

local E=os.clock()-z
while A[1]and A[1].t<E do table.remove(A,1)end
end
end)
end












if aq.enabled then
task.spawn(function()
local x=game:GetService"ReplicatedStorage"
local y=x:FindFirstChild"Utility"
local z=y and y:FindFirstChild"BridgeNet2"
if not z then
aq.Bridge"BridgeNet2 не найден — слушать нечего"
return
end
local A,B=pcall(require,z)
if not A then
aq.Bridge("require BridgeNet2 упал: "..tostring(B))
return
end
local C,D=pcall(B.ReferenceBridge,"precastHitbox")
if not C or not D then
aq.Bridge("ReferenceBridge упал: "..tostring(D))
return
end
local E=B.ReferenceIdentifier"action"
aq.Bridge(("подписался · карта %s · плейс %d"):format(
tostring(ac.Name()),game.PlaceId))

local F=0









task.spawn(function()
while not _apelStopped do
task.wait(15)
aq.Bridge(("жив, пакетов за прогон: %d · карта %s")
:format(F,tostring(ac.Name())))
end
end)
regConn(D:Connect(function(G)
F=F+1
local H=tostring(G and G[E])
local I=G and(G.cframe or G.position)
local J=G and(G.size and tostring(G.size)
or(G.radius and("радиус "..tostring(G.radius)))or"?")
local K="?"
if I then
local L=typeof(I)=="CFrame"and I.Position or I
K=("%.0f,%.0f,%.0f"):format(L.X,L.Y,L.Z)
end
local L=ab.HRP()
local M="-"
if L and K~="?"then
local N=typeof(I)=="CFrame"and I.Position or I
M=("%.0f"):format((N-L.Position).Magnitude)
end






local N="-"
if G and tonumber(G.delayUntilAttack)and tonumber(G.startTime)then
N=("%.2f"):format(tonumber(G.delayUntilAttack)
-(workspace:GetServerTimeNow()-tonumber(G.startTime)))
end

local O=("#%d %s | %s | %s | до нас %s | delay=%s | осталось %s"):format(
F,H,K,J,M,
tostring(G and G.delayUntilAttack),N)
aq.Bridge(O..(" | start=%s"):format(tostring(G and G.startTime)))








local function show(P,Q)
local R=typeof(P)
if R=="table"then
if Q<=0 then return"{...}"end
local T={}
for U,V in pairs(P)do
T[#T+1]=tostring(U).."="..show(V,Q-1)
end
table.sort(T)
return"{"..table.concat(T," ").."}"
end
if R=="CFrame"then
local T=P.Position
return("CFrame(%.0f,%.0f,%.0f)"):format(T.X,T.Y,T.Z)
end
return("%s(%s)"):format(R,tostring(P))
end
if type(G)=="table"then
aq.Bridge("   сырьё: "..show(G,2))
else
aq.Bridge("   сырьё: "..show(G,2).." (не таблица)")
end
end))
end)
end











if aq.enabled then
spawnLoop(function()
local x={}
while not _apelStopped do
task.wait(2)
local y=ab.HRP()
if y and IN_MATCH then
pcall(function()

local z=ac.Nearest(y.Position,60)
local A=z and ac.PivotOf(z)
if not A then return end

local B={}
for C,D in ipairs(workspace:GetDescendants())do
if D:IsA"BasePart"and not D:IsDescendantOf(z)
and not Players:GetPlayerFromCharacter(D.Parent or D)
then
local E=(D.Position-A).Magnitude


if E<=22 and math.max(D.Size.X,D.Size.Y,D.Size.Z)>=3
and not af.IsZone(D)
then
local F=D.Parent and D.Parent.Name or"?"
local G=F.."/"..D.Name.."/"..tostring(D.Size)
if not x[G]and#B<6 then
x[G]=true
B[#B+1]=("%s %s %s trans=%.2f cq=%s"):format(
G,tostring(D.Material):gsub("Enum.Material.",""),
D.Anchored and"anch"or"free",
D.Transparency,tostring(D.CanQuery))
end
end
end
end
if#B>0 then
aq.Log(("НЕ ВИЖУ у %s: %s"):format(z.Name,table.concat(B," ;; ")))
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
local x,y=ab.HRP(),aB
local z=y and ac.PivotOf(y)
if x and z then
local A=Vector3.new(x.Position.X-z.X,0,x.Position.Z-z.Z).Magnitude
aq.Log(("СТОЙКА у %s: вбок %.1f | вверх %.1f"):format(
y.Name,A,x.Position.Y-z.Y))
end
end
end)
end








if aq.enabled then
spawnLoop(function()
local x=""
while not _apelStopped do
task.wait(3)
local y=ab.HRP()
if y and IN_MATCH then
local z,A={},0
for B,C in ipairs(workspace:GetDescendants())do
if C:IsA"Humanoid"then
local D=C.Parent
local E,F=pcall(function()return D:GetPivot().Position end)
if E and D~=LocalPlayer.Character
and not Players:GetPlayerFromCharacter(D)then
local G=(F-y.Position).Magnitude
if G<=90 then
A=A+1
if#z<12 then
z[#z+1]=("%s @%.0f hp=%.0f [%s]"):format(
D.Name,G,C.Health,
D.Parent and D.Parent:GetFullName():gsub(
"^Workspace%.?","")or"?")
end
end
end
end
end


local B=("КТО РЯДОМ: %d | %s"):format(A,table.concat(z," ;; "))
if B~=x then
x=B
aq.Log(B)
end
end
end
end)
end









if aq.enabled then
local x=0
regConn(workspace.DescendantAdded:Connect(function(y)
local z=y.Parent and tostring(y.Parent.Name):lower()or""
if not z:find("secondbosscrescent",1,true)then return end
if not y:IsA"BasePart"then return end
if os.clock()-x<5 then return end
x=os.clock()

task.spawn(function()
local A=y.Position
local B=os.clock()
task.wait(0.25)
if not y.Parent then
aq.Log"ПОЛУМЕСЯЦ: прожил меньше четверти секунды"
return
end
local C=math.max(os.clock()-B,0.001)
local D=(y.Position-A).Magnitude/C
local E=ab.HRP()








local F,G,H=math.huge,-math.huge,0
for I,J in ipairs(workspace:GetDescendants())do
if J:IsA"BasePart"and J.Parent
and tostring(J.Parent.Name):lower():find("secondbosscrescent",1,true)
then
H=H+1
F=math.min(F,J.Position.Y-J.Size.Y*0.5)
G=math.max(G,J.Position.Y+J.Size.Y*0.5)
end
end

aq.Log(("ПОЛУМЕСЯЦ: %.0f студ/с, упреждение %s, до нас %.0f студ | %d шт, высота %.1f..%.1f, мы на %.1f"):format(
D,D>=18 and"строится"or"НЕ СТРОИТСЯ",
E and(y.Position-E.Position).Magnitude or-1,
H,F<math.huge and F or-1,G>-math.huge and G or-1,
E and E.Position.Y or-1))
end)
end))
end
















if aq.enabled then
local x=0



local function beamOf(y)
local z,A=0
for B,C in ipairs(y:GetDescendants())do
if C:IsA"BasePart"then
local D=C.Size.X*C.Size.Y*C.Size.Z
if D>z then A,z=C,D end
end
end
return A
end


local function axisOf(y,z)
local A=y.CFrame:PointToObjectSpace(z)
local B=y.Size
local C,D
if B.X>=B.Y and B.X>=B.Z then
C,D=A.X,Vector3.new(0,A.Y,A.Z).Magnitude
elseif B.Z>=B.Y then
C,D=A.Z,Vector3.new(A.X,A.Y,0).Magnitude
else
C,D=A.Y,Vector3.new(A.X,0,A.Z).Magnitude
end
return C,D,A
end

local function insideOf(y,z,A,B)
local C=y.CFrame:PointToObjectSpace(z)
local D=y.Size*0.5
return math.abs(C.X)<=D.X+A
and math.abs(C.Y)<=D.Y+B
and math.abs(C.Z)<=D.Z+A
end

local function describe(y,z,A)
local B,C,D=axisOf(z,A)
return("%s %s %s | центр %.0f,%.0f,%.0f | вдоль %.1f поперёк %.1f | по высоте %.1f | внутри %s, с запасом 3/12 %s"):format(
y,z.Name,tostring(z.Size),
z.Position.X,z.Position.Y,z.Position.Z,
B,C,D.Y,
tostring(insideOf(z,A,0,0)),
tostring(insideOf(z,A,3,12)))
end

regConn(workspace.DescendantAdded:Connect(function(y)
local z=y.Parent and tostring(y.Parent.Name):lower()or""
if z~="bossrifleprecast"then return end
if os.clock()-x<3 then return end
x=os.clock()
local A=y.Parent

task.spawn(function()

task.wait(0.05)
if not A.Parent then return end
local B=beamOf(A)
local C=ab.HRP()
if not B or not C then return end
local D,E=B.CFrame,B.Size
aq.Log("РУЖЬЁ: "..describe("предупреждение",B,C.Position))







local F=os.clock()+3
local G
while os.clock()<F do
for H,I in ipairs(workspace:GetChildren())do
if I:IsA"Model"and tostring(I.Name):lower()=="bossrifleshot"then
G=beamOf(I)
break
end
end
if G then break end
task.wait(0.03)
end

local H=ab.HRP()
if not G or not H then
aq.Log"РУЖЬЁ: выстрел за три секунды не появился"
return
end
aq.Log("РУЖЬЁ: "..describe("выстрел",G,H.Position))



local function longDir(I,J)
if J.X>=J.Y and J.X>=J.Z then return I.RightVector end
if J.Z>=J.Y then return I.LookVector end
return I.UpVector
end
local I=longDir(D,E)
local J=longDir(G.CFrame,G.Size)
local K=math.clamp(math.abs(I:Dot(J)),-1,1)
aq.Log(("РУЖЬЁ: угол между стволами %.1f°, сдвиг центров %.1f студ | мы сместились на %.1f студ"):format(
math.deg(math.acos(K)),
(G.Position-D.Position).Magnitude,
(H.Position-C.Position).Magnitude))
end)
end))
end












if aq.enabled then
local x=0
regConn(workspace.DescendantAdded:Connect(function(y)
local z=tostring(y.Name):lower()
if z:find("finalbossrotatingcircle",1,true)then
x=os.clock()+9
aq.Log"УЛЬТА: босс начал копить, пишу всё, что появится"
return
end
if os.clock()>=x then return end

if z=="apelmark"then return end
local A=ab.HRP()
local B=-1
if A and y:IsA"BasePart"then
B=(y.Position-A.Position).Magnitude
end
aq.Log(("УЛЬТА +%.1fс: %s [%s] в %.0f студах"):format(
9-(x-os.clock()),y:GetFullName(),y.ClassName,B))
end))
end









if ak.Watch()and aq.enabled then
aq.Log"ВУЛКАН: слушаю volcanicBossSpecficEvents"
end




if al.Watch()and aq.enabled then
aq.Log"СЕВЕР: слушаю northernBossSpecficEvents"
end



ae.SetFloorFilter(af.FloorIgnore)

ae.SetTrace(aq.enabled and aq.Log or nil)






ae.SetGroundClamp(function(x)
if not am.Allows"ground"then return x end
local y=am.Active()

















if y and y.floorY and y.ceiling then
local z=y.lift or 0
local A=y.floorY+z
local B=y.floorY+y.ceiling+z
if x.Y>=A and x.Y<=B then return x end
local C=af.GroundAt(x.X,x.Z,y.floorY+30)
if C then
local D=math.clamp(C.Y+z,A,B)
return Vector3.new(x.X,D,x.Z)
end
return Vector3.new(x.X,math.clamp(x.Y,A,B),x.Z)
end

local z=y and y.center.Y or x.Y
local A=af.GroundAt(x.X,x.Z,z)
if A and x.Y>A.Y+3 then return A end
return x
end)

regConn(RunService.Heartbeat:Connect(function(x)
if _apelStopped then return end


ae.SetVoidGuard(am.Allows"noVoid")



if ae.RescueFromVoid()and aq.enabled then
aq.Log"СПАСЕНИЕ ИЗ ПУСТОТЫ: вернул на последнюю твёрдую точку"
end

if not S.autoFarm then
if ae.IsPinning()then
drop(not S.autoFarm and"фарм выключен"or"включён полёт")
end
return
end



















































local y=af.SafeSpot()
if y then
if not aM then
aM=os.clock()
if aq.enabled then aq.Log"УКРЫТИЕ: загорелось"end
end
aL=y
aN=os.clock()



aK=os.clock()+2.2
elseif aM and(os.clock()-aN)>0.5 then
if aq.enabled then
aq.Log(("УКРЫТИЕ: погасло, горело %.1fс"):format(aN-aM))
end
aM=nil
end














local z=aM~=nil and(os.clock()-aM)<3.4













local A=aL and((af.CleanNear(aL)or aL)
+Vector3.new(0,3,0))or nil














local B=am.Value"haven"
if B then
local C=ab.HRP()
local D=am.Value"havenWhen"
local E,F=false
if C then E,F=af.TimerRing(D,C.Position)end
if E then
if p==0 then q=os.clock()end
p=os.clock()
end

local G=am.Value"havenTail"or 1.5
local H=p>0 and(os.clock()-p)<G
if C and H then
local I,J,K=af.HavenSpot(B,C.Position)
if I then



local L=I+Vector3.new(0,3,0)
if not o then
o=true
if aq.enabled then
aq.Log(("ПРОКЛЯТИЕ: круг %s на нас (размер %.1f), иду в укрытие %.0f,%.0f,%.0f | радиус %.1f | лететь %.0f студов")
:format(tostring(D),F or-1,
I.X,I.Y,I.Z,J or-1,K or-1))
end
end
ae.Where"укрытие проклятия"
ae.Pin(L,L+Vector3.new(0,0,1))
return
elseif aq.enabled and(os.clock()-r)>2 then


r=os.clock()
aq.Log(("ПРОКЛЯТИЕ: круг на нас, а укрытия %s в мире НЕТ")
:format(tostring(B)))
end
end




if not H and p>0 then
if o and aq.enabled then
aq.Log(("ПРОКЛЯТИЕ: отпустило, кольцо держалось %.1fс")
:format(p-q))
end
o=false
p,q=0,0
end
end

if am.Allows"gears"and aj.Step(m)then
if not l then
l=true
if aq.enabled then aq.Log"ШЕСТЕРЁНКИ: фаза началась"end
end
return
elseif l then
l=false
if aq.enabled then aq.Log"ШЕСТЕРЁНКИ: фаза кончилась"end
end









if am.Allows"cannon"and ai.Step()then
if not k then
k=true
if aq.enabled then aq.Log"ПУШКА: фаза началась, иду за ядром"end
end
return
elseif k then
k=false
if aq.enabled then aq.Log"ПУШКА: фаза кончилась"end
end












if A and not aM and not af.IsSafe(A,0)then
A=nil
end

if A and not z and os.clock()<aK then
if not n then
n=true
if aq.enabled then aq.Log"УКРЫТИЕ: зашёл"end
end











ae.Where"укрытие"
ae.Pin(A,A+Vector3.new(0,0,1))
return
end
if n then
n=false
if aq.enabled then aq.Log"УКРЫТИЕ: вышел"end
end
aL=nil











if am.Allows"dome"then






local C=af.HasDome()
local D=ab.HRP()
local E,F
if not C then E,F=af.SafeDome()end


if aq.enabled and os.clock()-w>1 then
local G=af.DomeReport()
if#G>0 then
w=os.clock()
aq.Log(("КУПОЛ: щит на мне=%s, цель=%s | %s"):format(
tostring(C),
E and("%.0f,%.0f,%.0f"):format(E.X,E.Y,E.Z)or"нет",
table.concat(G," ;; ")))
end
end












if C then
s=false
elseif not E then
u,v=0,0
end
if E and u==0 then u=os.clock()end

if E and D then










local G=2











local H=E












local I=math.abs(E.Y-D.Position.Y)<=60



if I and not af.IsSafe(H,G)then
H=af.CleanNear(H)or H
end





















local J=not af.IsSafe(H,G)
if I and J and(os.clock()-u)<1.5 then


ae.Where"щит: жду, пока пройдёт удар"
ae.Pin(D.Position,D.Position+Vector3.new(0,0,1))
return
end

if I then

if not s then
s=true
if aq.enabled then
local K=(E-D.Position).Magnitude
aq.Log(("КУПОЛ: иду подбирать, %.0f студ"):format(K))
end
end


ae.Where"щит"
ae.Pin(H,H+Vector3.new(0,0,1))


















local K=(E-D.Position).Magnitude
if K<=8 and v==0 then
v=os.clock()
end

if F and K<=12 then


if type(firetouchinterest)=="function"then
local L=ab.Char()
for M,N in ipairs(L and L:GetChildren()or{})do
if N:IsA"BasePart"then
pcall(firetouchinterest,N,F,0)
pcall(firetouchinterest,N,F,1)
end
end
end



if v>0 and(os.clock()-v)>=0.8 then
af.MarkDomeUsed(F)
v=0
if aq.enabled then
aq.Log"КУПОЛ: постоял и коснулся, отмечаю использованным"
end
end
end
return
end
end
end

local C=refuge()









if C and am.Active()then C=nil end



if C and not af.IsSafe(C+Vector3.new(0,3,0),ar)then
C=nil
end

if C then
local D=C+Vector3.new(0,3,0)
aC=D
if not j then
j=true
if aq.enabled then
aq.Log(("REFUGE идём в укрытие %.0f,%.0f,%.0f"):format(
D.X,D.Y,D.Z))
end
end



local E=am.Active()
if E and E.groundOnly then
local F=af.GroundAt(D.X,D.Z,E.center.Y)
if F and D.Y>F.Y+3 then D=F end
end
ae.Pin(D,D+Vector3.new(0,-1,0))
return
end
if j then
j=false
if aq.enabled then aq.Log"REFUGE укрытие больше не нужно"end
end

local D

if bg then
local E=ab.HRP()and ab.HRP().Position
local F=bg[bf]
if E and F then
local G=Vector3.new(E.X-F.X,0,E.Z-F.Z).Magnitude
if G<bb then
bh=bh or os.clock()
local H=(bf==1)and bd or bc
if os.clock()-bh>=H then
bf,bh=bf+1,nil
if aq.enabled then
aq.Log(("SWEEP точка %d из %d пройдена"):format(bf-1,#bg))
end
end
end
end

if bf>#bg and bi and ac.IsAlive(bi)then
local G=ac.PivotOf(bi)
if G and E then
local H=Vector3.new(E.X-G.X,0,E.Z-G.Z).Magnitude
if H>=bb then
D=G
F=G
else
bi=nil
if aq.enabled then aq.Log"SWEEP возврат выполнен"end
end
else
bi=nil
end
end

if bf>#bg and not bi then
bg=nil






aB=nil
if aq.enabled then aq.Log"SWEEP закончен — встаём бить"end
elseif bf<=#bg then


D=bg[bf]
end
end

if not D then D=aB and ac.PivotOf(aB)or nil end











if not D then








if aC then








local E=am.Active()
if not af.IsSafe(aC,ar)then
local F
if E then











F=af.SafePointAround(aC,{
from=aC,min=6,max=64,
margin=ar,baseY=aC.Y})
else
F=af.SafePoint(aC,ar)
end
if F then aC=F end
end





if af.IsSafe(aC,ar)then aD=nil end
ae.Where"без цели"
ae.Pin(aC,aC-Vector3.new(0,1,0))
else














local E=ab.HRP()
if E and IN_MATCH and ac.Started()and ae.IsPinning()then
ae.Where"без цели: держусь на месте"
ae.Pin(E.Position,E.Position+Vector3.new(0,0,1))
end
end
return
end

































local E=af.TargetedRecently(1.4)

local F=aB or ac.Nearest(D,40)
local G,H=9,7
if F then G,H=mobShape(F)end














local I=am.Allows"close"

local J=math.clamp(G,6,30)


local K=am.Value"keepAway"
if type(K)=="number"then J=math.max(J,K)end







local L=am.Value"stand"
if type(L)=="number"then J=L end


















local M=I and math.min(H+1,8)or(H+1)






local N=am.Value"hover"
if type(N)=="number"then M=N end
















local O=D.Y+M
aU.hover,aU.raiser,aU.raiseH=M,"-",0
for P,Q in ipairs(mobGuards())do






local R=I and F~=nil and Q.mob==F
local T=R and math.huge
or Vector3.new(D.X-Q.pos.X,0,D.Z-Q.pos.Z).Magnitude


if T<Q.radius+4 then
local U=Q.pos.Y+Q.height+1
if U>O then
O=U
aU.raiser,aU.raiseH=Q.name or"?",Q.height
end
end
end



local P=am.Active()


local Q=not(P and P.groundOnly)
and af.CeilingNear(D,J+26)or nil
local R=false
if Q and Q+3>O then
O=Q+3
R=true
end

aU.topY=O




















local T

local U=false
if P and P.groundOnly then
local V=ab.HRP()and ab.HRP().Position or D

local W=Vector3.new(V.X-D.X,0,V.Z-D.Z)
if W.Magnitude<1 then W=Vector3.new(1,0,0)end
W=W.Unit

if E then J=J+40 end
for X=0,11 do
local Y=(X%2==0 and 1 or-1)*math.rad(30*math.ceil(X/2))
local Z=CFrame.Angles(0,Y,0)*W
local _=af.GroundAt(D.X+Z.X*J,
D.Z+Z.Z*J,D.Y)
if _ and P.allow(_)then T=_ break end
end

T=T or af.GroundAt(D.X,D.Z,D.Y)







if not T or(P.hardAllow and not P.hardAllow(T))then
T=af.GroundAt(P.center.X,P.center.Z,P.center.Y)
or T or Vector3.new(D.X,O,D.Z)
end
else


if E then
local V=ab.HRP()and ab.HRP().Position or D
local W=Vector3.new(V.X-D.X,0,V.Z-D.Z)
if W.Magnitude<1 then W=Vector3.new(1,0,0)end
W=W.Unit*(J+46)
T=Vector3.new(D.X+W.X,O,D.Z+W.Z)
else
T=Vector3.new(D.X,O,D.Z)





























local V,W,X,Y,Z=
am.Orbit(aB and aB.Name)
if V and V>0 and orbiting()then
U=Z==true
local _=am.Active()



local bl=O+(X or 0)

local function spot(bm,bn)
bn=bn or V
local bo=Vector3.new(
D.X+math.cos(bm)*bn,bl,D.Z+math.sin(bm)*bn)
if _ and _.hardAllow and not _.hardAllow(bo)then
return nil
end
return bo
end



if a1~=aB or not a0 then
local bm=ab.HRP()and ab.HRP().Position or D
local bn=Vector3.new(bm.X-D.X,0,bm.Z-D.Z)
a0=(bn.Magnitude>0.1)
and math.atan2(bn.Z,bn.X)or 0
a_=a_ or 1
a1=aB
end

local bm=(W/V)*math.clamp(x or 1.6666666666666665E-2,0,0.1)






local bn=math.max(bm*30,0.35)

local function clearAhead(bo,bp)
for bq=1,4 do
local br=spot(a0+bo*bn*bq/4,bp)
if not br or not af.IsSafe(br,ar)or crowded(br)then
return false
end
end
return true
end





























local bo=shelterFromNamed(bl)
if bo then
T=bo
a0=nil
elseif Y then
a0=a0+a_*bm
local bp=spot(a0,V)
if bp then
T=bp
else
a_=-a_
end
elseif not clearAhead(a_,V)then
if clearAhead(-a_,V)then
a_=-a_
else





for bp,bq in ipairs{V+12,V-8,V+22}do
if bq>4 and clearAhead(a_,bq)then
V=bq
break
end
end
end
end









if not Y and not bo then
a0=a0+a_*bm
local bp=spot(a0,V)
if bp then
T=bp
else


a_=-a_
end
end
end














local bl=not(V and V>0 and orbiting())and am.Value"sideStep"or nil
if bl and bl>0 then
local bm=ab.HRP()and ab.HRP().Position or D
local bn=Vector3.new(bm.X-D.X,0,bm.Z-D.Z)
if bn.Magnitude<1 then bn=Vector3.new(1,0,0)end
bn=bn.Unit*bl
T=Vector3.new(D.X+bn.X,O,D.Z+bn.Z)
end
end
end
local bl=aC
and Vector3.new(T.X-aC.X,0,T.Z-aC.Z).Magnitude
or math.huge








if U or bl>f then
aC=T
else
aC=Vector3.new(aC.X,T.Y,aC.Z)
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
for V=0,br-1 do
local W=math.rad((360/br)*V)
local X=Vector3.new(
D.X+math.cos(W)*bq,
bm.Y,
D.Z+math.sin(W)*bq)
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
ae.Where"подъём от серпов"
ae.Pin(bo,D)
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

ae.Where"наземная стойка"
aC=ah.Step{
pos=D,
here=ab.HRP()and ab.HRP().Position or D,
reach=bq,
margin=br,
crowded=crowded,
state=aH,














escape=function()
if af.IsSafe(bm,ar)and not crowded(bm)then
return bm
end
local V=ab.HRP()and ab.HRP().Position or D
local W=af.GroundAt(D.X,D.Z,D.Y)
return af.SafePointAround(D,{
from=V,
min=J,
max=bq+30,
margin=br,
baseY=W and W.Y or V.Y,
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
ae.Where"зависание над боссом"
ae.Pin(bm,D)
return
end
end








do
local bn=ab.HRP()and ab.HRP().Position or nil


local bo















local bp=J+26




local bq=am.Value"reach"
if type(bq)=="number"then bp=bq end








local br=af.SpinRadius()
if br then bp=math.max(bp,br+25)end










local V=(P and P.groundOnly)and 140 or av
if br then V=math.max(V,br+40)end
























if am.Allows"legacy"then
local W={dodgeAt=aS,dodgeStand=aR}
ae.Where"старое уклонение"
bm=ag.Step{
stand=bm,pos=D,here=bn,
keepAway=J,reach=bp,margin=ar,
hold=as,crowded=crowded,guards=mobGuards,
state=W,


keepFar=am.Allows"keepFar",
log=aq.enabled and aq.Log or nil,
}
aS,aR=W.dodgeAt,W.dodgeStand
aC=bm
return
end

local W=(os.clock()-aS)<as















local function findEscape()
local X=os.clock()
if aO and X-aO<0.05 then
return aP,aQ
end
aO=X















local Y=am.Value"minimalDodge"
if Y then
local Z=bn or bm







local _,bs=pcall(af.EscapeStep,Z,1,Y)
if not _ then bs=nil end

local bt=am.Active()
local bu=not(bt and bt.hardAllow)
or(bs and bt.hardAllow(bs))
if bs and bu
and af.HasFloor(bs)


and not af.CrossesBorder(Z,bs)
and not crowded(bs)then
aP,aQ=bs,af.IsSafe(bs,ar)



if aq.enabled and(os.clock()-a5)>0.5 then
a5=os.clock()
aq.Log(("ШАГ В СТОРОНУ: %.0f,%.0f,%.0f | на %.1f студа | чисто=%s")
:format(bs.X,bs.Y,bs.Z,(bs-Z).Magnitude,
tostring(aQ)))
end
return aP,aQ
end
end

aP,aQ=af.SafePointAround(D,{
from=bn or bm,
min=J,
max=bp,
margin=ar,
baseY=bm.Y,
guards=mobGuards(),
})
return aP,aQ
end














if dodgeAllowed()then
if W and aR then






























local bs=am.Value"minionGuard"~=nil
if af.IsSafe(aR,ar)
and not(bs and crowded(aR))then
bm=aR
else


















local bt=af.ZoneAt(aR,0)~=nil
local bu,X=findEscape()
local Y=false
if bu and(bu-D).Magnitude<=V then
Y=X or bt
or af.ThreatAt(bu,ar)
<af.ThreatAt(aR,ar)
end
if Y then
aR,bm=bu,bu
aS=os.clock()
aE=os.clock()








if aq.enabled and(os.clock()-aZ)>0.5 then
aZ=os.clock()
aq.Log(("DODGE! точку накрыло, ухожу -> %.0f,%.0f,%.0f (чистая=%s)")
:format(bu.X,bu.Y,bu.Z,tostring(X)))
end
else
bo=bu
and(("нашёл выход, но он не лучше (чисто=%s, далеко=%.0f)")
:format(tostring(X),(bu-D).Magnitude))
or"выхода НЕ НАЙДЕНО (выдержка)"
bm=aR
end
end
elseif not W and af.IsSafe(bm,ar)and not crowded(bm)then
aR=nil
elseif aR
and af.IsSafe(aR,ar)
and not crowded(aR)
and(aR-D).Magnitude<=bp
then
bm=aR
elseif not af.IsSafe(bm,ar)or crowded(bm)then



local bs,bt=findEscape()

aS=os.clock()+(bt and 0 or(au-as))
if bs and(bs-D).Magnitude>V then
if aq.enabled then
aq.Log(("DODGE отброшен: %.0f студов от цели, предел %d"):format(
(bs-D).Magnitude,V))
end
bo=("выход отброшен: %.0f студов, предел %d"):format(
(bs-D).Magnitude,V)
bs=nil
end
if not bs then
bo="выхода НЕ НАЙДЕНО (основной поиск)"
end
if bs then
aR=bs
bm=bs
aE=os.clock()
if aq.enabled then


local bu="-"
local X=workspace:Raycast(bs,Vector3.new(0,-300,0))
if X then
bu=("%.0f"):format(bs.Y-X.Position.Y)
end
aq.Log(('DODGE -> %.0f,%.0f,%.0f | \u{434}\u{43e} \u{446}\u{435}\u{43b}\u{438} %.0f | \u{438}\u{437} %s | \u{437}\u{43e}\u{43d}=%d | \u{432}\u{435}\u{442}\u{43a}\u{430}=%s | \u{43d}\u{430}\u{434} \u{43f}\u{43e}\u{43b}\u{43e}\u{43c} %s'
):format(
bs.X,bs.Y,bs.Z,(bs-D).Magnitude,
af.Describe(bn or bm),af.Count(),
af.LastPick(),bu))
end
end
else
aR=nil
end
end







if af.IsSafe(bm,ar)then
if aD and aq.enabled then
local bs=(os.clock()-aD)*1000
if bs>120 then
aq.Log(("РЕАКЦИЯ %.0f мс под ударом | причина: %s"):format(
bs,bo or"ветка без поиска"))
end
end
aD=nil
elseif not aD then
aD=os.clock()
end
end













local bn=bm
local bo=ab.HRP()and ab.HRP().Position or nil



local bp=aR~=nil or R or a9 or bg==nil
if bo and not bp then
local bq=bn-bo
local br=a8*x
if bq.Magnitude>br then bn=bo+bq.Unit*br end
end
a9=false


















local bq=12
if bn.Y<D.Y-bq then
if aq.enabled then
aq.Log(("UNDER перенос отменён: y=%.0f, цель на %.0f"):format(bn.Y,D.Y))
end
bn=Vector3.new(bn.X,D.Y,bn.Z)
aR=nil
end







































if aq.enabled and af.ZoneAt(bn,0)
and(os.clock()-aG)>1 then
aG=os.clock()
aq.Log(("ВНУТРИ ОБЪЁМА: правило=%s, выдержка=%.2fс"):format(
tostring(am.Allows"rescue"),os.clock()-aF))
end

if am.Allows"rescue"and dodgeAllowed()
and af.ZoneAt(bn,0)and(os.clock()-aF)>0.15 then
local br=af.SafePoint(bn,ar)
if br and not af.IsSafe(br,ar)then br=nil end
if br then
aF=os.clock()
if aq.enabled then
aq.Log(("СПАСЕНИЕ: точка была внутри зоны, ухожу -> %.0f,%.0f,%.0f")
:format(br.X,br.Y,br.Z))
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
for V,W in ipairs{0.75,0.5,0.3,0.15}do
local X=Vector3.new(bs.X+bt.X*bu*W,bn.Y,
bs.Z+bt.Z*bu*W)
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
aq.Log(("ГРАНИЦА: точку вернули внутрь арены -> %.0f,%.0f,%.0f")
:format(bn.X,bn.Y,bn.Z))
end
end

































local bs=D
local bt=LocalPlayer:FindFirstChild"PlayerGui"
if bt and bt:FindFirstChild"firstBossLookAwayGui"then
bs=bn+(bn-D)
if aq.enabled then aq.Log"LOOKAWAY вспышка — отворачиваюсь"end
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
if not bn then drop"тоггл Auto Farm"end
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

ae.Where"уклонение без цели"
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








local bp=am.Active()
local bq="-"
local br=workspace:Raycast(bn.Position,Vector3.new(0,-300,0))
if br then bq=("%.0f"):format(bn.Position.Y-br.Position.Y)end
aq.Log(('HEIGHT \u{43d}\u{430}\u{434} \u{446}\u{435}\u{43b}\u{44c}\u{44e} %.1f | \u{446}\u{435}\u{43b}\u{44c} %s y=%.0f | hover=%.0f topY=%.0f | \u{437}\u{430}\u{434}\u{440}\u{430}\u{43b} %s (h=%.0f) | dodge=%s | \u{43f}\u{440}\u{430}\u{432}\u{438}\u{43b}\u{430}=%s ground=%s | \u{43d}\u{430}\u{434} \u{43f}\u{43e}\u{43b}\u{43e}\u{43c} %s'
)
:format(bn.Position.Y-bo.Y,aB.Name,bo.Y,
aU.hover,aU.topY,aU.raiser,aU.raiseH,
aR and("да, y="..math.floor(aR.Y))or"нет",
bp and(bp.name or"есть")or"НЕТ",
tostring(bp and bp.groundOnly),
bq))
end
end
end)
end






ay:Slider{
Name="Cast Only Within",
Desc="uses abilities only when the target is this close — 0 casts at any range",

Default=0,Min=0,Max=200,Decimals=0,
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
local x=bu*bs
local y=Vector3.new(math.cos(x)*bp,0,math.sin(x)*bp)
local z=Instance.new"Part"
z.Name="ApelMark"
z.Size=Vector3.new(bt,0.3,0.3)

z.CFrame=CFrame.lookAt(y,y+Vector3.new(math.cos(x),0,math.sin(x)))
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
if not bp then bg,bi=nil,nil end
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
br="след:"..tostring(bu.name)
end
end
end))

spawnLoop(function()
local bt,bu
while not _apelStopped do
task.wait(0.25)
local x=ab.Humanoid()
if x and x~=bt then
bt,bu=x,x.Health
regConn(x.HealthChanged:Connect(function(y)
local z=bu or y
bu=y
if y>=z then return end

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

local L=("DAMAGE -%.0f -> %.0f | zoneAgo=%.2fs (%s) | УБИЛА: %s | тут %s | mob=%s @%.0f | zones=%d | вокруг: %s | решение: %s | y=%.0f floor=%.0f arena=%s state=%s | атака: %s | %s"):format(
z-y,y,
os.clock()-bq,br,
af.PartInfo and af.PartInfo(bs)or"-",
K,
C and C.Name or"нет",B or-1,
af.Count(),J,
af.NotesText and af.NotesText()or"-",
D,E,F,
tostring(x:GetState()):gsub("Enum.HumanoidStateType.",""),
H,
((af.SafeTrail and af.SafeTrail(1.5)or"-")
..(af.SinceHop and(" | с прыжка %.2fс"):format(af.SinceHop())or"")))
aq.Log(L)



if y<=0 then
aq.Death(L.." | "..(workspace:FindFirstChild"dungeon"
and"подземелье"or"лобби"))
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
aq.Log(("АНИМАЦИЯ ВРАГА: %s | %s"):format(M.Name,
#O>0 and table.concat(O,", ")or"ничего не играет"))
end








if A then
local N=af.ZoneAt(A.Position,0)
local O=af.ZoneAt(A.Position,ar)
aq.Log(("ВНУТРИ ЗОНЫ: вплотную=%s | с запасом %d=%s"):format(
N and(tostring(N.Parent and N.Parent.Name)
.."/"..tostring(N.Name))or"НЕТ",
ar,
O and(tostring(O.Parent and O.Parent.Name)
.."/"..tostring(O.Name))or"НЕТ"))
end








if aq.enabled then
aq.Log("НАКРЫТИЕ: "..af.CoverReport())
end

if y<=0 and A then
for N,O in ipairs(af.NearestZones(A.Position,6))do
aq.Log("  БЛИЖАЙШАЯ ЗОНА: "..O)
end
end

if y<=0 then
local N=af.RecentAdds(2)
aq.Log(("ПОЯВИЛОСЬ ЗА 2с ДО СМЕРТИ: %d"):format(#N))
for O=1,math.min(#N,20)do
aq.Log("  "..N[O])
end
end







if A and y<=0 then



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
aq.Log(("СНИМОК СМЕРТИ: деталей в 45 студах — %d"):format(#N))
for O=1,math.min(#N,30)do
local P=N[O].part
aq.Log(("  %5.1f  %s | %s | size=%s | %s | trans=%.2f | зона=%s"):format(
N[O].gap,P:GetFullName():gsub("^Workspace%.",""),
P.ClassName,tostring(P.Size),tostring(P.Material),
P.Transparency,tostring(af.IsZone(P))))
end
end




aq.Log("      рядом: "..af.Nearby(A and A.Position or Vector3.zero,60))
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
drop"не в матче или фарм выключен"
elseif not aa:IsTop"AutoFarm"then




drop(not ab.Alive()and"персонаж мёртв"
or ac.Finished()and"прогон окончен"
or not ac.Started()and"прогон ещё не начат"
or"предикат AutoFarm ложен")
elseif not ab.Alive()then
drop"персонаж мёртв"
bp:Set"Dead — waiting to respawn"
else








if not aB and not ae.IsPinning()then
local bt=ab.HRP()
if bt and not af.HasFloor(bt.Position)then
local bu=ac.NextRoomWithEnemies(false)or ac.Rooms()[1]
local x=bu and bu.startPart
if x then
local y=x.Position+Vector3.new(0,4,0)



aC=y
ae.Pin(y,y+bt.CFrame.LookVector)
bp:Set"Stepped off the map — recovering"
end
end
end
pcall(function()













if aB and not e[tostring(aB.Name):lower()]then
local bt=ab.HRP()
if bt then
local bu,x=pickTarget(ac.Targets(),bt.Position)
if x and bu and bu~=aB then
acquire(bu)
if aq.enabled then
aq.Log("PRIORITY переключаемся на "..bu.Name)
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
local bu,x=ac.NextRoomWithEnemies(bt>0)
if bu then
enterRoom(bu)
trySweep(bu,x)
end
end










if not aB and#ac.Rooms()==0 then
local bu=ab.HRP()



local x=ac.Targets()
local y=bu and pickTarget(x,bu.Position)or nil
if y then
acquire(y)
bp:Set(("Wave %d — %d left"):format(ac.Wave(),#x))
end
end

if not aB then
local bu,x=ac.NextRoomWithEnemies(bt>0)
if bu then
local y=ab.HRP()
local z,A=false
if y then A,z=pickTarget(x,y.Position)end
if A then
acquire(A)
bp:Set(("Clearing %s — %d left%s"):format(
bu.name,#x,z and"  ·  priority target"or""))
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
local x=bu[#bu]
local y=ab.HRP()
if x and x.startPart and y then
bp:Set(ac.FightingBoss()and"Waiting for the boss to spawn"
or"Moving to the boss room")






local z=x.startPart.Position+Vector3.new(0,4,0)
aC=z
ae.Pin(z,z+y.CFrame.LookVector)
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
local x=gearGui()
local y=x and x:FindFirstChild"Frame"
if y then
for z,A in ipairs(y:GetChildren())do
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
local x=gearGui()
if not(x and x.Enabled)then return false end
if(os.clock()-bu)<2 then return false end

bu=os.clock()
aw.Fire("equipSet",S.gearSet)
x.Enabled=false
return true
end


spawnLoop(function()
while not _apelStopped do
task.wait(0.25)
pcall(answerGear)
end
end)


spawnLoop(function()
local x=false
while not _apelStopped and not x do
task.wait(2)
local y=gearOptions()
if#y>0 then
pcall(function()bt:SetOptions(y)end)
x=true
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
local x,y=0,0
while not _apelStopped do
task.wait(1)
if IN_MATCH and not Window:IsLoadingConfig()then
local z=LocalPlayer:FindFirstChild"PlayerGui"
if z then


if S.autoReady and z:FindFirstChild"readyButton"and(os.clock()-x)>3 then
x=os.clock()
aw.Fire"readyUp"
end
if S.autoStart and z:FindFirstChild"startButton"and(os.clock()-y)>3
and ac.IsOwner()and not gearPending()and not holdingForFriends()then
y=os.clock()
aw.Fire"changeStartValue"
end
end
end
end
end)













if aq.enabled then
spawnLoop(function()
local x=false
while not _apelStopped do
task.wait(1)
local y=IN_MATCH and ac.Started()and not ac.Finished()
if y and not x then
aq.Log(("=== ПРОГОН НАЧАТ · %s %s"):format(ac.Name(),ac.Difficulty()))
end
x=y
end
end)
end

local function afterRun()







aq.Log"=== ПРОГОН ОКОНЧЕН"









local x=S.smartDungeon and S.autoStartLobby
if not(S.autoReplay or x)then return end









if x then
local y=an.BestDifficultyFor(ac.Name(),ab.Level())
local z=ac.Difficulty()









if z~=""and ap.Rejects(ac.Name(),z,ac.Hardcore())then
Notify"Smart Dungeon: this run keeps failing — rebuilding it in the lobby"
drop()
aw.Fire"ReturnToLobbyEvent"
return
end
if y and z~=""and an.DifficultyRank(y)>an.DifficultyRank(z)then
Notify(("Smart Dungeon: %s is unlocked — returning to the lobby"):format(y))
drop()
aw.Fire"ReturnToLobbyEvent"
return
end
end

local y=ac.ReplayData()
if not y.dungeonName or y.dungeonName==""then return end

if not ac.IsOwner()then
Notify"Replay: only the run owner can replay this dungeon"
return
end

drop()
aw.Fire("replayDungeon",y)
end



















































































spawnLoop(function()
local x
while not _apelStopped do
task.wait(2)
if IN_MATCH and S.smartDungeon then
local y=ac.Name()
if y~=""and y~=x then
x=y
pcall(function()an.Stats(y)end)
end
end
end
end)



local x=aA:Label"Waiting for a dungeon"

spawnLoop(function()
while not _apelStopped do
task.wait(1)
if IN_MATCH then
pcall(function()









local y=ac.Rooms()
local z,A=0,0
for B,C in ipairs(y)do
if C.enemies then
z=z+1
A=A+#ac.AliveIn(C)
end
end






if not ac.Started()or ac.Finished()then forgetRooms()end
local B=clearedRooms()
local C=ac.TimeLeft()
x:Set(table.concat({
("<b>%s</b>%s"):format(ac.Name()~=""and ac.Name()or"—",
ac.Hardcore()and"  ·  Hardcore"or""),
("Rooms %d/%d   ·   Enemies left %d"):format(B,z,A),
("Time left %d:%02d   ·   %s"):format(math.floor(C/60),C%60,
ac.Finished()and"finished"or(ac.FightingBoss()and"boss fight"
or(ac.Started()and"in progress"or"waiting"))),
},"\n"))
end)
else
x:Set"Not in a dungeon"
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

local ae=50

return function(af)
local ag=af.Hoster
local ah=af.HostCtl or af.Hoster
local ai=af.Joining





S.hostNames=S.hostNames or{}

local function wanted()
local aj,ak={},{}
for al=1,ae do
local am=S.hostNames[al]
am=type(am)=="string"and am:gsub("^%s+",""):gsub("%s+$","")or""
if am~=""and not ak[am:lower()]then
ak[am:lower()]=true
aj[#aj+1]=am
end
end
return aj
end




local aj=ag:Section("Player Names",{Collapsible=false})
for ak=1,ae do
aj:Input{
Name="Player "..ak,
Default="",Placeholder="username",
Flag="HostName"..ak,
Callback=function(al)S.hostNames[ak]=tostring(al or"")end,
}
end

ah:Toggle{
Name="Wait For Them",
Desc="accepts join requests from the names above and holds the run until they are all here",
Default=false,Flag="HostWait",
Callback=function(ak)
S.hostWait=ak
if ak and not aa.CanHost()then
Notify"Joiner: requests arrive inside the dungeon — start it first"
end
end,
}

local ak=ah:Label"No names yet"


local function stillWaiting()
if not S.hostWait then return false,nil end
local al=wanted()
if#al==0 then return false,nil end
local am=aa.Missing(al)
if#am==0 then return false,nil end
return true,am
end



aa.SetHold(stillWaiting)


ac.OnClient("showJoinRequest",function(al,am,an)
if _apelStopped or not S.hostWait then return end
if an=="close"or type(am)~="string"or al==nil then return end

local ao=false
for ap,aq in ipairs(wanted())do
if aq:lower()==am:lower()then ao=true break end
end







if not ao then
if ad.enabled then
ad.Log(("ЗАЯВКА мимо списка: пришло %q, ждём %s"):format(
am,table.concat(wanted(),", ")))
end
return
end



task.delay(0.3,function()
if _apelStopped then return end
aa.Answer(al,true)
Notify("Joiner: accepted "..am)
end)
end)

spawnLoop(function()
while not _apelStopped do
if ak then
local al=wanted()
if#al==0 then
ak:Set"No names yet"
elseif not S.hostWait then
ak:Set(("%d names, waiting is off"):format(#al))
else
local am,an=stillWaiting()
ak:Set(am
and("waiting for %d: %s"):format(#an,table.concat(an,", "))
or"everyone is here — the run can start")
end
end
task.wait(1)
end
end)



local al
local am,an=0,false

ai:Input{
Name="Host",
Default="",Placeholder="username to join",
Flag="JoinHost",
Callback=function(ao)S.joinHost=tostring(ao or"")end,
}

local function askOnce()
local ao=S.joinHost
ao=type(ao)=="string"and ao:gsub("^%s+",""):gsub("%s+$","")or""
if ao==""then
Notify"Joiner: type a host name first"
return
end
if not aa.CanRequest()then
Notify"Joiner: requests can only be sent from the lobby"
return
end
task.spawn(function()
an=true
local ap,aq,ar=aa.SendRequest(ao)
an=false
if al then
al:Set(not ap and"request failed"
or aq and("waiting for "..ao.." to accept")
or("refused: "..tostring(ar or"?")))
end
end)
end

ai:Button{Name="Send Request",Text="Send",Callback=askOnce}

ai:Toggle{
Name="Auto Request",
Desc="keeps asking the host to let you in while you sit in the lobby",
Default=false,Flag="JoinerOn",
Callback=function(ao)S.joinerOn=ao end,
}

ai:Slider{
Name="Leave After",Default=30,Min=10,Max=180,Decimals=0,
Desc="seconds without the host in your dungeon before going back to the lobby",
Flag="JoinerPatience",
Callback=function(ao)S.joinerPatience=ao end,
}

al=ai:Label"Idle"



spawnLoop(function()
while not _apelStopped do
local ao=S.joinHost
ao=type(ao)=="string"and ao:gsub("^%s+",""):gsub("%s+$","")or""

if S.joinerOn and ao~=""and not an
and aa.CanRequest()and not Window:IsLoadingConfig()
and(os.clock()-am)>10
then


local ap=false
for aq,ar in ipairs(ab.Open()or{})do
if tostring(ar.name):lower()==ao:lower()then
ab.Join(ao)
ap=true
if al then al:Set("joining "..ao.." here")end
break
end
end

if not ap then
am=os.clock()
an=true
local aq,ar,as=aa.SendRequest(ao)
an=false
if al then
al:Set(not aq and"request failed"
or ar and("waiting for "..ao.." to accept")
or("refused: "..tostring(as or"?")))
end


if ar then am=os.clock()+15 end
end
end
task.wait(1)
end
end)





spawnLoop(function()
local ao
while not _apelStopped do
local ap=S.joinHost
ap=type(ap)=="string"and ap:gsub("^%s+",""):gsub("%s+$","")or""
local aq=tonumber(S.joinerPatience)or 30

if S.joinerOn and ap~=""and not aa.CanRequest()then
if aa.Present(ap)then
ao=nil
else
ao=ao or os.clock()
local ar=os.clock()-ao
if al then
al:Set(("%s is not here — %.0fs of %.0f")
:format(ap,ar,aq))
end
if ar>aq then
ao=nil
Notify("Joiner: "..ap.." never showed up, going back")
ac.Fire"ReturnToLobbyEvent"
end
end
else
ao=nil
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
if aw then return false,"уже идёт"end
local aA=LocalPlayer.Character
and LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
if not aA then return false,"нет персонажа"end

local aB=floorUnder(aA.Position)
if not aB then return false,"пол под ногами не найден"end







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
for aJ,aK in ipairs(aI:GetChildren())do
pcall(function()aK.Parent=ar end)
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
for aK,aL in ipairs(aJ:GetDescendants())do
if handle(aL,aB)then
aH=aH+1
if aH%ae==0 then task.wait()end
end
end
end


as=regConn(workspace.DescendantAdded:Connect(function(aI)
if not aw or not aI:IsA"BasePart"then return end
local aJ=false
for aK,aL in ipairs(targets())do
if aI:IsDescendantOf(aL)then aJ=true break end
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
for aK,aL in ipairs(aJ:GetDescendants())do
if not aw then break end
handle(aL,ax or 0)
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
local aI,aJ,aK=aE.X,aE.Y,aE.Z
if(aF<aC.minX and aI<aC.minX)or(aF>aC.maxX and aI>aC.maxX)then return false end
if(aG<aC.minY and aJ<aC.minY)or(aG>aC.maxY and aJ>aC.maxY)then return false end
if(aH<aC.minZ and aK<aC.minZ)or(aH>aC.maxZ and aK>aC.maxZ)then return false end

local aL=aC.cf:PointToObjectSpace(aD)












if math.abs(aL.X)<=aC.hx and math.abs(aL.Y)<=aC.hy
and math.abs(aL.Z)<=aC.hz then
return false
end

local aM=aC.cf:PointToObjectSpace(aE)
local aN,aO=0,1

local aP,aQ,aR=aL.X,aM.X-aL.X,aC.hx
if math.abs(aQ)<af then
if aP<-aR or aP>aR then return false end
else
local aS=1/aQ
local aT,aU=(-aR-aP)*aS,(aR-aP)*aS
if aT>aU then aT,aU=aU,aT end
if aT>aN then aN=aT end
if aU<aO then aO=aU end
if aN>aO then return false end
end

aP,aQ,aR=aL.Y,aM.Y-aL.Y,aC.hy
if math.abs(aQ)<af then
if aP<-aR or aP>aR then return false end
else
local aS=1/aQ
local aT,aU=(-aR-aP)*aS,(aR-aP)*aS
if aT>aU then aT,aU=aU,aT end
if aT>aN then aN=aT end
if aU<aO then aO=aU end
if aN>aO then return false end
end

aP,aQ,aR=aL.Z,aM.Z-aL.Z,aC.hz
if math.abs(aQ)<af then
if aP<-aR or aP>aR then return false end
else
local aS=1/aQ
local aT,aU=(-aR-aP)*aS,(aR-aP)*aS
if aT>aU then aT,aU=aU,aT end
if aT>aN then aN=aT end
if aU<aO then aO=aU end
if aN>aO then return false end
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
return("стен %d, дверей %d, углов %d"):format(#ag,#ah,al)
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
for aK,aL in ipairs{-1,1}do
local aM=(aF.cf*CFrame.new(aJ*aG,0,aL*aH)).Position
local aN=Vector3.new(aM.X,am,aM.Z)





local aO=false
for aP=1,#ai do
local aQ=ai[aP]
local aR,aS=aQ.X-aN.X,aQ.Z-aN.Z
if aR*aR+aS*aS<aA then aO=true break end
end
if not aO and not insideAnyWall(aN)then
ai[#ai+1]=aN
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
local aK=aj[aG]
aJ[#aJ+1]={aG,aI}
aK[#aK+1]={aE,aI}
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
local aK,aL=aF[1],aG[1]
local aM,aN=aF[aJ],aG[aJ]
aJ=aJ-1
if aJ>0 then
aF[1],aG[1]=aM,aN
local aO=1
while true do
local aP,aQ=aO*2,aO*2+1
local aR=aO
if aP<=aJ and aF[aP]<aF[aR]then aR=aP end
if aQ<=aJ and aF[aQ]<aF[aR]then aR=aQ end
if aR==aO then break end
aF[aR],aF[aO]=aF[aO],aF[aR]
aG[aR],aG[aO]=aG[aO],aG[aR]
aO=aR
end
end

if aK<=ak[aI+aL]then
for aO,aP in ipairs(aj[aL])do
local aQ,aR=aP[1],aP[2]
local aS=aK+aR
if aS<ak[aI+aQ]then
ak[aI+aQ]=aS
aJ=aJ+1
local aT=aJ
aF[aT],aG[aT]=aS,aQ
while aT>1 do
local aU=aT//2
if aF[aU]<=aF[aT]then break end
aF[aU],aF[aT]=aF[aT],aF[aU]
aG[aU],aG[aT]=aG[aT],aG[aU]
aT=aU
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
if type(dbg)=="function"then dbg("Route: сборка сорвалась: "..tostring(aE))end
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
local aK=(aC-aJ).Magnitude
if aK<=aH and(not aE or aK>aB)then
local aL
if aD then aL=aa.Clear(aC,aJ)else aL=not blockedByWalls(aC,aJ)end
if aL then aF[#aF+1]={aI,aK}end
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

local aI,aJ,aK=math.huge
for aL,aM in ipairs(aG)do
local aN,aO=aM[1],aM[2]
local aP=(aN-1)*al
for aQ,aR in ipairs(aH)do
local aS=aO+ak[aP+aR[1] ]+aR[2]
if aS<aI then aI,aJ,aK=aS,aN,aR[1]end
end
end
if not aJ then return nil,"no path"end

local aL={}
local aM,aN=aJ,0
while aM~=aK and aN<al do
aL[#aL+1]=ai[aM]
local aO,aP=math.huge
for aQ,aR in ipairs(aj[aM])do
local aS,aT=aR[1],aR[2]
local aU=aT+ak[(aS-1)*al+aK]
if aU<aO then aO,aP=aU,aS end
end
if not aP then break end
aM=aP
aN=aN+1
end
aL[#aL+1]=ai[aK]
aL[#aL+1]=aD
return aL,"via corners"
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





















local ad=5














local ae=6













local af=6
local ag=4












local ah=2.5
local ai=20











local aj=12

















local ak=40
local al=3


















local am=20

local an=90










local ao=8000






local ap=700
local aq=0.002






local ar=40

local as=120
local au=3







local av=0.5




local aw=5






local ax=2.5
local ay=0.3
local az=5
local aA=2
local aB=40
local aC=1.2











local aD=4
local aE=6

local aF={}











local aG,aH={},{}














local aI,aJ={},{}
local aK=0

local aL=0



local aM=0
local aN,aO=false,false
local aP,aQ=0,0
local aR=0
local aS=0
local aT,aU,aV=1





































local aW,aX=0
local aY,aZ=0.5,2















local a_=0.3
local a0=12
local a1=0
local a2=0
local a3
local a4,a5=0

local a6





function ab.SetFloorFilter(a7)
LPH_ATTRIBUTES(VM(NONE))a6=a7 end

local a7={
"ApelArenaFloor","ApelArenaWalls","ApelCastRing",
"ApelEditFloor","ApelEditWalls","ApelNavDots","ApelStepProbe","ApelNavProbe",
}


local a8={}
local a9={}

local b=RaycastParams.new()
b.FilterType=Enum.RaycastFilterType.Exclude
b.IgnoreWater=true




local ba=OverlapParams.new()
ba.FilterType=Enum.RaycastFilterType.Exclude
pcall(function()ba.RespectCanCollide=true end)

local function refreshFilter()
LPH_ATTRIBUTES(VM(NONE))
local bb={}
local bc=LocalPlayer and LocalPlayer.Character
if bc then bb[#bb+1]=bc end
for bd,be in ipairs(a7)do
local bf=workspace:FindFirstChild(be)
if bf then bb[#bb+1]=bf end
end
if a6 then
local bd,be=pcall(a6)
if bd and type(be)=="table"then
for bf,bg in ipairs(be)do bb[#bb+1]=bg end
end
end
a9=bb
b.FilterDescendantsInstances=bb
ba.FilterDescendantsInstances=bb

a8={}
end






local function addSkip(bb)
LPH_ATTRIBUTES(VM(NONE))
a9[#a9+1]=bb
local bc=pcall(function()b:AddToFilter(bb)end)
if not bc then b.FilterDescendantsInstances=a9 end
ba.FilterDescendantsInstances=a9
end














local bb
local bc,bd={},-99
local be=0.1
local bf=90

function ab.SetDanger(bg)
LPH_ATTRIBUTES(VM(NONE))bb=bg end







local bg

function ab.SetNoGo(bh)
LPH_ATTRIBUTES(VM(NONE))bg=(bh and#bh>0)and bh or nil end

local function inNoGo(bh,bi)
LPH_ATTRIBUTES(VM(NONE))
if not bg then return false end
for bj,bk in ipairs(bg)do
if bh>=bk[1]and bh<=bk[2]and bi>=bk[3]and bi<=bk[4]then return true end
end
return false
end

function ab.InNoGo(bh)
LPH_ATTRIBUTES(VM(NONE))return inNoGo(bh.X,bh.Z)end

local function cellOf(bh)
LPH_ATTRIBUTES(VM(NONE))return math.floor(bh/ac+0.5)end
local function worldOf(bh)
LPH_ATTRIBUTES(VM(NONE))return bh*ac end

local function at(bh,bi)
LPH_ATTRIBUTES(VM(NONE))
local bj=aF[bh]
return bj and bj[bi]or nil
end


































local function passThrough(bh)
LPH_ATTRIBUTES(VM(NONE))
return bh:IsA"BasePart"and not bh.CanCollide and bh~=workspace.Terrain
end

local function liveRoot(bh)
LPH_ATTRIBUTES(VM(NONE))
local bi=a8[bh]
if bi~=nil then return bi or nil end
local bj=false
local bk=bh
while bk and bk~=workspace do
if bk:IsA"Model"and bk:FindFirstChildOfClass"Humanoid"then
bj=bk
break
end
bk=bk.Parent
end
a8[bh]=bj
return bj or nil
end


local bh=4

local function castFloor(bi,bj)
LPH_ATTRIBUTES(VM(NONE))
for bk=1,bh do
local bl=workspace:Raycast(bi,Vector3.new(0,-bj,0),b)
if not bl then return nil end
local bm=liveRoot(bl.Instance)
if not bm and not passThrough(bl.Instance)then return bl.Position.Y end
addSkip(bm or bl.Instance)
end
return nil
end











local bi=4.93














local bj=2.22





















local bk=2.68













local bl=2.0












local bm
local bn=false



local bo=0.25
local bp=false

local function fitBox()
LPH_ATTRIBUTES(VM(NONE))
if bm and bm.Parent then return bm end
local bq,br=pcall(function()
local bq=Instance.new"Part"
bq.Name="ApelNavProbe"
bq.Anchored=true
bq.CanCollide=false
bq.CanQuery=false
bq.CanTouch=false
bq.Transparency=1
bq.Size=Vector3.new(bj,bi-bl,bj)
bq.Parent=workspace
return bq
end)
bm=bq and br or nil
return bm
end



local function fitsAt(bq,br,bs)
LPH_ATTRIBUTES(VM(NONE))
local bt=bi-bl
local bu=CFrame.new(bq,br+bl+bt*0.5,bs)
local c=fitBox()
if c then
c.CFrame=bu
local d,e=pcall(function()return workspace:GetPartsInPart(c,ba)end)
if d and type(e)=="table"then
for f,g in ipairs(e)do
if g~=c and g.CanCollide and g~=workspace.Terrain and not liveRoot(g)then
return false
end
end
return true
end
end






if not bn then
bn=true
aa.Log"Nav: GetPartsInPart недоступен — дорожки внутри клеток отключены"
end
return true
end






local bq=1.4
local br={
{0,0},
{bq,0},{-bq,0},{0,bq},{0,-bq},
{bq,bq},{bq,-bq},{-bq,bq},{-bq,-bq},
}


local function setLane(bs,bt,bu,c)
LPH_ATTRIBUTES(VM(NONE))
local d=aI[bs]
if not d then d={}aI[bs]=d end
local e=aJ[bs]
if not e then e={}aJ[bs]=e end
if d[bt]==nil and(bu~=0 or c~=0)then aK=aK+1 end
d[bt],e[bt]=bu,c
end

local function laneOf(bs,bt,bu)
LPH_ATTRIBUTES(VM(NONE))
local c=aI[bs]
if c and c[bt]~=nil then return c[bt],aJ[bs][bt]end
local d,e=bs*ac,bt*ac
local f,g=0,0
if not bp then
for h=1,#br do
local i=br[h]
if fitsAt(d+i[1],bu,e+i[2])then
f,g=i[1],i[2]
if h>1 then aK=aK+1 end
break
end
end
if aK>ao*bo then
bp=true
aa.Log(("Nav: дорожек вышло %d — проверка объёма врёт, отключаю их"):format(aK))
end
end
if not c then c={}aI[bs]=c end
c[bt]=f
local h=aJ[bs]
if not h then h={}aJ[bs]=h end
h[bt]=g
return f,g
end

















local bs={{0,0},{1,0},{-1,0},{0,1},{0,-1}}













local function probe(bt,bu,c)
LPH_ATTRIBUTES(VM(NONE))
local d,e=worldOf(bt),worldOf(bu)
local f
for g,h in ipairs(bs)do
f=castFloor(Vector3.new(d+h[1],c+ad,e+h[2]),
ad+ae)
if f then break end
end
if not f then return nil end
























if math.abs(f-c)>0.3 then
for g=2,#bs do
local h=bs[g]
local i=castFloor(Vector3.new(d+h[1],f+bl,e+h[2]),bl+0.7)
if i and i>f and(i-f)<=bl then f=i end
end
end








if bp or(f-c)<=bl then return f,0,0 end
if fitsAt(d,f,e)then return f,0,0 end
for g=2,#br do
local h=br[g]
local i=castFloor(Vector3.new(d+h[1],c+ad,e+h[2]),
ad+ae)
if i and fitsAt(d+h[1],i,e+h[2])then return i,h[1],h[2]end
end
return f,0,0
end

local bt=true








local bu=false








local function blocked(c,d,e,f,g,h)
LPH_ATTRIBUTES(VM(NONE))
local i=math.max(e,h or e)+bl





local j,k=laneOf(c,d,e)
local l,m=0,0
if h then l,m=laneOf(c+f,d+g,h)end
local n=Vector3.new(worldOf(c)+j,i+bk/2,worldOf(d)+k)
local o=Vector3.new(worldOf(c+f)+l-(worldOf(c)+j),0,
worldOf(d+g)+m-(worldOf(d)+k))

for p=1,bh do
local q
if bu or not bt then
q=workspace:Raycast(n,o,b)
else
local r,s=pcall(function()
return workspace:Blockcast(CFrame.new(n),
Vector3.new(bj,bk,bj),o,b)
end)
if r then
q=s
else
bt=false
aa.Log"Nav: Blockcast недоступен, иду лучом — маршрут будет жаться к стенам"
q=workspace:Raycast(n,o,b)
end
end
if not q then return false end
local r=liveRoot(q.Instance)
if not r and not passThrough(q.Instance)then return true end
addSkip(r or q.Instance)
end
return true
end


















local c=7






























local d=4












local e=2.2



local f=4.9

local function sheerEdge(g,h,i,j,k,l)
LPH_ATTRIBUTES(VM(NONE))
local m,n=worldOf(g),worldOf(h)
local o,p=worldOf(g+i),worldOf(h+j)
























local q=math.min(math.max(k,l)+bl,math.min(k,l)+f)
local r=q-(math.min(k,l)-ae)
local s=k
for u=1,d do
local v=u/d
local w=(u==d)and l
or castFloor(Vector3.new(m+(o-m)*v,q,n+(p-n)*v),r)











if not w then
w=castFloor(Vector3.new(m+(o-m)*v,q,n+(p-n)*v),r)
end
if not w then return true end
if math.abs(w-s)>e then return true end
s=w
end
return false
end



local function walkable(g,h)
LPH_ATTRIBUTES(VM(NONE))
local i,j=h.X-g.X,h.Z-g.Z
local k=math.sqrt(i*i+j*j)
if k<0.5 then return true end
local l,m=i/k,j/k
local n=math.ceil(math.min(c,k))













local o=g.Y-al
local p,q=g.X,g.Z
for r=1,n do
local s,u=g.X+l*r,g.Z+m*r
local v=Vector3.new(p,o+e+0.3,q)
local w=Vector3.new(s-p,0,u-q)
for x=1,bh do
local y=workspace:Raycast(v,w,b)
if not y then break end
local z=liveRoot(y.Instance)
if not z and not passThrough(y.Instance)then return false end
addSkip(z or y.Instance)
end
local x=castFloor(Vector3.new(s,o+e,u),e+ae)
if x then o=x end
p,q=s,u
end
return true
end


local function probeDeep(g,h,i)
LPH_ATTRIBUTES(VM(NONE))
local j,k=worldOf(g),worldOf(h)
for l,m in ipairs(bs)do
local n=castFloor(Vector3.new(j+m[1],i+ad,k+m[2]),
ad+ai)
if n then return n end
end
return nil
end


local function probeMid(g,h,i,j,k)
LPH_ATTRIBUTES(VM(NONE))
return castFloor(Vector3.new((worldOf(g)+worldOf(i))*0.5,k+ad,
(worldOf(h)+worldOf(j))*0.5),ad+ai)
end


local function pointOf(g,h)
LPH_ATTRIBUTES(VM(NONE))
local i=at(g,h)
if not i then return nil end
local j=aI[g]and aI[g][h]or 0
local k=aJ[g]and aJ[g][h]or 0
return Vector3.new(worldOf(g)+j,i+al,worldOf(h)+k)
end

local g={{1,0},{-1,0},{0,1},{0,-1}}


local h=ac*1.4142135623731
















local i=0.75
local function standCell(j,k,l)
LPH_ATTRIBUTES(VM(NONE))
local m=at(j,k)
if not l then return j,k,m end
if m and math.abs(m-l)<=i then return j,k,m end
local n,o,p
for q,r in ipairs(g)do
local s=at(j+r[1],k+r[2])
if s then
local u=math.abs(s-l)
if u<=e and(not p or u<p)then
p,n,o=u,j+r[1],k+r[2]
end
end
end
if n and(not m or p<math.abs(m-l))then return n,o,at(n,o)end
return j,k,m
end

local j={
{1,0,ac},{-1,0,ac},{0,1,ac},{0,-1,ac},
{1,1,h},{1,-1,h},{-1,1,h},{-1,-1,h},
}

local function edgeGet(k,l,m)
LPH_ATTRIBUTES(VM(NONE))
local n=k[l]
return n and n[m]
end















local function linked(k,l,m,n)
LPH_ATTRIBUTES(VM(NONE))
local o
if m==1 then o=edgeGet(aG,k,l)
elseif m==-1 then o=edgeGet(aG,k-1,l)
elseif n==1 then o=edgeGet(aH,k,l)
else o=edgeGet(aH,k,l-1)end
return type(o)=="number"and o or nil
end















local function ridgeAt(k,l)
LPH_ATTRIBUTES(VM(NONE))
local m=at(k,l)
if not m then return false end

local n=bl*0.5
local o,p=at(k-1,l),at(k+1,l)
if o and p and(m-o)>n and(m-p)>n then return true end
local q,r=at(k,l-1),at(k,l+1)
if q and r and(m-q)>n and(m-r)>n then return true end
return false
end















local function flood(k,l)
LPH_ATTRIBUTES(VM(NONE))
local m,n,o={},{},{}
local p=0
aM=0

aI,aJ,aK,bp={},{},0,false

local function gAt(q,r)
local s=m[q]
return s and s[r]or nil
end
local function gPut(q,r,s)
local u=m[q]
if not u then u={}m[q]=u end
if u[r]==nil then p=p+1 end
u[r]=s
end
local function gEdge(q,r,s,u,v,w)
local x,y,z
if s==1 then x,y,z=n,q,r
elseif s==-1 then x,y,z=n,q-1,r
elseif u==1 then x,y,z=o,q,r
else x,y,z=o,q,r-1 end
local A=x[y]
if not A then A={}x[y]=A end
local B=A[z]
if B~=nil then return B end
if blocked(q,r,v,s,u,w)then
B=false
else






local C=math.abs(w-v)







if bu or C<=bl or C>ad then
B=ad
elseif sheerEdge(q,r,s,u,v,w)then
B=bl
aM=aM+1
else
B=ad
end
end
A[z]=B
return B
end

local q,r=cellOf(k.X),cellOf(k.Z)
local s=k.Y-al
local u,v,w=probe(q,r,s)
if u then setLane(q,r,v or 0,w or 0)end

































local function seeCell(x,y)
local z=Vector3.new(k.X,s+bl+bk/2,k.Z)
local A=Vector3.new(worldOf(x),s+bl+bk/2,worldOf(y))-z
if A.Magnitude<0.1 then return true end
for B=1,bh do
local C=workspace:Raycast(z,A,b)
if not C then return true end
local D=liveRoot(C.Instance)
if not D and not passThrough(C.Instance)then return false end
addSkip(D or C.Instance)
end
return false
end

if u and(math.abs(u-s)>e or not seeCell(q,r))then
for x,y in ipairs(g)do
local z,A=q+y[1],r+y[2]
local B,C,D=probe(z,A,s)
if B and math.abs(B-s)<=e and seeCell(z,A)then
q,r,u=z,A,B
setLane(z,A,C or 0,D or 0)
break
end
end
end
if not u then


for x,y in ipairs(g)do
local z,A
u,z,A=probe(q+y[1],r+y[2],s)
if u then
q,r=q+y[1],r+y[2]
setLane(q,r,z or 0,A or 0)
break
end
end
end
if not u then return false,"под ногами нет пола"end

local x,y=q,r
gPut(q,r,u)

local z,A={q},{r}
local B=1
local C={[q]={[r]=true}}
local D=os.clock()







local E,F
if l then E,F=cellOf(l.X),cellOf(l.Z)end
local G

while B<=#z do
local H,I=z[B],A[B]
B=B+1
local J=gAt(H,I)












for K,L in ipairs(g)do
local M,N=H+L[1],I+L[2]


if math.abs(M-x)<=an and math.abs(N-y)<=an
and not inNoGo(worldOf(M),worldOf(N))then
local O=C[M]
if not O then O={}C[M]=O end

local P=gAt(M,N)
local Q,R,T
if P then
Q=P
else


Q,R,T=probe(M,N,J)

if not Q then Q,R,T=probeDeep(M,N,J),0,0 end
if Q then setLane(M,N,R or 0,T or 0)end
end
if Q then













local U=Q-J
local V=false
if U<=ad then
if U>=-ae then
V=true
elseif U>=-ai then


local W=probeMid(H,I,M,N,J)
V=W~=nil and math.abs(W-(J+Q)*0.5)<=ah
end
end
if V then


local W=gEdge(H,I,L[1],L[2],J,Q)






if W and U>W then W=false end
if W and not O[N]then
O[N]=true
gPut(M,N,Q)
z[#z+1],A[#A+1]=M,N
end
end
end
end
end

if p>=ao then break end





if E and not G then
local K=gAt(E,F)
if K and math.abs(K-l.Y)<=am then
G=#z+ap
end
end
if G and B>G then break end

if os.clock()-D>aq then
task.wait()
D=os.clock()
if _apelStopped then return false,"хаб выгружен"end
end
end















local H={}
for I,J in pairs(m)do
for K,L in pairs(J)do









local M=false
for N,O in ipairs(g)do
local P,Q=I+O[1],K+O[2]
local R=m[P]and m[P][Q]
if R then
if L-R>af then M=true break end
else














local T=castFloor(
Vector3.new(worldOf(P),L+ad,worldOf(Q)),
ad+af+2)
if not T and not blocked(I,K,L,O[1],O[2],nil)then
M=true
break
end
end
end






















if M and not(I==q and K==r)then
local N=0
for O,P in ipairs(g)do
if m[I+P[1] ]and m[I+P[1] ][K+P[2] ]then N=N+1 end
end
if N>=3 then H[#H+1]={I,K}end
end
end
end
for I,J in ipairs(H)do
local K=m[J[1] ]
if K and K[J[2] ]~=nil then K[J[2] ]=nil p=p-1 end
end







if p<ar and not bu then
bu=true
local I,J=flood(k,l)
bu=false
return I,J
end











if p<ar and aL>=ar and at(cellOf(k.X),cellOf(k.Z))then
return false,("сетка вышла крошечной (%d клеток), прежняя ещё держит"):format(p)
end

aF,aL,aG,aH=m,p,n,o
aP,aQ=x,y
return true
end



function ab.Ready()
LPH_ATTRIBUTES(VM(NONE))return aN end
function ab.Building()
LPH_ATTRIBUTES(VM(NONE))return aO end

function ab.Stats()
LPH_ATTRIBUTES(VM(NONE))



local k=0
for l,m in pairs(aF)do
for n in pairs(m)do
if ridgeAt(l,n)then k=k+1 end
end
end
return("клеток %d, центр %d:%d, радиус %d студов, отвесных граней %d, дорожек %d, гребней %d"):format(
aL,aP,aQ,an*ac,aM,aK,k)
end



function ab.HeightAt(k)
LPH_ATTRIBUTES(VM(NONE))
return at(cellOf(k.X),cellOf(k.Z))
end









function ab.Reachable(k,l)
LPH_ATTRIBUTES(VM(NONE))
if not aN then return false end
local m,n=cellOf(k.X),cellOf(k.Z)
local o=l or 3
for p=-o,o do
for q=-o,o do

local r=at(m+p,n+q)
if r and math.abs(r-k.Y)<=am then return true end
end
end
return false
end


















function ab.Clear(k,l)
LPH_ATTRIBUTES(VM(NONE))
if not aN then return false end


local m,n=k.X/ac+0.5,k.Z/ac+0.5
local o,p=l.X/ac+0.5,l.Z/ac+0.5

local q,r=math.floor(m),math.floor(n)
local s,u=math.floor(o),math.floor(p)









local v=at(s,u)
if v and math.abs(v-l.Y)>am then return false end









local w=k.Y-al
local x,y,z=standCell(q,r,w)
if x~=q or y~=r then
q,r=x,y
m,n=q+0.5,r+0.5
end

if not z then return false end
if q==s and r==u then return true end

local A,B=o-m,p-n
local C=A>0 and 1 or-1
local D=B>0 and 1 or-1




local E,F=math.abs(A),math.abs(B)
local G=(E>F)and(F/math.max(E,1e-6))or(E/math.max(F,1e-6))

local H,I=math.huge,math.huge
if A~=0 then
local J=A>0 and(q+1)or q
H=(J-m)/A
I=1/math.abs(A)
end
local J,K=math.huge,math.huge
if B~=0 then
local L=B>0 and(r+1)or r
J=(L-n)/B
K=1/math.abs(B)
end

for L=1,4096 do
local M,N=0,0
if H<J then
M=C
H=H+I
else
N=D
J=J+K
end

local O=linked(q,r,M,N)
if not O then return false end
local P,Q=q+M,r+N
local R=at(P,Q)
if not R then return false end


















local T=R-z
if T>O or T<-af then return false end
















if G>0.15 and T>bl*0.5 then
local U=(M~=0)and 0 or((A<0 and-1)or(A>0 and 1)or 0)
local V=(N~=0)and 0 or((B<0 and-1)or(B>0 and 1)or 0)
if U~=0 or V~=0 then
local W=linked(q+U,r+V,M,N)
local X=at(q+U,r+V)
local Y=at(P+U,Q+V)
if not W or not X or not Y or(Y-X)>W then return false end
end
end
q,r,z=P,Q,R
if q==s and r==u then return true end
end
return false
end













function ab.ClearSafe(k,l)
LPH_ATTRIBUTES(VM(NONE))
if not ab.Clear(k,l)then return false end
local m,n=cellOf(k.X),cellOf(k.Z)
local o,p=cellOf(l.X),cellOf(l.Z)
local q=math.max(math.abs(o-m),math.abs(p-n))
for r=0,q do
local s=m+math.floor((o-m)*r/math.max(1,q)+0.5)
local u=n+math.floor((p-n)*r/math.max(1,q)+0.5)
if not at(s+1,u)or not at(s-1,u)
or not at(s,u+1)or not at(s,u-1)then
return false
end







if r>0 and r<q and ridgeAt(s,u)then return false end
end
return true
end









function ab.NearestWhere(k,l,m)
LPH_ATTRIBUTES(VM(NONE))
if not aN then return nil end
local n,o=cellOf(k.X),cellOf(k.Z)
local p=math.max(1,math.floor((l or 40)/ac+0.5))
for q=1,p do
for r=-q,q do
for s=-q,q do
if math.abs(r)==q or math.abs(s)==q then
local u=at(n+r,o+s)
if u then
local v=Vector3.new(worldOf(n+r),u+al,worldOf(o+s))
if m(v)then return v end
end
end
end
end
end
return nil
end




function ab.RoomAt(k,l)
LPH_ATTRIBUTES(VM(NONE))
if not aN then return false end
local m,n=cellOf(k.X),cellOf(k.Z)
local o=at(m,n)
if not o then return false end
local p=math.max(1,math.floor(l/ac+0.5))
for q=-p,p do
for r=-p,p do
if q*q+r*r<=p*p then
local s=at(m+q,n+r)
if not s then return false end
if math.abs(s-o)>ad+ae then return false end
end
end
end
return true
end









local function nearestCell(k,l,m,n)
LPH_ATTRIBUTES(VM(NONE))
local function onLayer(o)return o~=nil and(not n or math.abs(o-k.Y)<=am)end
local o,p=cellOf(k.X),cellOf(k.Z)
local q=at(o,p)
if n and q and not onLayer(q)then q=nil end


if q and m then
local r,s=standCell(o,p,m)
if r~=o or s~=p then return r,s end
end
if q then return o,p end
for r=1,l do
for s=-r,r do
for u=-r,r do
if math.abs(s)==r or math.abs(u)==r then
if onLayer(at(o+s,p+u))then return o+s,p+u end
end
end
end
end
return nil
end






local function hotCells()
LPH_ATTRIBUTES(VM(NONE))
if os.clock()-bd<be then return bc end
bd=os.clock()
bc={}
if not bb then return bc end
local k,l=pcall(bb)
if not k or type(l)~="table"then return bc end

for m,n in ipairs(l)do
local o,p=n.cf,n.size
if o and p then
local q=p.Y*0.5

local r=math.abs(o.RightVector.X)*p.X*0.5
+math.abs(o.UpVector.X)*p.Y*0.5
+math.abs(o.LookVector.X)*p.Z*0.5
local s=math.abs(o.RightVector.Z)*p.X*0.5
+math.abs(o.UpVector.Z)*p.Y*0.5
+math.abs(o.LookVector.Z)*p.Z*0.5
local u,v=cellOf(o.Position.X-r),cellOf(o.Position.X+r)
local w,x=cellOf(o.Position.Z-s),cellOf(o.Position.Z+s)

if(v-u)*(x-w)<=4000 then
local y=n.cylinder and(p.Y*0.5)or nil
for z=u,v do
local A=aF[z]
if A then
for B=w,x do
local C=A[B]
if C then
local D=Vector3.new(worldOf(z),C+al,worldOf(B))
local E
if y then
local F=Vector3.new(D.X-o.Position.X,0,D.Z-o.Position.Z)
E=F.Magnitude<=y
and math.abs(D.Y-o.Position.Y)<=p.X*0.5
else
local F=o:PointToObjectSpace(D)
E=math.abs(F.X)<=p.X*0.5
and math.abs(F.Y)<=q
and math.abs(F.Z)<=p.Z*0.5
end
if E then bc[z*1000000+B]=true end
end
end
end
end
end
end
end
return bc
end

function ab.HotAt(k)
LPH_ATTRIBUTES(VM(NONE))
local l=hotCells()
return l[cellOf(k.X)*1000000+cellOf(k.Z)]==true
end



























local k=12

local function segHot(l,m,n)
LPH_ATTRIBUTES(VM(NONE))
if not bb then return false end
local o=hotCells()
local p,q=m.X-l.X,m.Z-l.Z
local r=math.sqrt(p*p+q*q)
if r<=0.1 then return o[cellOf(l.X)*1000000+cellOf(l.Z)]==true end
if n and r>n then
local s=n/r
p,q,r=p*s,q*s,n
end
local s=math.min(64,math.ceil(r/ac))











local u=false
for v=1,s do
local w=v/s
local x=o[cellOf(l.X+p*w)*1000000+cellOf(l.Z+q*w)]
if not x then
u=true
elseif u then
return true
end
end
return false
end

local function astar(l,m,n,o)
LPH_ATTRIBUTES(VM(NONE))
local p=hotCells()
local q,r,s={},{},{}
local u=0
local v,w,x={},{},{}
local y={}

local function key(z,A)return z*1000000+A end

local function push(z,A,B)
u=u+1
q[u],r[u],s[u]=z,A,B
local C=u
while C>1 do
local D=math.floor(C/2)
if s[D]<=s[C]then break end
q[D],q[C]=q[C],q[D]
r[D],r[C]=r[C],r[D]
s[D],s[C]=s[C],s[D]
C=D
end
end

local function pop()
local z,A=q[1],r[1]
q[1],r[1],s[1]=q[u],r[u],s[u]
u=u-1
local B=1
while true do
local C,D,E=B*2,B*2+1,B
if C<=u and s[C]<s[E]then E=C end
if D<=u and s[D]<s[E]then E=D end
if E==B then break end
q[E],q[B]=q[B],q[E]
r[E],r[B]=r[B],r[E]
s[E],s[B]=s[B],s[E]
B=E
end
return z,A
end




local function heur(z,A)
local B,C=math.abs(z-n),math.abs(A-o)
local D=math.min(B,C)
return(B+C-2*D)*ac+D*h
end

v[key(l,m)]=0
push(l,m,heur(l,m))

while u>0 do
local z,A=pop()
local B=key(z,A)
if not y[B]then
y[B]=true
if z==n and A==o then
local C={}
local D,E=z,A
while D do
C[#C+1]=pointOf(D,E)or Vector3.new(worldOf(D),at(D,E)+al,worldOf(E))
local F=key(D,E)
D,E=w[F],x[F]
end

local F={}
for G=#C,1,-1 do F[#F+1]=C[G]end
return F
end
local C=at(z,A)









for D,E in ipairs(j)do
local F,G=z+E[1],A+E[2]
local H=at(F,G)








local I
if H then
if E[1]==0 or E[2]==0 then
I=linked(z,A,E[1],E[2])
else
local J=linked(z,A,E[1],0)
local K=linked(z,A,0,E[2])
local L=(at(z+E[1],A)and at(z,A+E[2]))
and linked(z+E[1],A,0,E[2])or nil













if J and K and L then I=math.min(J,K,L,bl)end
end
end
if I then
local J=H-C
if J<=I and J>=-ae then
local K=key(F,G)
if not y[K]then


local L=J<-af and(-J-af)or 0


local M,N=at(F-1,G),at(F+1,G)
local O,P=at(F,G-1),at(F,G+1)
local Q=0
if not N then Q=Q+1 end
if not M then Q=Q+1 end
if not P then Q=Q+1 end
if not O then Q=Q+1 end


local R=ridgeAt(F,G)and ak or 0

local T=v[B]+E[3]
+L*ag+Q*aj+R
+(p[K]and bf or 0)
if T<(v[K]or math.huge)then
v[K]=T
w[K],x[K]=z,A
push(F,G,T+heur(F,G))
end
end
end
end
end
end
end
return nil
end




local function simplify(l)
LPH_ATTRIBUTES(VM(NONE))
if#l<=2 then return l end
local m={l[1]}
local n=1
for o=3,#l do
if not ab.ClearSafe(l[n],l[o])or segHot(l[n],l[o],k)then
m[#m+1]=l[o-1]
n=o-1
end
end
m[#m+1]=l[#l]
return m
end

function ab.Path(l,m)
LPH_ATTRIBUTES(VM(NONE))
a3=m
a4=(Vector3.new(m.X,0,m.Z)-Vector3.new(l.X,0,l.Z)).Magnitude
if not aN then return nil,"нет сетки"end

local n,o=nearestCell(l,4,l.Y-al)
if not n then a2=os.clock()a5="старт вне сетки"return nil,a5 end
local p,q=nearestCell(m,8,nil,true)









local r=false
if not p then
a2=os.clock()
a5="ЦЕЛЬ ВНЕ СЕТКИ"
ab.Grow()

















































local s={}
for u,v in ipairs{true,false}do
local w,x,y=math.huge
for z,A in pairs(aF)do
for B,C in pairs(A)do
if not v or math.abs(C-m.Y)<=am then
local D,E=worldOf(z)-m.X,worldOf(B)-m.Z
local F=v and(C-m.Y)or 0
local G=D*D+E*E+F*F
if G<w then w,x,y=G,z,B end
end
end
end
s[u]=x and{x,y,math.sqrt(w)}or nil
end
local u=s[2]
if s[1]and(not u or s[1][3]<=u[3]*1.5+20)then u=s[1]end
if not u then return nil,a5 end
local v,w=u[1],u[2]
p,q,r=v,w,true
end

local s=astar(n,o,p,q)
if not s then
a2=os.clock()
a5="цель в сетке, но пути к ней нет"
ab.Grow()
return nil,a5
end

local u=simplify(s)




if not r then u[#u]=m end







local v=(Vector3.new(m.X,0,m.Z)-Vector3.new(l.X,0,l.Z)).Magnitude
local w=(#s-1)*ac
if v>12 and w>v*1.6 then
aa.Log(("Nav: крюк %.0f%% — по клеткам %.0f при прямой %.0f, точек %d")
:format((w/v-1)*100,w,v,#u))
end
return u,r and"до края доступного"or"ok"
end

function ab.Step(l,m)
LPH_ATTRIBUTES(VM(NONE))























local n=false
if bb then
local o=hotCells()
local p,q=m.X-l.X,m.Z-l.Z
local r=math.sqrt(p*p+q*q)
if r>0.1 then
local s=math.min(64,math.ceil(r/ac))
for u=0,s do
local v=u/s
local w,x=l.X+p*v,l.Z+q*v
if o[cellOf(w)*1000000+cellOf(x)]then n=true break end
end
end
end











local function pick(o,p)
if not o then return o,p end
if walkable(l,o)then return o,p end





if aU then
for q=math.min(aT,#aU),1,-1 do
local r=aU[q]
local s,u=r.X-l.X,r.Z-l.Z
if math.sqrt(s*s+u*u)>1.5 and walkable(l,r)then
aT=q
return r,"назад по маршруту"
end
end
end










local q=(aU and aU[math.min(aT,#aU)])or m
local r,s=cellOf(l.X),cellOf(l.Z)
local u=l.Y-al
local v,w,x
for y,z in ipairs(g)do
local A,B=r+z[1],s+z[2]
local C=at(A,B)











local D=C and linked(r,s,z[1],z[2])
local E=C and(C-u)
if D and E<=D and E>=-ae then
local F=pointOf(A,B)or Vector3.new(worldOf(A),C+al,worldOf(B))
if walkable(l,F)then
local G=(Vector3.new(F.X,0,F.Z)-Vector3.new(q.X,0,q.Z)).Magnitude
if not x or G<x then x,v,w=G,A,B end
end
end
end
if v then


if aa.enabled then
aa.Log(("СХОЖУ С ГРАНИ: шаг упирался телом, отступаю на клетку %d:%d")
:format(worldOf(v),worldOf(w)))
end
return pointOf(v,w)or Vector3.new(worldOf(v),at(v,w)+al,worldOf(w)),
"схожу с грани"
end

return o,p
end




local function trace(o,p)
ab.Last={
why=p,
at=aT,
n=aU and#aU or 0,
step=o,
node=aU and aU[math.min(aT,math.max(1,#aU))],
}
return o,p
end


local function deliver(o,p)
local q,r=pick(o,p)
if not q then aX=nil return trace(q,r)end
local s=os.clock()




if aX and(s-aW)<aY then
local u,v=aX.X-l.X,aX.Z-l.Z
if math.sqrt(u*u+v*v)>aC then

local w,x=q.X-aX.X,q.Z-aX.Z
if math.sqrt(w*w+x*x)<=aZ then aX=q end
return trace(aX,r)
end
end
aX,aW=q,s
return trace(q,r)
end

if not n and ab.Clear(l,m)then
aU,aV=nil,nil
return deliver(m,"direct")
end
if not aN then
if ab.Clear(l,m)then return m,"direct, сетки нет"end
return nil,"нет сетки"
end
































local function advance()
while aT<=#aU do
local o=aU[aT]
local p=aU[aT-1]
local q=aU[aT+1]












local r=false
if p then
local s,u=o.X-p.X,o.Z-p.Z
r=(l.X-o.X)*s+(l.Z-o.Z)*u>0
end
if not r then
local s,u=o.X-l.X,o.Z-l.Z
local v=math.sqrt(s*s+u*u)

local w=aw
if p and q then
local x,y=o.X-p.X,o.Z-p.Z
local z,A=q.X-o.X,q.Z-o.Z
local B=math.sqrt(x*x+y*y)
local C=math.sqrt(z*z+A*A)
if B>0.01 and C>0.01
and(x*z+y*A)/(B*C)<ay then
w=ax
end
end
if v>w then break end














if o.Y-l.Y>math.max(0.6,v*0.5)then break end
end
aT=aT+1
end
end






























local function stretch(o)
if not o then return o end
local p,q=o.X-l.X,o.Z-l.Z
local r=math.sqrt(p*p+q*q)
if r>=aD or r<0.05 then return o end
local s=aD/r
return Vector3.new(l.X+p*s,o.Y,l.Z+q*s)
end

local function aimOf(o)
local p=aU and aU[o]
if not p then return nil end
local function farEnough(q)
local r,s=q.X-l.X,q.Z-l.Z
return(r*r+s*s)>az*az
end
if farEnough(p)then return p end




local q,r,s=p,o,0
while aU[r+1]and s<aB do
local u,v=aU[r],aU[r+1]
local w,x,y=v.X-u.X,v.Y-u.Y,v.Z-u.Z
local z=math.sqrt(w*w+y*y)
if z>0.01 then
local A=aA
while A<=z do
local B=A/z
local C=Vector3.new(u.X+w*B,u.Y+x*B,u.Z+y*B)
if not ab.Clear(l,C)then return stretch(q)end
q=C
if farEnough(C)then return C end
A=A+aA
end
s=s+z
end
r=r+1
end
return stretch(q)
end

local function furthest()
local o






for p=aT,#aU do
if ab.ClearSafe(l,aU[p])and not segHot(l,aU[p],k)then
o=p
else break end
end
if o then return o end






































if aU[aT]and ab.Clear(l,aU[aT])
and not segHot(l,aU[aT],k)then
if aa.enabled then
aa.Log"СРЕЗКА СКВОЗЬ УДАР: чистой хорды нет, иду по узлам маршрута"
end
return aT
end
if aU[aT]and aa.enabled then
aa.Log"ШАГА НЕТ: даже ближайший узел ведёт сквозь удар"
end
for p=aT,#aU do
if ab.ClearSafe(l,aU[p])then o=p else break end
end
if o then return o end
for p=aT,#aU do
if ab.Clear(l,aU[p])then o=p else break end
end
if o then return o end
































local function far(p)
local q=aimOf(p)
if not q then return nil end
local r,s=q.X-l.X,q.Z-l.Z
if math.sqrt(r*r+s*s)<=aw*0.5 then return nil end
return q
end
for p=aT-1,1,-1 do
local q=far(p)
if q and ab.ClearSafe(l,q)then return p end
end
for p=aT-1,1,-1 do
local q=far(p)
if q and ab.Clear(l,q)then return p end
end
return nil
end












local o=math.max(aE,(m-l).Magnitude*0.1)
if aU and aV and(m-aV).Magnitude<=o then
advance()
local function keeps(p)
if not p then return false end
local q,r=m.X-l.X,m.Z-l.Z
local s,u=m.X-p.X,m.Z-p.Z
return math.sqrt(s*s+u*u)
<=math.sqrt(q*q+r*r)+a0
end
local p=aT<=#aU and furthest()or nil
local q=p and aimOf(p)
if q and keeps(q)then
aT=p
return deliver(q,"via cell")
end

if(p or aU[aT])and(os.clock()-a1)>a_ then
a1=os.clock()
aU,aV=nil,nil
end















local r=aU and aU[aT]and aimOf(aT)
if r and keeps(r)then
return deliver(r,"по узлам маршрута")
end
end

local p=ab.Path(l,m)
if not p or#p==0 then


if ab.Clear(l,m)then
return m,n and"direct сквозь атаку, обхода нет"or"direct по кромке"
end
return nil,"маршрута нет"
end
aU,aV,aT=p,m,1

aX=nil
advance()
if aT>#aU then















return aU[#aU],"до края доступного"
end
local q=furthest()
if q then aT=q end
local r=aimOf(aT)











return deliver(r or aU[aT],"via cell")
end



function ab.Rebuild(l,m)
LPH_ATTRIBUTES(VM(NONE))
if aO then return end
aO=true






task.spawn(function()


local n=tick()
local o,p=pcall(function()
local o=LocalPlayer and LocalPlayer.Character
local p=o and o:FindFirstChild"HumanoidRootPart"
if not p then error"нет персонажа"end
refreshFilter()
local q,r=flood(p.Position,m)
if not q then error(r)end
end)
aO=false
aN=aL>0
if o then
aa.Log(("Nav: сетка построена за %.0f мс %s— %s"):format(
(tick()-n)*1000,
m and"(до цели) "or"",
ab.Stats()))

aU,aV,aT=nil,nil,1
else
aa.Log("Nav: сборка не принята:",tostring(p))
end
end)
end

















function ab.Grow()
LPH_ATTRIBUTES(VM(NONE))
if aO or not aN then return end
if os.clock()-aS<av then return end
aS=os.clock()


aa.Log(("Nav: маршрут не нашёлся (%s, до цели %.0f студов) — пересобираю")
:format(tostring(a5),a4))
ab.Rebuild(nil,a3)
end

function ab.Refresh(l)
LPH_ATTRIBUTES(VM(NONE))
if aO then return end
if os.clock()-aR<au then return end

local m=LocalPlayer and LocalPlayer.Character
local n=m and m:FindFirstChild"HumanoidRootPart"
if not n then return end

local o=(cellOf(n.Position.X)-aP)*ac
local p=(cellOf(n.Position.Z)-aQ)*ac
local q=math.sqrt(o*o+p*p)







local r=(os.clock()-a2)<au



local s=ab.HeightAt(n.Position)==nil
if not r and q<as and not s then return end

aR=os.clock()


aa.Log(("Nav: пересборка — %s (отход %.0f студов, я на %.0f,%.0f,%.0f)"):format(
r and"маршрут не нашёлся"
or(s and"подо мной нет клетки"or"ушли далеко"),
q,n.Position.X,n.Position.Y,n.Position.Z))
ab.Rebuild(l)
end

function ab.Clear_Held()
LPH_ATTRIBUTES(VM(NONE))
aU,aV,aT=nil,nil,1
aX=nil
end

return ab end function a.M():typeof(__modImpl())local aa=a.cache.M if not aa then aa={c=__modImpl()}a.cache.M=aa end return aa.c end end do local function __modImpl()




























local aa=a.l()

local ab={}

local ac="ApelHub"
local ad=ac.."/anim_table.json"
local ae=ac.."/anim_table.txt"
local af=10

local ag=3


local ah={}
local ai,aj=0,0
local ak=false
local al=setmetatable({},{__mode="k"})
local am={}
local an=setmetatable({},{__mode="k"})

local function canWrite()
return type(writefile)=="function"and type(isfile)=="function"
end

local function note(ao,ap)
if type(ap)~="number"then return ao end
if not ao then return{min=ap,max=ap,sum=ap,n=1}end
if ap<ao.min then ao.min=ap end
if ap>ao.max then ao.max=ap end
ao.sum,ao.n=ao.sum+ap,ao.n+1
return ao
end

local function fmt(ao)
if not ao then return"-"end
return("%.2f..%.2f (сред %.2f, замеров %d)"):format(ao.min,ao.max,ao.sum/ao.n,ao.n)
end

local function slot(ao,ap)
local aq=ah[ao]
if not aq then aq={}ah[ao]=aq end
local ar=aq[ap]
if not ar then ar={n=0,follows={}}aq[ap]=ar end
return ar
end





local function reviveStat(ao)
if type(ao)~="table"or type(ao.n)~="number"then return nil end
return{min=ao.min,max=ao.max,n=ao.n,sum=(ao.avg or ao.min or 0)*ao.n}
end

local function load()
if not canWrite()or not isfile(ad)then return end
local ao,ap=pcall(function()
return game:GetService"HttpService":JSONDecode(readfile(ad))
end)
if not ao or type(ap)~="table"then return end
for aq,ar in pairs(ap)do
for as,au in pairs(ar)do
local av=slot(aq,as)
av.n=(av.n or 0)+(tonumber(au.n)or 0)
av.size=av.size or au.size
if type(au.follows)=="table"then
for aw,ax in pairs(au.follows)do av.follows[aw]=(av.follows[aw]or 0)+ax end
end
for aw,ax in ipairs{"gap","lead","toHit","reach","hitFrom","dmg"}do
local ay=reviveStat(au[ax])
if ay then
if av[ax]then
av[ax].min=math.min(av[ax].min,ay.min)
av[ax].max=math.max(av[ax].max,ay.max)
av[ax].sum=av[ax].sum+ay.sum
av[ax].n=av[ax].n+ay.n
else
av[ax]=ay
end
end
end
end
end
end


local function flat(ao)
if not ao then return nil end
return{min=ao.min,max=ao.max,avg=ao.sum/ao.n,n=ao.n}
end

local function readable()
local ao={("== ТАБЛИЦА АНИМАЦИЙ ==  проигрышей %d, связей %d"):format(ai,aj)}
local ap={}
for aq in pairs(ah)do ap[#ap+1]=aq end
table.sort(ap)
for aq,ar in ipairs(ap)do
ao[#ao+1]=("\n[%s]"):format(ar)
local as={}
for au in pairs(ah[ar])do as[#as+1]=au end
table.sort(as,function(au,av)return ah[ar][au].n>ah[ar][av].n end)
for au,av in ipairs(as)do
local aw=ah[ar][av]
ao[#ao+1]=("  анимация %s — сыграна %dx"):format(av,aw.n)
ao[#ao+1]=("     период между повторами: %s"):format(fmt(aw.gap))
if aw.lead then ao[#ao+1]=("     фора до детали:          %s"):format(fmt(aw.lead))end
if aw.toHit then ao[#ao+1]=("     фора до урона:           %s"):format(fmt(aw.toHit))end
if aw.reach then ao[#ao+1]=("     дальность от моба:       %s"):format(fmt(aw.reach))end
if aw.hitFrom then ao[#ao+1]=("     бил с дистанции:         %s"):format(fmt(aw.hitFrom))end
if aw.dmg then ao[#ao+1]=("     урон:                    %s"):format(fmt(aw.dmg))end
if aw.size then ao[#ao+1]=("     размер детали:           %s"):format(aw.size)end
local ax={}
for ay,az in pairs(aw.follows)do ax[#ax+1]=("%s x%d"):format(ay,az)end
table.sort(ax)
if#ax>0 then ao[#ao+1]=("     следом появлялось:       %s"):format(table.concat(ax,", "))end
end
end
return table.concat(ao,"\n")
end

function ab.Save()
if not canWrite()then return false end
local ao={}
for ap,aq in pairs(ah)do
ao[ap]={}
for ar,as in pairs(aq)do
ao[ap][ar]={
n=as.n,size=as.size,follows=as.follows,
gap=flat(as.gap),lead=flat(as.lead),toHit=flat(as.toHit),
reach=flat(as.reach),hitFrom=flat(as.hitFrom),dmg=flat(as.dmg),
}
end
end
local ap=pcall(function()
writefile(ad,game:GetService"HttpService":JSONEncode(ao))
end)
local aq=pcall(function()writefile(ae,readable())end)
return ap and aq
end


local function isPlayerChar(ao)
if ao==LocalPlayer.Character then return true end
return Players:GetPlayerFromCharacter(ao)~=nil
end

local function eachMob(ao)
for ap,aq in ipairs(workspace:GetChildren())do
if aq:IsA"Model"and not isPlayerChar(aq)and aq:FindFirstChildOfClass"Humanoid"then
ao(aq)
end
end
local ap=workspace:FindFirstChild"dungeon"
if not ap then return end
for aq,ar in ipairs(ap:GetChildren())do
local as=ar:FindFirstChild"enemyFolder"
if as then
for au,av in ipairs(as:GetChildren())do
if av:IsA"Model"and av:FindFirstChildOfClass"Humanoid"then ao(av)end
end
end
end
end

local function casterOf(ao,ap)
local aq,ar
eachMob(function(as)
local au=as:FindFirstChild"HumanoidRootPart"or as.PrimaryPart
if not au then return end
local av=(au.Position-ao).Magnitude
if av<=(ap or 90)and(not ar or av<ar)then aq,ar=as,av end
end)
return aq,ar
end

local function isAttackPart(ao)
if not ao:IsA"BasePart"then return false end
local ap=tostring(ao.Name):lower()
if ap:find("hitbox",1,true)or ap:find("precast",1,true)
or ap:find("indicator",1,true)then return true end
local aq=ao.Parent and tostring(ao.Parent.Name):lower()or""
return aq:find"strike"~=nil or aq:find"shot"~=nil
or aq:find"blast"~=nil or aq:find"slam"~=nil
or aq:find"beam"~=nil
end


local function hook(ao)
if al[ao]then return end
local ap=ao:FindFirstChildOfClass"Humanoid"
local aq=ap and ap:FindFirstChildOfClass"Animator"
if not aq then return end
al[ao]=true

regConn(aq.AnimationPlayed:Connect(function(ar)
if _apelStopped or not ak then return end
pcall(function()
local as=tostring(ar.Animation and ar.Animation.AnimationId or"?")
:gsub("rbxassetid://",""):gsub("http://www%.roblox%.com/asset/%?id=","")
local au=slot(ao.Name,as)
local av=os.clock()



local aw=an[ao]
if not aw then aw={}an[ao]=aw end
if aw[as]then
local ax=av-aw[as]
if ax<60 then au.gap=note(au.gap,ax)end
end
aw[as]=av

au.n=au.n+1
ai=ai+1

local ax=ao:FindFirstChild"HumanoidRootPart"or ao.PrimaryPart
am[#am+1]={mob=ao.Name,id=as,at=av,model=ao,
pos=ax and ax.Position or nil}
while am[1]and av-am[1].at>3 do table.remove(am,1)end
end)
end))
end

local function linkPart(ao)
if not ak or not isAttackPart(ao)then return end
local ap=("%s/%s"):format(ao.Parent and ao.Parent.Name or"?",ao.Name)






local aq=casterOf(ao.Position,90)
if not aq then return end







local ar=os.clock()
local as
for au=#am,1,-1 do
local av=am[au]
if ar-av.at>ag then break end
if av.model==aq then as=av break end
end
if not as then return end






as.linked=as.linked or{}
if as.linked[ap]then return end
as.linked[ap]=true

local au=slot(as.mob,as.id)
au.lead=note(au.lead,ar-as.at)
au.follows[ap]=(au.follows[ap]or 0)+1





local av=ao.Size.X*ao.Size.Y*ao.Size.Z
if not au.size or(au.vol or 0)<av then
au.size=("%.1f x %.1f x %.1f"):format(ao.Size.X,ao.Size.Y,ao.Size.Z)
au.vol=av
end
if as.pos then au.reach=note(au.reach,(ao.Position-as.pos).Magnitude)end
aj=aj+1
end

function ab.Start()
if ak then return end
ak=true
load()

eachMob(hook)
regConn(workspace.DescendantAdded:Connect(function(ao)pcall(linkPart,ao)end))

spawnLoop(function()
while not _apelStopped and ak do
task.wait(1)
pcall(function()eachMob(hook)end)
end
end)

spawnLoop(function()
local ao
while not _apelStopped and ak do
task.wait(0.05)
local ap=LocalPlayer.Character
local aq=ap and ap:FindFirstChildOfClass"Humanoid"
local ar=ap and ap:FindFirstChild"HumanoidRootPart"
if aq and ar then
local as=aq.Health
if ao and as<ao-1 then
local au,av=casterOf(ar.Position,60)
if au then
for aw=#am,1,-1 do
if am[aw].model==au then
local ax=slot(am[aw].mob,am[aw].id)
ax.dmg=note(ax.dmg,ao-as)
ax.hitFrom=note(ax.hitFrom,av or 0)
ax.toHit=note(ax.toHit,os.clock()-am[aw].at)
break
end
end
end
end
ao=as
end
end
end)

spawnLoop(function()
while not _apelStopped and ak do
task.wait(af)
if ai>0 then pcall(ab.Save)end
end
end)

aa.Log("РЕКОРДЕР АНИМАЦИЙ: включён, пишу в "..ae)
end

function ab.Stop()
if not ak then return end
ak=false
pcall(ab.Save)
aa.Log(("РЕКОРДЕР АНИМАЦИЙ: выключен, проигрышей %d, связей %d"):format(ai,aj))
end

function ab.Stats()
local ao,ap=0,0
for aq,ar in pairs(ah)do
ao=ao+1
for as in pairs(ar)do ap=ap+1 end
end
return ao,ap,ai,aj
end

return ab end function a.N():typeof(__modImpl())local aa=a.cache.N if not aa then aa={c=__modImpl()}a.cache.N=aa end return aa.c end end do local function __modImpl()



































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
if not ag then return"сигнал выключен"end
return("сигналов %d (куб %d, круг %d), опоздавших %d, фора %s / худшая %s")
:format(aj,ak,al,am,
an and("%.2fс"):format(an)or"-",
ao and("%.2fс"):format(ao)or"-")
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
av,"сигнал:круг",0,af,true)
return
end

local aw,ax=ap.cframe,ap.size
if typeof(aw)~="CFrame"or typeof(ax)~="Vector3"then return end
ak=ak+1
aa.Foresee(aw,ax,av,"сигнал:куб",0,af,false)
end

function ac.Start()
if ag then return true,"уже слушаем"end

local ap,aq=pcall(function()
local ap=ab:WaitForChild("Utility",5)
local aq=ap and ap:FindFirstChild"BridgeNet2"
if not aq then error"BridgeNet2 не найден"end
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
return true,"слушаем"
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
local ag=a.M()
local ah=a.N()
local ai=a.O()
local aj=a.l()

local ak=game:GetService"RunService"

local al=32
local am=1.2
local an=14















local ao=3





























local ap={king=
{{-33,-24,-17,8}},
}

local aq={
["Spider Queen"]=Vector3.new(-205,237,-868),
}















local ar=45

local as={







["Northern Warrior"]=20,
}

local au={
["Ice Elemental"]=true,




["Spider Queen"]=true,


["Captain Blackbeard"]=true,


["Beast Master"]=true,
}
















local av={25,35,50}

local aw=4









local ax=0.5



local ay=16
local az=3



















































local aA=0






























local aB=3














local aC=13





















local aD=3

local aE=4










local aF=6







local aG=1.5



local aH=60
local aI=12

local aJ=0.4









local aK=60


local aL=55
local aM=200



















math.rad(50)























local aN=8














local aO=0.35

local aP=0.2



























local aQ=2
local aR=1.5








local aS=5
local aT=10






local aU={8,5,3,0}
















local aV=1.6
local aW=2



















local aX=0.5

local aY=1.5

local aZ=4

local a_=6












local a0=25
local a1=5

local a2=4




local a3=0.5








local a4=0.66


































local function showDots()
LPH_ATTRIBUTES(VM(NONE))
if aj.enabled then return S.testDots==true end
return S.testWalk==true
end







local function showRoute()
LPH_ATTRIBUTES(VM(NONE))
if aj.enabled then return S.testDots==true end
return S.testWalk==true
end
local function showZones()
LPH_ATTRIBUTES(VM(NONE))return aj.enabled and S.testZones==true end

local a5=0
local a6=0
local a7=0

local a8=0






local a9,b={},0







local ba,bb,bc=0,0







local bd,be,bf={},{},{}
local bg=0
local bh="нет"
local function noteBranch(bi)
LPH_ATTRIBUTES(VM(NONE))
a9[bi]=(a9[bi]or 0)+1
if bi~="ВСЕГО кадров под ударом"then
bh=bi


ad.Note("ветка",bi)
end
end

local bi=0.2















local function Plan()
LPH_ATTRIBUTES(VM(NONE))
return S.testArena and af or ag
end












ag.SetFloorFilter(ad.FloorIgnore)






ag.SetDanger(function()
LPH_ATTRIBUTES(VM(NONE))
local bj=ab.HRP()
if not bj then return{}end
return ad.ZoneShapes(bj.Position,150,0)
end)

return function(bj)
LPH_ATTRIBUTES(VM(NONE))






spawnLoop(function()
local bk=false
while not _apelStopped do
if not bk then
local bl=tostring(aa.Name and aa.Name()or""):lower()
for bm,bn in pairs(ap)do
if bl~=""and bl:find(bm,1,true)then
ag.SetNoGo(bn)
bk=true
aj.Log(("ЗАПРЕТНОЕ МЕСТО: включено для карты %s, квадратов %d")
:format(bl,#bn))
break
end
end
end
task.wait(2)
end
end)
local bk=bj.Test

local bl,bm={}










local bn={}

local function mobPoints()
local bo={}
for bp,bq in ipairs(bn)do
if bq.Parent then
local br=aa.PivotOf(bq)
if br then bo[#bo+1]=Vector3.new(br.X,0,br.Z)end
end
end
return bo
end local bo=


































math.huge


































































































local function mobKeeps()
local bp={}
for bq,br in ipairs(bn)do
if br.Parent then
local bs=aa.PivotOf(br)
if bs then













bp[#bp+1]={
at=Vector3.new(bs.X,0,bs.Z),
keep=as[br.Name]or 0,
}
end
end
end
return bp
end






local function freshFolder(bp)
for bq,br in ipairs(workspace:GetChildren())do
if br.Name==bp then pcall(function()br:Destroy()end)end
end
local bq=Instance.new"Folder"
bq.Name=bp
bq.Parent=workspace
return bq
end

local bp

local bq=RaycastParams.new()
bq.FilterType=Enum.RaycastFilterType.Exclude
bq.IgnoreWater=true

local function floorAt(br,bs,bt)





if ae.Running()then
local bu=ae.Ground()
if bu then return bu end
end








if ag.Ready()then
local bu=ag.HeightAt(Vector3.new(br,0,bs))
if bu then return bu end
end


bq.FilterDescendantsInstances={LocalPlayer.Character,bm}
local bu=workspace:Raycast(Vector3.new(br,(bt or 0)+8,bs),
Vector3.new(0,-300,0),bq)
return bu and bu.Position.Y or nil
end



local function ensureDots()
if bm and bm.Parent then return end
bm=freshFolder"ApelTestDots"
bl={}
for br=1,al*(#av+1)do
local bs=Instance.new"Part"









bs.Name="ApelMark"
bs.Size=Vector3.new(am,am,am)
bs.Anchored,bs.CanCollide,bs.CanQuery,bs.CanTouch=true,false,false,false
bs.Material=Enum.Material.Neon
bs.Transparency=0.3
bs.Parent=bm
bl[br]=bs
end
end











local br,bs={}

local function clearRoute()
if bs then bs:Destroy()bs=nil end
br={}
end

local function drawRoute(bt,bu)
if not showRoute()or not bu or#bu==0 then
for c,d in ipairs(br)do d.Transparency=1 end
return
end
if not bs or not bs.Parent then
bs=freshFolder"ApelRouteView"
br={}
end

local c=0
local function put(d,e)
c=c+1
local f=br[c]
if not f or not f.Parent then
f=Instance.new"Part"
f.Name="ApelMark"
f.Anchored,f.CanCollide=true,false
f.CanQuery,f.CanTouch=false,false
f.Material=Enum.Material.Neon
f.Parent=bs
br[c]=f
end

f.Size=e and Vector3.new(1.6,1.6,1.6)or Vector3.new(0.7,0.7,0.7)
f.Color=e and Color3.fromRGB(255,150,40)
or Color3.fromRGB(255,220,120)
f.Transparency=0.3
f.Position=d
end

local d=bt
for e,f in ipairs(bu)do
local g=(f-d).Magnitude
if g>0.01 then
local h=math.floor(g/aw)
for i=1,h do
put(d:Lerp(f,(i*aw)/g),false)
end
end
put(f,true)
d=f
if c>200 then break end
end
for e=c+1,#br do br[e].Transparency=1 end
end

local function clearMarks()
if bm then bm:Destroy()bm=nil end
bl={}
clearRoute()
end







local bt={}



local bu={}






local function legClear(c,d)
local e=Vector3.new(d.X-c.X,0,d.Z-c.Z)
local f=math.min(e.Magnitude,a0)
if f<0.5 then return true end
local g=e.Unit
local h=a1
while h<=f do
local i=c+g*h
if not ad.IsSafe(Vector3.new(i.X,c.Y,i.Z),aA)then return false end
h=h+a1
end
return true
end















local function legOut(c,d)
local e=Vector3.new(d.X-c.X,0,d.Z-c.Z)
local f=math.min(e.Magnitude,a0)
if f<0.5 then return true end
local g=e.Unit











local h=ab.Humanoid()
local i=math.max((h and h.WalkSpeed)or ay,1)
local j,k=a1,false
while j<=f do
local l=c+g*j
local m=ad.PassAt(Vector3.new(l.X,c.Y,l.Z),aA,j/i)
if m then
k=true
elseif k then
return false
end
j=j+a1
end
return true
end











local function pathGap(c,d,e)
local f,g=c.X-e.X,c.Z-e.Z
local h,i=d.X-e.X,d.Z-e.Z
local j,k=h-f,i-g
local l=j*j+k*k
if l<1e-6 then return math.sqrt(f*f+g*g)end
local m=-(f*j+g*k)/l
if m<0 then m=0 elseif m>1 then m=1 end
local n,o=f+j*m,g+k*m
return math.sqrt(n*n+o*o)
end








local c,d,e={},0
local f,g,h,i,j=0,0,0,0,0
local k=0
local l=0
local m=0
local n=0
local o=0
local p,q,r=0,0,0






local s=0
local u,v={},0
local w=-99










local x,y,z=0

local function clearZones()
if e then e:Destroy()e=nil end
c={}
end







local function drawZones(A)
if not e or not e.Parent then
e=freshFolder"ApelZoneView"
c={}
end

local B=ad.ZoneShapes(A,90,aA)
for C,D in ipairs(B)do
local E=c[C]
if not E or not E.Parent then
E=Instance.new"Part"
E.Name="ApelMark"
E.Anchored,E.CanCollide=true,false
E.CanQuery,E.CanTouch=false,false
E.Material=Enum.Material.ForceField
E.Parent=e
c[C]=E
end
E.Shape=D.cylinder and Enum.PartType.Cylinder or Enum.PartType.Block
E.Size=D.size
E.CFrame=D.cf

E.Color=D.ghost and Color3.fromRGB(90,160,255)
or Color3.fromRGB(255,220,60)
E.Transparency=0.75
end
for C=#B+1,#c do
if c[C]then c[C].Transparency=1 end
end
end


















local A=6
local B=false












local function hopSpot(C,D,E)
local F,G=math.huge
local H=mobPoints()
mobKeeps()
local I=D and A or aC
local J=D and(B and 0 or aD)or aE
J=J+(E or 0)
for K=6,aN,2 do
for L=1,16 do
local M=(L/16)*math.pi*2
local N=C.X+math.cos(M)*K
local O=C.Z+math.sin(M)*K
local P=floorAt(N,O,C.Y)
if P then
local Q=Vector3.new(N,P+az,O)






local R=not ag.InNoGo(Q)
and ad.IsSafe(Q,J)and Plan().Clear(C,Q)
and(B or Plan().RoomAt(Q,aF))
if R then
for T,U in ipairs(H)do
if(Vector3.new(Q.X,0,Q.Z)-U).Magnitude<I then
R=false break
end
end
end
if R and K<F then G,F=Q,K end
end
end

if G then break end
end
return G
end




local function hopSpotDeep(C,D)

















for E,F in ipairs(aU)do
local G=hopSpot(C,D,F)
if G and ad.RoomSafe(G,2.5)then return G,F end
end
for E,F in ipairs(aU)do
local G=hopSpot(C,D,F)
if G then return G,F end
end
if not D then return nil end
B=true
local E=hopSpot(C,D,0)
B=false
return E,false
end




local function leastThreat(C)
local D=ad.ThreatAt(C,0)
if D<=0 then return nil end
local E,F=D
local G=mobPoints()
mobKeeps()
for H=6,aN,2 do
for I=1,16 do
local J=(I/16)*math.pi*2
local K=C.X+math.cos(J)*H
local L=C.Z+math.sin(J)*H
local M=floorAt(K,L,C.Y)
if M then
local N=Vector3.new(K,M+az,L)
if Plan().Clear(C,N)and not ag.InNoGo(N)then
local O=true
for P,Q in ipairs(G)do
if(Vector3.new(N.X,0,N.Z)-Q).Magnitude<A then
O=false break
end
end


if O then
local P=ad.ThreatAt(N,0)
if P<E-1 then F,E=N,P end
end
end
end
end
end
return F
end



local function groundNow()
if ae.Running()then
local C=ae.Ground()
if C then return C end
end
local C=ab.HRP()
if not C then return nil end
return floorAt(C.Position.X,C.Position.Z,C.Position.Y)
end










local function pickSpot(C,D,E,F)
local G=ab.HRP()and ab.HRP().Position
if not G then return nil end
if showDots()then ensureDots()end












local H=not ad.IsSafe(G,0)
local I=H and 200 or 8















local J,K,L=-1,math.huge
table.clear(bu)
local M,N=math.huge

table.clear(bt)
bt.total,bt.unsafe,bt.blocked=0,0,0
bt.tight,bt.close,bt.crossed,bt.nofloor=0,0,0,0
bt.legcut=0









local O=mobPoints()
local P=mobKeeps()
local Q=math.huge
for R,T in ipairs(O)do
local U=(Vector3.new(G.X,0,G.Z)-T).Magnitude
if U<Q then Q=U end
end
if Q==math.huge then
Q=(Vector3.new(G.X,0,G.Z)-Vector3.new(C.X,0,C.Z)).Magnitude
end
local R=math.min(aC,Q)










local T={E}
if F then
for U,V in ipairs(av)do
if math.abs(V-E)>1 then T[#T+1]=V end
end
end

for U=1,#T do
local V=T[U]
for W=1,al do
local X=(U-1)*al+W
local Y=(W/al)*math.pi*2
local Z=C.X+math.cos(Y)*V
local _=C.Z+math.sin(Y)*V
local bv=floorAt(Z,_,C.Y)

local bw=bv and Vector3.new(Z,bv+az,_)or nil

if bw and ag.InNoGo(bw)then bw=nil end
bt.total=bt.total+1
if not bw then bt.nofloor=bt.nofloor+1 end
local bx=bw~=nil and ad.IsSafe(bw,aA)
if bw and not bx then bt.unsafe=bt.unsafe+1 end








local by=bx and Plan().Clear(G,bw)



local bz=bw~=nil
if bw then
local bA=Vector3.new(bw.X,0,bw.Z)
for bB,bC in ipairs(P)do



local bD=bC.keep or 0
if bD>0 and(bA-bC.at).Magnitude<bD then
bz=false break
end
end
end
local bA=bx and by

if showDots()and bl[X]then
local bB=bl[X]
if bw then
bB.Position=bw
bB.Transparency=0.3


if bA then
bB.Color=Color3.fromRGB(60,235,110)
elseif bx then
bB.Color=Color3.fromRGB(80,140,255)
else
bB.Color=Color3.fromRGB(255,70,70)
end
else


bB.Transparency=1
end
end

if bw and bx and not by then
bt.blocked=bt.blocked+1
end

if bA then











local bB=0


local bC=false
for bD,bE in ipairs(O)do
if pathGap(G,bw,bE)<R then bC=true break end
end
if bC then
bB=bB-5000
bt.crossed=bt.crossed+1
end
if ad.IsSafe(bw,aE)then bB=bB+1000
elseif ad.IsSafe(bw,aD)then


bB=bB+400
bt.tight=bt.tight+1
else bt.tight=bt.tight+1 end
if bz then bB=bB+500
else bt.close=bt.close+1 end






















local bD=0
local bE=Vector3.new(bw.X,0,bw.Z)
for bF,bG in ipairs(O)do
if(bE-bG).Magnitude<=aL then
bD=bD+1
end
end
if bD>1 then
bB=bB-math.min(bD-1,4)*aM
end


















if legClear(G,bw)then bB=bB+600
else
bB=bB-5000
bt.legcut=(bt.legcut or 0)+1
end





if Plan().RoomAt(bw,aF)then bB=bB+1200
else bB=bB-800 end



























local bF=(bw-G).Magnitude
bB=bB-bF*I



bu[#bu+1]={score=bB,far=bF}

local bG=bB>J
or(bB==J and bF<K)
if L==nil or bG then
L,J,K=bw,bB,bF
bt.crowd=bD
end
elseif bx then






local bB=(bw-G).Magnitude
if bB<M then N,M=bw,bB end
end
end
end
bt.best=J
bt.picked=L and"точка"or(N and"за стеной"or"НИЧЕГО")
bt.at=L or N
return L or N
end

local function walkSet(bv)
S.testWalk=bv
if bv then


S.autoFarm=false
S.speedOn=false








local bw,bx=ai.Start()
if not bw then
warn("Apel Hub: сигнал атак не подключился — "..tostring(bx))
end







Plan().Rebuild(groundNow())
else
ai.Stop()
bp=nil
clearMarks()
local bw=ab.Humanoid()


if bw then bw.AutoRotate=true end
end
end
S.walkSet=walkSet

bk:Toggle{
Name="Walk Farm",
Desc="runs to the nearest mob on foot along a path; turn the normal Auto Farm off first",
Default=false,Flag="TestWalk",
Callback=walkSet,
}






bk:Toggle{
Name="Rebuild Map",
Desc="Desert Temple only: strips the map to a flat floor and plain white walls",
Default=false,Flag="TestArena",
Callback=function(bv)
S.testArena=bv
if not bv then ae.Stop()end
end,
}






bk:Toggle{
Name="Animation Recorder",
Desc="records enemy animations: period, lead time, reach and damage -> ApelHub/anim_table.txt",
Default=false,Flag="TestAnimRec",
Callback=function(bv)
S.animRec=bv
if bv then ah.Start()else ah.Stop()end
end,
}

local function hopSet(bv)
S.testHop=bv
end
S.hopSet=hopSet

bk:Toggle{
Name="Emergency Hop",
Desc="when walking cannot leave an attack in time, blinks up to 10 studs to a clear spot",
Default=false,Flag="TestHop",
Callback=hopSet,
}

bk:Toggle{
Name="Show Danger",
Desc="draws attack zones exactly as the dodge model sees them, margins included",
Default=false,Flag="TestZones",
Callback=function(bv)
S.testZones=bv
if not bv then clearZones()end
end,
}

bk:Toggle{
Name="Show Points",
Desc="green is a spot it can stand on, red is covered by an attack; orange is the route",




Default=false,Flag="TestDots",
Callback=function(bv)
S.testDots=bv
if not bv then clearMarks()end
end,
}

local bv=bk:Label"Idle"










local bw=bk:Label"Signal: off"
local bx=0



local by
spawnLoop(function()
while not _apelStopped do
task.wait(1)






if S.testWalk and not S.testArena then
ag.Refresh()
end

if S.testArena then






if ae.Running()then af.Refresh(ae.Ground())end










local bz=tostring(aa.Name())
local bA=workspace:FindFirstChild"dungeon"
if bz:lower():find("desert temple",1,true)
and bA and by~=bA
then






ae.Stop()
local bB,bC=ae.Build()







if bB then
by=bA

af.Rebuild(ae.Ground())
end
if bv then
bv:Set(bB
and("Map rebuilt on "..bz..", "..tostring(bC).." parts")
or("Rebuild waiting: "..tostring(bC)))
end
end
end
end
end)

local bz,bA
local bB=false
local bC,bD=0,0
local bE=false

local bF

local bG=0












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
if bz and bz.Parent then
local U=aa.PivotOf(bz)
if U then
T=(Vector3.new(U.X,0,U.Z)
-Vector3.new(Q.Position.X,0,Q.Position.Z)).Magnitude
end
end
local U=("ПРОПУСК: удар -%.0f hp | модель: %s | до моба %.1f | внутри %d, мимо %d")
:format(P-O,R and"НАКРЫТ"or"чисто",T,M,L)
aj.Log(U)



local V=ad.NearestZones(Q.Position,3)
if type(V)=="table"then
for W,X in ipairs(V)do
local Y=type(X)=="table"and(X.text or tostring(X.gap))or tostring(X)
aj.Log("   "..tostring(Y))
end
end
end))
end local

N, O=0






local function tryHop(P,Q,R)


s=s*0.98+(Q and 0.02 or 0)
if Q then
if p==0 then
p=P



if aj.enabled and q>0 then
aj.Log(("ПРЫЖОК ДЕРЖАЛСЯ %.2fс чистым"):format(P-q))
end
end
else

if p>0 and aj.enabled and q<p
and(P-p)<aX then
aj.Log(("УШЁЛ НОГАМИ за %.2fс — прыжок не понадобился"):format(P-p))
end
p=0
end

















local T,U=math.huge
for V,W in ipairs(bn)do
local X=as[W.Name]
if X and W.Parent then
local Y=aa.PivotOf(W)
if Y then
local Z=(Vector3.new(Y.X,0,Y.Z)
-Vector3.new(R.Position.X,0,R.Position.Z)).Magnitude
if Z<X and Z<T then U,T=Y,Z end
end
end
end

local V=S.testHop and Q and p>0
and(P-q)>aO
and P>=v


local W=false
if not V and U and S.testHop and not Q
and(P-q)>aV and P>=v then
local X=0
for Y,Z in ipairs(u)do
if P-Z<=aT then X=X+1 end
end
if X<=(aS-aW)then
V,W=true,true
end
end




if V then
while u[1]and(P-u[1])>aT do
table.remove(u,1)
end
local X=0
for Y,Z in ipairs(u)do
if P-Z<=aR then X=X+1 end
end

local Y
if X>=aQ then
Y=("%d за %.1f с — третий сервер откатывает"):format(X,aR)
elseif#u>=aS then
Y=("%d за %.0f с — предел скачки"):format(#u,aT)
end
if Y then
V=false
if aj.enabled and(P-k)>2 then
k=P
aj.Log("ПРЫЖОК ПРИДЕРЖАН: "..Y)
end
end
end
if not V then return end

local X,Y=hopSpotDeep(R.Position,true)












if U then
local Z=Vector3.new(U.X,0,U.Z)
local _,bH=T
for bI=aN,6,-2 do
for bJ=1,16 do
local bK=(bJ/16)*math.pi*2
local bL=R.Position.X+math.cos(bK)*bI
local bM=R.Position.Z+math.sin(bK)*bI
local bN=floorAt(bL,bM,R.Position.Y)
if bN then
local bO=Vector3.new(bL,bN+az,bM)
local bP=(Vector3.new(bL,0,bM)-Z).Magnitude
if bP>_ and ad.IsSafe(bO,aD)
and not ag.InNoGo(bO)and Plan().Clear(R.Position,bO)then
bH,_=bO,bP
end
end
end
end
if bH then
X,Y=bH,0
if aj.enabled and(P-o)>2 then
o=P
aj.Log(("ОТСКОК ОТ ПРЕСЛЕДОВАТЕЛЯ: был в %.1f, ухожу на %.1f")
:format(T,_))
end
elseif W then

return
end
end

















local bH
if not X and(P-w)>aZ then
X=leastThreat(R.Position)
if X then bH,w=true,P end
end
if not X then
if aj.enabled then
aj.Log"ПРЫЖОК НЕ ВЫШЕЛ: некуда — ни чистой точки, ни места полегче в 10 студах"
end
return
end



local bI=(Vector3.new(X.X,0,X.Z)
-Vector3.new(R.Position.X,0,R.Position.Z)).Magnitude
local bJ=P-p


local bK=R.Position
R.CFrame=CFrame.new(X)*(R.CFrame-R.CFrame.Position)
R.AssemblyLinearVelocity=Vector3.zero
R.AssemblyAngularVelocity=Vector3.zero
q,p=P,0
u[#u+1]=P
if ad.NoteHop then ad.NoteHop()end
y,x,z=X,P,ad.ZoneAt(bK,0)



if aj.enabled then
local bL=X
task.delay(aP,function()
local bM=ab.HRP()
if not bM then return end
local bN=(Vector3.new(bM.Position.X,0,bM.Position.Z)
-Vector3.new(bK.X,0,bK.Z)).Magnitude
local bO=(Vector3.new(bM.Position.X,0,bM.Position.Z)
-Vector3.new(bL.X,0,bL.Z)).Magnitude
if bN<3 and bO>4 then

v=os.clock()+aY
aj.Log(("ПРЫЖОК ОТКАЧЕН: сервер вернул на старт, прыжок был %.1f студа — придержу %.1f с")
:format(bI,aY))
end
end)
end
r=r+1
if aj.enabled then
aj.Log(("ПРЫЖОК %d%s%s: на %.1f студа, был внутри %.2fс")
:format(r,(Y and Y>0)and(" (запас %d)"):format(Y)or"",
bH and" (в место полегче)"or"",bI,bJ))
end
end

regConn(ak.Heartbeat:Connect(function()
if _apelStopped or not S.testWalk then return end

local bH,bI=ab.HRP(),ab.Humanoid()
if not bH or not bI or not ab.Alive()then return end
watchDamage(bI)





























if bI.AutoRotate then bI.AutoRotate=false end











local bJ=os.clock()





if showRoute()and bp and(bJ-f)>0.2 then
f=bJ
drawRoute(bH.Position,(Plan().Path(bH.Position,bp)))
end

if showZones()and(bJ-d)>0.1 then
d=bJ
drawZones(bH.Position)
end

if bw and(bJ-bx)>0.5 then
bx=bJ








if ad.Enabled()then
bw:Set("Signal: "..ai.Stats())
else
bw:Set("Signal: "..ai.Stats()
.." | DODGE OFF — turn on Auto Dodge, nothing is dodged")
end
end











if not bz or not bz.Parent or(bJ-bC)>bi then
bC=bJ
bz=aa.Nearest(bH.Position)













if not S.testArena and ag.Ready()then






































local bK=60
local bL=25
local bM,bN,bO=math.huge,math.huge
local bP=0
local P,Q=math.huge
local R=aa.AllAlive()



local T={}
for U,V in ipairs(R)do
local W=aa.PivotOf(V)
T[U]=W and Vector3.new(W.X,0,W.Z)or nil
end
for U,V in ipairs(R)do
local W=aa.PivotOf(V)
if W and T[U]and ag.Reachable(W,3)then
local X=(W-bH.Position).Magnitude
local Y=0
for Z=1,#R do
if Z~=U and T[Z]
and(T[Z]-T[U]).Magnitude<=bK then
Y=Y+1
end
end
local Z=X+Y*bL
if Z<bN then
bO,bM,bN=V,X,Z
bP=Y
end
if as[V.Name]and X<=ar and X<P then
Q,P=V,X
end
end
end
if Q then bO,bM,bP=Q,P,-1 end














local U,V=math.huge
for W,X in ipairs(R)do
if X.Name=="Northern Warrior"and T[W]then
local Y=aa.PivotOf(X)
if Y and ag.Reachable(Y,3)then
local Z=(Y-bH.Position).Magnitude
if Z<U then V,U=X,Z end
end
end
end
if V then bO,bM,bP=V,U,-1 end
if aj.enabled and bO and(bJ-a5)>2 then
a5=bJ
aj.Log(("ЦЕЛЬ ПО ОДИНОЧЕСТВУ: %s в %.0f студах, соседей в 60 студах %s")
:format(bO.Name,bM,
bP<0 and"- (взят преследователь)"or tostring(bP)))
end
if bO then
bz=bO
bB=false
else




bB=true
end
end






bn={}
local bK=Vector3.new(bH.Position.X,0,bH.Position.Z)
for bL,bM in ipairs(aa.AllAlive())do
local bN=aa.PivotOf(bM)
if bN and(Vector3.new(bN.X,0,bN.Z)-bK).Magnitude<=aK then
bn[#bn+1]=bM
end
end
end
if not bz then







local bK=os.clock()
local bL=not ad.IsSafe(bH.Position,aA)
or not ad.BoxSafe(bH.Position)
if bL then









local bM=ad.EscapeStep(bH.Position,aA,aB)





if bM and not ad.BoxSafe(bM)then bM=nil end
if not bM then
for bN,bO in ipairs{6,10,14}do
for bP=0,15 do
local P=bP*math.pi/8
local Q=Vector3.new(
bH.Position.X+math.cos(P)*bO,
bH.Position.Y,
bH.Position.Z+math.sin(P)*bO)
if ad.BoxSafe(Q)and ad.IsSafe(Q,0)then
bM=Q
break
end
end
if bM then break end
end
if bM and aj.enabled and(bK-a6)>1 then
a6=bK
aj.Log"ПОСЛЕДНИЙ РУБЕЖ (без цели): выхода не было, ухожу перебором"
end
end
if bM then bI:MoveTo(bM)end
if bv then bv:Set"No mob nearby — stepping out of an attack"end
else
if bv then bv:Set"No mob nearby"end
end
tryHop(bK,bL,bH)
bp=nil
clearMarks()
return
end

local bK=aa.PivotOf(bz)
if not bK then return end



local bL=aq[bz.Name]
if bL and not ag.HeightAt(bL)then bL=nil end
if bL and(bJ-i)>5 and aj.enabled then
i=bJ
aj.Log(("ПОЗИЦИЯ: иду на боевую точку босса %s, до неё %.0f студов")
:format(bz.Name,(bL-bH.Position).Magnitude))
end



local bM=Vector3.new(bK.X,bH.Position.Y,bK.Z)
if(bM-bH.Position).Magnitude>0.1 then
bH.CFrame=CFrame.new(bH.Position,bM)
end






















local bN=not ad.IsSafe(bH.Position,aA)
or not ad.BoxSafe(bH.Position)













local bO=ad.IsSafe(bH.Position,aE)



if bN then
if p==0 then p=bJ end
else
p=0
end

















if not bL then tryHop(bJ,bN,bH)end










local bP=(Vector3.new(bK.X,0,bK.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude







local P=mobPoints()
local Q=bP
do
local R=Vector3.new(bH.Position.X,0,bH.Position.Z)
for T,U in ipairs(P)do
local V=(U-R).Magnitude
if V<Q then Q=V end
end
end








local R=0
if O then
local T=bJ-N
if T>0.01 then R=(O-Q)/T end
end
if not O or(bJ-N)>0.05 then
O,N=Q,bJ
end


local T=math.huge
if R>0.5 then T=(Q-an)/R end












local U=an+ao+10



local V,W=true
for X,Y in ipairs(aa.AllAlive())do
local Z=aa.PivotOf(Y)
if Z then
local _=(Vector3.new(Z.X,0,Z.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude
if _<=Q+1 then
W=W or Y.Name
if not au[Y.Name]then V=false break end
end
end
end




















local X=an
for Y,Z in ipairs(aa.AllAlive())do
local _=as[Z.Name]
if _ and _>X then
local bQ=aa.PivotOf(Z)
if bQ then
local bR=(Vector3.new(bQ.X,0,bQ.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude
if bR<_ then X=_ end
end
end
end
if W and(as[W]or 0)>X then
X=as[W]
end
local bQ=X+ao



















if bE then
if Q>=bQ or V then bE=false end
elseif not V
and(Q<X or(T<ax and Q<U))then
bE=true
end









local bR=bE and bQ or an
local Y=bz and ad.HazardRadius and ad.HazardRadius(bz)
if Y and Y+aD>bR then
bR=Y+aD
end
local Z=bz and as[bz.Name]
if Z and Z>bR then bR=Z end








if bN then noteBranch"ВСЕГО кадров под ударом"end


bg=bg%128+1
bd[bg],be[bg],bf[bg]=bH.Position,bJ,bN
local _,bS,bT=false
for bU=1,128 do
local bV=be[bU]
if bV and(bJ-bV)<=0.5 then
if not bT or bV<bT then bS,bT=bd[bU],bV end
if bf[bU]then _=true end
end
end
local bU=false
if bS and bT and(bJ-bT)>0.4 and _ then
local bV=(Vector3.new(bH.Position.X,0,bH.Position.Z)
-Vector3.new(bS.X,0,bS.Z)).Magnitude
bU=bV<2
if bU and aj.enabled and(bJ-bb)>1 then
bb=bJ
aj.Log(("ЗАСТОЙ ПОД УДАРОМ: за %.2fс сдвинулся %.1f студа — прыгаю")
:format(bJ-bT,bV))
end
end


if bN then
if ba==0 then
ba,bc=bJ,bH.Position
elseif(bJ-ba)>0.4 and bc then
local bV=(Vector3.new(bH.Position.X,0,bH.Position.Z)
-Vector3.new(bc.X,0,bc.Z)).Magnitude
if bV<1.5 and aj.enabled and(bJ-bb)>1 then
bb=bJ
local bW=bp and(Vector3.new(bp.X,0,bp.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude or-1
aj.Log(("СТОЮ В УДАРЕ %.2fс: сдвинулся %.1f | ветка %s | цель в %.1f | зон %s | escaped=%s укрытие=%s стойка=%s")
:format(bJ-ba,bV,bh,bW,
tostring(ad.Count and ad.Count()or"?"),
tostring(escaped),tostring(E~=nil),tostring(y~=nil)))
end
end
else
ba,bc=0,nil
end
if aj.enabled and(bJ-b)>30 then
b=bJ
local bV={}
for bW,bX in pairs(a9)do bV[#bV+1]=("%s=%d"):format(bW,bX)end
table.sort(bV)
if#bV>0 then
aj.Log("ВЕТКИ ПОД УДАРОМ: "..table.concat(bV," | "))
end
a9={}
end

if(bN or not bO)and aj.enabled and(bJ-g)>1 then
g=bJ
aj.Log(("МОЗГ: накрыт=%s просторно=%s отход=%s до цели %.1f до ближайшего %.1f мобов рядом %d зон %s")
:format(tostring(bN),tostring(bO),tostring(bE),
bP,Q,#bn,
tostring(select(1,ad.Count and ad.Count()or"?"))))


table.sort(bu,function(bV,bW)return bV.score>bW.score end)
local bV={}
for bW=1,math.min(5,#bu)do
bV[#bV+1]=("%d@%.0f"):format(bu[bW].score,bu[bW].far)
end
if#bV>0 then
aj.Log("КАНДИДАТЫ (очки@студы): "..table.concat(bV,"  "))
end

aj.Log(("ВЫБОР: всего %s | опасных %s, за стеной %s, тесных %s, близко к мобу %s, путь режет %s, дорога в удар %s, без пола %s | ТОЛПА У ТОЧКИ %s | взято %s со счётом %s")
:format(tostring(bt.total),tostring(bt.unsafe),
tostring(bt.blocked),tostring(bt.tight),
tostring(bt.close),tostring(bt.crossed),
tostring(bt.legcut),
tostring(bt.nofloor),tostring(bt.crowd),
tostring(bt.picked),
tostring(bt.best)))
end












if not S.testArena then

if E then






local bV
if typeof(F)=="Instance"then
bV=not F.Parent or not ad.IsZone(F)
else

bV=not bN
end







local bW=false
if typeof(F)=="Instance"then
local bX=F.Parent
local bY=tostring(bX and bX.Name or F.Name):lower()
bW=ad.NamedZoneAt(E,0,bY)and true or false
end
















if bV or bN or(bJ-D)>aI or bW then
if aj.enabled then
aj.Log(("УКРЫТИЕ снято: %s"):format(
bV and"атака больше не опасна"
or(bN and"саму щель накрыло — стоять нельзя"
or((bJ-D)>aI and"вышло время"
or"саму щель накрыло атакой"))))
end
E,F=nil,nil
end
end
















local bV=an+ao
local bW=Vector3.new(bK.X,0,bK.Z)
local bX=E
and(Vector3.new(E.X,0,E.Z)-bW).Magnitude>bV

if bN and(not E or bX)
and(not bp or not ad.IsSafe(bp,0))
and(bJ-G)>aJ then
G=bJ












local function pick(bY,bZ,b_)
return ag.NearestWhere(bH.Position,aH,function(b0)
if not ad.IsSafe(b0,bY)then return false end
if bZ and not ag.RoomAt(b0,aF)then return false end
if b_ and(Vector3.new(b0.X,0,b0.Z)-bW).Magnitude>bV then
return false
end
return true
end)
end

local bY=pick(aD,true,true)
or pick(aE,true,false)
or pick(aD,false,false)
or pick(0,false,false)


local bZ=bY

if bZ and ag.Path(bH.Position,bZ)then
local b_=E
E,D=bZ,bJ
F=ad.ZoneAt(bH.Position,0)or F
if aj.enabled then
aj.Log(("УКРЫТИЕ%s: щель в %.0f студах, до моба %.0f — %s | прячусь от %s")
:format(b_ and" (перевыбор)"or"",
(bZ-bH.Position).Magnitude,
(Vector3.new(bZ.X,0,bZ.Z)-bW).Magnitude,
bY and"БЬЮ ОТТУДА"or"не достаю",
typeof(F)=="Instance"
and F:GetFullName()or"неизвестно"))
end
elseif bZ and aj.enabled then
aj.Log(("УКРЫТИЕ: щель в %.0f студах есть, но маршрута к ней нет")
:format((bZ-bH.Position).Magnitude))
end
end
end

local bV=false
if not bN then bF=nil end



if bL then
bp,H,bD,bA=bL,bJ,bJ,bK
bV=true
if bN then noteBranch"выход-post"end
bF,E,F=nil,nil,nil
elseif E then


bp,H,bD,bA=E,D,bJ,bK
bV=true
if bN then noteBranch"укрытие"end
end













if bN and bF then
local bW=(Vector3.new(bF.X,0,bF.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude<=a2
local bX=(bJ-bG)>C
if bW or not Plan().Clear(bH.Position,bF)
or not legOut(bH.Position,bF)
or(bX and not ad.IsSafe(bF,aA))then
bF=nil
else
bp,bD,bA=bF,bJ,bK
bV=true
noteBranch"побег-fleeTo"
end
end

if bN and not bV then





local bW=ad.EscapeStep(bH.Position,aA,aB)
local bX=false
















if s>a4 then
local bY,bZ=Vector3.zero,0
for b_,b0 in ipairs(ad.ZoneShapes(bH.Position,60,0)or{})do
local b1=b0.cf and b0.cf.Position
if b1 then
bY,bZ=bY+Vector3.new(b1.X,0,b1.Z),bZ+1
end
end
if bZ>0 then
local b_=bY/bZ
local b0=Vector3.new(bH.Position.X,0,bH.Position.Z)
local b1,b2=(b0-b_).Magnitude
for b3=aN,6,-2 do
for b4=1,16 do
local b5=(b4/16)*math.pi*2
local b6=bH.Position.X+math.cos(b5)*b3
local b7=bH.Position.Z+math.sin(b5)*b3
local b8=(Vector3.new(b6,0,b7)-b_).Magnitude
if b8>b1 then
local b9=floorAt(b6,b7,bH.Position.Y)
if b9 then
local ca=Vector3.new(b6,b9+az,b7)
if not ag.InNoGo(ca)and Plan().Clear(bH.Position,ca)
and ad.IsSafe(ca,0)then
b2,b1=ca,b8
end
end
end
end
end
if b2 then
bW,bX=b2,true
if aj.enabled and(bJ-n)>2 then
n=bJ
aj.Log(("ЗАПЕРТ (%.0f%% кадров под ударом): ухожу от середины опасности, стало %.0f студов")
:format(s*100,b1))
end
end
end
end



























if bW then













local bY=Vector3.new(bW.X-bH.Position.X,0,bW.Z-bH.Position.Z)
if bY.Magnitude>0.1 and not ad.IsSafe(bW,aE)then
for bZ,b_ in ipairs{4,8,12}do
local b0=bW+bY.Unit*b_
local b1=floorAt(b0.X,b0.Z,bW.Y)
if b1 then
local b2=Vector3.new(b0.X,b1+az,b0.Z)
if ad.IsSafe(b2,aE)and not ag.InNoGo(b2)
and Plan().Clear(bH.Position,b2)then
bW=b2
break
end
end
end
end

local bZ
for b_,b0 in ipairs{aE,2,0}do
if ad.IsSafe(bW,b0)then bZ=b0 break end
end

























if not bX and(not bZ or bZ<aE)
and(bJ-m)>0.3 then
m=bJ




local b_,b0,b1=math.huge
for b2,b3 in ipairs{aE,2}do
for b4=6,aN,2 do
for b5=1,16 do
local b6=(b5/16)*math.pi*2
local b7=bH.Position.X+math.cos(b6)*b4
local b8=bH.Position.Z+math.sin(b6)*b4
local b9=floorAt(b7,b8,bH.Position.Y)
if b9 then
local ca=Vector3.new(b7,b9+az,b8)
if b4<b_ and ad.IsSafe(ca,b3)
and not ag.InNoGo(ca)
and Plan().Clear(bH.Position,ca)then
b0,b_,b1=ca,b4,b3
end
end
end
if b0 then break end
end
if b0 then break end
end
if b0 then
bW,bZ=b0,b1
if aj.enabled and(bJ-l)>1 then
l=bJ
aj.Log(("ВЫХОД С ЗАПАСОМ %d: место в %.0f студах")
:format(b1,b_))
end
end
end

if not bZ then bW=nil end
if bW and aj.enabled and bZ<aE and(bJ-l)>1 then
l=bJ
aj.Log(("ВЫХОД ТЕСНЫЙ: запас %d вместо %d — но внутри удара хуже")
:format(bZ,aE))
end
end







if not bW then
local bY=ad.ZoneAt(bH.Position,0)




local bZ=(typeof(bY)=="Instance"and bY:IsA"BasePart")and bY or nil
local b_
if bZ then b_=bZ.Position
elseif typeof(bY)=="table"and bY.cf then b_=bY.cf.Position
elseif typeof(bY)=="Instance"and bY:IsA"Model"then
local b0,b1=pcall(function()return bY:GetPivot().Position end)
b_=b0 and b1 or nil
end
if b_ then












local b0=bZ and bZ.Size or(typeof(bY)=="table"and bY.size or nil)
local b1=bZ and bZ.CFrame or(typeof(bY)=="table"and bY.cf or nil)
local b2,b3
local b4=Vector3.new(bH.Position.X-b_.X,0,bH.Position.Z-b_.Z)
local b5=b0 and math.abs(b0.Z-b0.Y)<1 and b0.X<=8
if b0 and b1 and not b5 then
local b6=b1:PointToObjectSpace(bH.Position)
local b7,b8=b0.X*0.5,b0.Z*0.5

if(b7-math.abs(b6.X))<=(b8-math.abs(b6.Z))then
b2=b1.RightVector*(b6.X>=0 and 1 or-1)
b3=b7
else
b2=b1.LookVector*(b6.Z>=0 and 1 or-1)
b3=b8
end
b2=Vector3.new(b2.X,0,b2.Z)
end
if not b2 or b2.Magnitude<0.1 then
b2=b4
b3=b0 and math.max(b0.X,b0.Z)*0.5 or 17
end
if b2.Magnitude<0.5 then
b2=Vector3.new(bH.CFrame.LookVector.X,0,bH.CFrame.LookVector.Z)
end
if b2.Magnitude>0.1 then
local b6=Vector3.new(b_.X,0,b_.Z)+b2.Unit*((b3 or 17)+6)
local b7=floorAt(b6.X,b6.Z,bH.Position.Y)
if b7 then
local b8=Vector3.new(b6.X,b7+az,b6.Z)
if not ag.InNoGo(b8)and Plan().Clear(bH.Position,b8)then
bW=b8
if aj.enabled and(bJ-l)>1 then
l=bJ
aj.Log(("ОТХОД ЧЕРЕЗ ГРАНЬ: %s, до грани %.0f, идём на %.0f")
:format(typeof(bY)=="Instance"and bY.Name or"зона",b3 or 17,
(Vector3.new(b8.X,0,b8.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude))
end
end
end
end
end
end









if bW then
local bY=Vector3.new(bW.X,0,bW.Z)
local bZ=Vector3.new(bK.X,0,bK.Z)
if(bY-bZ).Magnitude<aC then
local b_=bY-bZ
if b_.Magnitude<0.1 then
b_=Vector3.new(bH.Position.X-bK.X,0,bH.Position.Z-bK.Z)
end
if b_.Magnitude>0.1 then
local b0=bZ+b_.Unit*aC
local b1=Vector3.new(b0.X,bW.Y,b0.Z)
if ad.IsSafe(b1,aA)and Plan().Clear(bH.Position,b1)then
bW=b1
end
end
end
end


















if bW and ad.BoxSafe(bW)and not ad.RoomSafe(bW,2.5)then
local bY
for bZ,b_ in ipairs{3,2,1}do
local b0=ad.EscapeStep(bH.Position,aA,aB+b_)
if b0 and ad.BoxSafe(b0)and ad.RoomSafe(b0,b_)then
bY=b0
break
end
end
if bY then
bW=bY
if aj.enabled and(bJ-a8)>2 then
a8=bJ
aj.Log"ПОБЕГ С ЗАПАСОМ: кромку заменил на место с просветом"
end
end
end
if bW and Plan().Clear(bH.Position,bW)and legOut(bH.Position,bW)
and ad.BoxSafe(bW)then
bp,bD,bA=bW,bJ,bK
bF,bG,bV=bW,bJ,true
elseif bW and aj.enabled and(bJ-a8)>1 then
a8=bJ
aj.Log"ПОБЕГ ОТКЛОНЁН: дорога к выходу идёт сквозь другую атаку"
end
end


















local bW=false
if bp and not bV then
local bX=(Vector3.new(bp.X,0,bp.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude<=a2







local bY=false
for bZ,b_ in ipairs(P)do
if(Vector3.new(bp.X,0,bp.Z)-b_).Magnitude<aC then
bY=true break
end
end
























local bZ=(bJ-H)<a3
bW=not bX
and not bY
and Plan().Clear(bH.Position,bp)
and(bJ-H)<aG
and legClear(bH.Position,bp)
and(bZ or ad.IsSafe(bp,aA))


and not bN
end



if y then









local bX
if typeof(z)=="Instance"then
bX=not z.Parent or not ad.IsZone(z)
else
bX=not bN
end















if bN or not ad.IsSafe(y,aA)or(bJ-x)>a_ then
y,z=nil,nil
elseif bX then
y,z=nil,nil
else
bp,H,bV=y,x,true
if bN then noteBranch"стойка"end
if aj.enabled and(bJ-j)>2 then
j=bJ
aj.Log(("СТОЮ ПОСЛЕ ПРЫЖКА: вокруг чистого нет, держу точку %.0f,%.0f (%.1f с)")
:format(y.X,y.Z,bJ-x))
end
end
end



















if not bV and not bW then
bD,bA=bJ,bK


local bX=pickSpot(bK,bN or not bO,bR,bN or bE or not bO)




















if bX and ad.BoxSafe(bX)and not ad.RoomSafe(bX,2.5)then
local bY=pickSpot(bK,true,bR,true)
if bY and ad.RoomSafe(bY,2.5)then bX=bY end
end
if bX and not ad.BoxSafe(bX)then
if aj.enabled and(bJ-a6)>1 then
a6=bJ
aj.Log"ТОЧКА ОТВЕРГНУТА ОБЪЁМОМ: круг считал её чистой, тело задевает атаку"
end
bX=nil
end
if bX then
bp,H=bX,bJ
if bN then noteBranch"кольцо"end
elseif bN then
bp=nil
if aj.enabled and(bJ-a6)>1 then
a6=bJ
aj.Log"КОЛЬЦО ПУСТО ПОД УДАРОМ: сбрасываю цель, пусть решает уход"
end
end
end





local bX=getgenv().ApelHub
if bX then
bX.TestBrain={
hurt=bN,roomy=bO,backing=bE,
mobDist=bP,mob=bz and bz.Name or nil,
here=bH.Position,goal=bp,ring=bR,
escaped=bV,fleeTo=bF,
pick={
total=bt.total,unsafe=bt.unsafe,
blocked=bt.blocked,tight=bt.tight,
close=bt.close,crossed=bt.crossed,
best=bt.best,picked=bt.picked,
at=bt.at,
},
}
end





















































if math.abs(bK.Y-bH.Position.Y)>20 then bp=bK end

if not bp and bN then
local bY
for bZ,b_ in ipairs{true,false}do
for b0,b1 in ipairs{6,10,14}do
for b2=0,15 do
local b3=b2*math.pi/8
local b4=Vector3.new(
bH.Position.X+math.cos(b3)*b1,
bH.Position.Y,
bH.Position.Z+math.sin(b3)*b1)
if ad.BoxSafe(b4)and ad.IsSafe(b4,0)
and(not b_ or Plan().Clear(bH.Position,b4))then
bY=b4
break
end
end
if bY then break end
end
if bY then break end
end
if bY then
bp=bY
if aj.enabled and(bJ-a6)>1 then
a6=bJ
aj.Log(("ПОСЛЕДНИЙ РУБЕЖ: цели не было, ухожу в %.0f студах")
:format((Vector3.new(bY.X,0,bY.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude))
end
end
end

if not bp then






bI:MoveTo(bH.Position)
clearRoute()
if aj.enabled and(bJ-a6)>1 then
a6=bJ
aj.Log(("ЦЕЛИ НЕТ ВОВСЕ: накрыт=%s, встал на месте"):format(tostring(bN)))
end
if bv then bv:Set"Nowhere clean to stand"end
return
end

local bY=(Vector3.new(bp.X,0,bp.Z)
-Vector3.new(bH.Position.X,0,bH.Position.Z)).Magnitude













local bZ,b_=bz,bP
if E then
local b0=Vector3.new(bH.Position.X,0,bH.Position.Z)
for b1,b2 in ipairs(bn)do
local b3=aa.PivotOf(b2)
if b3 then
local b4=(Vector3.new(b3.X,0,b3.Z)-b0).Magnitude
if b4<b_ then bZ,b_=b2,b4 end
end
end
if bZ~=bz then
local b1=aa.PivotOf(bZ)
local b2=b1 and Vector3.new(b1.X,bH.Position.Y,b1.Z)
if b2 and(b2-bH.Position).Magnitude>0.1 then
bH.CFrame=CFrame.new(bH.Position,b2)
end
if aj.enabled and(bJ-h)>1 then
h=bJ
aj.Log(("В УКРЫТИИ БЬЮ %s в %.0f студах вместо %s в %.0f")
:format(bZ.Name,b_,bz.Name,bP))
end
end
end









local b0=ad.HazardRadius and ad.HazardRadius(bZ)or nil




local b1=math.max(an+ao,(b0 or 0)+6,
(as[bZ.Name]or 0)+4)











if b_<=b1 or(bL and bY<=a2)then
ac.Swing()
end







if ad.IsSafe(bH.Position,0)then
ac.CastReady(bZ,tonumber(S.castReach)or 0,{})
end




















local b2=not ad.RoomSafe(bH.Position,2.5)
if b2 and aj.enabled and(bJ-a7)>2 then
a7=bJ
aj.Log"КРАЙ: стоять здесь нельзя, рядом атака — переставляюсь"
end
if bY<=a2 and math.abs(bK.Y-bH.Position.Y)<=20
and(bL or E or y
or(not bN and bO and not bE and not b2))then
bI:MoveTo(bH.Position)
clearRoute()
if bv then
bv:Set(("Fighting %s — %.0f studs"):format(bz.Name,bP))
end
return
end

ad.Note("доЦели",("%.0f"):format(bY))
ad.Note("накрыт",tostring(bN))


local b3,b4=Plan().Step(bH.Position,bp)
if b3 then
bI:MoveTo(b3)
if bv then
bv:Set(("Running to %s — %.0f studs (%s)"):format(bz.Name,bY,b4))
end
elseif S.testArena then



bI:MoveTo(bp)
if bv then
bv:Set(("Running to %s — %.0f studs (%s)")
:format(bz.Name,bY,b4 or"direct"))
end
else








if bN then
local b5
for b6,b7 in ipairs{6,10,14}do
for b8=0,15 do
local b9=b8*math.pi/8
local ca=Vector3.new(
bH.Position.X+math.cos(b9)*b7,
bH.Position.Y,
bH.Position.Z+math.sin(b9)*b7)
if ad.BoxSafe(ca)and ad.IsSafe(ca,0)then
b5=ca
break
end
end
if b5 then break end
end
if b5 then
bI:MoveTo(b5)
if aj.enabled and(bJ-a6)>1 then
a6=bJ
aj.Log"МАРШРУТА НЕТ ПОД УДАРОМ: ухожу перебором направлений"
end
if bv then bv:Set"Dodging without route"end
return
end
end









bI:MoveTo(bH.Position)
clearRoute()
if bv then
bv:Set(("No route to %s — %.0f studs (%s)")
:format(bz.Name,bY,b4 or"no path"))
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
return ak,ak and"opened (вручную)"or"could not open"
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










ad.GROUP_TYPES={
weapon={weapon=true},
armor={helmet=true,chest=true},
ability={ability=true},
}




local ae={"physicalDamage","physicalPower","spellPower","health"}

local function dupRank(af)
local ag=tonumber(af.data.currentUpgrade)or 0
local ah=0
for ai,aj in ipairs(ae)do
local ak=tonumber(af.data[aj])
if ak and ak>ah then ah=ak end
end
return ag,ah
end







function ad.AdvancedCandidates(af)
af=af or{}
local ag=af.groups or{}
local ah=af.keepUpgraded~=false
local ai=ab.Items(true)


local aj={}
for ak,al in pairs(ad.GROUP_TYPES)do
for am in pairs(al)do aj[am]=ak end
end




local ak={}
if af.keepBest then
local al={weapon=true,helmet=true,chest=true}
local am={}
for an,ao in ipairs(ai)do
local ap=(tonumber(ao.data.currentUpgrade)or 0)>0
if al[ao.type]and not ao.equipped
and not(ah and ap)then
for aq,ar in ipairs(ae)do
local as=tonumber(ao.data[ar])
if as then
local au=ao.type.."/"..ar
local av=am[au]
if not av or as>(tonumber(av.data[ar])or 0)then am[au]=ao end
end
end
end
end
for an,ao in pairs(am)do ak[ao.key]=true end
end


local al={}
for am,an in ipairs(ai)do
local ao=aj[an.type]
local ap=ao and ag[ao]
if ap and ap.on and not an.equipped and not ak[an.key]then
local aq=(tonumber(an.data.currentUpgrade)or 0)>0
local ar=an.name
local as=not(ah and aq)
and not(ap.keep or{})[ar]



if as and next(ap.only or{})~=nil then as=(ap.only or{})[ar]==true end


if as and next(ap.rarities or{})~=nil then as=(ap.rarities or{})[an.rarity]==true end
local au=tonumber(ap.maxLevel)or 0
if as and au>0 then as=(tonumber(an.data.levelReq)or 0)<au end

if as then al[#al+1]=an end
end
end






local am={}
for an,ao in ipairs(al)do
local ap=aj[ao.type]
local aq=tonumber((ag[ap]or{}).dupes)or 0
if aq>0 then
local ar=am[ao.name]
if not ar then ar={};am[ao.name]=ar end
ar[#ar+1]=ao
end
end
local an={}
for ao,ap in pairs(am)do
local aq=aj[ap[1].type]
local ar=tonumber((ag[aq]or{}).dupes)or 0
table.sort(ap,function(as,au)
local av,aw=dupRank(as)
local ax,ay=dupRank(au)
if av~=ax then return av>ax end
return aw>ay
end)
for as=1,math.min(ar,#ap)do an[ap[as].key]=true end
end

local ao={}
for ap,aq in ipairs(al)do
if not an[aq.key]then ao[#ao+1]=aq end
end
return ao
end














local af=game:GetService"ReplicatedStorage"

local ag={weapon="GetWeapons",helmet="GetHelmets",chest="GetChests"}



local ah={}







local function readCatalog(ai)
if ai=="ability"then
local aj=af:FindFirstChild"abilities"
if not aj then return nil end









local ak={}
for al,am in ipairs(aj:GetChildren())do
ak[#ak+1]=tostring(am.Name)
end
return ak
end

local aj=ag[ai]
if not aj then return nil end
local ak=af:FindFirstChild"Utility"
local al=ak and ak:FindFirstChild"DataRequester"
if not al then return nil end
local am,an=pcall(require,al)
if not am or type(an)~="table"or type(an[aj])~="function"then return nil end

local ao,ap=pcall(an[aj])
if not ao or type(ap)~="table"then return nil end
local aq={}
for ar,as in pairs(ap)do
aq[#aq+1]=tostring((type(as)=="table"and as.name)or ar)
end
return aq
end



function ad.WarmCatalog(ai)
local aj=false
for ak,al in ipairs{"weapon","helmet","chest","ability"}do
if ai or ah[al]==nil then
local am=readCatalog(al)
if am and#am>0 then
ah[al]=am
aj=true
end
end
end
return aj
end

function ad.GroupNames(ai)
local aj=ad.GROUP_TYPES[ai]
if not aj then return{}end
local ak,al={},{}
local function add(am)
am=tostring(am or"")
if am~=""and not ak[am]then
ak[am]=true
al[#al+1]=am
end
end

for am in pairs(aj)do
for an,ao in ipairs(ah[am]or{})do add(ao)end
end



if#al==0 then
for am,an in ipairs(ab.Items())do
if aj[an.type]then add(an.name)end
end
end

table.sort(al)
return al
end


function ad.OwnedNames()
local ai,aj={},{}
for ak,al in ipairs(ab.Items())do
if not ai[al.name]then ai[al.name]=true;aj[#aj+1]=al.name end
end
table.sort(aj)
return aj
end




function ad.AllNames()
local ai,aj={},{}
for ak,al in ipairs{"weapon","helmet","chest","ability"}do
for am,an in ipairs(ah[al]or{})do
if not ai[an]then ai[an]=true;aj[#aj+1]=an end
end
end
if#aj==0 then return ad.OwnedNames()end
table.sort(aj)
return aj
end





function ad.Equip(ai,aj)
if aj then
return(aa.Invoke("equipItem",ai.type,ai.num,aj))
end
return(aa.Invoke("equipItem",ai.type,ai.num))
end

function ad.Unequip(ai)
return(aa.Invoke("unequipItem",ai.type,ai.num))
end



ad.EQUIP_STATS={["Spell Power"]="spellPower",["Physical Damage"]="physicalDamage"}



ad.ARMOR_STATS={Health=
"health",
["Spell Power"]="spellPower",
["Physical Power"]="physicalPower",
}
ad.ARMOR_SLOTS={"helmet","chest"}






local function scoreOf(ai,aj,ak)
if ak then return ac.OfItem(ai,aj)end
return tonumber(ai[aj])or 0
end

function ad.BestWeapon(ai,aj)
local ak=ad.EQUIP_STATS[ai]or"spellPower"
local al=ab.Level()
local am,an,ao=(-1)

for ap,aq in ipairs(ab.Items())do
if aq.type=="weapon"then
local ar=tonumber(aq.data.levelReq)or 0
local as=scoreOf(aq.data,ak,aj)
if aq.equipped then ao=aq end
if ar<=al and as>am then an,am=aq,as end
end
end
return an,ao,am
end



function ad.BestArmor(ai,aj,ak)
local al=ad.ARMOR_STATS[aj]or"health"
local am=ab.Level()
local an,ao,ap=(-1)

for aq,ar in ipairs(ab.Items())do
if ar.type==ai then
local as=tonumber(ar.data.levelReq)or 0
local au=scoreOf(ar.data,al,ak)
if ar.equipped then ap=ar end
if as<=am and au>an then ao,an=ar,au end
end
end
return ao,ap,an
end



function ad.Score(ai,aj,ak)
if not ai or not aj then return 0 end
return scoreOf(ai.data,aj,ak)
end











ad.UPGRADE_STATS={
["Spell Power"]="spell",
["Physical Damage"]="physical",Health=
"health",
}



function ad.UpgradeCost(ai)
ai=math.max(0,math.floor(tonumber(ai)or 0))
if ai==0 then return 100 end
if ai>466 then return 100000 end
local aj=100
for ak=1,ai do
if aj*1.06+50-aj>220 then
aj=aj+220
else
aj=aj*1.06+50
end
end
return math.floor(aj>100000 and 100000 or aj)
end




function ad.AffordableUpgrades(ai,aj,ak)
local al=tonumber(ai.data.currentUpgrade)or 0
local am=(tonumber(ai.data.maxUpgrades)or 0)-al
if ak then am=math.min(am,ak)end

local an,ao=tonumber(aj)or 0,0
for ap=0,am-1 do
local aq=ad.UpgradeCost(al+ap)
if aq>an then break end
an=an-aq
ao=ao+1
end
return ao
end

function ad.Upgrade(ai,aj,ak)
local al=tonumber(ai.data.currentUpgrade)or 0
local am=(tonumber(ai.data.maxUpgrades)or 0)-al
if am<=0 then return false,"already maxed"end

local an,ao=1
if ak=="10x"then
an,ao=10,"10x"
elseif ak=="spendAll"then
an,ao=am,"spendAll"
end

local ap=ad.AffordableUpgrades(ai,ab.Gold(),an)
if ap<=0 then
return false,("need %d gold"):format(ad.UpgradeCost(al))
end

aa.Fire("upgradeItem",ai.type,ai.num,aj,ap,ao)
ab.InvalidateInventory()
return true,("+%d %s"):format(ap,aj)
end

function ad.EquippedWeapon()
for ai,aj in ipairs(ab.Items())do
if aj.type=="weapon"and aj.equipped then return aj end
end
return nil
end









local ai={weapon=1,helmet=2,chest=3}

function ad.EquippedGear()
local aj={}
for ak,al in ipairs(ab.Items())do
if al.equipped and ai[al.type]then aj[#aj+1]=al end
end
table.sort(aj,function(ak,al)return ai[ak.type]<ai[al.type]end)
return aj
end


function ad.UpgradeTargets(aj)
local ak=ad.EquippedGear()
if aj~="All"then return ak end

local al={}
local am={}
for an,ao in ipairs(ak)do
al[#al+1]=ao
am[ao]=true
end
for an,ao in ipairs(ab.Items())do
if not am[ao]and not ao.equipped and ai[ao.type]
and(tonumber(ao.data.maxUpgrades)or 0)>(tonumber(ao.data.currentUpgrade)or 0)then
al[#al+1]=ao
end
end
return al
end




ad.SKILL_STATS={
["Spell Power"]="spellPower",
["Physical Power"]="physicalPower",Stamina=
"stamina",
}

function ad.SpendSkill(aj,ak)
local al=math.max(1,math.floor(tonumber(ak)or 1))
return aa.Fire("spendSkillPoint",aj,al)
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







local ag=af:Section"Simple Auto Sell"
local ah=af:Section("Advanced Auto Sell",{Open=false})
local ai=ae.Equip
local aj=ae.Smith
local ak=ae.Skills



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

ag:Dropdown{
Name="Sell By",
Desc="Rarity uses the rarity list, Level dumps gear you have outgrown, Both needs the two to agree",
Options={"Rarity","Level","Both"},
Default="Rarity",
Flag="SellMode",
Callback=function(al)S.sellMode=al end,
}

ag:Dropdown{
Name="Sell Rarities",
Desc="nothing is sold while this is empty and the mode uses rarity",
Options=rarityOptions(),Multi=true,
Flag="SellRarities",
Callback=function(al)
local am={}
for an,ao in pairs(al or{})do
if ao then am[plain(an)]=true end
end
S.sellRarities=am
end,
}

ag:Slider{
Name="Sell Below Level",
Desc="sells items whose level requirement is under this — set it to your own level to dump outgrown gear",
Default=1,Min=1,Max=300,Decimals=0,
Flag="SellBelowLevel",
Callback=function(al)S.sellBelowLevel=al end,
}

ag:Dropdown{
Name="Sell Categories",
Desc="leave empty to allow every category",
Options={"Weapons","Abilities","Helmets","Chests"},Multi=true,
Flag="SellCategories",
Callback=function(al)
local am={}
for an,ao in pairs(al or{})do
if ao and ad[an]then am[ad[an] ]=true end
end
S.sellCategories=am
end,
}

local al
al=ag:Dropdown{
Name="Hold List",
Desc="items picked here are never sold, whatever the filters say",
Options=ab.AllNames(),Multi=true,Search=true,CacheOptions=true,
Flag="SellHold",
Callback=function(am)
local an={}
for ao,ap in pairs(am or{})do if ap then an[ao]=true end end
S.sellHold=an
end,
}

ag:Toggle{
Name="Keep Best Weapon",
Desc="never sell the strongest weapon by spell power or by physical damage",
Default=true,Flag="SellKeepBest",
Callback=function(am)S.sellKeepBest=am end,
}

ag:Toggle{
Name="Keep Upgraded",
Desc="never sell anything you have poured gold into",
Default=true,Flag="SellKeepUpgraded",
Callback=function(am)S.sellKeepUpgraded=am end,
}

ag:Button{Name="Open Sell Menu",Text="Open",Callback=function()
local am,an=ab.OpenSellUi()
Notify(am and("Sell menu "..tostring(an))or("Could not open — "..tostring(an)))
end}

ag:Toggle{
Name="Auto Sell",
Desc="sells everything matching the filters, anywhere — town or dungeon; ignored while Advanced Auto Sell is on",
Default=false,Flag="AutoSell",
Callback=function(am)S.autoSell=am end,
}

local am=ag:Label"Nothing matches the sell filters"

local function sellNow()
local an=ab.SellCandidates(sellOpts())
if#an==0 then return 0 end
return ab.Sell(an)
end

ag:Button{Name="Sell Now",Text="Sell",Callback=function()
task.spawn(function()
local an=sellNow()
Notify(an>0 and("Sold %d item%s"):format(an,an==1 and""or"s")
or"Nothing matches the sell filters")
end)
end}

local function refillHold()
local an=ab.AllNames()
pcall(function()al:SetOptions(an)end)
return#an
end

ag:Button{Name="Refresh Hold List",Text="Refresh",Callback=function()
task.spawn(function()
aa.InvalidateInventory()
ab.WarmCatalog()
local an=refillHold()
Notify(("%d item name%s in the game"):format(an,an==1 and""or"s"))
end)
end}

spawnLoop(function()
while not _apelStopped do
task.wait(3)
pcall(function()
local an=ab.SellCandidates(sellOpts())
local ao=0
for ap,aq in ipairs(an)do ao=ao+(tonumber(aq.data.sellPrice)or 0)end
am:Set(#an==0 and"Nothing matches the sell filters"
or("%d item%s matching · %d gold"):format(#an,#an==1 and""or"s",ao))
end)



if S.autoSell and not S.autoSellAdv and not Window:IsLoadingConfig()then
pcall(sellNow)
end
end
end)












S.sellAdv=S.sellAdv or{}
S.sellAdvGroups={
weapon={on=false,keep={},only={},rarities={},maxLevel=0,dupes=0},
armor={on=false,keep={},only={},rarities={},maxLevel=0,dupes=0},
ability={on=false,keep={},only={},rarities={},maxLevel=0,dupes=0},
}

local function advOpts()
return{
keepBest=S.sellAdvKeepBest~=false,
keepUpgraded=S.sellAdvKeepUpgraded~=false,
groups=S.sellAdvGroups,
}
end

ah:SubLabel"Each group has its own rules. The simple filters above are ignored while this is on."

ah:Toggle{
Name="Keep Best",
Desc="never sell the strongest weapon or armor piece by any stat",
Default=true,Flag="SellAdvKeepBest",
Callback=function(an)S.sellAdvKeepBest=an end,
}

ah:Toggle{
Name="Keep Upgraded",
Desc="never sell anything you have poured gold into",
Default=true,Flag="SellAdvKeepUpgraded",
Callback=function(an)S.sellAdvKeepUpgraded=an end,
}



local an={
{key="weapon",title="Weapons",noun="weapons"},
{key="armor",title="Armor",noun="helmets and chests"},
{key="ability",title="Abilities",noun="abilities"},
}

local ao={}

for ap,aq in ipairs(an)do
local ar=S.sellAdvGroups[aq.key]
local as=ah:Section(aq.title,{Open=false})

as:Toggle{
Name="Sell "..aq.title,
Desc="turn on the rules below for "..aq.noun,
Default=false,Flag="SellAdvOn"..aq.title,
Callback=function(au)ar.on=au end,
}

local au=as:Dropdown{
Name="Never Sell",
Desc="these are kept whatever the other rules say",
Options=ab.GroupNames(aq.key),Multi=true,Search=true,CacheOptions=true,
Flag="SellAdvKeep"..aq.title,
Callback=function(au)
local av={}
for aw,ax in pairs(au or{})do if ax then av[aw]=true end end
ar.keep=av
end,
}

local av=as:Dropdown{
Name="Sell Only These",
Desc="leave empty to allow every item in the group",
Options=ab.GroupNames(aq.key),Multi=true,Search=true,CacheOptions=true,
Flag="SellAdvOnly"..aq.title,
Callback=function(av)
local aw={}
for ax,ay in pairs(av or{})do if ay then aw[ax]=true end end
ar.only=aw
end,
}

as:Dropdown{
Name="Rarities",
Desc="leave empty to allow every rarity",
Options=rarityOptions(),Multi=true,
Flag="SellAdvRar"..aq.title,
Callback=function(aw)
local ax={}
for ay,az in pairs(aw or{})do if az then ax[plain(ay)]=true end end
ar.rarities=ax
end,
}





if aq.key=="ability"then
as:Slider{
Name="Keep Duplicates",
Desc="keep at most this many copies of the same ability, sell the weaker ones — 0 turns it off",
Default=0,Min=0,Max=10,Decimals=0,
Flag="SellAdvDupes"..aq.title,
Callback=function(aw)ar.dupes=aw end,
}
else
as:Slider{
Name="Sell Below Level",
Desc="only sell gear you have outgrown — 0 turns it off",
Default=0,Min=0,Max=300,Decimals=0,
Flag="SellAdvLvl"..aq.title,
Callback=function(aw)ar.maxLevel=aw end,
}
end

ao[#ao+1]=function()
local aw=ab.GroupNames(aq.key)
pcall(function()au:SetOptions(aw)end)
pcall(function()av:SetOptions(aw)end)
return#aw
end
end

local function refillGroups()
local ap=0
for aq,ar in ipairs(ao)do ap=ap+(ar()or 0)end
return ap
end





task.spawn(function()
if ab.WarmCatalog()then
refillGroups()
refillHold()
end
end)

ah:Button{Name="Refresh Item Lists",Text="Refresh",Callback=function()
task.spawn(function()
aa.InvalidateInventory()
ab.WarmCatalog()
local ap=refillGroups()
Notify(("%d item name%s across the groups"):format(ap,ap==1 and""or"s"))
end)
end}

ah:Toggle{
Name="Advanced Auto Sell",
Desc="sells by the per-group rules; replaces the simple auto sell while on",
Default=false,Flag="AutoSellAdvanced",
Callback=function(ap)S.autoSellAdv=ap end,
}

local ap=ah:Label"Nothing matches the advanced rules"

local function advSellNow()
local aq=ab.AdvancedCandidates(advOpts())
if#aq==0 then return 0 end
return ab.Sell(aq)
end

ah:Button{Name="Sell Now (Advanced)",Text="Sell",Callback=function()
task.spawn(function()
local aq=advSellNow()
Notify(aq>0 and("Sold %d item%s"):format(aq,aq==1 and""or"s")
or"Nothing matches the advanced rules")
end)
end}

spawnLoop(function()
while not _apelStopped do
task.wait(3)
pcall(function()
local aq=ab.AdvancedCandidates(advOpts())
local ar=0
for as,au in ipairs(aq)do ar=ar+(tonumber(au.data.sellPrice)or 0)end
ap:Set(#aq==0 and"Nothing matches the advanced rules"
or("%d item%s matching · %d gold"):format(#aq,#aq==1 and""or"s",ar))
end)

if S.autoSellAdv and not Window:IsLoadingConfig()then
pcall(advSellNow)
end
end
end)



ai:Dropdown{
Name="Weapon By",
Options={"Spell Power","Physical Damage"},
Default="Spell Power",
Flag="EquipBy",
Callback=function(aq)S.equipBy=aq end,
}

ai:Dropdown{
Name="Armor By",
Desc="Health is the tank pick; the other two scale your damage instead",
Options={"Health","Spell Power","Physical Power"},
Default="Health",
Flag="EquipArmorBy",
Callback=function(aq)S.equipArmorBy=aq end,
}

ai:Toggle{
Name="Auto Equip Best",
Desc="swaps weapon, helmet and chest to the strongest you can wear at your level",
Default=false,Flag="AutoEquipBest",
Callback=function(aq)S.autoEquipBest=aq end,
}

ai:Toggle{
Name="Judge By Max Upgrades",
Desc="compares what items will be when fully upgraded, not what they are now",
Default=false,Flag="EquipByPotential",
Callback=function(aq)S.equipByPotential=aq end,
}

ai:Slider{
Name="Only If Better By",
Desc="how much stronger a candidate must be before it replaces what you wear",
Default=0,Min=0,Max=100,Decimals=0,Suffix="%",
Flag="EquipGainPct",
Callback=function(aq)S.equipGainPct=tonumber(aq)or 0 end,
}

local aq=ai:Label"Equipped: —"










local function worthSwap(ar,as,au)
if not ar then return false end
if as and as.key==ar.key then return false end
if not as then return true end

local av=tonumber(S.equipGainPct)or 0
if av<=0 then return true end

local aw=ab.Score(as,au,S.equipByPotential)
local ax=ab.Score(ar,au,S.equipByPotential)
if aw<=0 then return true end
return ax>=aw*(1+av/100)
end

local function equipBest()
local ar={}
local as=S.equipByPotential==true

local au=ab.EQUIP_STATS[S.equipBy]or"spellPower"
local av,aw=ab.BestWeapon(S.equipBy,as)
if worthSwap(av,aw,au)then
ab.Equip(av)
ar[#ar+1]=av.name
end

local ax=ab.ARMOR_STATS[S.equipArmorBy]or"health"
for ay,az in ipairs(ab.ARMOR_SLOTS)do
local aA,aB=ab.BestArmor(az,S.equipArmorBy,as)
if worthSwap(aA,aB,ax)then
ab.Equip(aA)
ar[#ar+1]=aA.name
end
end

if#ar>0 then aa.InvalidateInventory()end
return ar
end

ai:Button{Name="Equip Best Now",Text="Equip",Callback=function()
task.spawn(function()
local ar=equipBest()
Notify(#ar>0 and("Equipped "..table.concat(ar,", "))
or"Already wearing the best you own")
end)
end}

ai:Button{Name="Swap Ability Set",Text="Swap",Callback=function()
ab.SwapAbilitySet()
Notify"Ability set swapped"
end}








local function equipNow()
if not S.autoEquipBest then return end
if Window:IsLoadingConfig()then return end
aa.InvalidateInventory()
pcall(equipBest)
end

for ar,as in ipairs{"reloadInventory","updateLocalInventoryTable"}do
ac.OnClient(as,function()task.spawn(equipNow)end)
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
ar, as=ab.BestWeapon(S.equipBy)local
au, av=ab.BestArmor("helmet",S.equipArmorBy)local
aw, ax=ab.BestArmor("chest",S.equipArmorBy)
aq:Set(("Weapon: <b>%s</b>\nHelmet: %s   ·   Chest: %s"):format(
as and as.name or"—",
av and av.name or"—",
ax and ax.name or"—"))
end)
end
end)



aj:Dropdown{
Name="Upgrade",
Desc="Equipped pours gold into what you are wearing; All spreads it over everything unmaxed",
Options={"Equipped","All"},
Default="Equipped",
Flag="UpgradeScope",
Callback=function(as)S.upgradeScope=as end,
}

aj:Dropdown{
Name="Upgrade Stat",
Desc="health cannot be upgraded on a weapon — the game refuses it",
Options={"Spell Power","Physical Damage","Health"},
Default="Spell Power",
Flag="UpgradeStat",
Callback=function(as)S.upgradeStat=ab.UPGRADE_STATS[as]or"spell"end,
}

aj:Dropdown{
Name="Upgrade Amount",
Options={"1x","10x","Spend All"},
Default="Spend All",
Flag="UpgradeMode",
Callback=function(as)
S.upgradeMode=(as=="10x"and"10x")or(as=="Spend All"and"spendAll")or nil
end,
}

aj:Toggle{
Name="Auto Upgrade",
Desc="keeps pouring gold into your gear anywhere, town or dungeon",
Default=false,Flag="AutoUpgrade",
Callback=function(as)S.autoUpgrade=as end,
}

local as=aj:Label"Nothing equipped"


local function upgradeNow()
local av=ab.UpgradeTargets(S.upgradeScope)
if#av==0 then return false,"nothing to upgrade"end

local aw,ax=0
for ay,az in ipairs(av)do


local aA=S.upgradeStat or"spell"
if aA=="health"and az.type=="weapon"then aA="spell"end

local aB,aC=ab.Upgrade(az,aA,S.upgradeMode)
if aB then aw,ax=aw+1,aC else ax=aC end
task.wait(0.35)
aa.InvalidateInventory()

if not aB and type(aC)=="string"and aC:find"need"then break end
end

if aw>0 then
return true,("%d item%s, last %s"):format(aw,aw==1 and""or"s",tostring(ax))
end
return false,tostring(ax)
end

aj:Button{Name="Upgrade Now",Text="Upgrade",Callback=function()
task.spawn(function()
local av,aw=upgradeNow()
Notify(av and("Upgraded — "..tostring(aw))or("Upgrade skipped — "..tostring(aw)))
end)
end}



aj:Button{Name="Open Game Upgrade Menu",Text="Open",Callback=function()
local av,aw=ab.OpenBlacksmithUi()
Notify(av and("Blacksmith menu "..tostring(aw))or("Could not open — "..tostring(aw)))
end}

spawnLoop(function()
while not _apelStopped do
task.wait(5)
pcall(function()



local av={}
for aw,ax in ipairs(ab.EquippedGear())do
local ay=tonumber(ax.data.currentUpgrade)or 0
local az=tonumber(ax.data.maxUpgrades)or 0
av[#av+1]=ay>=az
and("<b>%s</b> — maxed (%d/%d)"):format(ax.name,ay,az)
or("<b>%s</b> — %d/%d, next %d gold")
:format(ax.name,ay,az,ab.UpgradeCost(ay))
end
if#av>0 then
av[#av+1]=("Gold %d"):format(aa.Gold())
as:Set(table.concat(av,"\n"))
else
as:Set"Nothing equipped"
end
end)


if S.autoUpgrade and not Window:IsLoadingConfig()then
pcall(upgradeNow)
end
end
end)



ak:Dropdown{
Name="Spend Into",
Options={"Spell Power","Physical Power","Stamina"},
Default="Spell Power",
Flag="SkillStat",
Callback=function(av)S.skillStat=ab.SKILL_STATS[av]or"spellPower"end,
}

ak:Toggle{
Name="Auto Spend Skill Points",
Desc="spends every point you earn into the stat above",
Default=false,Flag="AutoSkill",
Callback=function(av)S.autoSkill=av end,
}

local av=ak:Label"Points: 0"

ak:Button{Name="Spend All Now",Text="Spend",Callback=function()
task.spawn(function()
local aw=aa.SkillPoints()
if aw<=0 then return Notify"No skill points to spend"end
ab.SpendSkill(S.skillStat or"spellPower",aw)
Notify(("Spent %d point%s"):format(aw,aw==1 and""or"s"))
end)
end}



ak:Button{Name="Reset Skill Points",Text="Reset",Callback=function()
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
av:Set(("Points: <b>%d</b>   ·   spell %s · physical %s · stamina %s"):format(
aa.SkillPoints(),tostring(aa.Val("spellPower",0)),
tostring(aa.Val("physicalPower",0)),tostring(aa.Val("stamina",0))))
end)

if S.autoSkill and not Window:IsLoadingConfig()then
local aw=aa.SkillPoints()
if aw>0 then pcall(ab.SpendSkill,S.skillStat or"spellPower",aw)end
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























local aa=game:GetService"Players"
local ab=game:GetService"ReplicatedStorage"
game:GetService"RunService"
local ac=aa.LocalPlayer
local ad=a.l()







local function elevate()
if setthreadidentity then pcall(setthreadidentity,8)end
end
elevate()






local ae=false




local af=(getgenv and getgenv())or _G
af._CosmeticGetter=af._CosmeticGetter or{armed=false,picks={},hooked=false,selfCall=false}
local ag=af._CosmeticGetter


ag.selfCall=false
ag.picks=ag.picks or{}

local ah={}
local ai=false



local function stop()
ai=true
ag.armed=false
for aj,ak in ipairs(ah)do pcall(function()ak:Disconnect()end)end
ah={}
end
af._CosmeticGetterStop=stop








local aj=ab:WaitForChild("remotes",5)

local function want(ak)
return aj and aj:WaitForChild(ak,5)or nil
end

local ak=want"awardCaseCosmetic"
local al=want"purchaseCase"
local am=want"casePurchaseResult"
local an=want"getPlayerCosmetics"
local ao=want"getCaseConfig"
local ap=want"getCaseCosmetics"



local aq=aj and aj:FindFirstChild"addCosmeticLocal"


local as=aj and aj:FindFirstChild"alertPlayer"
local av=ab:WaitForChild("Utility",5)

local aw,ax=pcall(function()
return require(av:WaitForChild("AssetRequester",5))
end)
if not aw then ax=nil end




if not ag.hooked and hookmetamethod and getnamecallmethod then
ag.hooked=true
local ay=newcclosure or function(ay)return ay end
local az
az=hookmetamethod(game,"__namecall",ay(function(aA,...)







if ag.selfCall and aA==ak and getnamecallmethod()=="FireServer"then
return az(aA,...)
end
if ag.armed and aA==ak and getnamecallmethod()=="FireServer"then local
aB, aC, aD=...
local aE=ag.picks




if aE and aE[aB]then
return az(aA,...)
end
local aF
for aG,aH in pairs(aE or{})do
if aG~=aB then aF=aH break end
end
if aF then
return az(aA,aF.name,aF.type,aD)
end
end
return az(aA,...)
end))
end


local ay={
common=Color3.fromRGB(152,152,152),
uncommon=Color3.fromRGB(91,194,80),
rare=Color3.fromRGB(75,77,195),
epic=Color3.fromRGB(146,70,159),
legendary=Color3.fromRGB(244,154,9),
}
local az={common=1,uncommon=2,rare=3,epic=4,legendary=5}
local aA={"rare","epic","legendary"}
local aB={"common","uncommon","rare","epic","legendary"}

local aC={
{key="armors",title="Armors"},
{key="weapons",title="Weapons"},
{key="enchants",title="Enchants"},
{key="titles",title="Titles"},
}

local aD={}
do
local aE,aF=pcall(function()return require(av:WaitForChild("DataRequester",5))end)
local aG,aH=false
if aE and type(aF)=="table"and aF.GetCosmetics then aG,aH=pcall(aF.GetCosmetics)end
if aG and type(aH)=="table"then
for aI,aJ in pairs(aH)do
if type(aJ)=="table"then
for aK,aL in pairs(aJ)do
if type(aL)=="table"then
aD[#aD+1]={
name=tostring(aL.name or aK),
type=tostring(aL.cosmeticType or aI),
rarity=string.lower(tostring(aL.rarity or"common")),
imageId=tostring(aL.imageId or""),
}
end
end
end
end
end
end

table.sort(aD,function(aE,aF)
if aE.type~=aF.type then return aE.type<aF.type end
local aG,aH=az[aE.rarity]or 0,az[aF.rarity]or 0
if aG~=aH then return aG>aH end
return aE.name<aF.name
end)




local aE=Color3.fromRGB(26,26,26)
local aF=Color3.fromRGB(44,43,43)
local aG=Color3.fromRGB(62,62,62)
local aH=Color3.fromRGB(42,40,40)
local aI=Color3.fromRGB(226,132,19)
local aJ=Color3.fromRGB(255,255,255)
local aK=Color3.fromRGB(168,168,168)
local aL=Color3.fromRGB(128,128,128)
local aM=Color3.fromRGB(120,220,150)
local aN=Color3.fromRGB(237,66,69)
Color3.fromRGB(62,62,62)






local aO=0.20
local aP=0.40
local aQ=0.50
local aR=0.30

local function new(aS,aT,aU)
local aV=Instance.new(aS)
for aW,aX in pairs(aT or{})do
if aW~="Parent"then aV[aW]=aX end
end
for aW,aX in ipairs(aU or{})do aX.Parent=aV end
if aT and aT.Parent then aV.Parent=aT.Parent end
return aV
end

local function corner(aS)return new("UICorner",{CornerRadius=UDim.new(0,aS or 6)})end

local function stroke(aS,aT,aU)
return new("UIStroke",{
Color=aS or Color3.fromRGB(70,70,82),
Thickness=aT or 1,
Transparency=aU or 0,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
})
end











local aS={}


local function loadOwned()
local aT,aU=pcall(function()return an:InvokeServer()end)
if not aT or type(aU)~="table"then return false end
local aV={}
for aW,aX in pairs(aU)do
if type(aX)=="table"then
for aY,aZ in pairs(aX)do aV[tostring(aZ)]=true end
end
end
aS=aV
return true
end














local aT,aU={},{}


local function loadCase(aV)
if aT[aV]==nil then
local aW,aX=pcall(function()return ao:InvokeServer(aV)end)
aT[aV]=(aW and type(aX)=="table")and aX or false
end
if aU[aV]==nil then
local aW,aX=pcall(function()return ap:InvokeServer(aV)end)
aU[aV]=(aW and type(aX)=="table")and aX or false
end
return aT[aV],aU[aV]
end





local function bestCaseFor(aV)
local aW,aX,aY=0,0
for aZ,a_ in ipairs(aA)do
local a0,a1=loadCase(a_)
if a0 and a1 and type(a0.weights)=="table"then
local a2,a3={},{}
for a4,a5 in ipairs(a1)do
if type(a5)=="table"then
a2[a5.rarity]=(a2[a5.rarity]or 0)+1
a3[a5.name]=true
end
end
local a4,a5=0,0
for a6,a7 in pairs(aV)do
local a8=a0.weights[a7.rarity]
local a9=a2[a7.rarity]
if a8 and a9 and a9>0 and a3[a6]then
a4=a4+a8/a9
a5=a5+1
end
end
if a5>0 and a4>aW then
aY,aW,aX=a_,a4,a5
end
end
end
return aY,aW,aX
end







local aV=ac.Name.."/Assets"



local function fetchAsset(aW)
local aX=ab:FindFirstChild(aV)
local aY=aX and aX:FindFirstChild(aW.name)
if aY then return aY end
if ax and ax.RequestAsset then
pcall(function()
ax.RequestAsset("cosmetics",aW.type,aW.name):await()
end)
end
aX=ab:FindFirstChild(aV)
return aX and aX:FindFirstChild(aW.name)or nil
end









local aW
if ae then
local aX=ac:WaitForChild"PlayerGui":FindFirstChild"mainInterface"
local aY=aX and aX:FindFirstChild"shop"
aY=aY and aY:FindFirstChild"cosmetics"
aY=aY and aY:FindFirstChild"featuredArmorCosmeticShop1"
local aZ=aY and aY:FindFirstChild"ViewportFrame"
local a_=aZ and aZ:FindFirstChild"Dummy"
if a_ then
aW=a_:Clone()
local a0={}
for a1,a2 in ipairs(aW:GetDescendants())do
if a2:IsA"Motor6D"then
if a2.Part0 then a0[a2.Part0]=true end
if a2.Part1 then a0[a2.Part1]=true end
end
end
for a1,a2 in ipairs(aW:GetChildren())do
local a3=a2:IsA"BasePart"and not a0[a2]
if a3 or a2:IsA"Model"or a2:IsA"Accessory"then
pcall(function()a2:Destroy()end)
end
end
end
end













local function rigAttachments(aX)
local aY={}
for aZ,a_ in ipairs(aX:GetDescendants())do
if a_:IsA"Attachment"and aY[a_.Name]==nil then aY[a_.Name]=a_ end
end
return aY
end


local function wearOnRig(aX)
if not aW then return nil,0 end
local aY=aW:Clone()
local aZ=rigAttachments(aY)
local a_=0

for a0,a1 in ipairs(aX:GetChildren())do
if a1:IsA"Model"or a1:IsA"Accessory"then
local a2=a1:Clone()
local a3=a2:FindFirstChild"Handle"
local a4=a3 and a3:FindFirstChildOfClass"Attachment"
local a5=a4 and aZ[a4.Name]
if a3 and a4 and a5 then


local a6=a5.WorldCFrame*a4.CFrame:Inverse()
local a7=a6*a3.CFrame:Inverse()
for a8,a9 in ipairs(a2:GetDescendants())do
if a9:IsA"BasePart"then a9.CFrame=a7*a9.CFrame end
end
a_=a_+1
end
a2.Parent=aY
end
end

for a0,a1 in ipairs(aY:GetDescendants())do
if a1:IsA"BasePart"then a1.Anchored=true;a1.CanCollide=false end
end
return aY,a_
end

local function loneModel(aX)
local aY=Instance.new"Model"
aY.Name=aX.Name
for aZ,a_ in ipairs(aX:GetChildren())do a_:Clone().Parent=aY end
local aZ=0
for a_,a0 in ipairs(aY:GetDescendants())do
if a0:IsA"BasePart"then
a0.Anchored=true
a0.CanCollide=false
aZ=aZ+1
end
end
if aZ==0 then aY:Destroy();return nil end
return aY
end













local function aimRig(aX,aY)
aY:PivotTo(CFrame.new(0,0,0))
local aZ=Instance.new"Camera"
aZ.Parent=aX
aX.CurrentCamera=aZ
aZ.CFrame=CFrame.new(Vector3.new(0,1,-5),Vector3.new(0,0,0))
return true
end

local function aimLone(aX,aY)
local aZ,a_,a0=pcall(function()return aY:GetBoundingBox()end)
if not aZ or typeof(a_)~="CFrame"or typeof(a0)~="Vector3"then return false end
local a1=math.max(a0.X,a0.Y,a0.Z)
if a1<=0 or a1>200 then return false end
aY:PivotTo(CFrame.new(0,0,0))
local a2=Instance.new"Camera"
a2.Parent=aX
aX.CurrentCamera=a2


local a3=a1*0.85+1
a2.CFrame=CFrame.new(Vector3.new(0,a1*0.05,-a3),Vector3.new(0,0,0))
return true
end

local aX={}



function aX.Open()

if not(ak and al and am)then
Notify"Cosmetic Getter works in the lobby only"
return
end
if af._CosmeticGetterStop then pcall(af._CosmeticGetterStop)end
ai=false
ah={}
af._CosmeticGetterStop=stop

local aY=ac:WaitForChild"PlayerGui"





for aZ,a_ in ipairs{aY,game:GetService"CoreGui",gethui and gethui()or nil}do
for a0,a1 in ipairs{"ApelCosmeticGetter","ApelCratePreview"}do
local a2=a_ and a_:FindFirstChild(a1)
while a2 do
pcall(function()a2:Destroy()end)
pcall(function()a2.Parent=nil end)
a2=a_:FindFirstChild(a1)
if a2 and a2.Parent==a_ then break end
end
end
end

local aZ=new("ScreenGui",{
Name="ApelCosmeticGetter",
ResetOnSpawn=false,
IgnoreGuiInset=true,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
DisplayOrder=1200,
Parent=aY,
})









local a_=new("Frame",{
Name="root",
Size=UDim2.fromOffset(760,470),
Position=UDim2.new(0.5,-380,0.5,-235),
BackgroundColor3=aE,
BackgroundTransparency=aO,
BorderSizePixel=0,
Active=true,
Draggable=true,
Parent=aZ,
},{corner(6)})


local a0=new("Frame",{
Name="header",
Size=UDim2.new(1,0,0,30),
BackgroundColor3=aF,
BackgroundTransparency=aP,
BorderSizePixel=0,
Parent=a_,
},{corner(6)})

new("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0,0,1,-1),
BackgroundColor3=aG,
BorderSizePixel=0,
Parent=a0,
})

new("Frame",{
Size=UDim2.fromOffset(14,14),
Position=UDim2.fromOffset(9,8),
BackgroundColor3=aI,
BorderSizePixel=0,
Parent=a0,
},{corner(7)})

new("TextLabel",{
Size=UDim2.fromOffset(200,30),
Position=UDim2.fromOffset(30,0),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=13,
RichText=true,
TextColor3=aJ,
TextXAlignment=Enum.TextXAlignment.Left,
Text='Cosmetic <font color="#E28413">Getter</font>',
Parent=a0,
})

local a1=new("TextLabel",{
Name="count",
Size=UDim2.fromOffset(240,30),
Position=UDim2.new(1,-274,0,0),
BackgroundTransparency=1,
Font=Enum.Font.Gotham,
TextSize=11,
TextColor3=aK,
TextXAlignment=Enum.TextXAlignment.Right,
Text="",
Parent=a0,
})

local a2=new("TextButton",{
Size=UDim2.fromOffset(22,18),
Position=UDim2.new(1,-28,0,6),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=12,
TextColor3=aK,
Text="X",
Parent=a0,
})

a2.Activated:Connect(function()
stop()
pcall(function()aZ:Destroy()end)
end)


local a3=new("Frame",{
Name="rail",
Size=UDim2.new(0,134,1,-30),
Position=UDim2.fromOffset(0,30),
BackgroundTransparency=1,
Parent=a_,
})

new("TextLabel",{
Size=UDim2.new(1,-20,0,18),
Position=UDim2.fromOffset(12,10),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=aJ,
TextXAlignment=Enum.TextXAlignment.Left,
Text="COSMETIC TYPE",
Parent=a3,
})



local a4={type="armors",rarity={},search="",picks={},nPicks=0,case=nil}

local a5,a6={},{}
local a7,a8,a9

for b,ba in ipairs(aC)do
local bb=new("TextButton",{
Size=UDim2.new(1,-20,0,22),
Position=UDim2.fromOffset(10,34+(b-1)*25),
BackgroundColor3=aI,
BackgroundTransparency=1,
BorderSizePixel=0,
Font=Enum.Font.Gotham,
TextSize=12,
TextColor3=aK,
TextXAlignment=Enum.TextXAlignment.Left,
Text="  "..ba.title,
Parent=a3,
},{corner(4)})
a5[ba.key]=bb
bb.Activated:Connect(function()
a4.type=ba.key
a7()
end)
end


local b=new("Frame",{
Name="body",
Size=UDim2.new(1,-134,1,-30),
Position=UDim2.fromOffset(134,30),
BackgroundTransparency=1,
Parent=a_,
})

local ba=new("TextLabel",{
Name="pageTitle",
Size=UDim2.new(1,-24,0,20),
Position=UDim2.fromOffset(0,8),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=14,
TextColor3=aJ,
TextXAlignment=Enum.TextXAlignment.Left,
Text="Armors",
Parent=b,
})



local function sectionHead(bb,bc,bd)
new("TextLabel",{
Size=UDim2.fromOffset(12,14),
Position=UDim2.fromOffset(0,bc),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=aK,
Text="-",
Parent=b,
})
local be=new("TextLabel",{
Size=UDim2.fromOffset(200,14),
Position=UDim2.fromOffset(14,bc),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=12,
TextColor3=aJ,
TextXAlignment=Enum.TextXAlignment.Left,
Text=bb,
Parent=b,
})
be.Size=UDim2.fromOffset(be.TextBounds.X+8,14)
new("Frame",{
Size=UDim2.new(1,-(be.Position.X.Offset+be.Size.X.Offset+24),0,1),
Position=UDim2.fromOffset(be.Position.X.Offset+be.Size.X.Offset,bc+7),
BackgroundColor3=aG,
BorderSizePixel=0,
Parent=b,
})
end

sectionHead("Filter",36)

local bb=new("TextBox",{
Name="search",
Size=UDim2.fromOffset(200,24),
Position=UDim2.fromOffset(0,56),
BackgroundColor3=aH,
BackgroundTransparency=aR,
BorderSizePixel=0,
Font=Enum.Font.Gotham,
TextSize=12,
TextColor3=aJ,
PlaceholderText="Search",
PlaceholderColor3=aL,
ClearTextOnFocus=false,
Text="",
Parent=b,
},{corner(4),new("UIPadding",{PaddingLeft=UDim.new(0,9)})})

for bc,bd in ipairs(aB)do
local be=new("TextButton",{
Size=UDim2.fromOffset(74,24),
Position=UDim2.fromOffset(208+(bc-1)*78,56),
BackgroundColor3=aH,
BackgroundTransparency=aR,
BorderSizePixel=0,
Font=Enum.Font.GothamBold,
TextSize=10,
TextColor3=ay[bd],
Text=bd:upper(),
Parent=b,
},{corner(4)})
a6[bd]=be
be.Activated:Connect(function()
a4.rarity[bd]=(not a4.rarity[bd])or nil
a7()
end)
end

sectionHead("Items",92)


local bc=136
local bd=ae and 150 or 40

local be=new("ScrollingFrame",{
Name="grid",
Size=UDim2.new(1,-24,1,-226),
Position=UDim2.fromOffset(0,110),
BackgroundColor3=aG,
BackgroundTransparency=aQ,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollBarThickness=4,
ScrollBarImageColor3=aL,
ScrollingDirection=Enum.ScrollingDirection.Y,
Parent=b,
},{
corner(5),
new("UIGridLayout",{
CellSize=UDim2.fromOffset(bc,bd),
CellPadding=UDim2.fromOffset(6,6),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
new("UIPadding",{
PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),
PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,8),
}),
})

sectionHead("Auto roll",0)
for bf,bg in ipairs(b:GetChildren())do
if(bg:IsA"TextLabel"and bg.Text=="Auto roll")
or(bg:IsA"TextLabel"and bg.Text=="-"and bg.Position==UDim2.fromOffset(0,0))
or(bg:IsA"Frame"and bg.Position.Y.Offset==7 and bg.Position.Y.Scale==0 and bg.Size.Y.Offset==1)then
bg.Position=UDim2.new(0,bg.Position.X.Offset,1,-104+bg.Position.Y.Offset)
end
end

local bf=new("Frame",{
Name="rollCard",
Size=UDim2.new(1,-24,0,66),
Position=UDim2.new(0,0,1,-80),
BackgroundColor3=aG,
BackgroundTransparency=aQ,
BorderSizePixel=0,
Parent=b,
},{corner(5)})

local bg=new("TextLabel",{
Name="picked",
Size=UDim2.new(1,-220,0,18),
Position=UDim2.fromOffset(12,10),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=13,
TextColor3=aK,
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
Text="Nothing selected",
Parent=bf,
})

local bh=new("TextLabel",{
Name="status",
Size=UDim2.new(1,-220,0,30),
Position=UDim2.fromOffset(12,30),
BackgroundTransparency=1,
Font=Enum.Font.Gotham,
TextSize=11,
TextColor3=aK,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
TextWrapped=true,
Text="Pick a cosmetic, then press Start.",
Parent=bf,
})

local function status(bi,bj)
bh.Text=bi
bh.TextColor3=bj or aK
end

local bi=new("TextButton",{
Name="roll",
Size=UDim2.fromOffset(184,42),
Position=UDim2.new(1,-196,0,12),
BackgroundColor3=aI,
BorderSizePixel=0,
Font=Enum.Font.GothamBold,
TextSize=13,
TextColor3=Color3.fromRGB(26,26,26),
Text="Start Auto Roll",
Parent=bf,
},{corner(5)})



local bj={}
local bk=0


function a9(bl)
if not bl.box then return end
local bm=bl.item
local bn=bl.frame:FindFirstChildOfClass"UIStroke"
if aS[bm.name]then
bl.tick.Text="✓"
bl.tick.TextColor3=aM
bl.box.BackgroundTransparency=1
bl.title.TextColor3=aM
if bn then bn.Color=aM;bn.Transparency=0.35;bn.Thickness=1 end
elseif a4.picks[bm.name]then
bl.tick.Text="✓"
bl.tick.TextColor3=Color3.fromRGB(26,26,26)
bl.box.BackgroundColor3=aI
bl.box.BackgroundTransparency=0
bl.title.TextColor3=aJ
if bn then bn.Color=aI;bn.Transparency=0;bn.Thickness=1 end
else
bl.tick.Text=""
bl.box.BackgroundColor3=aH
bl.box.BackgroundTransparency=0.15
bl.title.TextColor3=aJ
if bn then bn.Color=ay[bm.rarity]or aK;bn.Transparency=0.4;bn.Thickness=1 end
end
end

local function refreshPicked()
local bl={}
for bm in pairs(a4.picks)do bl[#bl+1]=bm end
table.sort(bl)
a4.nPicks=#bl
if#bl==0 then
bg.Text="Nothing selected"
bg.TextColor3=aK
elseif#bl==1 then
local bm=a4.picks[bl[1] ]
bg.Text=("%s  ·  %s  ·  %s"):format(bm.name,bm.type,bm.rarity)
bg.TextColor3=ay[bm.rarity]or aJ
else
bg.Text=("%d selected  ·  %s"):format(#bl,table.concat(bl,", "))
bg.TextColor3=aJ
end
end

local function selectItem(bl,bm)

if aS[bl.name]then
status(("You already own %s."):format(bl.name),aM)
return
end
if a4.picks[bl.name]then
a4.picks[bl.name]=nil
else
a4.picks[bl.name]=bl
end
a9(bm)
refreshPicked()
a8()
end

local function makeCard(bl,bm)
local bn=ay[bl.rarity]or aJ
local bo=new("TextButton",{
Name="card-"..bl.name,
LayoutOrder=bm,
BackgroundColor3=aH,
BackgroundTransparency=aR,
BorderSizePixel=0,
AutoButtonColor=false,
Text="",
ClipsDescendants=true,
Parent=be,
},{corner(6),stroke(bn,1)})

if not ae then


local bp=new("Frame",{
Name="box",
Size=UDim2.fromOffset(13,13),
Position=UDim2.fromOffset(8,13),
BackgroundColor3=aH,
BackgroundTransparency=0.15,
BorderSizePixel=0,
Parent=bo,
},{corner(3),stroke(aK,1,0.5)})

local bq=new("TextLabel",{
Name="tick",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=Color3.fromRGB(26,26,26),
Text="",
Parent=bp,
})

local br=new("TextLabel",{
Name="title",
Size=UDim2.new(1,-34,1,0),
Position=UDim2.fromOffset(28,0),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=aJ,
TextWrapped=true,
Text=bl.name,
Parent=bo,
})

local bs={
item=bl,frame=bo,box=bp,tick=bq,title=br,
built=true,queued=false,
}

bo.Activated:Connect(function()selectItem(bl,bs)end)
bj[#bj+1]=bs
a9(bs)
return bs
end

local bp=new("Frame",{
Name="well",
Size=UDim2.fromOffset(bc-12,96),
Position=UDim2.fromOffset(6,6),
BackgroundColor3=Color3.fromRGB(28,28,33),
BorderSizePixel=0,
ClipsDescendants=true,
Parent=bo,
},{corner(4)})

local bq=new("ViewportFrame",{
Name="vp",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Ambient=Color3.fromRGB(190,190,190),
LightColor=Color3.fromRGB(255,255,255),
LightDirection=Vector3.new(-0.4,-1,-0.6),
Visible=false,
Parent=bp,
})

local br=new("ImageLabel",{
Name="img",
Size=UDim2.fromScale(0.94,0.94),
Position=UDim2.fromScale(0.03,0.03),
BackgroundTransparency=1,
ScaleType=Enum.ScaleType.Fit,
Image="",
Visible=false,
Parent=bp,
})

local bs=new("TextLabel",{
Name="spin",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=aK,
Text="…",
Parent=bp,
})

new("TextLabel",{
Name="title",
Size=UDim2.new(1,-8,0,40),
Position=UDim2.fromOffset(4,106),
BackgroundTransparency=1,
Font=Enum.Font.GothamBold,
TextSize=11,
TextColor3=aJ,
TextWrapped=true,
TextYAlignment=Enum.TextYAlignment.Top,
Text=bl.name,
Parent=bo,
})

local bt={item=bl,frame=bo,vp=bq,img=br,spin=bs,built=false,queued=false}
bo.Activated:Connect(function()selectItem(bl,bt)end)
bj[#bj+1]=bt
return bt
end






local function fillFlat(bl)
local bm=bl.item
if bm.type=="titles"then
bl.spin.Text=bm.name
bl.spin.TextSize=13
bl.spin.TextWrapped=true
bl.spin.TextColor3=ay[bm.rarity]or aJ
bl.built=true
return true
end
if bm.imageId~=""then
bl.img.Image=bm.imageId
bl.img.Visible=true
bl.spin.Visible=false
bl.built=true
return true
end
return false
end

local function fillModel(bl)
local bm=bl.item
local bn=fetchAsset(bm)







elevate()
if ai or not bl.frame.Parent then return end
if not bn then
bl.spin.Text="no model"
bl.spin.TextColor3=aN
return
end



local bo,bp=false
if bm.type=="armors"then
local bq,br=wearOnRig(bn)
if bq and br>0 then
bp,bo=bq,true
elseif bq then
bq:Destroy()
end
end
if not bp then bp=loneModel(bn)end
if not bp then
bl.spin.Text="empty"
bl.spin.TextColor3=aN
return
end

bp.Parent=bl.vp
if(bo and aimRig(bl.vp,bp))or((not bo)and aimLone(bl.vp,bp))then
bl.spin.Visible=false
bl.vp.Visible=true
else
bp:Destroy()
bl.spin.Text="cannot render"
bl.spin.TextColor3=aN
end
end

local bl=false
local bm={}
local bn=false







local function inView(bo)
local bp=bo.frame.AbsolutePosition.Y-be.AbsolutePosition.Y
return bp>-(bd+8)and bp<be.AbsoluteSize.Y+bd
end

local function unload(bo)
if not bo.built or not bo.vp then return end
bo.built=false
bo.vp.Visible=false
pcall(function()bo.vp:ClearAllChildren()end)
if bo.item.imageId==""and bo.item.type~="titles"then
bo.spin.Visible=true
bo.spin.Text="…"
bo.spin.TextColor3=aK
end
end

local function pump(bo)
if bn then return end
bn=true
task.spawn(function()
elevate()
while not ai and bo==bk do
local bp=table.remove(bm,1)
if not bp then break end
if bp.frame.Parent and inView(bp)and not bp.built then
local bq,br=pcall(fillModel,bp)
elevate()
if not bq then
bp.spin.Text="failed"
bp.spin.TextColor3=aN
if not bl then
bl=true
ad.Log("cosmetic: модель не собралась —",bp.item.name,tostring(br))
end
end
bp.built=true
task.wait()
elevate()
end
end
bn=false
end)
end

local function refreshVisible()
if ai or not ae then return end
local bo=bk
for bp,bq in ipairs(bj)do
if not bq.frame.Parent then

elseif inView(bq)then
if not bq.built and not bq.queued then
bq.queued=true
bm[#bm+1]=bq
end
elseif bq.built then
unload(bq)
bq.queued=false
end
end
pump(bo)
end



local function startLoader(bo)
if not ae then return end
for bp,bq in ipairs(bj)do fillFlat(bq)end
task.defer(function()
elevate()
if bo==bk then refreshVisible()end
end)
end

ah[#ah+1]=be:GetPropertyChangedSignal"CanvasPosition":Connect(refreshVisible)

function a7()
bk=bk+1
for bo,bp in ipairs(bj)do pcall(function()bp.frame:Destroy()end)end
bj={}
bm={}



for bo,bp in pairs(a5)do
local bq=(bo==a4.type)
bp.BackgroundTransparency=bq and 0 or 1
bp.TextColor3=bq and Color3.fromRGB(26,26,26)or aK
bp.Font=bq and Enum.Font.GothamBold or Enum.Font.Gotham
if bq then ba.Text=bp.Text:gsub("^%s+","")end
end
local bo=next(a4.rarity)~=nil
for bp,bq in pairs(a6)do
local br=(not bo)or a4.rarity[bp]
bq.BackgroundTransparency=br and 0 or 0.55
bq.TextTransparency=br and 0 or 0.5
end

local bp=a4.search:lower()
local bq=0
for br,bs in ipairs(aD)do
local bt=bs.type==a4.type
local bu=(not bo)or a4.rarity[bs.rarity]
local bv=bp==""or bs.name:lower():find(bp,1,true)~=nil
if bt and bu and bv then
bq=bq+1
makeCard(bs,bq)
end
end

local br=0
for bs,bt in ipairs(bj)do
a9(bt)
if aS[bt.item.name]then br=br+1 end
end
a1.Text=("%d shown of %d  ·  %d owned"):format(bq,#aD,br)
startLoader(bk)
end

bb:GetPropertyChangedSignal"Text":Connect(function()
a4.search=bb.Text
a7()
end)


local bo=0



local bp=0

function a8()
bp=bp+1
local bq=bp
a4.case=nil
if a4.nPicks==0 then
status("Pick one or more cosmetics, then press Start.",aK)
return
end
status("Working out the best crate...",aK)
task.spawn(function()
elevate()
local br,bs,bt=bestCaseFor(a4.picks)
if ai or bq~=bp then return end
a4.case=br
if not br then
status("None of the picks are in a crate pool right now.",aN)
elseif bt<a4.nPicks then
status(("%s crate - %.3f%% per roll, covers %d of %d picks. Press Start."):format(
br:upper(),bs,bt,a4.nPicks),aJ)
else
status(("%s crate - %.3f%% per roll. Press Start."):format(br:upper(),bs),aJ)
end
end)
end
















local bq=false
local br









local function setRollButton()
if bq then
bi.Text="Stop"
bi.BackgroundColor3=aN
bi.TextColor3=Color3.fromRGB(255,255,255)
else
bi.Text="Start Auto Roll"
bi.BackgroundColor3=aI
bi.TextColor3=Color3.fromRGB(22,22,22)
end
end




local bs=0.35

local function rollLoop()
task.spawn(function()
elevate()
local bt=0







local bu=bs
local bv=0
while bq and not ai and ag.armed and next(ag.picks or{})do
bt=bt+1


local bw,bx
bx=am.OnClientEvent:Connect(function(by)
if type(by)=="table"and bw==nil then bw=by end
end)
al:FireServer(a4.case)




local by=0
while bw==nil and by<6 and bq and not ai do
by=by+task.wait()
end
pcall(function()bx:Disconnect()end)
elevate()



if bw==nil then
bv=bv+1
if bv>=3 then
br="Server stopped answering purchases."
break
end
bu=math.min(bu*2,5)
bt=bt-1
status(("No answer from the server, waiting %.1fs..."):format(bu),aI)
task.wait(bu)
elevate()
continue
end
bv=0

if not bw.success then
local bz=tostring(bw.message or"")
local bA=bz:lower()



if bA:find"slow"or bA:find"wait"or bA:find"cooldown"
or bA:find"too fast"or bA:find"try again"then
bu=math.min(bu*2,5)
bt=bt-1
status(("Server asked to slow down, waiting %.1fs (roll %d)"):format(bu,bt),aI)
task.wait(bu)
elevate()
continue
end
br="Server refused: "..bz
break
end


if bu>bs then bu=math.max(bs,bu*0.7)end






local bz=ag.picks[bw.cosmetic]~=nil
local bA,bB=bw.cosmetic,bw.cosmeticType
if not bz then
for bC,bD in pairs(ag.picks)do
if bC~=bw.cosmetic then bA,bB=bD.name,bD.type break end
end
end
ag.selfCall=true
ak:FireServer(bA,bB,bw.transactionId)
ag.selfCall=false

bo=bt
status(("Roll %d - rolled %s%s"):format(
bt,tostring(bw.cosmetic),bz and"   <<< MATCH, waiting for the award"or""),
bz and aM or aI)

if bz then


ag.picks[bw.cosmetic]=nil
a4.picks[bw.cosmetic]=nil
aS[bw.cosmetic]=true
task.defer(function()
elevate()
if ai then return end
for bC,bD in ipairs(bj)do
if bD.item.name==bw.cosmetic then a9(bD)end
end
refreshPicked()
end)
if not next(ag.picks)then
br=("Got %s on roll %d - all picks done."):format(tostring(bw.cosmetic),bt)
break
end
end
task.wait(bu)
elevate()
end

bq=false
task.defer(function()
elevate()
if ai or not aZ.Parent then return end
setRollButton()
if br then status(br,br:find"Hit "and aM or aI)end
br=nil
end)
end)
end

bi.Activated:Connect(function()
if bq then
bq=false
br="Stopped."
return
end
if not ag.hooked then
status("No hookmetamethod in this executor - auto roll would burn gems, refusing.",aN)
return
end
if a4.nPicks==0 then
status("Pick at least one cosmetic first.",aI)
return
end
if not a4.case then
status("Still working out which crate to spin - one moment.",aI)
return
end



local bt={}
for bu,bv in pairs(a4.picks)do bt[bu]=bv end
ag.picks=bt
ag.armed=true
bo=0
bq=true
setRollButton()
status(("Rolling %s crate for %d pick%s..."):format(
a4.case:upper(),a4.nPicks,a4.nPicks==1 and""or"s"),aI)
rollLoop()
end)








if as then
ah[#ah+1]=as.OnClientEvent:Connect(function(bt)
if ai or type(bt)~="string"then return end
if not bt:lower():find"previous crate awarded"then return end
task.defer(function()
elevate()
if ai or not aZ.Parent then return end
bq=false
setRollButton()
status("STOPPED: the server closed the previous deal itself ("..bt..") - that one cost gems.",aN)
end)
end)
end


if aq then
ah[#ah+1]=aq.OnClientEvent:Connect(function(...)
if ai or not ag.armed then return end
local bt=ag.picks or{}
local bu
for bv,bw in ipairs{...}do
if type(bw)=="string"and bt[bw]then bu=bw break end
if type(bw)=="table"then
for bx,by in pairs(bw)do
if type(by)=="string"and bt[by]then bu=by break end
end
if bu then break end
end
end
if not bu then return end
bt[bu]=nil
a4.picks[bu]=nil
aS[bu]=true
if not next(bt)then ag.armed=false end
task.defer(function()
elevate()
if ai or not aZ.Parent then return end
for bv,bw in ipairs(bj)do
if bw.item.name==bu then a9(bw)end
end
refreshPicked()
if not next(bt)then
bq=false
setRollButton()
status(("Obtained %s after %d rolls. All picks done."):format(bu,bo),aM)
else
status(("Obtained %s after %d rolls. Still hunting %d more."):format(
bu,bo,a4.nPicks),aM)
end
end)
end)
end


setRollButton()
a7()



task.spawn(function()
elevate()
if loadOwned()and not ai then



a7()
end
end)

if#aD==0 then
status("Cosmetic catalog is empty - are you in the lobby?",aN)
elseif not ag.hooked then
status("No hookmetamethod in this executor - auto roll would burn gems, it is disabled.",aN)
else
ad.Log("cosmetic: каталог прочитан, позиций —",#aD)
end

end

return aX end function a.U():typeof(__modImpl())local aa=a.cache.U if not aa then aa={c=__modImpl()}a.cache.U=aa end return aa.c end end do local function __modImpl()

local aa=a.n()
local ab=a.b()
local ac=a.R()
local ad=a.r()
local ae=a.s()
local af=a.l()






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
for al,am in ipairs(ak:GetDescendants())do
if am:IsA"TextLabel"or am:IsA"TextButton"then
local an=am.Text
if an==ah or an==ai then
if ag[am]==nil then ag[am]=an end
am.Text="Hidden"
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
if not al then ae.RestoreNoclip()end
end,
}


local al=ah.Perf

al:Toggle{
Name="Performance Mode",
Desc="strips materials, textures and particles — rejoin to restore",
Default=false,Flag="PerformanceMode",
Callback=function(am)
S.perfMode=am


if am then task.spawn(ab.Boost)end
end,
}

al:Toggle{
Name="Ultra Performance Mode",
Desc="everything above plus 3D rendering off and a black screen",
Default=false,Flag="UltraPerformanceMode",
Callback=function(am)
S.ultraPerf=am
if am then
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



local am=ai:Label"Loading..."

ai:Toggle{
Name="Hide Name",
Desc="blanks your own nameplate and every label in the interface that shows your nick",
Default=false,Flag="HideName",
Callback=function(an)
S.hideName=an
if an then hideNames()else restoreNames()end
end,
}



spawnLoop(function()
while not _apelStopped do
task.wait(2)
if S.hideName then pcall(hideNames)end

pcall(function()
local an=ac.EquippedWeapon()
local ao=aa.Items()
am:Set(table.concat({
("Level <b>%d</b>   ·   XP %s/%s"):format(aa.Level(),
tostring(aa.Val("XP",0)),tostring(aa.Val("XPNeeded",0))),
("Gold %s   ·   Gems %s   ·   Points %d"):format(
tostring(aa.Gold()),tostring(aa.Gems()),aa.SkillPoints()),
("Physical %s   ·   Spell %s   ·   Stamina %s"):format(
tostring(aa.Val("physicalPower",0)),tostring(aa.Val("spellPower",0)),
tostring(aa.Val("stamina",0))),
("Weapon %s   ·   %d item%s in the bag"):format(
an and an.name or"—",#ao,#ao==1 and""or"s"),
},"\n"))
end)
end
end)



aj:Toggle{Name="Enable Webhook",Default=false,Flag="WebhookOn",
Desc="nothing is posted while this is off",
Callback=function(an)S.webhookOn=an end}

aj:Input{Name="Webhook URL",Default="",Placeholder="https://discord.com/api/webhooks/...",
Flag="WebhookURL",Callback=function(an)S.webhookUrl=tostring(an or"")end}

aj:Dropdown{
Name="Ping On Rarity",
Desc="ping only when the run dropped one of these; leave empty to ping every report",
Options=(function()
local an={}
for ao,ap in ipairs(aa.RARITIES)do
an[#an+1]=('<font color="%s">%s</font>'):format(aa.RARITY_COLOR[ap]or"#FFFFFF",ap)
end
return an
end)(),
Multi=true,
Flag="WebhookPingRarities",
Callback=function(an)
local ao={}
for ap,aq in pairs(an or{})do
if aq then
local as=tostring(ap):gsub("<[^>]->","")
ao[(as:gsub("^%s+",""):gsub("%s+$",""))]=true
end
end
S.pingRarities=ao
end,
}

aj:Input{Name="Discord User ID",Default="",Placeholder="ping you on every post",
Numeric=true,Flag="WebhookUserId",
Callback=function(an)S.webhookUserId=tostring(an or"")end}

aj:Toggle{Name="Mention @everyone",Default=false,Flag="WebhookEveryone",
Callback=function(an)S.webhookEveryone=an end}



aj:Button{Name="Send Test Post",Text="Send",Callback=function()
task.spawn(function()
if tostring(S.webhookUrl or"")==""then return Notify"Paste a webhook URL first"end
local an,ao=ad.Test()
if ao then
Notify("Webhook failed: "..tostring(ao))
else
Notify(S.webhookOn and("Webhook OK (HTTP "..tostring(an)..")")
or("Webhook OK (HTTP "..tostring(an)..") — posting is still off"))
end
end)
end}

aj:SubLabel"Send Test Post works even while Enable Webhook is off, so you can check the URL first."

















if IN_LOBBY then
local an=ah.Cosmetic

an:SubLabel"Opens a separate window: pick any number of cosmetics, the hub spins the crate that covers them best. A wrong roll is refused, so it costs no gems."

an:Button{
Name="Cosmetic Getter",
Text="Open",
Callback=function()
local ao,ap=pcall(function()a.U()
.Open()
end)
if not ao then
Notify"Cosmetic Getter failed to open"
af.Log("cosmetic: окно не открылось —",tostring(ap))
end
end,
}
end
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















local ag={Shared=
{"shared","account"},
["Per Account (only this acc)"]={"perUser","account"},
["Per Account (all accs)"]={"perUser","all"},
}

ab.SettingsSection4:Dropdown{
Name="Auto Save Mode",
Desc='Shared \u{2014} one config for the game, Per Account \u{2014} your own. All accs \u{2014} sets it for every account on this PC'
,
Options={"Shared","Per Account (only this acc)","Per Account (all accs)"},
Default=(aa:GetConfigMode()~="perUser"and"Shared")
or(aa:GetConfigModeScope()=="all"and"Per Account (all accs)")
or"Per Account (only this acc)",
Flag="ConfigMode",
IgnoreConfig=true,
Callback=function(ah)
local ai=ag[ah]or ag.Shared
aa:SetConfigMode(ai[1],ai[2])









if aa:IsLoadingConfig()then return end
local aj=aa:GetAutoload()
if aj then aa:SaveConfig(aj)end
end
}




local ah=ab.SettingsSection4:Section("Config Export",{Open=false})
local ai=ab.SettingsSection4:Section("Config Import",{Open=false})



ah:Button{
Name="Copy Config to Clipboard",
Text="Copy",
Callback=function()
local aj=game:GetService"HttpService"
local ak,al=pcall(function()
return aj:JSONEncode(aa:GetConfig())
end)
if not ak then ac"Could not encode the config"return end
local am=setclipboard or toclipboard
if not am then ac"This executor has no clipboard"return end
am(af..tostring(ae).."\n"..al)
ac"Config copied to clipboard"
end
}

ah:Button{
Name="Export Config",
Text="Upload and copy link",
Callback=function()
local aj=game:GetService"HttpService"
local ak,al=pcall(function()
return aj:JSONEncode(aa:GetConfig())
end)
if not ak then ac"Could not encode the config"return end
local am=af..tostring(ae).."\n"..al
local an=httpRequest()
local ao=setclipboard or toclipboard

task.spawn(function()
local ap
if an then
pcall(function()
local aq=an{Url="https://paste.rs/",Method="POST",
Headers={["Content-Type"]="text/plain"},Body=am}
local as=aq and(aq.Body or aq.body)
if as then ap=as:match"(https://paste%.rs/%S+)"end
end)
end
if ap then
if ao then ao(ap)end
ac("Link copied:\n"..ap)
elseif ao then
ao(am)
ac"Upload failed, config copied to clipboard instead"
else
ac"This executor has no HTTP and no clipboard"
end
end)
end
}

configImportURL=""
ai:Input{
Name="Import URL",
Placeholder="paste.rs or .json link",
Flag="ConfigImportURL",
IgnoreConfig=true,
Callback=function(aj)configImportURL=aj or""end
}

ai:Button{
Name="Import Config",
Text="Download and apply",
Callback=function()
local aj=tostring(configImportURL or""):gsub("^%s+",""):gsub("%s+$","")
if aj==""then ac"Paste a config link first"return end
local ak=httpRequest()
if not ak then ac"This executor has no HTTP"return end
task.spawn(function()
local al,am=pcall(ak,{Url=aj,Method="GET",
Headers={["User-Agent"]="ApelHub-ConfigImport"}})
local an=al and am and(am.Body or am.body)
if not an or an==""then ac"Import failed: nothing came back"return end
local ao=an:match"^%-%-%s*APELCFG:([^\r\n]+)"
an=an:gsub("^%-%-[^\r\n]*\r?\n","")
local ap,aq=pcall(function()
return game:GetService"HttpService":JSONDecode(an)
end)
if not(ap and type(aq)=="table"and type(aq.objects)=="table")then
ac"Import failed: not a valid config"
return
end


aa:LoadConfig(aq)
ac(("Imported %d settings%s"):format(#aq.objects,
ao and(" from "..ao)or""))
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
local aj=false
pcall(function()
local ak=aa:GetAutoload()



if ak then aj=aa:DeleteConfig(ak)end
aa:RemoveAutoload()
end)
ac(aj and"Config deleted, unloading"
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
local am=0
if ak<24 then
if ak==0 and al>0 then am=100 end
local an=100

for ao=1,math.min(23,al-1)do
an=an*1.06+50
if ao>=ak then am=am+math.floor(an)end
end
end
local an=ak<24 and 24 or(ak>466 and 466 or ak)
local ao=al<24 and 24 or(al>466 and 466 or al)
am=am+(ao-an)*(110*(ao+an)-2445)
an=ak<466 and 466 or ak
ao=al<466 and 466 or al
am=am+(ao-an)*100000
return am
end


local function commas(ak)
local al=tostring(math.floor(ak))
local am=al:reverse():gsub("(%d%d%d)","%1 "):reverse()
return(am:gsub("^%s+",""))
end



local function num(ak)
if not ak then return nil end
return tonumber((tostring(ak.Text):gsub("[^%d%-]","")))
end











local ak={"inventory","sellShop","blacksmith","tradingGui"}

local function openMenu()
local al=ad:FindFirstChild"PlayerGui"
if not al then return nil,nil end
for am,an in ipairs(ak)do
local ao=al:FindFirstChild(an)
local ap=ao and ao:FindFirstChild"itemStatFrame"
if ap and ap.Visible then return ao,ap end
end
return nil,nil
end


local function readTooltip()local
al, am=openMenu()
if not am then return nil end

for an,ao in ipairs{"weaponMain","armorMain","petMain"}do
local ap=am:FindFirstChild(ao)
if ap and ap.Visible then
local aq=ap:FindFirstChild"upgrades"
local as,av=tostring(aq and aq.Text or""):match"(%d+)%s*/%s*(%d+)"
if not as then return nil end
return{
card=ap,
name=tostring(ap:FindFirstChild"name"and ap.name.Text or"?"),
done=tonumber(as),max=tonumber(av),
phys=num(ap:FindFirstChild"physicalDamage"),
spell=num(ap:FindFirstChild"spellPower"),
health=num(ap:FindFirstChild"health"),
}
end
end
return nil
end



return function()

local al=(gethui and gethui())or ad:WaitForChild"PlayerGui"
local am=al:FindFirstChild"ApelPredictor"
if am then am:Destroy()end

local an=Instance.new"ScreenGui"
an.Name="ApelPredictor"
an.ResetOnSpawn=false
an.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
an.DisplayOrder=50
an.Parent=al

local ao=Instance.new"Frame"
ao.Name="panel"
ao.BackgroundColor3=ae
ao.BackgroundTransparency=0.1
ao.BorderSizePixel=0
ao.Visible=false
ao.Size=UDim2.fromOffset(250,176)
ao.Parent=an

local ap=Instance.new"UICorner"
ap.CornerRadius=UDim.new(0,6)
ap.Parent=ao

local aq=Instance.new"UIStroke"
aq.Color=af
aq.Thickness=1
aq.Parent=ao

local as=Instance.new"Frame"
as.BackgroundColor3=af
as.BorderSizePixel=0
as.Size=UDim2.new(1,0,0,26)
as.Parent=ao
local av=ap:Clone()
av.Parent=as

local aw=Instance.new"Frame"
aw.BackgroundColor3=af
aw.BorderSizePixel=0
aw.Position=UDim2.new(0,0,1,-6)
aw.Size=UDim2.new(1,0,0,6)
aw.Parent=as

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
ax.Parent=as

local ay=Instance.new"Frame"
ay.BackgroundTransparency=1
ay.Position=UDim2.fromOffset(10,32)
ay.Size=UDim2.new(1,-20,1,-42)
ay.Parent=ao

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




local aK=select(1,openMenu())
local aL=aK and(aK:FindFirstChild"mainBackground"
or aK:FindFirstChild"Frame")
if not aL then return end



local aM=aL:FindFirstChild"ApelPredictorSettings"
if aM then aM:Destroy()end

aJ=Instance.new"Frame"
aJ.Name="ApelPredictorSettings"
aJ.BackgroundColor3=ae
aJ.BackgroundTransparency=0.1
aJ.BorderSizePixel=0
aJ.AnchorPoint=Vector2.new(0.5,1)
aJ.Position=UDim2.new(0.5,0,0,-6)
aJ.Size=UDim2.new(0.62,0,0,30)
aJ.Parent=aL

local aN=Instance.new"UICorner"
aN.CornerRadius=UDim.new(0,6)
aN.Parent=aJ
local aO=Instance.new"UIStroke"
aO.Color=af
aO.Parent=aJ

local aP=Instance.new"TextLabel"
aP.BackgroundTransparency=1
aP.FontFace=ai
aP.TextSize=14
aP.TextColor3=ag
aP.TextXAlignment=Enum.TextXAlignment.Left
aP.Position=UDim2.fromOffset(10,0)
aP.Size=UDim2.new(0.4,0,1,0)
aP.Text="Potential Predictor"
aP.Parent=aJ

local aQ=Instance.new"TextButton"
aQ.BackgroundColor3=af
aQ.BorderSizePixel=0
aQ.FontFace=ai
aQ.TextSize=13
aQ.TextColor3=Color3.new(1,1,1)
aQ.AnchorPoint=Vector2.new(1,0.5)
aQ.Position=UDim2.new(1,-10,0.5,0)
aQ.Size=UDim2.fromOffset(46,20)
aQ.Text="ON"
aQ.Parent=aJ
local aR=Instance.new"UICorner"
aR.CornerRadius=UDim.new(0,4)
aR.Parent=aQ

local aS=Instance.new"TextBox"
aS.BackgroundColor3=af
aS.BorderSizePixel=0
aS.FontFace=ai
aS.TextSize=13
aS.TextColor3=Color3.new(1,1,1)
aS.PlaceholderText="max"
aS.Text=""
aS.ClearTextOnFocus=false
aS.AnchorPoint=Vector2.new(1,0.5)
aS.Position=UDim2.new(1,-62,0.5,0)
aS.Size=UDim2.fromOffset(64,20)
aS.Parent=aJ
local aT=Instance.new"UICorner"
aT.CornerRadius=UDim.new(0,4)
aT.Parent=aS

local aU=Instance.new"TextLabel"
aU.BackgroundTransparency=1
aU.FontFace=ai
aU.TextSize=12
aU.TextColor3=ah
aU.TextXAlignment=Enum.TextXAlignment.Right
aU.AnchorPoint=Vector2.new(1,0.5)
aU.Position=UDim2.new(1,-130,0.5,0)
aU.Size=UDim2.fromOffset(120,20)
aU.Text="upgrade to:"
aU.Parent=aJ

regConn(aQ.MouseButton1Click:Connect(function()
aH=not aH
aQ.Text=aH and"ON"or"OFF"
aQ.TextColor3=aH and Color3.new(1,1,1)or ah
if not aH then ao.Visible=false end
end))

regConn(aS.FocusLost:Connect(function()
aI=tostring(aS.Text):gsub("[^%d]","")
aS.Text=aI
end))
end



local aK

local function refresh()
buildSettings()
if not aH then ao.Visible=false return end

local aL=readTooltip()
if not aL then ao.Visible=false aK=nil return end


local aM=tonumber(aI)
if not aM or aM>aL.max then aM=aL.max end
if aM<aL.done then aM=aL.done end

local aN=("%s|%d|%d|%s|%s|%s"):format(aL.name,aL.done,aM,
tostring(aL.phys),tostring(aL.spell),tostring(aL.health))
if aN~=aK then
aK=aN

aA.left.Text="Upgrades"
aA.right.Text=("%d  →  %d"):format(aL.done,aM)

local function fill(aO,aP,aQ)
if not aQ then aO.holder.Visible=false return end
aO.holder.Visible=true
local aR=aa.At(aQ,aL.done,aM)
aO.left.Text=aP
aO.right.Text=("%s  →  %s"):format(commas(aQ),commas(aR))
end

fill(aB,"Physical",aL.phys)
fill(aC,"Spell",aL.spell)
fill(aD,"Health",aL.health)

aG.Text=commas(upgradeCost(aL.done,aM))


local aO=2
if aL.phys then aO=aO+1 end
if aL.spell then aO=aO+1 end
if aL.health then aO=aO+1 end
ao.Size=UDim2.fromOffset(250,42+aO*22)
end


local aO=aL.card.AbsolutePosition
local aP=aL.card.AbsoluteSize
ao.Position=UDim2.fromOffset(aO.X+aP.X+8,aO.Y)
ao.Visible=true
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
local al,am
pcall(function()
if not isfile(ak)then return end
local an=game:GetService"HttpService":JSONDecode(readfile(ak))
if type(an)~="table"then return end
for ao,ap in ipairs(aj)do
if an.mode==ap then al=ap end
end
if type(an.best)=="boolean"then am=an.best end
end)
return al,am
end

local function saveChoice(al,am)
if not canFile()then return end
pcall(function()
if type(isfolder)=="function"and type(makefolder)=="function"
and not isfolder"ApelHub"then
makefolder"ApelHub"
end
writefile(ak,game:GetService"HttpService":JSONEncode{
mode=al,best=am,
})
end)
end

return function()
local al,am=loadChoice()
local an=al or"Off"
local ao=am~=false














local ap={"inventory","sellShop","blacksmith","tradingGui"}












local aq=setmetatable({},{__mode="k"})

local function findGrid(as)
for av,aw in ipairs(as:GetDescendants())do
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

local function gridIn(as)
local av=aq[as]
if av and av.Parent and av:IsDescendantOf(as)then
return av
end
local aw=findGrid(as)
aq[as]=aw
return aw
end


local function openMenus()
local as=ac:FindFirstChild"PlayerGui"
local av={}
if not as then return av end
for aw,ax in ipairs(ap)do
local ay=as:FindFirstChild(ax)
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







local function keyOf(as)
local av=as:FindFirstChild"itemType"
if not av then return nil end
local aw=av:FindFirstChild"uniqueItemNum"
if not aw then return nil end
return tostring(av.Value).."_"..tostring(aw.Value)
end

local function itemIndex()
local as={}
for av,aw in ipairs(aa.Items())do
as[aw.type.."_"..tostring(aw.num)]=aw
end
return as
end











local as={"physicalDamage","physicalPower"}

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
if an=="Rarity"then return ai[av.rarity]or 0 end
if an=="Level"then return tonumber(aw.levelReq)or 0 end
if an=="Phys"then return statOf(aw,as)end
if an=="Spell"then return tonumber(aw.spellPower)or 0 end
return 0
end

local av




local function applySort()
local aw=openMenus()
if#aw==0 then return end
local ax=(an~="Off")and itemIndex()or nil
for ay,az in ipairs(aw)do
av(az.grid,ax)
end
end







local aw=false

local function queueSort()
if an=="Off"or aw then return end
aw=true
task.defer(function()
aw=false
pcall(applySort)
end)
end

av=function(ax,ay)
if not ax then return end

if an=="Off"then


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
if ao then return aA.w>aB.w end
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
local aC=(aA==an)
aB.TextColor3=aC and af or ag
aB.BackgroundColor3=aC and ae or ad
end
if az.dir then az.dir.Text=ao and"best top"or"best last"end
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
local aK=Instance.new"TextButton"
aK.BackgroundColor3=ad
aK.BorderSizePixel=0
aK.AutoButtonColor=false
aK.FontFace=ah
aK.TextSize=13
aK.TextColor3=ag
aK.Text=aJ
aK.LayoutOrder=aI
aK.Size=UDim2.fromOffset(58,20)
aK.Parent=aF
local aL=Instance.new"UICorner"
aL.CornerRadius=UDim.new(0,4)
aL.Parent=aK
aH[aJ]=aK

regConn(aK.MouseButton1Click:Connect(function()
an=aJ
saveChoice(an,ao)
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
aI.Text=ao and"best top"or"best last"
aI.Parent=aB
local aJ=Instance.new"UICorner"
aJ.CornerRadius=UDim.new(0,4)
aJ.Parent=aI

regConn(aI.MouseButton1Click:Connect(function()
ao=not ao
saveChoice(an,ao)
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


if an~="Off"then applySort()end
end)
task.wait(0.5)
end
end)
end end function a.ab():typeof(__modImpl())local aa=a.cache.ab if not aa then aa={c=__modImpl()}a.cache.ab=aa end return aa.c end end do local function __modImpl()





















local aa=a.m()
local ab=a.l()

local ac=game:GetService"TeleportService"

local ad={}



ad.KEYS={"rare","epic","legendary"}

ad.CASE_LABEL={
rare="Rare Case",
epic="Epic Case",
legendary="Legendary Case",
}



local ae={
armors="armor",
weapons="weapon",
enchants="enchant",
titles="title",
}

local af
local ag={}



function ad.Configs(ah)
if af and not ah then return af end

local ai,aj={},{}
for ak,al in ipairs(ad.KEYS)do
local am,an=aa.Invoke("getCaseConfig",al)
if am and type(an)=="table"and type(an.items)=="table"then
ai[al]=an
else
aj[#aj+1]=al
end
end

if#aj>0 then
ab.Log("cases: конфиг не пришёл по кейсам",table.concat(aj,", "))
end



if not next(ai)then return nil end

af=ai
return af
end

function ad.Invalidate()
af=nil
end







function ad.Key(ah,ai)
return tostring(ah).."/"..tostring(ai)
end


function ad.Owned()
local ah={}
local ai,aj=aa.Invoke"getPlayerCosmetics"
if not ai or type(aj)~="table"then
ab.Log"cases: getPlayerCosmetics не ответил"
return ah,false
end
for ak,al in pairs(aj)do
if type(al)=="table"then
for am,an in ipairs(al)do ah[ad.Key(ak,an)]=true end
end
end
return ah,true
end










function ad.BestFor(ah)
local ai=ad.Configs()
if not ai then return nil end

local aj={}
for ak,al in ipairs(ah)do aj[ad.Key(al.type,al.name)]=true end

local ak
for al,am in ipairs(ad.KEYS)do
local an=ai[am]
local ao,ap=0,0
for aq,as in ipairs((an and an.items)or{})do
if aj[ad.Key(as.type,as.name)]then
ao=ao+(tonumber(as.percent)or 0)
ap=ap+1
end
end
if ap>0 then
local aq=tonumber(an.price)or 0
if not ak or ao>ak.percent
or(ao==ak.percent and aq<ak.price)then
ak={key=am,percent=ao,price=aq,hits=ap}
end
end
end
return ak
end



function ad.Pool()
local ah=ad.Configs()
ag={}
if not ah then return{}end

local ai={}
for aj,ak in ipairs(ad.KEYS)do
for al,am in ipairs((ah[ak]and ah[ak].items)or{})do
local an=ad.Key(am.type,am.name)
if not ai[an]then
ai[an]=true
local ao=("%s · %s %s"):format(am.name,tostring(am.rarity),
ae[am.type]or tostring(am.type))
ag[ao]={name=am.name,type=am.type,rarity=am.rarity}
end
end
end

local aj={}
for ak in pairs(ag)do aj[#aj+1]=ak end
table.sort(aj)
return aj
end



function ad.Item(ah)
if not ah or ah==""then return nil end
local ai=ag[ah]
if ai then return ai end



ad.Pool()
return ag[ah]
end



function ad.Ready()
local ah=LocalPlayer:FindFirstChild"leaderstats"
if not ah or not ah:FindFirstChild"Gems"then return false end
return aa.Get"purchaseCase"~=nil and aa.Get"casePurchaseResult"~=nil
end






function ad.Buy(ah,ai)
local aj=aa.Get"purchaseCase"
local ak=aa.Get"casePurchaseResult"
if not aj or not ak then return nil,"нет ремоутов покупки"end

local al
local am=ak.OnClientEvent:Connect(function(am)
if al==nil then al=am or false end
end)

local an=pcall(function()aj:FireServer(ah)end)
if not an then
am:Disconnect()
return nil,"purchaseCase не выстрелил"
end

local ao=os.clock()+(ai or 15)
while al==nil and os.clock()<ao and not _apelStopped do
task.wait(0.05)
end
am:Disconnect()

if al==nil then return nil,"сервер не ответил"end
if type(al)~="table"then return nil,"ответ не таблица"end
return al
end



function ad.Award(ah)
return aa.Fire("awardCaseCosmetic",ah.cosmetic,ah.cosmeticType,ah.transactionId)
end



function ad.Rejoin()
return(pcall(function()
ac:Teleport(game.PlaceId,LocalPlayer)
end))
end

return ad end function a.ac():typeof(__modImpl())local aa=a.cache.ac if not aa then aa={c=__modImpl()}a.cache.ac=aa end return aa.c end end end






















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
local am=a.r()
local an=a.s()
local ao=a.t()
local ap=a.u()

local aq=a.G()
local as=a.I()
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




local aK=aq(aJ)
as(aJ)
av(aJ)
aw(aJ)
ax(aJ)
ay(aJ)
az(aJ)

aE()
aF()










ak.Prefetch=am.Prefetch


ak.WantReport=function()return S.webhookOn==true end



ak.OnOutcome=al.Note







if aH then
ao.Start()




ap.Start()

ak.Watch(
function(aL)
if S.webhookOn then pcall(am.Run,aL)end
end,
function()
if aK then pcall(aK)end
end
)
end

local aL=Window:CreateMinimizer{
Size=UDim2.fromOffset(50,50),
Position=UDim2.new(1,-10,0.5,0),
Icon="rbxassetid://138310609771261",
}

local aM=ah(Window,aJ,aL)
aA(Window,aJ,aM)
aB(Window,aJ)
aC(Window,aJ,aa)
aD(Window,aJ,aM,aa)


ai(Window)



if getgenv then
getgenv().ApelHub={
Build="11.09 20:08:59",
S=S,
Window=Window,
Priority=a.j(),
Dungeon=a.o(),
Danger=a.x(),


Route=a.L(),

Nav=a.M(),
Items=a.R(),
Lobby=a.E(),


Cases=a.ac(),
Character=an,
Webhook=am,
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

pcall(an.Stop)
pcall(ap.Restore)
end)

ab.install(Window)
