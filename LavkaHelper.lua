script_name("LavkaHelper")
script_version("2.1")
local imgui = require("imgui")
local active = imgui.ImBool(false)
local samp = require 'lib.samp.events'
local x2, y2 = getScreenResolution()
local checkbox = imgui.ImBool(false)
local checkbox222 = imgui.ImBool(false)
local checkbox333 = imgui.ImBool(false)
local checkbox444 = imgui.ImBool(false)
local rend = imgui.ImBool(false)
local roff = imgui.ImBool(false)
local f = require 'moonloader'.font_flag
local font = renderCreateFont('Arial', 10, f.BOLD + f.SHADOW)
--local rgb1 = imgui.ImFloat4(1.0,1.0,1.0,1.0)
--local rgb2 = imgui.ImFloat4(1.0,1.0,1.0,1.0)
--local hexcolor = 0x00ff00ff
local encoding = require ("encoding")
encoding.default = "CP1251"
u8 = encoding.UTF8
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
style.WindowRounding = 0
style.ChildWindowRounding = 1.5
colors[clr.TitleBg]                = ImVec4(255, 0, 0, 1)
colors[clr.TitleBgActive]          = ImVec4(255, 0, 0, 1)
colors[clr.TitleBgCollapsed]       = ImVec4(255, 0, 0, 0.1)
main = function()
while not isSampAvailable() do wait(0) end
autoupdate("https://raw.githubusercontent.com/Zloybig/lavka-help/main/Update.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/Zloybig/lavka-help/main/LavkaHelper.lua")
sampRegisterChatCommand('lavkah',function() active.v = not active.v end)
	while true do wait(0)
		imgui.Process = active.v
		local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
			if checkbox.v then
				for IDTEXT = 0, 2048 do
					if sampIs3dTextDefined(IDTEXT) then
						local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
						local ll = getDistanceBetweenCoords3d(posX, posY, posZ, x2, y2, z2)
						if text == 'Р Р€Р С—РЎР‚Р В°Р Р†Р В»Р ВµР Р…Р С‘РЎРЏ РЎвЂљР С•Р Р†Р В°РЎР‚Р В°Р С�Р С‘.' and not isCentralMarket(posX, posY) then
							if ll<=5.0 then
								drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,0xFF0000FF)
							elseif ll>5.0 then
								drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,0xFFFFFFFF)
							end
						end
					end
				end
			end	
			if checkbox222.v then
				for _, v in pairs(getAllObjects()) do
				local model = getObjectModel(v)
					if model == 19132 then
					local _, x, y, z = getObjectCoordinates(v)
					local dist = getDistanceBetweenCoords3d(x, y, z, x2, y2, z2)
						if dist<=25.0 then
							drawCircleIn3d(x,y,z-1.3,25,36,1.5,0xFF0000FF)
						elseif dist>25.0 then
							drawCircleIn3d(x,y,z-1.3,25,36,1.5,0xFFFFFFFF)
						end
					end
				end
			end
			if checkbox333.v then
				function samp.onShowDialog(dialogId, style, title, button1, button2, jj)
					if dialogId == 3040 and not isCentralMarket(x2, y2) then
						checkbox.v = false
						checkbox222.v = false
					end
				end
			end
			if checkbox444.v then
				function samp.onServerMessage(color, text)
					if text:find('Р вЂ™РЎвЂ№ РЎРѓР Р…РЎРЏР В»Р С‘ Р В»Р В°Р Р†Р С”РЎС“!') and not isCentralMarket(x2 , y2) or text:find('^%s*%(%( Р В§Р ВµРЎР‚Р ВµР В· 30 РЎРѓР ВµР С”РЎС“Р Р…Р Т‘ Р Р†РЎвЂ№ РЎРѓР С�Р С•Р В¶Р ВµРЎвЂљР Вµ РЎРѓРЎР‚Р В°Р В·РЎС“ Р С•РЎвЂљР С—РЎР‚Р В°Р Р†Р С‘РЎвЂљРЎРЉРЎРѓРЎРЏ Р Р† Р В±Р С•Р В»РЎРЉР Р…Р С‘РЎвЂ РЎС“ Р С‘Р В»Р С‘ Р С—Р С•Р Т‘Р С•Р В¶Р Т‘Р В°РЎвЂљРЎРЉ Р Р†РЎР‚Р В°РЎвЂЎР ВµР в„– %)%)%s*$') and not isCentralMarket(x2 , y2) then
						checkbox.v = true
						checkbox222.v = true
					end
				end
			end
			if rend.v then
				for id = 0, 2304 do
					if sampIs3dTextDefined(id) then
						local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(id)
						if math.floor(posZ) == 17 and text == '' then
							if isPointOnScreen(posX, posY, posZ, nil) then
								local pX, pY = convert3DCoordsToScreen(getCharCoordinates(PLAYER_PED))
								local lX, lY = convert3DCoordsToScreen(posX, posY, posZ)
								renderFontDrawText(font, 'Р РЋР Р†Р С•Р В±Р С•Р Т‘Р Р…Р В°', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
								renderDrawLine(pX, pY, lX, lY, 1, 0xFF52FF4D)
								renderDrawPolygon(pX, pY, 10, 10, 10, 0, 0xFFFFFFFF)
								renderDrawPolygon(lX, lY, 10, 10, 10, 0, 0xFFFFFFFF)
							end
						end
					end
				end
			end
			if roff.v then
				function samp.onServerMessage(color, text)
					if text:find('%[Р СџР С•Р Т‘РЎРѓР С”Р В°Р В·Р С”Р В°%] {FFFFFF}Р вЂ™РЎвЂ№ РЎС“РЎРѓР С—Р ВµРЎв‚¬Р Р…Р С• Р В°РЎР‚Р ВµР Р…Р Т‘Р С•Р Р†Р В°Р В»Р С‘ Р В»Р В°Р Р†Р С”РЎС“ Р Т‘Р В»РЎРЏ Р С—РЎР‚Р С•Р Т‘Р В°Р В¶Р С‘/Р С—Р С•Р С”РЎС“Р С—Р С”Р С‘ РЎвЂљР С•Р Р†Р В°РЎР‚Р В°!') then
						sampAddChatMessage('{FFFF00}[Lavka helper] {FFFFFF}Р вЂ™РЎвЂ№ РЎРѓР В»Р С•Р Р†Р С‘Р В»Р С‘ Р В»Р В°Р Р†Р С”РЎС“, РЎР‚Р ВµР Р…Р Т‘Р ВµРЎР‚ Р В±РЎвЂ№Р В» Р Р†РЎвЂ№Р С”Р В»РЎР‹РЎвЂЎР ВµР Р…', -1)
						rend.v= false
					end
				end
			end
	end
end

function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
	  function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
		  if doesFileExist(json) then
			local f = io.open(json, 'r')
			if f then
			  local info = decodeJson(f:read('*a'))
			  updatelink = info.updateurl
			  updateversion = info.latest
			  f:close()
			  os.remove(json)
			  if updateversion ~= thisScript().version then
				lua_thread.create(function(prefix)
				  local dlstatus = require('moonloader').download_status
				  local color = -1
				  sampAddChatMessage((prefix..'Р С›Р В±Р Р…Р В°РЎР‚РЎС“Р В¶Р ВµР Р…Р С• Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ. Р СџРЎвЂ№РЎвЂљР В°РЎР‹РЎРѓРЎРЉ Р С•Р В±Р Р…Р С•Р Р†Р С‘РЎвЂљРЎРЉРЎРѓРЎРЏ c '..thisScript().version..' Р Р…Р В° '..updateversion), color)
				  wait(250)
				  downloadUrlToFile(updatelink, thisScript().path,
					function(id3, status1, p13, p23)
					  if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
						print(string.format('Р вЂ”Р В°Р С–РЎР‚РЎС“Р В¶Р ВµР Р…Р С• %d Р С‘Р В· %d.', p13, p23))
					  elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
						print('Р вЂ”Р В°Р С–РЎР‚РЎС“Р В·Р С”Р В° Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘РЎРЏ Р В·Р В°Р Р†Р ВµРЎР‚РЎв‚¬Р ВµР Р…Р В°.')
						sampAddChatMessage((prefix..'Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р В·Р В°Р Р†Р ВµРЎР‚РЎв‚¬Р ВµР Р…Р С•!'), color)
						goupdatestatus = true
						lua_thread.create(function() wait(500) thisScript():reload() end)
					  end
					  if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
						if goupdatestatus == nil then
						  sampAddChatMessage((prefix..'Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р С—РЎР‚Р С•РЎв‚¬Р В»Р С• Р Р…Р ВµРЎС“Р Т‘Р В°РЎвЂЎР Р…Р С•. Р вЂ”Р В°Р С—РЎС“РЎРѓР С”Р В°РЎР‹ РЎС“РЎРѓРЎвЂљР В°РЎР‚Р ВµР Р†РЎв‚¬РЎС“РЎР‹ Р Р†Р ВµРЎР‚РЎРѓР С‘РЎР‹..'), color)
						  update = false
						end
					  end
					end
				  )
				  end, prefix
				)
			  else
				update = false
				print('v'..thisScript().version..': Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р Р…Р Вµ РЎвЂљРЎР‚Р ВµР В±РЎС“Р ВµРЎвЂљРЎРѓРЎРЏ.')
			  end
			end
		  else
			print('v'..thisScript().version..': Р СњР Вµ Р С�Р С•Р С–РЎС“ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚Р С‘РЎвЂљРЎРЉ Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ. Р РЋР С�Р С‘РЎР‚Р С‘РЎвЂљР ВµРЎРѓРЎРЉ Р С‘Р В»Р С‘ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚РЎРЉРЎвЂљР Вµ РЎРѓР В°Р С�Р С•РЎРѓРЎвЂљР С•РЎРЏРЎвЂљР ВµР В»РЎРЉР Р…Р С• Р Р…Р В° '..url)
			update = false
		  end
		end
	  end
	)
	while update ~= false do wait(100) end
  end

drawCircleIn3d = function(x, y, z, radius, polygons,width,color)
    local step = math.floor(360 / (polygons or 36))
    local sX_old, sY_old
    for angle = 0, 360, step do
        local lX = radius * math.cos(math.rad(angle)) + x
        local lY = radius * math.sin(math.rad(angle)) + y
        local lZ = z
        local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
        if sZ > 1 then
            if sX_old and sY_old then
                renderDrawLine(sX, sY, sX_old, sY_old, width, color)
            end
            sX_old, sY_old = sX, sY
        end
    end
end

isCentralMarket = function(x, y)
	return (x > 1044 and x < 1197 and y > -1565 and y < -1403)
end

function imgui.OnDrawFrame()
	imgui.SetNextWindowPos(imgui.ImVec2(x2 / 2, y2 / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(500, 400), imgui.Cond.FirstUseEver)
	imgui.Begin("Lavka helper", active ,imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysUseWindowPadding + imgui.WindowFlags.NoResize)
	imgui.Text(u8"Р вЂќР В»РЎРЏ РЎвЂ Р ВµР Р…РЎвЂљРЎР‚Р В°Р В»РЎРЉР Р…Р С•Р С–Р С• РЎР‚РЎвЂ№Р Р…Р С”Р В°")
	imgui.Spacing()
	imgui.Checkbox(u8"Р В Р ВµР Р…Р Т‘Р ВµРЎР‚ Р В»Р В°Р Р†Р С•Р С” РЎвЂ РЎР‚", rend)
	imgui.Checkbox(u8"Р С’Р Р†РЎвЂљР С•-Р С•РЎвЂљР С”Р В»РЎР‹РЎвЂЎР ВµР Р…Р С‘РЎРЏ РЎР‚Р ВµР Р…Р Т‘Р ВµРЎР‚Р В° Р С—РЎР‚Р С‘ Р В°РЎР‚Р ВµР Р…Р Т‘Р Вµ Р В»Р В°Р Р†Р С”Р С‘",roff)
	imgui.Separator()
	imgui.Spacing()
	imgui.Text(u8"Р вЂќР В»РЎРЏ Р С—Р ВµРЎР‚Р ВµР Р…Р С•РЎРѓРЎвЂљР Р…РЎвЂ№РЎвЂ¦ Р В»Р В°Р Р†Р С•Р С”")
	imgui.Checkbox(u8("РЎС“РЎвЂЎР С‘РЎвЂљРЎвЂ№Р Р†Р В°РЎвЂљРЎРЉ Р В»Р В°Р Р†Р С”Р С‘"), checkbox)
	imgui.Checkbox(u8("РЎС“РЎвЂЎР С‘РЎвЂљРЎвЂ№Р Р†Р В°РЎвЂљРЎРЉ Р В±Р С‘Р В·Р Р…Р ВµРЎРѓРЎвЂ№ (Р В Р В°Р В±Р С•РЎвЂљР В°Р ВµРЎвЂљ, Р Р…Р С• Р ВµРЎвЂ°РЎвЂ� Р Р† Р С—РЎР‚Р С•РЎвЂ Р ВµРЎРѓРЎРѓР Вµ Р Т‘Р С•РЎР‚Р С•Р В±Р С•РЎвЂљР С”Р С‘)"), checkbox222)
	imgui.Checkbox(u8("Р С’Р Р†РЎвЂљР С•-Р С•РЎвЂљР С”Р В»РЎР‹РЎвЂЎР ВµР Р…Р С‘Р Вµ РЎРѓР С”РЎР‚Р С‘Р С—РЎвЂљР В° Р С—РЎР‚Р С‘ Р С‘РЎРѓР С—Р С•Р В»РЎРЉР В·Р С•Р Р†Р В°Р Р…Р С‘Р С‘ Р В»Р В°Р Р†Р С”Р С‘"), checkbox333)
	imgui.Checkbox(u8("Р С’Р Р†РЎвЂљР С•-Р Р†Р С”Р В»РЎР‹РЎвЂЎР ВµР Р…Р С‘Р Вµ РЎРѓР С”РЎР‚Р С‘Р С—РЎвЂљР В° Р С—РЎР‚Р С‘ РЎРѓР В»РЎвЂ�РЎвЂљР Вµ Р В»Р В°Р Р†Р С”Р С‘"), checkbox444)
	imgui.SetCursorPos(imgui.ImVec2(460, 200))
	imgui.Text(u8"Р С’Р Р†РЎвЂљР С•РЎР‚: Samp_God_Game Р вЂєР С›Р Тђ")
	--imgui.ColorEdit4(u8"Р В¦Р Р†Р ВµРЎвЂљ Р С”РЎР‚РЎС“Р С–Р В°", rgb1)
	--imgui.ColorEdit4(u8"Р В¦Р Р†Р ВµРЎвЂљ Р С”РЎР‚РЎС“Р С–Р В° Р С—РЎР‚Р С‘ Р В·Р В°РЎвЂ¦Р С•Р Т‘Р Вµ Р Р† Р Р…Р ВµР С–Р С•", hexcolor)
	imgui.End()
  end
