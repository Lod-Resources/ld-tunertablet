



const store = Vuex.createStore({
  state: {},
  mutations: {},
  actions: {}
});

const app = Vue.createApp({
  data: () => ({
    showUI: false,
    extrasUI: false,
    policeUI: false,
    recorderUI: false,
    presetInput: false,
    currentPage: "Home",
    currentPageDescription: "",
    currentSubPage: "Aero",
    currentSubPageDescription: "Fine-tune advanced settings like engine performance and suspension for optimal results.",
    currentVehicleName: "Annis Elegy",
    currentVehiclePlate: "CKN117X",
    currentVehicleAcceleration: 40,
    currentVehicleTopSpeed: 50,
    currentVehicleTraction: 20,
    currentVehicleBraking: 80,
    currentVehicleFuelLevel: 20,
    currentVehicleHealth: 20,
    currentVehicleOilLevel: 20,
    currentVehicleEngineTemp: 20,
    confirmChanges: false,
    currentTime: "12:00",
    showSubPages: false,
    XMLData: "",
    Pages: [
      // { title: 'Home', description: 'Start screen with quick access to your tunerchip settings. You can start tuning your vehicle here.' },
      // { title: 'Presets', description: 'Load or create new presets for your vehicle. Customize and save configurations for quick access.' },
      // { title: 'Simple Configuration', description: 'Easily configure basic settings for your vehicle. A user-friendly and quick editing interface.' },
      // { title: 'Advanced Configuration', description: 'Fine-tune advanced settings like engine performance and suspension for optimal results.' },
      // { title: 'Test Tool', description: 'One-to-one to measure your vehicles performance' },
      // { title: 'XML', description: 'Export or import your vehicle settings as XML files for easy sharing or backup purposes.' }
    ],
    subPages: [
      // { title: 'Aero', description: 'This set of values represent the vehicle body shape, and mostly affect top speed behavior.' },
      // { title: 'Chassis', description: 'This set of values represent the vehicle body itself, and will play a big role on how the vehicle behaves overall.' },
      // { title: 'Engine', description: 'The moving force of your vehicle, this set of values govern details about how different bits of the engine will behave. Works in close relationswhip with Transmission.' },
      // { title: 'Transmission', description: 'Together with the Engine, the transmission settings define the power output of your vehicle.' },
      // { title: 'Brakes', description: 'Brakes are one of the main defining factors of the performance of your vehicle. This value should complement both the vehicles power and traction, so as to keep a coherent balance. Unless you have reasons for it not to.' },
      // { title: 'Traction', description: 'Traction is the main limiter of power and braking ability, and has to be able to handle both; otherwise your vehicle may suffer wheelspin/wheel lock. However, these can also be treated as features and not defects, being part of the vehicles personality.' },
      // { title: 'Suspension', description: 'Stiffer, softer, loose, tight. This section governs how your car floats above its wheels.' },
      // { title: 'Anti-roll', description: 'The main goal of the Anti-roll Bars is to prevent the car from leaning too much when taking a corner. Do keep in mind that the wheels the cars leans into, receive more grip from the pressure, while the wheels on the other side lose traction.' },
    ],
    readyPresets: [
      // { title: 'Drift Mode', description: 'In Drift mode, you can drift by pressing the support button you set.' },
      // { title: 'Eco Mode', description: 'Eco Mode has your cars standard settings and you can select this mode if you want to return it back.' },
      // { title: 'Sport Mode', description: 'Sport Mode sophisticatedly indexes your vehicle to the ideal speed mode' },
    ],
    Presets: [

    ],
    SimpleConfiguration: [
      // {title: 'Boost', description: 'Also called engine power, it dictates the target acceleration the engine is aiming for, measured in G-Forces. Wheel grip may not be able to cope with it, however.', minValue: 0, maxValue: 0.5, step: 0.005, modal: 'fInitialDriveForce', fInitialDriveForce: 0},
      // {title: 'Acceleration', description: 'How responsive the engine revs will be to throttle control. It is measured in Higher values will result in faster RPM acceleration and deceleration, while lower values will result in more sluggish RPMs.', minValue: 0, maxValue: 3, step: 0.001 , modal: 'fDriveInertia', fDriveInertia: 0},
      // {title: 'Gear Change', description: 'The vehicle will take 0.5s to shift from gear to gear.', minValue: 0, maxValue: 10, step: 0.25 , modal: 'fClutchChangeRateScaleUpShift', fClutchChangeRateScaleUpShift: 0},
      // {title: 'Breaking', description: 'Usually, the best balance is between 0.55 and 0.7 for best braking capabilities, as it accounts for the weight transfer that ensues when braking. (60% Front - 40% Rear)', minValue: 0, maxValue: 1, step: 0.025 , modal: 'fBrakeBiasFront', fBrakeBiasFront: 0},
      // {title: 'Drivetrain', description: 'Defines how the power from fInitialDriveForce is distributed between the axles. 0.0 implies a fully RWD setup, with will only deliver power to the rear wheels.', minValue: 0, maxValue: 1, step: 0.05 , modal: 'fDriveBiasFront', fDriveBiasFront: 0},
    ],
   
    AdvancedConfiguration: [
      // Aero
      // {subCategory: "Aero", title: 'Downforce', description: 'Downforce is a way to gain grip at speed, and can be increased by Spoilers. This car will generate 0.14Gs of additional grip at 60mph.', minValue: 0, maxValue: 5, step: 0.05, modal: 'fDownforceModifier', fDownforceModifier: 0},
      // {subCategory: "Aero", title: 'Air Resistance', description: 'Higher resistance means an eariler perceived loss of power at higher speed, resulting in a lower top speed, as the engine cannot overpower this force. Lower air resistance allows the vehicle to travel faster on the same power.', minValue: 0, maxValue: 20, step: 0.5, modal: 'fInitialDragCoeff', fInitialDragCoeff: 0},
      // // Chassis
      // {subCategory: "Chassis", title: 'Mass', description: 'Measured in Kg, mass is only responsible for the interaction between entities. Lets say its the vehicles pushing force.', minValue: 0, maxValue: 15000, step: 1, modal: 'fMass', fMass: 0},
      // {subCategory: "Chassis", title: 'Center of Mass', description: 'This editor is not able to edit the Center Of Mass offsets yet.', minValue: -2, maxValue: 2, step: 1, modal: 'vecCentreOfMassOffset', vecCentreOfMassOffset: 0},
      // {subCategory: "Chassis", title: 'Rotational Inertia', description: 'This editor is not able to edit the Rotational Inertia offsets yet.', minValue: -2, maxValue: 2, step: 1, modal: 'vecInertiaMultiplier', vecInertiaMultiplier: 0},
      // // Engine
      // {subCategory: "Engine", title: 'Engine/Acceleration', description: 'Also called engine power, it dictates the target acceleration the engine is aiming for, measured in G-Forces. Wheel grip may not be able to cope with it, however.', minValue: 0, maxValue: 0.5, step: 0.005, modal: 'fInitialDriveForce', fInitialDriveForce: 0},
      // {subCategory: "Engine", title: 'Drive inertia', description: 'How responsive the engine revs will be to throttle control. It is measured in Higher values will result in faster RPM acceleration and deceleration, while lower values will result in more sluggish RPMs.', minValue: 0, maxValue: 3, step: 0.001, modal: 'fDriveInertia', fDriveInertia: 0},
      // {subCategory: "Engine", title: 'Top Speed', description: 'Maximum engine top speed. Over this speed, the engine power will degrade greatly. Keep in mind that gearing will stretch over this length.', minValue: 0, maxValue: 200, step: 1, modal: 'fInitialDriveMaxFlatVel', fInitialDriveMaxFlatVel: 0},
      // // Transmission
      // {subCategory: "Transmission", title: 'Nº of Gears', description: 'As gears modulate the fInitialDriveForce up until fInitialDriveMaxFlatVel, keepin a reasonably number of gears for your top speed is reccomended. Remember Transmission upgrades add one gear total.', minValue: 0, maxValue: 6, step: 1, modal: 'nInitialDriveGears', nInitialDriveGears: 0},
      // {subCategory: "Transmission", title: 'Up Shift times', description: '', minValue: 0, maxValue: 10, step: 0.25, modal: 'fClutchChangeRateScaleUpShift', fClutchChangeRateScaleUpShift: 0},
      // {subCategory: "Transmission", title: 'Down Shift times', description: '', minValue: 0, maxValue: 10, step: 0.25, modal: 'fClutchChangeRateScaleDownShift', fClutchChangeRateScaleDownShift: 0},
      // {subCategory: "Transmission", title: 'Power Bias', description: '', minValue: 0, maxValue: 1, step: 0.05, modal: 'fDriveBiasFront', fDriveBiasFront: 0},

      // // Brakes
      // {subCategory: "Brakes", title: 'Brake Strength', description: 'How many Gs of deceleration are applied to each wheel. fTractionCurveMax and fBrakeForce are closely related. Assuming perfect balance, a fourth of brake is enough to make each wheel lockup.', minValue: 0.1, maxValue: 1, step: 0.001, modal: 'fBrakeForce', fBrakeForce: 0},
      // {subCategory: "Brakes", title: 'Brake Bias', description: 'Distribution of the brake strength between the axles. Usually, the best balance is between 0.55 and 0.7 for best braking capabilities, as it accounts for the weight transfer that ensues when braking.', minValue: 0, maxValue: 1, step: 0.025, modal: 'fBrakeBiasFront', fBrakeBiasFront: 0},
      // {subCategory: "Brakes", title: 'Handbrake Strength', description: 'Similar to fBrakeForce, but is only applied to the rear axle(s).', minValue: 0, maxValue: 1, step: 0.05, modal: 'fHandBrakeForce', fHandBrakeForce: 0},
      // // Traction
      // {subCategory: "Traction", title: 'Tire Grip Curve Max', description: 'In V, grip is represented as how much the vehicles tires are able to accelerate or decelerate the cars body, as a whole.', minValue: 0, maxValue: 3, step: 0.05, modal: 'fTractionCurveMax', fTractionCurveMax: 0},
      // {subCategory: "Traction", title: 'Tire Grip Curve Min', description: 'Similar to fBrakeForce, but is only applied to the rear axle(s).', minValue: 0, maxValue: 3, step: 0.05, modal: 'fTractionCurveMin', fTractionCurveMin: 0},
      // {subCategory: "Traction", title: 'Traction Curve', description: 'Slide angle at which the car will enjoy the best grip available. The vehicle will tend to stay below half of this value. It is reccomended to keep it at default 22.5 on most vehicles, though Sports and Supercars can have it as low as 18º if you so desire, making them stay more straight. Over 24º is not reccomended save for the slidiest cars, like old muscles.', minValue: 10, maxValue: 30, step: 0.5, modal: 'fTractionCurveLateral', fTractionCurveLateral: 0},
      // {subCategory: "Traction", title: 'Tire Grip Bias', description: 'This value perfectly describes situations where the front and rear axles have different kinds of wheels, be it the compounds are different, or the tire width is different. Very useful for dragsters and high performance cars who come with changes like these.', minValue: 0, maxValue: 1, step: 0.005, modal: 'fTractionBiasFront', fTractionBiasFront: 0},
      // {subCategory: "Traction", title: 'Offroad Traction Loss', description: 'How exaggerated the traction loss is for this vehicle. A value of 1.0 makes the car lose grip on each surface as expected by the game. Below 1.0 you lose less grip than normal, over 1.0 you lose more grip than normal.', minValue: 0, maxValue: 1.5, step: 0.001, modal: 'fTractionLossMult', fTractionLossMult: 0},
      // {subCategory: "Traction", title: 'Low Speed Burnout Mult', description: 'How exaggerated the fake burnout griploss is for this vehicle.', minValue: 0, maxValue: 2, step: 0.05, modal: 'fLowSpeedTractionLossMult', fLowSpeedTractionLossMult: 0},
      // {subCategory: "Traction", title: 'Max Steer Angle', description: 'Maximum steering angle for the vehicle.', minValue: 0, maxValue: 50, step: 0.05, modal: 'fSteeringLock', fSteeringLock: 0},
      // // Suspension
      // {subCategory: "Suspension", title: 'Spring Strength', description: 'Spring strength.', minValue: 0, maxValue: 5, step: 0.001, modal: 'fSuspensionForce', fSuspensionForce: 0},
      // {subCategory: "Suspension", title: 'Spring Comp Dampen Strength', description: '', minValue: 0, maxValue: 3, step: 0.05, modal: 'fSuspensionCompDamp', fSuspensionCompDamp: 0},
      // {subCategory: "Suspension", title: 'Spring Rebound Dampen Strength', description: 'How strongly the spring strength is dampened when compressing or decompressing.', minValue: 0, maxValue: 3, step: 0.05, modal: 'fSuspensionReboundDamp', fSuspensionReboundDamp: 0},
      // {subCategory: "Suspension", title: 'Compression/Decompression Upper Limits', description: '', minValue: 0, maxValue: 1, step: 0.005, modal: 'fSuspensionUpperLimit', fSuspensionUpperLimit: 0},
      // {subCategory: "Suspension", title: 'Compression/Decompression Lower Limits', description: 'Compression upper and lower limits, in meters. Yeah, use centimeters.', minValue: -1, maxValue: 0, step: 0.005, modal: 'fSuspensionLowerLimit', fSuspensionLowerLimit: 0},
      // {subCategory: "Suspension", title: 'Suspension Raise', description: 'In meters, this raises or lowers the natural stance of the vehicle.', minValue: -1, maxValue: 1, step: 0.05, modal: 'fSuspensionRaise', fSuspensionRaise: 0},
      // {subCategory: "Suspension", title: 'Strength Bias', description: 'Spring strength distribution between the axles of the vehicle.', minValue: 0, maxValue: 1, step: 0.005, modal: 'fSuspensionBiasFront', fSuspensionBiasFront: 0},
      // // Anti-roll
      // {subCategory: "Anti-roll", title: 'Antiroll Strength', description: 'How strongly the antiroll bars try to keep the vehicle from leaning.', minValue: 0, maxValue: 2, step: 0.001, modal: 'fAntiRollBarForce', fAntiRollBarForce: 0},
      // {subCategory: "Anti-roll", title: 'Strength Bias', description: 'Distribution of the antiroll bar strength between the car axles.', minValue: 0, maxValue: 1, step: 0.05, modal: 'fAntiRollBarBiasFront', fAntiRollBarBiasFront: 0},
      // {subCategory: "Anti-roll", title: 'Rollcentre - Front', description: 'Relative to the model bottom, defines where the pivot point is. This is used for leaning.', minValue: 0, maxValue: 1, step: 0.001, modal: 'fRollCentreHeightFront', fRollCentreHeightFront: 0},
      // {subCategory: "Anti-roll", title: 'Rollcentre - Back', description: 'Relative to the model bottom, defines where the pivot point is. This is used for leaning.', minValue: 0, maxValue: 1, step: 0.05, modal: 'fRollCentreHeightRear', fRollCentreHeightRear: 0},
    ],
    Content: ``,
    Locales: {
      // welcome: "Welcome",
      // ucreatedpresets: "Your Created Presets",
      // vehiclestats: "Vehicle Stats",
      // acceleration: "Acceleration",
      // speed: "Speed",
      // handling: "Traction",
      // braking: "Braking",
      // oiltemp: "Fuel Level",
      // dashtemp: "Engine Health",
      // watertemp: "Oil Level",
      // enginetemp: "Engine Temp",
      // confirmtext: "You are responsible for any modifications to your vehicle, please do not do this if you are not sure.",
      // metrics: "Metrics",
      // metricsdescription: "This editor makes an effort of translating some handling items to real world measurements, depicted in red on them. For transparency and ease of fact-checking, this section documents and details the math used to get the Ingame metrics.",
      // ucreatedpresetsdesc: "You can easily access or delete the settings you have edited and saved from the specially developed configuration page."
    },
    currentData: [],
    customsPageData: [],
    presetName: "",
    reachHundred: 0,
    reachQuarterMile: 0,
    reachSixty: 0,
    reachHalfMile: 0,
    counter: 0,
    timer: null,
  }),
 
  methods: {
    resetSettings() {
      postNUI("DEFAULT_BACK")
      setTimeout(() => {
        this.tuningTablet = true
        postNUI('GET_ADVANCED_DATA',{})
      }, 300);
    },
    applySettingsSimple() {
      postNUI('SAVE_SIMPLE_SETTINGS',{
        SimpleConfiguration : this.SimpleConfiguration,
        }
      )
      
    },
    applySettingsAdvanced() {
      postNUI('SAVE_ADVANCED_SETTINGS',{
        AdvancedConfigurationData : this.AdvancedConfiguration,
        dataname : this.presetName 
        }
      )
      this.extrasUI = false
      this.presetInput = false
       postNUI('GET_CUSTOMS_DATA', {});
      this.currentPage == "Presets"
    },
  
    
    openInput() {
      this.extrasUI = true
      this.presetInput = true
    },
    applySettingsPreview() {
    },
    selectReadyPreset(title) {
      postNUI('CHANGE_MODE',{
        mode : title,
      }
      )
      this.selectedCustomPreset = title;
      this.selectedReadyPreset = null;
    },
    deletePreset(title, index) {
      const selectedData = this.Presets.find(preset => preset.title === title);
      if (selectedData) {
          postNUI('DELETE_PRESET', {
              vehicleData: selectedData
          });
      }
      this.currentPage = "Presets";

    this.Presets.splice(index, 1);
    this.currentPage = "Presets";
    },
    InsertXML(title) {
      const selectedData = this.Presets.find(preset => preset.title === title);
  
      if (!selectedData) {
          console.error("❌ Selected preset not found for title:", title);
          return;
      }
      const vehicleData = {
          dataname: selectedData.title, 
          AdvancedConfigurationData: selectedData.AdvancedConfigurationData || [] 
      };
      postNUI('GET_XML_DATA', {
          vehicleData: vehicleData
      });
      postNUI('GET_ADVANCED_DATA')
      postNUI('GET_CUSTOMS_DATA',{})
      this.currentPage = "Presets"; 
    },  
    // Update Methods
    updateHandlingData(handlingData) {
      this.SimpleConfiguration.forEach((item) => {
        if (handlingData[item.modal] !== undefined) {
          item[item.modal] = handlingData[item.modal];
        }
      });
      this.AdvancedConfiguration.forEach((item) => {
        if (handlingData[item.modal] !== undefined) {
          item[item.modal] = handlingData[item.modal];
        }
      });
    },
    // UI Methods
    toggleConfirm() {
      this.confirmChanges = !this.confirmChanges; 
    },
    increaseValue(item) {
      item[item.modal] = Math.min(item[item.modal] + item.step, item.maxValue);
    },
    decreaseValue(item) {
      item[item.modal] = Math.max(item[item.modal] - item.step, item.minValue);
    },
    onInputChange(item, modal) {
      item[modal] = parseFloat(item[modal]);
    },
    updateTime() {
      const now = new Date();
      const hours = now.getHours();
      const minutes = now.getMinutes().toString().padStart(2, '0');
      const seconds = now.getSeconds().toString().padStart(2, '0');
      const ampm = hours >= 12 ? 'PM' : 'AM';
      const formattedHours = hours % 12 || 12; 
      this.currentTime = `${formattedHours}:${minutes}:${seconds} ${ampm}`;
    },
    updatePage(page) {
      this.currentPage = page.title;
      this.currentPageDescription = page.description;
      if (this.currentPage == "Presets") {

        postNUI('GET_CUSTOMS_DATA',{})
      } else if (this.currentPage == "Advanced Configuration") {
        postNUI('GET_ADVANCED_DATA',{})
        postNUI('GET_CUSTOMS_DATA',{})
      } else if (this.currentPage == "Test Tool") {
        this.extrasUI = true 
        this.recorderUI = true
        this.policeUI = false
        this.presetInput= false
        this.showUI = false
        this.currentPage = "Home"
        postNUI('TEST_TOOL')
   
      }
    },
    updateSubPage(subpage) {
      this.currentPage = "Advanced Configuration";
      this.currentSubPage = subpage.title;
      this.currentSubPageDescription = subpage.description;

    },
    hideSubPages() {
      this.showSubPages = false;
    },
    copyHandling() {
      const textArea = document.createElement('textarea');
      textArea.value = this.generatedXML;
      document.body.appendChild(textArea);
      textArea.select();
      document.execCommand('copy');
      document.body.removeChild(textArea);
    },
    downloadHandling() {
      if (!this.generatedXML.trim()) {

        return;
    }

    const file = new Blob([this.generatedXML], { type: "text/xml" });
    const url = URL.createObjectURL(file);

    if (typeof window.invokeNative !== "undefined") {
        window.invokeNative("openUrl", url); // FiveM tarayıcısında URL aç
    } else {

        const a = document.createElement("a");
        a.href = url;
        a.download = "handling.xml"; // Dosya adı
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }
    },
    exitUI() {
      postNUI("exit");
      this.showUI = false
    },
    startTimer() {
      if (this.timer) return; 
      this.counter = 0;
      this.timer = setInterval(() => {
        this.counter++;
        if (this.reachHalfMile > 0) {
          this.stopTimer();
        }
      }, 1000);
    },
    stopTimer() {
      if (this.timer) {
        clearInterval(this.timer);
        this.timer = null;
      }
    },
    resetTimer() {
      this.stopTimer();
      this.counter = 0;
    }
  },
  

  computed: {
    filteredConfiguration() {
      return this.AdvancedConfiguration.filter(
        (item) => item.subCategory === this.currentSubPage
      );
    },
    filteredConfigurations() {
      return this.AdvancedConfiguration.filter(item => item.subCategory === this.currentSubPage);
    },
    advancedConfigMap() {
      return this.AdvancedConfiguration.reduce((acc, item) => {
        acc[item.modal] = item[item.modal];
        return acc;
      }, {});
    },
    generatedXML() {
      return `
        <?xml version="1.0" encoding="UTF-8"?>
                        <CHandlingDataMgr>
                          <HandlingData>
                          <Item type="CHandlingData">
                            <handlingName>${this.currentVehicleName}</handlingName>
                            <fMass value="${this.advancedConfigMap.fMass}" />
                            <fInitialDragCoeff value="${this.advancedConfigMap.fInitialDragCoeff}" />
                            <fDownforceModifier value="${this.advancedConfigMap.fDownforceModifier}" />
                            <fPercentSubmerged value="85.000000" />
                            <vecCentreOfMassOffset x="0.000000" y="0.00000" z="0.000000" />
                            <vecInertiaMultiplier x="1.400000" y="1.400000" z="1.600000" />
                            <fDriveBiasFront value="${this.advancedConfigMap.fDriveBiasFront }" />
                            <nInitialDriveGears value="${this.advancedConfigMap.nInitialDriveGears}" />
                            <fInitialDriveForce value="${this.advancedConfigMap.fInitialDriveForce}" />
                            <fDriveInertia value="${this.advancedConfigMap.fDriveInertia}" />
                            <fClutchChangeRateScaleUpShift value="${this.advancedConfigMap.fClutchChangeRateScaleUpShift}" />
                            <fClutchChangeRateScaleDownShift value="${this.advancedConfigMap.fClutchChangeRateScaleDownShift }" />
                            <fInitialDriveMaxFlatVel value="${this.advancedConfigMap.fInitialDriveMaxFlatVel}" />
                            <fBrakeForce value="${this.advancedConfigMap.fBrakeForce}" />
                            <fBrakeBiasFront value="${this.advancedConfigMap.fBrakeBiasFront}" />
                            <fHandBrakeForce value="${this.advancedConfigMap.fHandBrakeForce}" />
                            <fSteeringLock value="${this.advancedConfigMap.fSteeringLock}" />
                            <fTractionCurveMax value="${this.advancedConfigMap.fTractionCurveMax}" />
                            <fTractionCurveMin value="${this.advancedConfigMap.fTractionCurveMin}" />
                            <fTractionCurveLateral value="${this.advancedConfigMap.fTractionCurveLateral}" />
                            <fTractionSpringDeltaMax value="0.150000" />
                            <fLowSpeedTractionLossMult value="${this.advancedConfigMap.fLowSpeedTractionLossMult}" />
                            <fCamberStiffnesss value="0.000000" />
                            <fTractionBiasFront value="${this.advancedConfigMap.fTractionBiasFront}" />
                            <fTractionLossMult value="${this.advancedConfigMap.fTractionLossMult}" />
                            <fSuspensionForce value="${this.advancedConfigMap.fSuspensionForce}" />
                            <fSuspensionCompDamp value="${this.advancedConfigMap.fSuspensionCompDamp}" />
                            <fSuspensionReboundDamp value="${this.advancedConfigMap.fSuspensionReboundDamp}" />
                            <fSuspensionUpperLimit value="${this.advancedConfigMap.fSuspensionUpperLimit}" />
                            <fSuspensionLowerLimit value="${this.advancedConfigMap.fSuspensionLowerLimit}" />
                            <fSuspensionRaise value="${this.advancedConfigMap.fSuspensionRaise}" />
                            <fSuspensionBiasFront value="${this.advancedConfigMap.fSuspensionBiasFront}" />
                            <fAntiRollBarForce value="${this.advancedConfigMap.fAntiRollBarForce}" />
                            <fAntiRollBarBiasFront value="${this.advancedConfigMap.fAntiRollBarBiasFront}" />
                            <fRollCentreHeightFront value="${this.advancedConfigMap.fRollCentreHeightFront}" />
                            <fRollCentreHeightRear value="${this.advancedConfigMap.fRollCentreHeightRear}" />
                            <fCollisionDamageMult value="1.0000" />
                            <fWeaponDamageMult value="1.000000" />
                            <fDeformationDamageMult value="1.000000" />
                            <fEngineDamageMult value="1.500000" />
                            <fPetrolTankVolume value="65.000000" />
                            <fOilVolume value="5.000000" />
                            <fSeatOffsetDistX value="0.000000" />
                            <fSeatOffsetDistY value="0.000000" />
                            <fSeatOffsetDistZ value="0.000000" />
                            <nMonetaryValue value="35000" />
                            <strModelFlags>440010</strModelFlags>
                            <strHandlingFlags>20000</strHandlingFlags>
                            <strDamageFlags>0</strDamageFlags>
                            <AIHandling>AVERAGE</AIHandling>
                            <SubHandlingData>
                                <Item type="NULL" />
                                <Item type="NULL" />
                                <Item type="NULL" />
                            </SubHandlingData>
                            </Item>
                        </HandlingData>
                        </CHandlingDataMgr>
      `;
    }
  },

  mounted() {
    this.updateTime();
    setInterval(this.updateTime, 1000);
    const defaultPage = this.Pages.find(page => page.title === this.currentPage);
    if (defaultPage) {
      this.currentPageDescription = defaultPage.description;
    }
    window.addEventListener("message", (event) => {
      if (event.data.action == "SHOW_INTERFACE") {
        this.showUI = true
        this.Locales = event.data.Locales
        this.AdvancedConfiguration = event.data.AdvancedConfiguration
        this.SimpleConfiguration = event.data.SimpleConfiguration
        this.readyPresets = event.data.readyPresets
        this.Pages = event.data.Pages
        this.subPages = event.data.subPages
        this.currentVehicleName = event.data.vehicleDatas.currentVehicleName
        this.currentVehiclePlate = event.data.vehicleDatas.currentVehiclePlate
        this.extrasUI = false 
        this.recorderUI = false
        this.policeUI = false
        this.currentVehicleAcceleration = event.data.vehicleDatas.currentVehicleAcceleration
        this.currentVehicleTopSpeed = event.data.vehicleDatas.currentVehicleTopSpeed
        this.currentVehicleTraction = event.data.vehicleDatas.currentVehicleTraction
        this.currentVehicleBraking = event.data.vehicleDatas.currentVehicleBraking
        this.currentVehicleFuelLevel = event.data.vehicleDatas.currentVehicleFuelLevel
        this.currentVehicleHealth = event.data.vehicleDatas.currentVehicleHealth
        this.currentVehicleOilLevel = event.data.vehicleDatas.currentVehicleOilLevel
        this.currentVehicleEngineTemp = event.data.vehicleDatas.currentVehicleEngineTemp
        this.updateHandlingData(event.data.handlingData);
        postNUI('GET_CUSTOMS_DATA',{})

        
      } if (event.data.action == "GET_CURRENT_DATA") {
        const receivedData = event.data.GetCurrentData; 

        this.Presets = receivedData.map(item => ({
          title: item.Data.dataname || "Unknown Preset", 
          description: "Saved", 
          AdvancedConfigurationData	: item.Data.AdvancedConfigurationData	 
        }));
      } if (event.data.action == "GET_VEHICLE_DATA") {
        this.updateHandlingData(event.data.vehicleData);
        postNUI('GET_CUSTOMS_DATA',{})
      } if (event.data.action == "GET_TOOL") {
       
        this.extrasUI = true 
        this.recorderUI = true
        this.policeUI = false
        this.presetInput= false
        this.showUI = false
        this.reachHundred = event.data.reach100
        this.reachSixty = event.data.reach60
        this.reachQuarterMile = event.data.reachquart
        this.reachHalfMile = event.data.reachhalf
      } 
      if (event.data.action == "TIMER") {
        if (event.data.status == 0) {
          this.stopTimer();
        } else if (event.data.status == 1) {
          this.startTimer();
        }  else if (event.data.status == 2) {
          this.resetTimer();
        }
      } 
      document.onkeyup = (data) => {
        if (data.which == 27) {
          postNUI("exit");
          this.showUI = false;
          return;
        }
      };
    });

  },

  destroyed() {

  },
  created() {

  },
  beforeDestroy() {
  },
});

app.use(store).mount("#app");


var resourceName = "ld-tunertablet";

if (window.GetParentResourceName) {
  resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
  try {
    const response = await fetch(`https://${resourceName}/${name}`, {
      method: "POST",
      mode: "cors",
      cache: "no-cache",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json"
      },
      redirect: "follow",
      referrerPolicy: "no-referrer",
      body: JSON.stringify(data)
    });
    return !response.ok ? null : response.json();
  } catch (error) {
    // console.log(error)
  }
};



