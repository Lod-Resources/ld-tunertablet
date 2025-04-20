RegisterServerEvent('ld-tunertablet:CreateTableData', function(plate, data, dataName)
    if dataName == "IsSportModOn" then
        IsSportModOn[plate] = true
        oldSportModData[plate] = data
    elseif dataName == "DriftMode"  then
        DriftMode[plate] = data
    elseif dataName == "TuningData" then
        TuningData[plate] = data
    elseif dataName == "CurrentVehicleData" then
        CurrentVehicleData[plate] = data
    elseif dataName == "CloseSportMod" then
        IsSportModOn[plate] = false
    elseif dataName == "NormalMod" then
        IsSportModOn[plate] = false
        DriftMode[plate] = false
    end
end)

RegisterServerEvent('ld-tunertablet:OpenNormalMod')
AddEventHandler('ld-tunertablet:OpenNormalMod', function(plate)
    IsSportModOn[plate] = false
    DriftMode[plate] = false
end)

Citizen.CreateThread(function()
    lib.callback.register('ld-tunertablet:GetData', function(source, cb, plate, dataName)
        if dataName == "TuningData" then
            cb(TuningData[plate])
        elseif dataName == "CurrentVehicleData" then
            while not (CurrentVehicleData[plate]) do
                Citizen.Wait(0)
            end
            cb(CurrentVehicleData[plate])
        elseif dataName == "IsSportModOn" then
            cb(IsSportModOn[plate])
        elseif dataName == "DriftMode" then
            cb(DriftMode[plate])
        elseif dataName == "exOldData" then
            cb(IsSportModOn[plate], oldSportModData[plate])
        elseif dataName == "ActiveData" then
            while not (ActiveMode[plate]) do
                Citizen.Wait(0)
            end
            cb(ActiveMode[plate])
        end
    end)
end)


