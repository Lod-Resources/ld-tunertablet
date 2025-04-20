Citizen.CreateThread(function()
    
    lib.callback.register('m-tuning:sqlDta', function(source, plate, dataName)
        if not dataName then
            -- print("⚠️ ERROR: dataName is nil!")
            return nil
        end
    
        local data = ExecuteSQL('SELECT * FROM `ld_tuning` WHERE plate = @plate', {["@plate"] = plate})
    
        if data and #data > 0 then
            -- print("✅ SQL Data Exists:", json.encode(data[1]))
        else
            -- print("❌ No Data Found for plate:", plate)
            return nil
        end
    
        if dataName == "DefaultData" then
            return data[1].defaultData and json.decode(data[1].defaultData) or nil
        elseif dataName == "currentData" then
            return data[1].currentData and json.decode(data[1].currentData) or nil
        else
            TriggerClientEvent('ox_lib:notify', source, {title = _L('warning'),description = _L('invalid_preset'),type = 'warning'})
            -- print("⚠️ ERROR: Invalid dataName received:", dataName)
            return nil
        end
    end)
end)

RegisterNetEvent("m-tuning:deleteCurrentData", function(jsdata, plate)
    local data = ExecuteSQL('SELECT * FROM `ld_tuning` WHERE plate = @plate', {["@plate"] = plate})
    
    if not data or #data == 0 then
        -- TriggerClientEvent('ox_lib:notify', source, {title = _L('warning'),description = _L('invalid_preset'),type = 'warning'})
        return
    end

    local currentData = data[1].currentData
    local jsonData = json.decode(currentData)
    
    if not jsonData or #jsonData == 0 then
        -- print("❌ No presets found in currentData")
        return
    end

    local targetIndex = nil

    for idx, entry in ipairs(jsonData) do
        if entry.Data.dataname == jsdata.vehicleData.title then
            targetIndex = idx
            break
        end
    end

    if targetIndex then
        table.remove(jsonData, targetIndex)
        local newJsonData = json.encode(jsonData)

        ExecuteSQL('UPDATE `ld_tuning` SET currentData = @newData WHERE plate = @plate', {
            ["@newData"] = newJsonData,
            ["@plate"] = plate
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('ox_lib:notify', source, {title = _L('success'),description = _L('preset_deleted'),type = 'sucess'})
            else
                print("❌ Error updating ld_tuning.")
            end
        end)
    else
        -- print("❌ No matching preset found for: " .. jsdata.vehicleData.title)
        TriggerClientEvent('ox_lib:notify', source, {title = _L('warning'),description = _L('invalid_preset'),type = 'warning'})
    end
end)


RegisterNetEvent("m-tuning:ActiveModeData", function(plate, activedata, bool)
    if activedata ~= nil then
        local activeDataToSave

        if bool then
            activeDataToSave = activedata["vehicleData"] 
        else
            activeDataToSave = activedata
        end

        ExecuteSQL('UPDATE `ld_tuning` SET activeData = @activeData WHERE plate = @plate', {
            ['@plate'] = plate,
            ['@activeData'] = json.encode(activeDataToSave)
        })
        ActiveMode[plate] = activeDataToSave
    else
        local data = ExecuteSQL('SELECT * FROM `ld_tuning` WHERE plate = @plate', {["@plate"] = plate})
        if data and data[1] and data[1].defaultData then
            local newdata = json.decode(data[1].defaultData)
            ExecuteSQL('UPDATE `ld_tuning` SET activeData = @activeData WHERE plate = @plate', {
                ['@plate'] = plate,
                ['@activeData'] = json.encode(newdata)
            })

            ActiveMode[plate] = newdata

            TriggerClientEvent('ox_lib:notify', source, {title = _L('success'),description = _L('default'),type = 'success'})
        else
            print("❌ No default data found for plate:", plate)
            TriggerClientEvent('ox_lib:notify', source, {title = _L('warning'),description = _L('invalid_preset'),type = 'warning'})
        end
    end
end)
