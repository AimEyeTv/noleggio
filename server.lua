ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent("noleggio:pc")
AddEventHandler("noleggio:pc",function (soldi)
    exports.ox_inventory:RemoveItem(source, 'money', soldi)
end)

RegisterNetEvent("noleggio:pb")
AddEventHandler("noleggio:pb",function(soldi)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney('bank', soldi)
end)