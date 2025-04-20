

RegisterNuiCallback("CHANGE_MODE", function(data)
    mode = data.mode
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
   
    if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
        local plate = GetVehicleNumberPlateText(vehicle)

        if mode == "Drift Mode" then
            TriggerServerEvent("ld-tunertablet:CreateTableData", plate, false, "NormalMod")
            SportModOn[plate] = false
            if not driftMod[plate] then
                driftMod[plate] = true
                TriggerServerEvent("ld-tunertablet:CreateTableData", plate, true, "DriftMode")
                lib.notify({title = _L("drift_mode"), description = _L("mode_enabled"), type = 'success'})
            else
                driftMod[plate] = false
                TriggerServerEvent("ld-tunertablet:CreateTableData", plate, false, "DriftMode")
                lib.notify({title = _L("drift_mode"), description = _L("mode_disabled"), type = 'error'})
            end
        elseif mode == "Sport Mode" then 
            TriggerServerEvent("ld-tunertablet:CreateTableData", plate, false, "NormalMod")
            driftMod[plate] = false
            if not SportModOn[plate] then
                SportModOn[plate] = true
                SportModOnFunction(vehicle, plate)
                lib.notify({title = _L("sport_mode"), description = _L("mode_enabled"), type = 'success'})
            else
                SportModOn[plate] = false
                lib.callback('ld-tunertablet:GetData',false, function(dataone)
                    if dataone == nil or dataone == false then
                        SportModOnFunction(vehicle, plate)
                    else
                        NormalMode(vehicle, plate, oldSportMod[plate])
                    end
                end, plate, "exOldData")
                lib.notify({title = _L("sport_mode"), description = _L("mode_disabled"), type = 'error'})
            end
        elseif mode == "Eco Mode" then
            driftMod[plate] = false
            SportModOn[plate] = false
            TriggerServerEvent("ld-tunertablet:CreateTableData", plate, false, "NormalMod")
            NormalMode(vehicle, plate, oldSportMod[plate])
            lib.notify({title = _L("eco_mode"), description = _L("mode_enabled"), type = 'success'})
            
        end
    end 
end)


function SportModOnFunction(vehicle, plate)
    local oldfInitialDriveMaxFlatVelData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
    local oldffDriveInertiaData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia")
    local oldfClutchChangeRateScaleUpShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift")
    local oldfClutchChangeRateScaleDownShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift")
    oldSportMod[plate] = {
        oldfInitialDriveMaxFlatVel = oldfInitialDriveMaxFlatVelData,
        oldffDriveInertia = oldfInitialDriveMaxFlatVelData,
        oldfClutchChangeRateScaleUpShift = oldfInitialDriveMaxFlatVelData,
        oldfClutchChangeRateScaleDownShift = oldfInitialDriveMaxFlatVelData,
    }
	
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', oldfInitialDriveMaxFlatVelData + (oldfInitialDriveMaxFlatVelData / Config.Modes["SportModeSettings"]["fInitialDriveMaxFlatVel"]))
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', Config.Modes["SportModeSettings"]["fDriveInertia"])
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', oldfClutchChangeRateScaleUpShiftData * Config.Modes["SportModeSettings"]["fClutchChangeRateScaleUpShift"]) 
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', oldfClutchChangeRateScaleDownShiftData * Config.Modes["SportModeSettings"]["fClutchChangeRateScaleDownShift"])
    TriggerServerEvent("ld-tunertablet:CreateTableData", plate, oldSportMod[plate], "IsSportModOn")
    lib.notify({title = _L("sport_mode"), description = _L("settings_applied"), type = 'success'})
end

function NormalMode(vehicle, plate, olddata)
    if olddata == nil then
        lib.notify({title = _L("normal_mode_error"), description = _L("no_previous_data"), type = 'error'})
        return
    else
        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', olddata.oldfInitialDriveMaxFlatVel)
        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', olddata.oldffDriveInertia)
        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', olddata.oldfClutchChangeRateScaleUpShift)
        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', olddata.oldfClutchChangeRateScaleDownShift)
    end
    TriggerServerEvent("ld-tunertablet:CreateTableData", plate , false, "CloseSportMod")
    lib.notify({title = _L("normal_mode"), description = _L("settings_applied"), type = 'success'})
end

local lastVehicle = nil
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    
    while true do
        Citizen.Wait(1000)

        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            local plate = GetVehicleNumberPlateText(vehicle)

            if vehicle ~= lastVehicle then
                lastVehicle = vehicle
                Wait(200)
                local activebool = false
                lib.callback('ld-tunertablet:GetData',false, function(activedata)
                    Wait(1000)
                    if activedata ~= nil then
                        local ped = PlayerPedId()
                        local veh = GetVehiclePedIsUsing(ped)
                        activebool = true
                        setAdvancedData(veh, activedata, nil, true)
                    end
                end, plate, "ActiveData") 
                Wait(200)

                lib.callback('ld-tunertablet:GetData',false, function(driftModData)
                    Wait(1000)
                    if driftModData == true then
                        if driftMod[plate] == false or driftMod[plate] == nil then
                            driftMod[plate] = true
                        end
                    elseif driftModData == false then
                        if driftMod[plate] == true or driftMod[plate] == nil then
                            driftMod[plate] = false
                        end
                    end
                end, plate, "DriftMode") 

                Wait(200)
                lib.callback('ld-tunertablet:GetData',false, function(SportModOnData)
                    Wait(1000)
                    if SportModOnData == true then
                        if SportModOn[plate] == false or SportModOn[plate] == nil then
                            SportModOn[plate] = true
                        end
                    elseif SportModOnData == false then
                        if SportModOn[plate] == true then
                            lib.callback('ld-tunertablet:GetData',false, function(SportModeBool, olddata)
                                if SportModeBool == nil or SportModeBool == true then
                                    if oldSportMod[plate] == nil or oldSportMod[plate] == false then
                                        olddata = olddata
                                    else
                                        olddata = oldSportMod[plate]
                                    end
                                    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', olddata.oldfInitialDriveMaxFlatVel)
                                    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', olddata.oldffDriveInertia)
                                    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', olddata.oldfClutchChangeRateScaleUpShift)
                                    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', olddata.oldfClutchChangeRateScaleDownShift)
                                    TriggerServerEvent("ld-tunertablet:CreateTableData", plate , false, "CloseSportMod")
                                end
     
                            end, plate, "exOldData")
                            SportModOn[plate] = false
                        end
                    end
                end, plate, "IsSportModOn") 

                Wait(200)
                lib.callback('ld-tunertablet:GetData',false, function(tuningdata)
                    Wait(1000)
                    if tuningdata ~= nil then
                        setVehData(vehicle, tuningdata)
                    end
                end, plate, "TuningData") 
                Wait(200)
                lib.callback('ld-tunertablet:GetData',false, function(currentdata)
                    Wait(1000)
                    if currentdata ~= nil then
                        if not activebool then
                            local ped = PlayerPedId()
                            local veh = GetVehiclePedIsUsing(ped)
                            setAdvancedData(veh, currentdata, nil, true)
                        end

                    end
                end, plate, "CurrentVehicleData") 

            end
        else
            lastVehicle = nil
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(sleep)
        sleep = 3000
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
       
        if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            sleep = 1500
            local plate = GetVehicleNumberPlateText(vehicle)
            if Config.Modes["SpeedType"] then
                speed = math.ceil(GetEntitySpeed(vehicle) * 2.236936)
            else
                speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            end
            if driftMod[plate] then
                sleep = 0
                if IsControlPressed(1, 21) then
                    if speed <= tonumber(Config.Modes["DriftModeSpeedLimit"]) then
                        SetVehicleReduceGrip(vehicle, true)
                    end
                elseif IsControlJustReleased(1, 21) then
                    SetVehicleReduceGrip(vehicle, false)
                end
        
            end
        end

    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            local plate = GetVehicleNumberPlateText(vehicle)
            Wait(1000)
            if SportModOn[plate] then
                local oldfInitialDriveMaxFlatVelData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
                local oldfClutchChangeRateScaleUpShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift")
                local oldfClutchChangeRateScaleDownShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift")
            
                oldSportMod[plate] = {
                    oldfInitialDriveMaxFlatVel = oldfInitialDriveMaxFlatVelData,
                    oldffDriveInertia = oldfInitialDriveMaxFlatVelData,
                    oldfClutchChangeRateScaleUpShift = oldfInitialDriveMaxFlatVelData,
                    oldfClutchChangeRateScaleDownShift = oldfInitialDriveMaxFlatVelData,
                }
                
                SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', oldfInitialDriveMaxFlatVelData + (oldfInitialDriveMaxFlatVelData / 100 * 20))
                SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', 2.000000)
                SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', oldfClutchChangeRateScaleUpShiftData * 8)
                SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', oldfClutchChangeRateScaleDownShiftData * 8)
                break
            else
                lib.callback('ld-tunertablet:GetData',false, function(dataone, olddata)
                    if dataone == nil or dataone == false then 
                        return
                    else
                        olddata = oldSportMod[plate]
                        if olddata == nil  then return end
                        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', olddata.oldfInitialDriveMaxFlatVel)
                        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', olddata.oldffDriveInertia)
                        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', olddata.oldfClutchChangeRateScaleUpShift)
                        SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', olddata.oldfClutchChangeRateScaleDownShift)
                        TriggerServerEvent("ld-tunertablet:CreateTableData", plate , false, "CloseSportMod")
                    end

                end, plate, "exOldData")
                SportModOn[plate] = false
            end
        end

    end
end)

