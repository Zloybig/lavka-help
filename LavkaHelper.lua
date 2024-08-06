script_name("LavkaHelper")
script_version("1.0")
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
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/Zloybig/lavka-help/main/Update.jason" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/qrlk/moonloader-script-updater/"
        end
    end
end
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
sampRegisterChatCommand('lavkah',function() active.v = not active.v end)
	while true do wait(0)
		imgui.Process = active.v
		local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
			if checkbox.v then
				for IDTEXT = 0, 2048 do
					if sampIs3dTextDefined(IDTEXT) then
						local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
						local ll = getDistanceBetweenCoords3d(posX, posY, posZ, x2, y2, z2)
						if text == 'Управления товарами.' and not isCentralMarket(posX, posY) then
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
					if text:find('Вы сняли лавку!') and not isCentralMarket(x2 , y2) or text:find('^%s*%(%( Через 30 секунд вы сможете сразу отправиться в больницу или подождать врачей %)%)%s*$') and not isCentralMarket(x2 , y2) then
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
								renderFontDrawText(font, 'Свободна', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
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
					if text:find('%[Подсказка%] {FFFFFF}Вы успешно арендовали лавку для продажи/покупки товара!') then
						sampAddChatMessage('{FFFF00}[Lavka helper] {FFFFFF}Вы словили лавку, рендер был выключен', -1)
						rend.v= false
					end
				end
			end
	end
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
	imgui.Text(u8"Для центрального рынка")
	imgui.Spacing()
	imgui.Checkbox(u8"Рендер лавок цр", rend)
	imgui.Checkbox(u8"Авто-отключения рендера при аренде лавки",roff)
	imgui.Separator()
	imgui.Spacing()
	imgui.Text(u8"Для переностных лавок")
	imgui.Checkbox(u8("учитывать лавки"), checkbox)
	imgui.Checkbox(u8("учитывать бизнесы (Работает, но ещё в процессе дороботки)"), checkbox222)
	imgui.Checkbox(u8("Авто-отключение скрипта при использовании лавки"), checkbox333)
	imgui.Checkbox(u8("Авто-включение скрипта при слёте лавки"), checkbox444)
	imgui.SetCursorPos(imgui.ImVec2(460, 200))
	imgui.Text(u8"Автор: Samp_God_Game")
	--imgui.ColorEdit4(u8"Цвет круга", rgb1)
	--imgui.ColorEdit4(u8"Цвет круга при заходе в него", hexcolor)
	imgui.End()
  end
