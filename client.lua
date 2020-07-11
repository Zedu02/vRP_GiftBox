------------------------CREDITS------------------------
-------- Script made by Vlad, DevStudios Owner --------
--         Script edited by Bre Faby #barosul        --
--          Site: https://devstudios.store           --
--        Forum: http://forum.devstudios.store       --
--   Copyright 2019 ©DevStudios. All rights served   --
-------------------------------------------------------

incircle = false 
waiting = false

giftBox = {x = -530.02941894532, y = -229.9102935791, z = 36.702156066894}

local blips = {
    {name="P: [ GIFTBOX ] Vino aici!", id=108, x= -530.02941894532, y= -229.9102935791, z= 36.702156066894, color= 57},

  }


-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('chance', function(data, cb)
  TriggerServerEvent('vRP:giftboxopen')
  waiting = true
  closeGui()
  cb('ok')
end)

-- Open Gui and Focus NUI
function openGui()
	SetNuiFocus(true, true)
	SendNUIMessage({openNUI = true})
  end
  
  -- Close Gui and disable NUI
  function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openNUI = false})
	giftOpen = false
  end

function giftbox_DisplayText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function giftbox1(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.2*scale, 0.5*scale)
        SetTextFont(6)
        SetTextProportional(1)
    SetTextColour( 100, 200, 200, 255 )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
      World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

taginaltime = 1.5
taginaltime2 = 1.36
taginaltime3 = 1.22

Citizen.CreateThread(function()
    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.color)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z

		if GetDistanceBetweenCoords(giftBox.x,giftBox.y,giftBox.z,px,py,pz,true) <= 20 then
			giftbox1(giftBox.x,giftBox.y,giftBox.z +taginaltime, tostring("~w~[ ~b~Event Cadouri ~w~]"))
		--	DrawMarker(32,giftBox.x,giftBox.y,giftBox.z+0.5,0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001, rainbow.r, rainbow.g, rainbow.b,200,0,0,0,true)
			DrawMarker(32, giftBox.x,giftBox.y,giftBox.z+0.4, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 100, 200, 200, 255, 0, 0, 0, true)
			--DrawMarker(6,giftBox.x,giftBox.y,giftBox.z+0.5,0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001,255,255,255,200,0,0,0,true)
		end
		if not waiting then
			if(Vdist(giftBox.x,giftBox.y,giftBox.z,px,py,pz) < 2)then
				if (incircle == false) then
					giftbox_DisplayText("Apasa ~INPUT_CONTEXT~ pentru a deschide un ~g~Cadou~w~!")
				end
				incircle = true
				callGift(51)
			else 
				if(Vdist(giftBox.x,giftBox.y,giftBox.z,px,py,pz) > 2)then
					incircle = false
				end
			end
		else
			if(Vdist(giftBox.x,giftBox.y,giftBox.z,px,py,pz) < 2)then
				if (incircle == false) then
					giftbox_DisplayText("~w~Trebuie sa astepti pentru a deschide un nou cadou!")
				end
				incircle = true
			else 
				if(Vdist(giftBox.x,giftBox.y,giftBox.z,px,py,pz) > 2)then
					incircle = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if waiting then
			Citizen.Wait(30*60*1000)
			waiting = false
		end
	end
end)

function callGift(button)
	if IsControlJustPressed(1, button) then
		if (IsInVehicle()) then
			TriggerEvent('inmasina')
		else
		  if giftOpen then
			closeGui()
			giftOpen = false
		  else
			openGui()
			giftOpen = true
		  end
		end
	end
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
	  return true
	else
	  return false
	end
end  

RegisterNetEvent('vRP:giftboxmenuopen')
AddEventHandler('vRP:giftboxmenuopen', function()
TriggerServerEvent('vRP:giftboxopen')
end)

RegisterNetEvent('inmasina')
AddEventHandler('inmasina', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Nu poti deschide giftbox-ul in masina!")
    SetNotificationMessage("CHAR_BUGSTARS", "CHAR_BUGSTARS", true, 1, "GIFTBOX")
    DrawNotification(false, true)
end)