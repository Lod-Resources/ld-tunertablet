Config = {}

Config.Language = "en" -- just en if u want add more lang from locales.lua

Config.Menu = {
    ["Commands"] = {
        ["Tuner"] = "tunertablet",
    },
}

Config.Modes = {
    ["SpeedType"] = "KMH",
    ["DriftModeSpeedLimit"] = 50,
    ["SportModeSettings"] = {
        ["fInitialDriveMaxFlatVel"] = 100 * 20,
        ["fDriveInertia"] = 2.000000,
        ["fClutchChangeRateScaleUpShift"] = 8,
        ["fClutchChangeRateScaleDownShift"] = 8,
    }
}

Config.Pages = {
    ["Main_Pages"] = {
        { title = 'Home', description = 'Start screen with quick access to your tunerchip settings. You can start tuning your vehicle here.' },
        { title = 'Presets', description = 'Load or create new presets for your vehicle. Customize and save configurations for quick access.' },
        { title = 'Simple Configuration', description = 'Easily configure basic settings for your vehicle. A user-friendly and quick editing interface.' },
        { title = 'Advanced Configuration', description = 'Fine-tune advanced settings like engine performance and suspension for optimal results.' },
        { title = 'Test Tool', description = 'One-to-one to measure your vehicles performance' },
        { title = 'XML', description = 'Export or import your vehicle settings as XML files for easy sharing or backup purposes.' }
    },
    ["Sub_Pages"] = {
        { title = 'Aero', description = 'This set of values represent the vehicle body shape, and mostly affect top speed behavior.' },
        { title = 'Chassis', description = 'This set of values represent the vehicle body itself, and will play a big role on how the vehicle behaves overall.' },
        { title = 'Engine', description = 'The moving force of your vehicle, this set of values govern details about how different bits of the engine will behave. Works in close relationswhip with Transmission.' },
        { title = 'Transmission', description = 'Together with the Engine, the transmission settings define the power output of your vehicle.' },
        { title = 'Brakes', description = 'Brakes are one of the main defining factors of the performance of your vehicle. This value should complement both the vehicles power and traction, so as to keep a coherent balance. Unless you have reasons for it not to.' },
        { title = 'Traction', description = 'Traction is the main limiter of power and braking ability, and has to be able to handle both; otherwise your vehicle may suffer wheelspin/wheel lock. However, these can also be treated as features and not defects, being part of the vehicles personality.' },
        { title = 'Suspension', description = 'Stiffer, softer, loose, tight. This section governs how your car floats above its wheels.' },
        { title = 'Anti-roll', description = 'The main goal of the Anti-roll Bars is to prevent the car from leaning too much when taking a corner. Do keep in mind that the wheels the cars leans into, receive more grip from the pressure, while the wheels on the other side lose traction.' }
    }
}

Config.ReadyPresets = {
    { title = 'Drift Mode', description = 'In Drift mode, you can drift by pressing the support button you set.' },
    { title = 'Eco Mode', description = 'Eco Mode has your cars standard settings and you can select this mode if you want to return it back.' },
    { title = 'Sport Mode', description = 'Sport Mode sophisticatedly indexes your vehicle to the ideal speed mode' }
}

Config.Configurables = {
    ["Simple"] = {
        {title = 'Boost', description = 'Also called engine power, it dictates the target acceleration the engine is aiming for, measured in G-Forces. Wheel grip may not be able to cope with it, however.', minValue = 0, maxValue = 0.5, step = 0.005, modal = 'fInitialDriveForce', fInitialDriveForce = 0},
        {title = 'Acceleration', description = 'How responsive the engine revs will be to throttle control. It is measured in Higher values will result in faster RPM acceleration and deceleration, while lower values will result in more sluggish RPMs.', minValue = 0, maxValue = 3, step = 0.001, modal = 'fDriveInertia', fDriveInertia = 0},
        {title = 'Gear Change', description = 'The vehicle will take 0.5s to shift from gear to gear.', minValue = 0, maxValue = 10, step = 0.25, modal = 'fClutchChangeRateScaleUpShift', fClutchChangeRateScaleUpShift = 0},
        {title = 'Breaking', description = 'Usually, the best balance is between 0.55 and 0.7 for best braking capabilities, as it accounts for the weight transfer that ensues when braking. (60% Front - 40% Rear)', minValue = 0, maxValue = 1, step = 0.025, modal = 'fBrakeBiasFront', fBrakeBiasFront = 0},
        {title = 'Drivetrain', description = 'Defines how the power from fInitialDriveForce is distributed between the axles. 0.0 implies a fully RWD setup, with will only deliver power to the rear wheels.', minValue = 0, maxValue = 1, step = 0.05, modal = 'fDriveBiasFront', fDriveBiasFront = 0},      
    },
    ["Advanced"] = {
        {subCategory = "Aero", title = 'Downforce', description = 'Downforce is a way to gain grip at speed, and can be increased by Spoilers. This car will generate 0.14Gs of additional grip at 60mph.', minValue = 0, maxValue = 5, step = 0.05, modal = 'fDownforceModifier', fDownforceModifier = 0},
        {subCategory = "Aero", title = 'Air Resistance', description = 'Higher resistance means an eariler perceived loss of power at higher speed, resulting in a lower top speed, as the engine cannot overpower this force. Lower air resistance allows the vehicle to travel faster on the same power.', minValue = 0, maxValue = 20, step = 0.5, modal = 'fInitialDragCoeff', fInitialDragCoeff = 0},
        
        -- Chassis
        {subCategory = "Chassis", title = 'Mass', description = 'Measured in Kg, mass is only responsible for the interaction between entities. Lets say its the vehicles pushing force.', minValue = 0, maxValue = 15000, step = 1, modal = 'fMass', fMass = 0},
        {subCategory = "Chassis", title = 'Center of Mass', description = 'This editor is not able to edit the Center Of Mass offsets yet.', minValue = -2, maxValue = 2, step = 1, modal = 'vecCentreOfMassOffset', vecCentreOfMassOffset = 0},
        {subCategory = "Chassis", title = 'Rotational Inertia', description = 'This editor is not able to edit the Rotational Inertia offsets yet.', minValue = -2, maxValue = 2, step = 1, modal = 'vecInertiaMultiplier', vecInertiaMultiplier = 0},
        
        -- Engine
        {subCategory = "Engine", title = 'Engine/Acceleration', description = 'Also called engine power, it dictates the target acceleration the engine is aiming for, measured in G-Forces. Wheel grip may not be able to cope with it, however.', minValue = 0, maxValue = 0.5, step = 0.005, modal = 'fInitialDriveForce', fInitialDriveForce = 0},
        {subCategory = "Engine", title = 'Drive inertia', description = 'How responsive the engine revs will be to throttle control. It is measured in Higher values will result in faster RPM acceleration and deceleration, while lower values will result in more sluggish RPMs.', minValue = 0, maxValue = 3, step = 0.001, modal = 'fDriveInertia', fDriveInertia = 0},
        {subCategory = "Engine", title = 'Top Speed', description = 'Maximum engine top speed. Over this speed, the engine power will degrade greatly. Keep in mind that gearing will stretch over this length.', minValue = 0, maxValue = 200, step = 1, modal = 'fInitialDriveMaxFlatVel', fInitialDriveMaxFlatVel = 0},
        
        -- Transmission
        {subCategory = "Transmission", title = 'Nº of Gears', description = 'As gears modulate the fInitialDriveForce up until fInitialDriveMaxFlatVel, keepin a reasonably number of gears for your top speed is reccomended. Remember Transmission upgrades add one gear total.', minValue = 0, maxValue = 6, step = 1, modal = 'nInitialDriveGears', nInitialDriveGears = 0},
        {subCategory = "Transmission", title = 'Up Shift times', description = '', minValue = 0, maxValue = 10, step = 0.25, modal = 'fClutchChangeRateScaleUpShift', fClutchChangeRateScaleUpShift = 0},
        {subCategory = "Transmission", title = 'Down Shift times', description = '', minValue = 0, maxValue = 10, step = 0.25, modal = 'fClutchChangeRateScaleDownShift', fClutchChangeRateScaleDownShift = 0},
        {subCategory = "Transmission", title = 'Power Bias', description = '', minValue = 0, maxValue = 1, step = 0.05, modal = 'fDriveBiasFront', fDriveBiasFront = 0},

        -- Brakes
        {subCategory = "Brakes", title = 'Brake Strength', description = 'How many Gs of deceleration are applied to each wheel. fTractionCurveMax and fBrakeForce are closely related. Assuming perfect balance, a fourth of brake is enough to make each wheel lockup.', minValue = 0.1, maxValue = 1, step = 0.001, modal = 'fBrakeForce', fBrakeForce = 0},
        {subCategory = "Brakes", title = 'Brake Bias', description = 'Distribution of the brake strength between the axles. Usually, the best balance is between 0.55 and 0.7 for best braking capabilities, as it accounts for the weight transfer that ensues when braking.', minValue = 0, maxValue = 1, step = 0.025, modal = 'fBrakeBiasFront', fBrakeBiasFront = 0},
        {subCategory = "Brakes", title = 'Handbrake Strength', description = 'Similar to fBrakeForce, but is only applied to the rear axle(s).', minValue = 0, maxValue = 1, step = 0.05, modal = 'fHandBrakeForce', fHandBrakeForce = 0},
        
        -- Traction
        {subCategory = "Traction", title = 'Tire Grip Curve Max', description = 'In V, grip is represented as how much the vehicles tires are able to accelerate or decelerate the cars body, as a whole.', minValue = 0, maxValue = 3, step = 0.05, modal = 'fTractionCurveMax', fTractionCurveMax = 0},
        {subCategory = "Traction", title = 'Tire Grip Curve Min', description = 'Similar to fBrakeForce, but is only applied to the rear axle(s).', minValue = 0, maxValue = 3, step = 0.05, modal = 'fTractionCurveMin', fTractionCurveMin = 0},
        {subCategory = "Traction", title = 'Traction Curve', description = 'Slide angle at which the car will enjoy the best grip available. The vehicle will tend to stay below half of this value. It is reccomended to keep it at default 22.5 on most vehicles, though Sports and Supercars can have it as low as 18º if you so desire, making them stay more straight. Over 24º is not reccomended save for the slidiest cars, like old muscles.', minValue = 10, maxValue = 30, step = 0.5, modal = 'fTractionCurveLateral', fTractionCurveLateral = 0},
        {subCategory = "Traction", title = 'Tire Grip Bias', description = 'This value perfectly describes situations where the front and rear axles have different kinds of wheels, be it the compounds are different, or the tire width is different. Very useful for dragsters and high performance cars who come with changes like these.', minValue = 0, maxValue = 1, step = 0.005, modal = 'fTractionBiasFront', fTractionBiasFront = 0},
        {subCategory = "Traction", title = 'Offroad Traction Loss', description = 'How exaggerated the traction loss is for this vehicle. A value of 1.0 makes the car lose grip on each surface as expected by the game. Below 1.0 you lose less grip than normal, over 1.0 you lose more grip than normal.', minValue = 0, maxValue = 1.5, step = 0.001, modal = 'fTractionLossMult', fTractionLossMult = 0},
        {subCategory = "Traction", title = 'Low Speed Burnout Mult', description = 'How exaggerated the fake burnout griploss is for this vehicle.', minValue = 0, maxValue = 2, step = 0.05, modal = 'fLowSpeedTractionLossMult', fLowSpeedTractionLossMult = 0},
        {subCategory = "Traction", title = 'Max Steer Angle', description = 'Maximum steering angle for the vehicle.', minValue = 0, maxValue = 50, step = 0.05, modal = 'fSteeringLock', fSteeringLock = 0},
        
        -- Suspension
        {subCategory = "Suspension", title = 'Spring Strength', description = 'Spring strength.', minValue = 0, maxValue = 5, step = 0.001, modal = 'fSuspensionForce', fSuspensionForce = 0},
        {subCategory = "Suspension", title = 'Spring Comp Dampen Strength', description = '', minValue = 0, maxValue = 3, step = 0.05, modal = 'fSuspensionCompDamp', fSuspensionCompDamp = 0},
        {subCategory = "Suspension", title = 'Spring Rebound Dampen Strength', description = 'How strongly the spring strength is dampened when compressing or decompressing.', minValue = 0, maxValue = 3, step = 0.05, modal = 'fSuspensionReboundDamp', fSuspensionReboundDamp = 0},
        {subCategory = "Suspension", title = 'Compression/Decompression Upper Limits', description = '', minValue = 0, maxValue = 1, step = 0.005, modal = 'fSuspensionUpperLimit', fSuspensionUpperLimit = 0},
        {subCategory = "Suspension", title = 'Compression/Decompression Lower Limits', description = 'Compression upper and lower limits, in meters. Yeah, use centimeters.', minValue = -1, maxValue = 0, step = 0.005, modal = 'fSuspensionLowerLimit', fSuspensionLowerLimit = 0},
        {subCategory = "Suspension", title = 'Suspension Raise', description = 'In meters, this raises or lowers the natural stance of the vehicle.', minValue = -1, maxValue = 1, step = 0.05, modal = 'fSuspensionRaise', fSuspensionRaise = 0},
        {subCategory = "Suspension", title = 'Strength Bias', description = 'Spring strength distribution between the axles of the vehicle.', minValue = 0, maxValue = 1, step = 0.005, modal = 'fSuspensionBiasFront', fSuspensionBiasFront = 0},
        
        -- Anti-roll
        {subCategory = "Anti-roll", title = 'Antiroll Strength', description = 'How strongly the antiroll bars try to keep the vehicle from leaning.', minValue = 0, maxValue = 2, step = 0.001, modal = 'fAntiRollBarForce', fAntiRollBarForce = 0},
        {subCategory = "Anti-roll", title = 'Strength Bias', description = 'Distribution of the antiroll bar strength between the car axles.', minValue = 0, maxValue = 1, step = 0.05, modal = 'fAntiRollBarBiasFront', fAntiRollBarBiasFront = 0},
        {subCategory = "Anti-roll", title = 'Rollcentre - Front', description = 'Relative to the model bottom, defines where the pivot point is. This is used for leaning.', minValue = 0, maxValue = 1, step = 0.001, modal = 'fRollCentreHeightFront', fRollCentreHeightFront = 0},
        {subCategory = "Anti-roll", title = 'Rollcentre - Back', description = 'Relative to the model bottom, defines where the pivot point is. This is used for leaning.', minValue = 0, maxValue = 1, step = 0.05, modal = 'fRollCentreHeightRear', fRollCentreHeightRear = 0}
    }
}