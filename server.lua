ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('brr_menupersonal:getJob')
AddEventHandler('brr_menupersonal:getJob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    return job
end)

RegisterNetEvent('brr_menupersonal:getJobLabel')
AddEventHandler('brr_menupersonal:getJobLabel', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jobgrade = xPlayer.job.grade_label
    return jobgrade
end)
