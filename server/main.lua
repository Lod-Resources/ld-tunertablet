
IsSportModOn, oldSportModData, DriftMode, TuningData, CurrentVehicleData, ActiveMode, Core = {}, {}, {}, {}, {}, {}, nil

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(2000)
    print(("[^9LD-TUNERTABLET^7] ^3For support if you have any problems^7: https://discord.gg/P92aXCShVP "))
end)


RegisterNetEvent("ld-tunertablet:createData:NewSave", function(newData, plate)
    local data = ExecuteSQL('SELECT * FROM `ld_tuning` WHERE plate = @plate', {["@plate"] = plate})
    if next(data) == nil or next(data) == "[]" then
        return
    else
        local currentData = json.decode(data[1].currentData)
        
        if currentData == nil then
            currentData = {}
        end
        local newDataName = newData["dataname"]

        local newDataEntry = {
            Data = newData,
            name = newDataName
        }
        local newDataIndex = nil
        for index, entry in ipairs(currentData) do
            if entry.name == newDataName then
                newDataIndex = index
                break
            end
        end

        if newDataIndex then
           
            table.remove(currentData, newDataIndex)
        else
            
            table.insert(currentData, newDataEntry)
        end

        ExecuteSQL('UPDATE `ld_tuning` SET currentData = @currentData WHERE plate = @plate', {
            ["@currentData"] = json.encode(currentData),
            ["@plate"] = plate
        }, function(rowsChanged)
            if newDataIndex then
                TriggerClientEvent('ox_lib:notify', source, {title = _L('success'),description = _L('preset_removed'),type = 'success'})
            else
                TriggerClientEvent('ox_lib:notify', source, {title = _L('success'),description = _L('preset_saved'),type = 'success'})
            end
        end)
    end
end)



RegisterNetEvent("ld-tunertablet:createData", function(plate, vehdata)
    GetData = ExecuteSQL('SELECT * FROM `ld_tuning` WHERE plate = @plate', {["@plate"] = plate})
    ActiveMode[plate] = vehdata
    if next(GetData) == nil or  next(GetData) == "[]" then
        ExecuteSQL("INSERT INTO ld_tuning (plate, defaultData) VALUES (@plate, @defaultData)", {
            ['@plate'] = plate,
            ['@defaultData'] = json.encode(vehdata)
        })

        ExecuteSQL("UPDATE ld_tuning SET tunerChip = @tunerChip, plate = @plate WHERE plate = @plate", {
            ['@plate'] = plate,
            ['@tunerChip'] = 1
        })
    end
end) 

