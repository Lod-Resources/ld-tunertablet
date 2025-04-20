-- Presets

RegisterNUICallback("GET_CUSTOMS_DATA", function(data)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    if vehicle == 0 then
        lib.notify({title = _L("error"), description = _L("no_vehicle_found"), type = 'error'})
        return
    end
    local plate = GetVehicleNumberPlateText(vehicle)
    local dataName = "currentData"
    lib.callback('ld-tunertablet:sqlDta', false, function(Datalar)
        SendNUIMessage({
            action = "GET_CURRENT_DATA",
            GetCurrentData = Datalar or {},
        })
    end, plate, dataName)
end)

RegisterNUICallback("DELETE_PRESET", function(data)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local plate = GetVehicleNumberPlateText(vehicle)

    TriggerServerEvent("ld-tunertablet:deleteCurrentData", data, plate)
    lib.notify({title = _L("success"), description = _L("preset_deleted"), type = 'success'})
end)


RegisterNUICallback("GET_XML_DATA", function(data)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local plate = GetVehicleNumberPlateText(vehicle)
    if not data or not data.vehicleData then
        lib.notify({title = _L("xml_error"), description = _L("invalid_vehicle_data"), type = 'error'})
        return
    end
    if not data.vehicleData.AdvancedConfigurationData then
        lib.notify({title = _L("xml_data"), description = _L("loaded_config"), type = 'success'})
        return
    end
    setAdvancedData(vehicle, data, true, nil)

    TriggerServerEvent("ld-tunertablet:ActiveModeData", plate, data.vehicleData.AdvancedConfigurationData, false)
    lib.notify({title = _L("success"), description = _L("xml_data"), type = 'success'})
end)



