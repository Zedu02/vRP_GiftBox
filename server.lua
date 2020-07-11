------------------------CREDITS------------------------
-------- Script made by Vlad, DevStudios Owner --------
--         Script made for Diamond Romania RP        --
--          Site: https://devstudios.store           --
--        Forum: http://forum.devstudios.store       --
--   Copyright 2019 ©DevStudios. All rights served   --
-------------------------------------------------------
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPgb = {}
Tunnel.bindInterface("vRP_giftbox",vRPgb)
Proxy.addInterface("vRP_giftbox",vRPgb)

vRPclient = Tunnel.getInterface("vRP","vRP_giftbox")

MySQL.createCommand("vRP/gitbox_init", [[
	CREATE TABLE IF NOT EXISTS `vrp_giftbox` (
	`user_id` int(255) NOT NULL PRIMARY KEY,
	`giftbox` int(255) NOT NULL
  );
]])
MySQL.createCommand("vRP/giftbox_init_user","INSERT IGNORE INTO vrp_giftbox(user_id,giftbox) VALUES(@user_id,@giftbox)")
MySQL.createCommand("vRP/giftbox_drop","DROP DATABASE vrp_giftbox")
MySQL.createCommand("vRP/get_giftbox","SELECT * FROM vrp_giftbox WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_giftbox","UPDATE vrp_giftbox SET giftbox = @giftbox WHERE user_id = @user_id")

MySQL.execute("vRP/gitbox_init")

tmpgiftbox = {}

function displayBox(value)
	return "<span class=\"symbol\">Cadouri: </span> "..value
end

function vRPgb.getgiftbox(user_id)
	local giftbox = tonumber(tmpgiftbox[user_id])
	if giftbox ~= nil then
		return tonumber(tmpgiftbox[user_id])
	else
		return 0
	end
end

function vRPgb.setgiftbox(user_id,value)
	local giftbox = tonumber(tmpgiftbox[user_id])
	if giftbox ~= nil then
		tmpgiftbox[user_id] = tonumber(value)
	end

	local source = vRP.getUserSource({user_id})
	if source ~= nil then
		vRPclient.setDivContent(source,{"giftbox",displayBox(value)})
	end
end

function vRPgb.givegiftbox(user_id,amount)
	local giftbox = vRPgb.getgiftbox(user_id)
	local giftboxs = giftbox + amount
	vRPgb.setgiftbox(user_id,giftboxs)
end

function vRPgb.takegiftbox(user_id,amount)
	local giftbox = vRPgb.getgiftbox(user_id)
	local giftboxs = giftbox - amount
	vRPgb.setgiftbox(user_id,giftboxs)
end

function vRPgb.tryBoxPayment(user_id,amount)
	local giftbox = vRPgb.getgiftbox(user_id)
	if giftbox >= amount then
		vRPgb.setgiftbox(user_id,giftbox-amount)
		return true
	else
		return false
	end
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local cfg = getConfig()
	MySQL.execute("vRP/giftbox_init_user", {user_id = user_id, giftbox = cfg.open_giftbox}, function(affected)
		MySQL.query("vRP/get_giftbox", {user_id = user_id}, function(rows, affected)
			if #rows > 0 then
				tmpgiftbox[user_id] = tonumber(rows[1].giftbox)
			end
		end)
	end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local giftbox = tmpgiftbox[user_id]
	if giftbox and giftbox ~= nil then
		MySQL.execute("vRP/set_giftbox", {user_id = user_id, giftbox = giftbox})
	end
end)

AddEventHandler("vRP:save", function()
	for i, v in pairs(tmpgiftbox) do
		if v ~= nil then
			MySQL.execute("vRP/set_giftbox", {user_id = i, giftbox = v})
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		local cfg = getConfig()
		local mygiftbox = vRPgb.getgiftbox(user_id)
		vRPclient.setDiv(source, {"giftbox", cfg.display_css, displayBox(mygiftbox)})
	end
end)

local function givePlayergiftbox(player,choice)
	local cfg = getConfig()
	vRP.prompt({player, cfg.menu.prompt_user_id, "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, cfg.menu.prompt_g, "", function(player, giftbox)
				giftbox = giftbox
				if(tonumber(giftbox))then
					giftbox = tonumber(giftbox)
					vRPgb.givegiftbox(user_id,giftbox)
					vRPclient.notify(player, {" ~w~Ai dat ~g~"..GetPlayerName(target).."~w~, ~g~"..giftbox.." ~g~Cadouri~w~!"})
					vRPclient.notify(target, {" ~g~"..GetPlayerName(player).."~w~ ti-a dat ~g~"..giftbox.." Cadouri~w~!"})
					TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, ' ^2'.. GetPlayerName(player) ..' ^0a dat ^2'.. GetPlayerName(target) ..'^0, ^2'.. giftbox ..' Cadouri ^0!')
				else
					vRP.notify(player, {cfg.message.invalid_number})
				end
			end})
		else
			vRPclient.notify(player, {cfg.message.offline})
		end
	end})
end

local function takePlayergiftbox(player,choice)
	local cfg = getConfig()
	vRP.prompt({player, cfg.menu.prompt_user_id, "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, cfg.menu.prompt_g, "", function(player, giftbox)
				giftbox = giftbox
				local tgiftbox = tonumber(vRPgb.getgiftbox(user_id))
				if(tonumber(giftbox))then
					giftbox = tonumber(giftbox)
					if(tgiftbox >= giftbox)then
						vRPgb.takegiftbox(user_id,giftbox)
						vRPclient.notify(player, {" Ai furat ~g~"..GetPlayerName(target).."~w~, ~g~"..giftbox.." ~g~Cadouri~w~!"})
						vRPclient.notify(target, {" ~g~"..GetPlayerName(player).."~w~ a luat ~g~"..giftbox.." Cadouri~w~ de la tine!"})
						TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, ' ^2'.. GetPlayerName(player) ..' ^0a luat de la ^2'.. GetPlayerName(target) ..'^0, ^2'.. giftbox ..' Cadouri ^0!')
					else
						vRPclient.notify(player, {cfg.message.only_has ..tgiftbox.." Cadouri~w~!",})
					end
				else
					vRPclient.notify(player, {cfg.message.invalid_number})
				end
			end})
		else
			vRPclient.notify(player, {cfg.message.offline})
		end
	end})
end

local function resetgiftbox(player,choice)
	local cfg = getConfig()
	vRP.prompt({player, cfg.menu.prompt_user_id, "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			local tgiftbox = tonumber(vRPgb.getgiftbox(user_id))
			vRPgb.takegiftbox(target, tgiftbox)
				vRPclient.notify(player,{cfg.message.reset_msg.. GetPlayerName(target) .. "~w~'s ~g~Cadouri~w~!"})
				TriggerClientEvent("chatMessage", -1, "", { 255, 255, 255 }, " ^2".. GetPlayerName(player) .." ^0a resetat ^2".. GetPlayerName(target) .."^0's ^Cadouri ^0!")
			else
			vRPclient.notify(player, {cfg.message.offline})
		end
	end})
end

local function giftboxtrade(player,choice)
	local cfg = getConfig()
	vRP.prompt({player, cfg.menu.prompt_user_id, "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, cfg.menu.prompt_g, "", function(player, giftbox)
			local tgiftbox = tonumber(vRPgb.getgiftbox(user_id))
			if(tonumber(giftbox))then
				giftbox = tonumber(giftbox)
				if(tgiftbox >= giftbox)then
				vRPgb.tryBoxPayment(user_id,giftbox)
						vRPgb.givegiftbox(target,giftbox)
						vRPclient.notify(player, {cfg.trade.msg_give..""..giftbox.." Cadouri~w~!"})
						vRPclient.notify(target, {cfg.trade.msg_received..""..giftbox.." Cadouri~w~!"})
					else
						vRPclient.notify(player, {cfg.message.not_enough_gb})
					end
				else
					vRPclient.notify(player, {cfg.message.invalid_number})
				end
			end})
		else
			vRPclient.notify(player, {cfg.message.offline})
		end
	end})
end

local function giftboxadmin(player,choice)
local cfg = getConfig()
		vRP.buildMenu({"Cadouri Admin", {player = player}, function(menu)
			menu.name = "Cadouri Admin"
			menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu.onclose = function(player) vRP.closeMenu({player}) end
			menu[cfg.menu.reset_t] = {resetgiftbox, cfg.menu.reset_desc}
			menu[cfg.menu.give_t] = {givePlayergiftbox, cfg.menu.give_desc}
			menu[cfg.menu.take_t] = {takePlayergiftbox, cfg.menu.take_desc}
		vRP.openMenu({player,menu})
	end})
end

local function giftboxmenup(player,choice)
local cfg = getConfig()
		vRP.buildMenu({"Cadouri Meniu", {player = player}, function(menu)
			menu.name = "Cadouri Meniu"
			menu.css={top="75px",header_color="rgba(0,200,0,0.75)"}
			menu.onclose = function(player) vRP.closeMenu({player}) end
			menu[cfg.menu.trade] = {giftboxtrade, cfg.menu.trade_desc}
		vRP.openMenu({player,menu})
	end})
end

RegisterServerEvent('vRP:giftboxopen')
AddEventHandler('vRP:giftboxopen', function ()
	local cfg = getConfig()
	local user_id = vRP.getUserId({source})
	local chance = math.random(1,1000)
	
	if prim(chance) then
		chance= chance - 1
	end

	if vRPgb.tryBoxPayment(user_id,cfg.giftbox.open_amount) then
		if chance%2 == 0 then
			local money = math.random(100000,500000)
			vRPclient.addBlip(source,{-545.720703125,-227.97738647461,37.649803161621,500,69,"GiftBox Market"})
			vRP.giveMoney({user_id,money})
			vRPclient.notify(source,{cfg.giftbox.msg_got .. money .." EURO~w~!"})
			TriggerClientEvent('chatMessage', -1, '^0[ ^4Eternity ^0]', { 255, 255, 255 }, ' ^4'.. GetPlayerName(source) ..'^0 a deschis un ^2Cadou ^0si a primit ^4'.. money ..' EURO^0!')
		end

		if chance%3 == 0 then
			local giftbox = math.random(1,3)
			vRPgb.givegiftbox(user_id,giftbox)
			vRPclient.notify(source,{cfg.giftbox.msg_got .. giftbox .. " Cadou ~w~!"})
			TriggerClientEvent('chatMessage', -1, '^0[ ^4Eternity ^0]', { 255, 255, 255 }, ' ^4'.. GetPlayerName(source) ..'^0 a deschis un ^2Cadou ^0si a primit ^4'.. giftbox ..' Cadou^0!')
		end
		
	else
		vRPclient.notify(source,{cfg.message.not_enough_gb})
	end
end)

RegisterServerEvent('vRP:moneygift')
AddEventHandler('vRP:moneygift', function ()
	local cfg = getConfig()
	local user_id = vRP.getUserId({source})
	if vRP.tryPayment({user_id,cfg.market.amount}) then
		vRPclient.addBlip(source,{-530.02941894532,-229.9102935791,36.702156066894,500,69,"Cadou"})
		vRPgb.givegiftbox(user_id,1)
		vRPclient.notify(user_id, {cfg.market.tr_succes})
	else
		vRPclient.notify(user_id, {cfg.market.not_enough_m})
	end
end)

RegisterServerEvent('vRP:gbpaycheck')
AddEventHandler('vRP:gbpaycheck', function()
	local cfg = getConfig()
  	local user_id = vRP.getUserId({source})
	  vRPgb.givegiftbox(user_id,cfg.paycheck.amount)
	  vRPclient.notifyPicture(source,{cfg.paycheck.picture,1,cfg.paycheck.title,false,cfg.paycheck.msg})
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local cfg = getConfig()
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		choices[cfg.menu.name] = {giftboxmenup, cfg.menu.giftbox_desc}
	    add(choices)
    end
end})

function prim(n)
	max = n/2
	for i=2,max do
		if n%i == 0 then
			return false
		else
			return true
		end
	end
end