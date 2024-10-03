ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
	createBlip()
end)

createBlip = function ()
    for k, a in pairs(config.noleggio) do
        v = config.noleggio[k].ped
		local blip = AddBlipForCoord(v['x'], v['y'], v['z'])
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

function Refreshmoney()
    local data = ESX.GetPlayerData()
    local bankBalance = 0

    if data and data.accounts then
        print("Check data")
        for k, v in pairs(data.accounts) do
            if v.name == 'bank' then
                bankBalance = v.money or 0
            end
        end
    end

    return bankBalance
end

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
    Wait(0)
    end
end


Citizen.CreateThread(function ()
    
    for k, a in pairs(config.noleggio) do
        v = config.noleggio[k].ped
        local pedhash = GetHashKey(v.model)
        
        
        if pedhash then
            _RequestModel(pedhash)
            if not DoesEntityExist(pedhash) then
                pedhash = CreatePed(0, pedhash,v['x'],v['y'],v['z']-0.964,0,false,true)
                SetEntityHeading(pedhash, v['h'])
                SetBlockingOfNonTemporaryEvents(pedhash, true)
                FreezeEntityPosition(pedhash,true)
                SetEntityInvincible(pedhash,true)
            end
            SetModelAsNoLongerNeeded(pedhash)
        end
        exports.ox_target:addLocalEntity(pedhash,{ 
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
                                banca = Refreshmoney()
                                local spawn = config.noleggio[k].SpawnCar
                                local soldi = exports.ox_inventory:Search('count', 'money')
                                local pos = vector3(spawn['x'], spawn['y'], spawn['z'])
                                if ESX.Game.IsSpawnPointClear(pos, 10) then
                                    if soldi >= prezzo  then
                                        local mezzo = GetHashKey(model)
                                        RequestModel(mezzo)
                                        while not HasModelLoaded(mezzo) do
                                            Wait(500)
                                        end    
                                            if config.customplate then 
                                                vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false)  
                                                lib.setVehicleProperties(vehicle, {
                                                    plate = config.plate
                                                })
                                            else 
                                                vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false) 
                                            end
                                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                            TriggerServerEvent('noleggio:pc',prezzo)
                                            local notifica = "Hai noleggiato questo veicolo per $"..prezzo
                                            ESX.ShowNotification(notifica)
                                    
                                        elseif banca >= prezzo then
                                        local mezzo = GetHashKey(model)
                                        RequestModel(mezzo)
                                        while not HasModelLoaded(mezzo) do
                                            Wait(500)
                                        end
                                        if config.customplate then
                                            vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false)
                                            lib.setVehicleProperties(vehicle, {
                                                plate = config.plate
                                            })
                                        else
                                            vehicle = CreateVehicle(mezzo, pos, spawn['h'], true, false)
                                        end
                                        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        TriggerServerEvent('noleggio:pb',prezzo)
                                        local notifica = "Hai noleggiato questo veicolo per $"..prezzo
                                        ESX.ShowNotification(notifica)
                                    else
                                        ESX.ShowNotification("Non hai abbastanza soldi!")
                                end
                                else 
                                    ESX.ShowNotification("Rimuovi i veicoli nei dintorni")
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
