ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local isMenuOpen = false

local options = {
	{label = "Riot Truck", value = 'spawn_riot'},
	{label = "Riot Truck w/Water Cannon", value = 'spawn_riot2'},
	{label = "Prisoner Bus", value = 'spawn_bus'},
	{label = "Prisoner Van", value = 'spawn_van'},
	}
	
function OpenMenu()
	isMenuOpen = true
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(),'general_menu', {
		title = "Prison Motorpool Menu",
		align = "upperleft",
		elements = options
	}, function(data, menu)
		--menu.Close()
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'general_menu')
		isMenuOpen = false
			
			if data.current.value == 'spawn_riot' then		
				SpawnRiot()
			end
			if data.current.value == 'spawn_riot2' then		
				SpawnRiot2()
			end
			if data.current.value == 'spawn_bus' then		
				SpawnBus()
			end
			if data.current.value == 'spawn_van' then		
				SpawnVan()
			end
			
		end,
		function(data,menu)
			--menu.Close()
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'general_menu')
			isMenuOpen = false
		end)
end

function SpawnRiot()
		vehiclehash = GetHashKey('riot')
        	RequestModel(vehiclehash)
		Citizen.Wait(400)
		if ESX.Game.IsSpawnPointClear(vector3(1835.143, 2542.154, 45.52307),1) then
			local spawnedVeh = CreateVehicle(vehiclehash, 1835.143, 2542.154, 45.52307, 267.76, 0)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
			Citizen.Wait(500)
			SetVehicleFuelLevel(spawnedVeh, 100.0)					
			SetVehicleCustomPrimaryColour(spawnedVeh, 0,0,0)
			Citizen.Wait(500)
		else	
			ParkingisFull()
		end
end
function SpawnRiot2()
		vehiclehash = GetHashKey('riot2')
        	RequestModel(vehiclehash)
		Citizen.Wait(400)
		if ESX.Game.IsSpawnPointClear(vector3(1835.143, 2542.154, 45.52307),1) then
			local spawnedVeh = CreateVehicle(vehiclehash, 1835.143, 2542.154, 45.52307, 267.76, 0)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
			Citizen.Wait(500)
			SetVehicleFuelLevel(spawnedVeh, 100.0)
			SetVehicleCustomPrimaryColour(spawnedVeh, 0,0,0)
			Citizen.Wait(500)
		else	
			ParkingisFull()
		end
end
function SpawnBus()
		vehiclehash = GetHashKey('pbus')
        	RequestModel(vehiclehash)
		Citizen.Wait(400)
		if ESX.Game.IsSpawnPointClear(vector3(1835.143, 2542.154, 45.52307),1) then
			local spawnedVeh = CreateVehicle(vehiclehash, 1835.143, 2542.154, 45.52307, 267.76, 0)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
			Citizen.Wait(500)
			SetVehicleFuelLevel(spawnedVeh, 100.0)	
			--no need to set the color to black
			--SetVehicleCustomPrimaryColour(spawnedVeh, 0,0,0)
			Citizen.Wait(500)
		else	
			ParkingisFull()
		end
end
function SpawnVan()
		vehiclehash = GetHashKey('policet')
        	RequestModel(vehiclehash)
		Citizen.Wait(400)
		if ESX.Game.IsSpawnPointClear(vector3(1835.143, 2542.154, 45.52307),1) then
			local spawnedVeh = CreateVehicle(vehiclehash,1835.143, 2542.154, 45.52307, 267.76, 0)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
			Citizen.Wait(500)
			SetVehicleFuelLevel(spawnedVeh, 100.0)	
			--no need to set the color to black
			--SetVehicleCustomPrimaryColour(spawnedVeh, 0,0,0)
			Citizen.Wait(500)
		else	
			ParkingisFull()
		end
end

function ParkingisFull()
	ESX.ShowNotification('~r~Spawn point is occupied. Cannot give vehicle.~s~')
end


Citizen.CreateThread(function()
    local location = vector3(1841.13, 2545.846, 45.65784)
    while true do 
        Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(ped)
		local distance = #(playerCoords - location)
	
		if distance < 2.0 then
				yourJob = ESX.PlayerData.job.name
				-- check to see if your job is police, sheriff or highway patrol
				if yourJob == "police" or yourJob == "sheriff" or yourJob == "highway" then
					ESX.Game.Utils.DrawText3D(location, "Press ~y~[H] ~w~for the motorpool menu", 2, 4)
					if IsControlJustReleased(0,74) and not isMenuOpen then	
					OpenMenu()
					end
				end		
		end		
	end
end)
