------------------------CREDITS------------------------
-------- Script made by Vlad, DevStudios Owner --------
--         Script made for Diamond Romania RP        --
--          Site: https://devstudios.store           --
--        Forum: http://forum.devstudios.store       --
--   Copyright 2019 ©DevStudios. All rights served   --
-------------------------------------------------------
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
	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z
		
		if GetDistanceBetweenCoords(-545.720703125,-227.97738647461,37.649803161621,px,py,pz,true) <= 20 then
			giftbox1(-545.720703125,-227.97738647461,37.649803161621 + taginaltime, tostring("~b~Event Cadouri ~w~Market | Pret: ~b~350.000$"))
			DrawMarker(32, -545.720703125,-227.97738647461,37.649803161621+0.4, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 100, 200, 200, 255, 0, 0, 0, true)
	--		DrawMarker(29,-545.720703125,-227.97738647461,37.649803161621+0.5,0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001, rainbow.r, rainbow.g, rainbow.b,130,0,0,0,true)
	--		DrawMarker(6,-545.720703125,-227.97738647461,37.649803161621+0.5,0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 255,255,255,130,0,0,0,true)
		end
		if(Vdist(-545.720703125,-227.97738647461,37.649803161621,px,py,pz) < 2)then
			if (incircle == false) then
				giftbox_DisplayText("Apasa ~INPUT_CONTEXT~ pentru a face ~g~Tranzactia~w~!")
			end
			incircle = true
			if(IsControlJustReleased(1, 51))then
				TriggerServerEvent('vRP:moneygift')
			end
		elseif(Vdist(-545.720703125,-227.97738647461,37.649803161621,px,py,pz) > 2)then
			incircle = false
		end
	end
end)