ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
	createBlip()
end)

function createBlip()
	for k, v in pairs(config.noleggio) do
		local blip = AddBlipForCoord(v[k].ped['x'], v[k].ped['y'], v[k].ped['z'])
		SetBlipSprite(blip, config.blip)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, config.blipcolor)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Noleggio')
		EndTextCommandSetBlipName(blip)
	end
end

Citizen.CreateThread(function ()
    local data = ESX.GetPlayerData()
    for ooo,v in pairs(data.accounts) do
        if v.name == 'bank' then
            banca = v.money
        end
    end
    for k, a in pairs(config.noleggio) do
        v = config.noleggio[k].ped
        
        lib.RequestModel(v.model)
        npc = CreatePed(0, v.model,v['x'],v['y'],v['z']-0.964,0,false,true)
        SetEntityHeading(npc, v['h'])
        FreezeEntityPosition(npc,true)
        SetEntityInvincible(npc,true)

        exports.ox_target:addLocalEntity(npc,{ 
            {
                label = "Noleggio "..v.label,
                icon = "car",
                onSelect = function()
                    local elements= {}
                    for _, auto in pairs(config.VehicleList) do
                        local i = 0
                        local titolo = auto['title']
                        local desc = auto['desc']
                        local model = auto['model']
                        local icon = auto['icon']
                        local prezzo = auto['prezzo']
                        table.insert(elements,{
                            title = titolo,
                            description = desc,
                            icon = icon,
                            onSelect = function ()
                                local spawn = config.noleggio[k].SpawnCar
                                local soldi = exports.ox_inventory:Search('count', 'money')
                                
                                if soldi >= prezzo  then
                                    local mezzo = GetHashKey(model)
                                    RequestModel(mezzo)
                                    while not HasModelLoaded(mezzo) do
                                        Wait(500)
                                    end
                                    local pos = vector3(spawn['x'], spawn['y'], spawn['z'])
                                    local vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false) 
                                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    TriggerServerEvent('noleggio:pc',prezzo)
                                elseif banca >= prezzo then
                                    local mezzo = GetHashKey(model)
                                    RequestModel(mezzo)
                                    while not HasModelLoaded(mezzo) do
                                        Wait(500)
                                    end
                                    local pos = vector3(spawn['x'], spawn['y'], spawn['z'])
                                    if config.customplate then
                                        vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false)
                                        lib.setVehicleProperties(vehicle, {
                                            plate = config.plate
                                        })
                                    end
                                    
                                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    TriggerServerEvent('noleggio:pb',prezzo)
                                    
                                else 
                                    print('Non hai soldi')
                                end
                            end})
                            lib.registerContext({ 
                            id = 'menunoleggio',
                            title = 'Noleggio',
                            options = elements   
                        })
                        i=i+1
                    end
                    lib.showContext('menunoleggio')
                end
            }
        })
    end
end)

RegisterCommand('soldibanca',function ()
    local data = ESX.GetPlayerData()
    for a,v in pairs(data.accounts) do
        if v.name == 'bank' then
            banca = v.money
        elseif v.name == 'money' then
            cashMoney = v.money
        end
    end
    print("Hai "..banca )
end)