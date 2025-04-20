
driftMod, oldSportMod, SportModOn, Core = {}, {}, {}, nil


function _L(key, ...)
    local lang = Config.Language or "en"
    local result = Locales.Languages[lang][key] or Locales.Languages["en"][key] or key
    
    -- Handle string replacement for parameters
    local args = {...}
    if #args > 0 then
        for i, v in ipairs(args) do
            result = result:gsub("{" .. (i-1) .. "}", tostring(v))
        end
    end
    
    return result
end

-- Update the notifications to use the localization system
RegisterCommand("tunertablet", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = _L("tuning_tablet"), description = _L("need_vehicle"), type = 'error'})
        return
    end
    
    -- Check if player is in driver's seat
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then
        lib.notify({title = _L("tuning_tablet"), description = _L("need_driver_seat"), type = 'error'})
        return
    end
    
    -- Call the OpenUI function
    OpenUI()
end, false)


function OpenUI()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local vehicleDatas = {
        currentVehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
        vehicleHash = GetEntityModel(vehicle),
        currentVehiclePlate = GetVehicleNumberPlateText(vehicle),
        currentVehicleAcceleration = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveForce') * 10,
        currentVehicleBraking = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce') * 10,
        currentVehicleTraction = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax') * 10,
        currentVehicleTopSpeed = GetVehicleMaxSpeed(vehicle),
        currentVehicleEngineTemp = GetVehicleEngineTemperature(vehicle),
        currentVehicleFuelLevel = GetVehicleFuelLevel(vehicle),
        currentVehicleOilLevel = GetVehicleOilLevel(vehicle),
        currentVehicleHealth = GetVehicleEngineHealth(vehicle),
    }

    if IsPedInAnyVehicle(ped) then 
        local getData = GetVehData(vehicle)
        TriggerServerEvent("m-tuning:createData", GetVehicleNumberPlateText(vehicle), getData)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "SHOW_INTERFACE",
            vehicleDatas = vehicleDatas,
            handlingData = GetVehData(vehicle),
            Locales = Locales.Languages[Config.Language],
            AdvancedConfiguration = Config.Configurables["Advanced"],
            SimpleConfiguration = Config.Configurables["Simple"],
            readyPresets = Config.ReadyPresets,
            Pages = Config.Pages["Main_Pages"],
            subPages = Config.Pages["Sub_Pages"],
        })
    else 
        lib.notify({title = _L("tuning_tablet"), description = _L("need_vehicle"), type = 'error'})
    end
end


exports('OpenUI', OpenUI)


RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
end)


RegisterNUICallback("GET_ADVANCED_DATA",function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    SendNUIMessage({
        action = "GET_VEHICLE_DATA",
        vehicleData =  GetVehData(veh),
    })
end)

RegisterNUICallback("SAVE_SIMPLE_SETTINGS", function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    setVehData(veh, data)
    TriggerServerEvent("m-tuning:CreateTableData", GetVehicleNumberPlateText(veh), data, "TuningData")
    lib.notify({title = _L("settings_saved"), description = _L("simple_settings_applied"), type = 'success'})
end)

RegisterNUICallback("SAVE_ADVANCED_SETTINGS", function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local plate = GetVehicleNumberPlateText(veh)
    TriggerServerEvent("m-tuning:createData:NewSave", data, plate, data.dataname)
    setAdvancedData(veh, data, false, nil)
    TriggerServerEvent("m-tuning:ActiveModeData", plate, data, true)
    lib.notify({title = _L("advanced_settings"), description = _L("settings_applied"), type = 'success'})
end)

RegisterNUICallback("DEFAULT_BACK", function ()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local plate = GetVehicleNumberPlateText(veh)
    DefaultAdvancedData(veh, plate)
    TriggerServerEvent("m-tuning:ActiveModeData", plate)
    lib.notify({title = _L("default_settings"), description = _L("restored_factory"), type = 'info'})
end)

RegisterNUICallback("TEST_TOOL", function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        if vehicle == 0 then
            lib.notify({title = _L("test_tool_error"), description = _L("need_vehicle"), type = 'error'})
            return
        end
        SetNuiFocus(false, false)
        
        lib.notify({title = _L("test_tool"), description = _L("press_g_start"), type = 'info'})
        
        while true do
            Wait(0)
 
            if IsControlJustReleased(0, 194) then 
              
                SendNUIMessage({
                    action = "TIMER",
                    status = 2
                })
                OpenUI()
                return 
            end
            
            if GetEntitySpeed(vehicle) * 3.6 > 1 then
                if IsControlJustReleased(0, 47) then
                    lib.notify({title = _L("test_tool_error"), description = _L("vehicle_stationary"), type = 'error'})
               
                end
            else
                if IsControlJustReleased(0, 47) then
                    break
                end
            end
        end
        
        local startTime = GetGameTimer()
        local startCoords = GetEntityCoords(vehicle)
        local quarterMile = 402.336 -- 
        local halfMile = 804.672 
        local reached100, reached60, reachedQuarter, reachedHalf = false, false, false, false
        local zeroToHundredTime, zeroToSixtyTime, quarterMileTime, halfMileTime
        SendNUIMessage({
            action = "TIMER",
            status = 1
        })
        lib.notify({title = _L("test_started"), description = _L("test_in_progress"), type = 'success'})
        
        local testActive = true
        while testActive do
            Wait(0) 
            if IsControlJustReleased(0, 194) then 
                SendNUIMessage({
                    action = "TIMER",
                    status = 2
                })
                OpenUI()
                return 
            end 
            if IsControlJustReleased(0, 20) then 
                SendNUIMessage({
                    action = "TIMER",
                    status = 2
                })
                lib.notify({title = _L("test_reset"), description = _L("press_g_restart"), type = 'info'})
                break 
            end
            local currentSpeed = GetEntitySpeed(vehicle) * 3.6 
            local currentTime = GetGameTimer() - startTime
            local currentCoords = GetEntityCoords(vehicle)
            local distance = #(currentCoords - startCoords)
            
            local updated = false 
            
            if not reached100 and currentSpeed >= 100 then
                zeroToHundredTime = currentTime / 1000
                reached100 = true
                updated = true
                lib.notify({title = _L("test_milestone"), description = _L("zero_to_hundred", zeroToHundredTime), type = 'info'})
            end
            
            if not reached60 and currentSpeed >= 60 then
                zeroToSixtyTime = currentTime / 1000
                reached60 = true
                updated = true
                lib.notify({title = _L("test_milestone"), description = _L("zero_to_sixty", zeroToSixtyTime), type = 'info'})
            end
            
            if not reachedQuarter and distance >= quarterMile then
                quarterMileTime = currentTime / 1000
                reachedQuarter = true
                updated = true
                lib.notify({title = _L("test_milestone"), description = _L("quarter_mile", quarterMileTime), type = 'info'})
            end
            
            if not reachedHalf and distance >= halfMile then
                halfMileTime = currentTime / 1000
                reachedHalf = true
                updated = true
                lib.notify({title = _L("test_milestone"), description = _L("half_mile", halfMileTime), type = 'info'})
            end

            if updated then
                SendNUIMessage({
                    action = "GET_TOOL",
                    reach100 = zeroToHundredTime or "N/A",
                    reach60 = zeroToSixtyTime or "N/A",
                    reachquart = quarterMileTime or "N/A",
                    reachhalf = halfMileTime or "N/A"
                })
            end
            
            if reached100 and reached60 and reachedQuarter and reachedHalf then
                testActive = false
            end
        end
        
        SendNUIMessage({
            action = "GET_TOOL",
            reach100 = zeroToHundredTime or "N/A",
            reach60 = zeroToSixtyTime or "N/A",
            reachquart = quarterMileTime or "N/A",
            reachhalf = halfMileTime or "N/A"
        })
        SendNUIMessage({
            action = "TIMER",
            status = 0
        })
        lib.notify({title = _L("test_complete"), description = _L("press_delete"), type = 'success'})
        
       
    end
end)





