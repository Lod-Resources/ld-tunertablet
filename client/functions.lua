

LastEngineMultiplier = 1.0
function setVehData(veh, data)
    if not DoesEntityExist(veh) or not data then return nil end


    local settings = {}
    if data.SimpleConfiguration then
        for _, config in ipairs(data.SimpleConfiguration) do
            settings[config.modal] = config[config.modal]
        end
    end
    
  
    if settings.fInitialDriveForce then
        SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(settings.fInitialDriveForce) + 0.0)
    end
    
    if settings.fDriveInertia then
        SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(settings.fDriveInertia) + 0.0)
    end
    
    if settings.fClutchChangeRateScaleUpShift then
        SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(settings.fClutchChangeRateScaleUpShift) + 0.0)
    end
    
    if settings.fDriveBiasFront then
        SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(settings.fDriveBiasFront) + 0.0)
    end
    
    if settings.fBrakeBiasFront then
        SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(settings.fBrakeBiasFront) + 0.0)
    end
end

function setAdvancedData(veh, data, bool, three)
    local newdata = {}

  
    if three then
        if data.vehicleData ~= nil then
            newdata = data.vehicleData
        else
            DefaultAdvancedData(veh, GetVehicleNumberPlateText(veh), data)
            return
        end
    else
        if bool then
            newdata = data.vehicleData.AdvancedConfigurationData
        else
            newdata = data.AdvancedConfigurationData
        end
    end


    if not DoesEntityExist(veh) or not newdata then return nil end


    local vehicleData = {}

    for _, v in ipairs(newdata) do
        vehicleData[v.modal] = v[v.modal] or v.value or v.fMass or v.fInitialDriveForce or v.fBrakeForce
    end


    TriggerServerEvent("m-tuning:CreateTableData", GetVehicleNumberPlateText(veh), vehicleData, "CurrentVehicleData")


    SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(vehicleData.fDownforceModifier) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(vehicleData.fInitialDragCoeff) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(vehicleData.fMass) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(vehicleData.fInitialDriveForce) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(vehicleData.fDriveInertia) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(vehicleData.fInitialDriveMaxFlatVel) + 0.0)
    SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", tonumber(vehicleData.nInitialDriveGears))
    SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(vehicleData.fClutchChangeRateScaleUpShift) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(vehicleData.fClutchChangeRateScaleDownShift) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(vehicleData.fDriveBiasFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(vehicleData.fBrakeForce) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(vehicleData.fBrakeBiasFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(vehicleData.fHandBrakeForce) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(vehicleData.fTractionCurveMax) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(vehicleData.fTractionCurveMin) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(vehicleData.fTractionCurveLateral) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(vehicleData.fTractionBiasFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(vehicleData.fTractionLossMult) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(vehicleData.fLowSpeedTractionLossMult) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(vehicleData.fSteeringLock) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(vehicleData.fSuspensionForce))
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(vehicleData.fSuspensionCompDamp) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(vehicleData.fSuspensionReboundDamp) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(vehicleData.fSuspensionUpperLimit) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(vehicleData.fSuspensionLowerLimit) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(vehicleData.fSuspensionRaise) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(vehicleData.fSuspensionBiasFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(vehicleData.fAntiRollBarForce) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(vehicleData.fAntiRollBarBiasFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(vehicleData.fRollCentreHeightFront) + 0.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(vehicleData.fRollCentreHeightRear) + 0.0)
end



function DefaultAdvancedData(veh,plate, GelenData)
    if GelenData ~= nil then
        data = GelenData
        if data ~= nil then 
            local tonum = tonumber(data.nInitialDriveGears)
            if not DoesEntityExist(veh) or not data then return nil end
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(data.fDownforceModifier)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(data.fInitialDragCoeff)  + 0.0 )
            -- CHASIS
            SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(data.fMass)  + 0.0 )
            -- ENGINE
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(data.fInitialDriveForce)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(data.fDriveInertia)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(data.fInitialDriveMaxFlatVel)  + 0.0 )
            -- TRANSMISSION
            SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", math.floor(tonum)) -- İnteger
            SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.fClutchChangeRateScaleUpShift)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(data.fClutchChangeRateScaleDownShift)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(data.fDriveBiasFront))
            -- BRAKE
            SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(data.fBrakeForce)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(data.fBrakeBiasFront)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(data.fHandBrakeForce)  + 0.0 )
            -- TRACTION
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(data.fTractionCurveMax)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(data.fTractionCurveMin)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(data.fTractionCurveLateral)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(data.fTractionBiasFront)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(data.fTractionLossMult)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(data.fLowSpeedTractionLossMult)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(data.fSteeringLock)  + 0.0 )
            -- SUSPENSION
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(data.fSuspensionForce))
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(data.fSuspensionCompDamp)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(data.fSuspensionReboundDamp)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(data.fSuspensionUpperLimit)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(data.fSuspensionLowerLimit)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(data.fSuspensionRaise)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(data.fSuspensionBiasFront)  + 0.0 )
            -- ANTIROLL
            SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(data.fAntiRollBarForce)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(data.fAntiRollBarBiasFront)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(data.fRollCentreHeightFront)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(data.fRollCentreHeightRear)  + 0.0 )
            TriggerServerEvent("m-tuning:CreateTableData", plate, data, "CurrentVehicleData")
        end
    else
        lib.callback('m-tuning:sqlDta', false, function(data)

            if data ~= nil then 
                local tonum = tonumber(data.nInitialDriveGears)
                if not DoesEntityExist(veh) or not data then return nil end
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(data.fDownforceModifier)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(data.fInitialDragCoeff)  + 0.0 )
                -- CHASIS
                SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(data.fMass)  + 0.0 )
                -- ENGINE
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(data.fInitialDriveForce)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(data.fDriveInertia)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(data.fInitialDriveMaxFlatVel)  + 0.0 )
                -- TRANSMISSION
                SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", math.floor(tonum)) -- İnteger
                SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.fClutchChangeRateScaleUpShift)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(data.fClutchChangeRateScaleDownShift)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(data.fDriveBiasFront))
                -- BRAKE
                SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(data.fBrakeForce)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(data.fBrakeBiasFront)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(data.fHandBrakeForce)  + 0.0 )
                -- TRACTION
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(data.fTractionCurveMax)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(data.fTractionCurveMin)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(data.fTractionCurveLateral)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(data.fTractionBiasFront)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(data.fTractionLossMult)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(data.fLowSpeedTractionLossMult)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(data.fSteeringLock)  + 0.0 )
                -- SUSPENSION
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(data.fSuspensionForce))
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(data.fSuspensionCompDamp)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(data.fSuspensionReboundDamp)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(data.fSuspensionUpperLimit)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(data.fSuspensionLowerLimit)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(data.fSuspensionRaise)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(data.fSuspensionBiasFront)  + 0.0 )
                -- ANTIROLL
                SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(data.fAntiRollBarForce)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(data.fAntiRollBarBiasFront)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(data.fRollCentreHeightFront)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(data.fRollCentreHeightRear)  + 0.0 )
                TriggerServerEvent("m-tuning:CreateTableData", plate, data, "CurrentVehicleData")
            end
        end, plate, "DefaultData")
    end

end


local VehicleDefaultData = {}

function GetVehData(veh)
    VehicleDefaultData = {}
    VehicleDefaultData.fDownforceModifier = GetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier")
    VehicleDefaultData.fInitialDragCoeff = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff")
    -- CHASIS
    VehicleDefaultData.fMass = GetVehicleHandlingFloat(veh, "CHandlingData", "fMass")
    VehicleDefaultData.vecCentreOfMassOffset = GetVehicleHandlingVector(veh, "CHandlingData", "vecCentreOfMassOffset") -- Vector
    VehicleDefaultData.vecInertiaMultiplier = GetVehicleHandlingVector(veh, "CHandlingData", "vecInertiaMultiplier") -- Vector
    -- ENGINE
    VehicleDefaultData.fInitialDriveForce = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce") 
    VehicleDefaultData.fDriveInertia = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia") 
    VehicleDefaultData.fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel") 
    -- TRANSMISSION
    VehicleDefaultData.nInitialDriveGears = GetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears") -- İnteger
    VehicleDefaultData.fClutchChangeRateScaleUpShift = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift") 
    VehicleDefaultData.fClutchChangeRateScaleDownShift = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift") 
    VehicleDefaultData.fDriveBiasFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront") 
    -- BRAKE
    VehicleDefaultData.fBrakeForce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce") 
    VehicleDefaultData.fBrakeBiasFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront") 
    VehicleDefaultData.fHandBrakeForce = GetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce") 
    -- TRACTION
    VehicleDefaultData.fTractionCurveMax = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax") 
    VehicleDefaultData.fTractionCurveMin = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin") 
    VehicleDefaultData.fTractionCurveLateral = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral") 
    VehicleDefaultData.fTractionBiasFront= GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront") 
    VehicleDefaultData.fTractionLossMult = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult") 
    VehicleDefaultData.fLowSpeedTractionLossMult = GetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult") 
    VehicleDefaultData.fSteeringLock = GetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock") 
    -- SUSPENSION
    VehicleDefaultData.fSuspensionForce = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce") 
    VehicleDefaultData.fSuspensionCompDamp = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp") 
    VehicleDefaultData.fSuspensionReboundDamp = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp") 
    VehicleDefaultData.fSuspensionUpperLimit = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit") 
    VehicleDefaultData.fSuspensionLowerLimit = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit") 
    VehicleDefaultData.fSuspensionRaise = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise") 
    VehicleDefaultData.fSuspensionBiasFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront") 
    -- ANTIROLL
    VehicleDefaultData.fAntiRollBarForce = GetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce") 
    VehicleDefaultData.fAntiRollBarBiasFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront") 
    VehicleDefaultData.fRollCentreHeightFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront") 
    VehicleDefaultData.fRollCentreHeightRear = GetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear") 
    return VehicleDefaultData
end
