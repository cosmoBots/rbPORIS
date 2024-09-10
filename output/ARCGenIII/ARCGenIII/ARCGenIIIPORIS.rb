require_relative 'PORIS'

class ARCGenIIIPORIS < PORISDoc
    def initialize(project_id)
        super(project_id)
        @sysARCGenIII = PORISSys.new("ARCGenIII")
        @mdARCGenIIIMode_UNKNOWN = PORISMode.new("ARCGenIIIMode_UNKNOWN")
        self.setRoot(@sysARCGenIII)
        @sysFirmware = PORISSys.new("Firmware")
        @mdFirmwareMode_UNKNOWN = PORISMode.new("FirmwareMode_UNKNOWN")
        @sysVariants = PORISSys.new("Variants")
        @mdVariantsMode_UNKNOWN = PORISMode.new("VariantsMode_UNKNOWN")
        @sysAcquisition = PORISSys.new("Acquisition")
        @mdAcquisitionMode_UNKNOWN = PORISMode.new("AcquisitionMode_UNKNOWN")
        @prShuffleLines = PORISParam.new("ShuffleLines")
        @mdShuffleLinesMode_UNKNOWN = PORISMode.new("ShuffleLinesMode_UNKNOWN")
        @vlShuffleLines_UNKNOWN = PORISValue.new("ShuffleLines_UNKNOWN")
        @prShiftNumber = PORISParam.new("ShiftNumber")
        @mdShiftNumberMode_UNKNOWN = PORISMode.new("ShiftNumberMode_UNKNOWN")
        @vlShiftNumber_UNKNOWN = PORISValue.new("ShiftNumber_UNKNOWN")
        @sysSubarrayFeature = PORISSys.new("SubarrayFeature")
        @mdSubarrayFeatureMode_UNKNOWN = PORISMode.new("SubarrayFeatureMode_UNKNOWN")
        @prCols = PORISParam.new("Cols")
        @mdColsMode_UNKNOWN = PORISMode.new("ColsMode_UNKNOWN")
        @vlCols_UNKNOWN = PORISValue.new("Cols_UNKNOWN")
        @proffsetRow = PORISParam.new("offsetRow")
        @mdoffsetRowMode_UNKNOWN = PORISMode.new("offsetRowMode_UNKNOWN")
        @vloffsetRow_UNKNOWN = PORISValue.new("offsetRow_UNKNOWN")
        @prRows = PORISParam.new("Rows")
        @mdRowsMode_UNKNOWN = PORISMode.new("RowsMode_UNKNOWN")
        @vlRows_UNKNOWN = PORISValue.new("Rows_UNKNOWN")
        @proffsetCol = PORISParam.new("offsetCol")
        @mdoffsetColMode_UNKNOWN = PORISMode.new("offsetColMode_UNKNOWN")
        @vloffsetCol_UNKNOWN = PORISValue.new("offsetCol_UNKNOWN")
        @sysExposureCtrl = PORISSys.new("ExposureCtrl")
        @mdExposureCtrlMode_UNKNOWN = PORISMode.new("ExposureCtrlMode_UNKNOWN")
        @sysOpenShutter = PORISSys.new("OpenShutter")
        @mdOpenShutterMode_UNKNOWN = PORISMode.new("OpenShutterMode_UNKNOWN")
        @prExpTime = PORISParam.new("ExpTime")
        @mdExpTimeMode_UNKNOWN = PORISMode.new("ExpTimeMode_UNKNOWN")
        @vlExpTime_UNKNOWN = PORISValue.new("ExpTime_UNKNOWN")
        @sysPixelSpeed = PORISSys.new("PixelSpeed")
        @mdPixelSpeedMode_UNKNOWN = PORISMode.new("PixelSpeedMode_UNKNOWN")
        @prnumOfFrames = PORISParam.new("numOfFrames")
        @mdnumOfFramesMode_UNKNOWN = PORISMode.new("numOfFramesMode_UNKNOWN")
        @vlnumOfFrames_UNKNOWN = PORISValue.new("numOfFrames_UNKNOWN")
        @prCalibGain = PORISParam.new("CalibGain")
        @mdCalibGainMode_UNKNOWN = PORISMode.new("CalibGainMode_UNKNOWN")
        @vlCalibGain_UNKNOWN = PORISValue.new("CalibGain_UNKNOWN")
        @sysOutputSource = PORISSys.new("OutputSource")
        @mdOutputSourceMode_UNKNOWN = PORISMode.new("OutputSourceMode_UNKNOWN")
        @sysRecomposition = PORISSys.new("Recomposition")
        @mdRecompositionMode_UNKNOWN = PORISMode.new("RecompositionMode_UNKNOWN")
        @sysDimensions = PORISSys.new("Dimensions")
        @mdDimensionsMode_UNKNOWN = PORISMode.new("DimensionsMode_UNKNOWN")
        @pruiRows = PORISParam.new("uiRows")
        @mduiRowsMode_UNKNOWN = PORISMode.new("uiRowsMode_UNKNOWN")
        @vluiRows_UNKNOWN = PORISValue.new("uiRows_UNKNOWN")
        @pruiCols = PORISParam.new("uiCols")
        @mduiColsMode_UNKNOWN = PORISMode.new("uiColsMode_UNKNOWN")
        @vluiCols_UNKNOWN = PORISValue.new("uiCols_UNKNOWN")
        @prBinning = PORISParam.new("Binning")
        @mdBinningMode_UNKNOWN = PORISMode.new("BinningMode_UNKNOWN")
        @vlBinning_UNKNOWN = PORISValue.new("Binning_UNKNOWN")
        @mdARCGenIIIMode_Real = PORISMode.new("ARCGenIIIMode_Real")
        @mdARCGenIIIMode_Emulated = PORISMode.new("ARCGenIIIMode_Emulated")
        @mdFirmwareMode_tim = PORISMode.new("FirmwareMode_tim")
        @mdFirmwareMode_osiris2 = PORISMode.new("FirmwareMode_osiris2")
        @mdFirmwareMode_osiris3 = PORISMode.new("FirmwareMode_osiris3")
        @mdFirmwareMode_osiris4 = PORISMode.new("FirmwareMode_osiris4")
        @mdFirmwareMode_osiris5 = PORISMode.new("FirmwareMode_osiris5")
        @mdAcquisitionMode_Normal = PORISMode.new("AcquisitionMode_Normal")
        @mdAcquisitionMode_FrameTransfer = PORISMode.new("AcquisitionMode_FrameTransfer")
        @mdAcquisitionMode_Shuffling = PORISMode.new("AcquisitionMode_Shuffling")
        @vlShuffleLines_Full_Range = PORISValueFloat.new("ShuffleLines_Full_Range",0,200,1000)
        @mdShuffleLinesMode_Normal = PORISMode.new("ShuffleLinesMode_Normal")
        @vlShiftNumber_Full_Range = PORISValueFloat.new("ShiftNumber_Full_Range",0,5,1000)
        @mdShiftNumberMode_Normal = PORISMode.new("ShiftNumberMode_Normal")
        @mdSubarrayFeatureMode_Off = PORISMode.new("SubarrayFeatureMode_Off")
        @mdSubarrayFeatureMode_On = PORISMode.new("SubarrayFeatureMode_On")
        @mdColsMode_Normal = PORISMode.new("ColsMode_Normal")
        @vlCols_Full_Range = PORISValueFloat.new("Cols_Full_Range",0,2048,4098)
        @mdoffsetRowMode_Normal = PORISMode.new("offsetRowMode_Normal")
        @vloffsetRow_Full_Range = PORISValueFloat.new("offsetRow_Full_Range",0,2048,4098)
        @mdRowsMode_Normal = PORISMode.new("RowsMode_Normal")
        @vlRows_Full_Range = PORISValueFloat.new("Rows_Full_Range",0,2048,4098)
        @mdoffsetColMode_Normal = PORISMode.new("offsetColMode_Normal")
        @vloffsetCol_Full_Range = PORISValueFloat.new("offsetCol_Full_Range",0,2048,4098)
        @mdOpenShutterMode_On = PORISMode.new("OpenShutterMode_On")
        @mdOpenShutterMode_Off = PORISMode.new("OpenShutterMode_Off")
        @vlExpTime_Full_Range = PORISValueFloat.new("ExpTime_Full_Range",0,1,4294967.295)
        @mdExpTimeMode_Normal = PORISMode.new("ExpTimeMode_Normal")
        @mdExpTimeMode_FT = PORISMode.new("ExpTimeMode_FT")
        @vlExpTime_FT_Range = PORISValueFloat.new("ExpTime_FT_Range",0,0,360)
        @mdPixelSpeedMode_SLW = PORISMode.new("PixelSpeedMode_SLW")
        @mdPixelSpeedMode_MED = PORISMode.new("PixelSpeedMode_MED")
        @mdPixelSpeedMode_FST = PORISMode.new("PixelSpeedMode_FST")
        @mdExposureCtrlMode_Normal = PORISMode.new("ExposureCtrlMode_Normal")
        @mdExposureCtrlMode_FT = PORISMode.new("ExposureCtrlMode_FT")
        @mdnumOfFramesMode_Multiple = PORISMode.new("numOfFramesMode_Multiple")
        @vlnumOfFrames_Multiple_Range = PORISValueFloat.new("numOfFrames_Multiple_Range",2,10,4294967295)
        @mdnumOfFramesMode_Single = PORISMode.new("numOfFramesMode_Single")
        @vlnumOfFrames_1 = PORISValue.new("numOfFrames_1")
        @vlCalibGain_Normal_Range = PORISValueFloat.new("CalibGain_Normal_Range",0,2,15)
        @mdCalibGainMode_Normal = PORISMode.new("CalibGainMode_Normal")
        @mdExposureCtrlMode_NoShutter = PORISMode.new("ExposureCtrlMode_NoShutter")
        @mdExposureCtrlMode_Calibration = PORISMode.new("ExposureCtrlMode_Calibration")
        @mdOutputSourceMode_0x0 = PORISMode.new("OutputSourceMode_0x0")
        @mdOutputSourceMode_0x1 = PORISMode.new("OutputSourceMode_0x1")
        @mdOutputSourceMode_0x2 = PORISMode.new("OutputSourceMode_0x2")
        @mdOutputSourceMode_0x3 = PORISMode.new("OutputSourceMode_0x3")
        @mdOutputSourceMode_ALL = PORISMode.new("OutputSourceMode_ALL")
        @mdOutputSourceMode_TWO = PORISMode.new("OutputSourceMode_TWO")
        @mdRecompositionMode_None = PORISMode.new("RecompositionMode_None")
        @mdRecompositionMode_Parallel = PORISMode.new("RecompositionMode_Parallel")
        @mdRecompositionMode_Serial = PORISMode.new("RecompositionMode_Serial")
        @mdRecompositionMode_QuadCCD = PORISMode.new("RecompositionMode_QuadCCD")
        @mdRecompositionMode_QuadIR = PORISMode.new("RecompositionMode_QuadIR")
        @mdRecompositionMode_CDSQuad = PORISMode.new("RecompositionMode_CDSQuad")
        @mdRecompositionMode_HawaiiRG = PORISMode.new("RecompositionMode_HawaiiRG")
        @mdAcquisitionMode_NormalWindow = PORISMode.new("AcquisitionMode_NormalWindow")
        @vluiRows_Full_Range = PORISValueFloat.new("uiRows_Full_Range",0,4112,4112)
        @mduiRowsMode_Normal = PORISMode.new("uiRowsMode_Normal")
        @vluiRows_FTRange = PORISValueFloat.new("uiRows_FTRange",0,2056,2056)
        @mduiRowsMode_Half = PORISMode.new("uiRowsMode_Half")
        @vluiCols_Full_Range = PORISValueFloat.new("uiCols_Full_Range",0,4096,4096)
        @mduiColsMode_Normal = PORISMode.new("uiColsMode_Normal")
        @mdDimensionsMode_Normal = PORISMode.new("DimensionsMode_Normal")
        @mdDimensionsMode_FT = PORISMode.new("DimensionsMode_FT")
        @vlBinning_1x1 = PORISValue.new("Binning_1x1")
        @vlBinning_1x2 = PORISValue.new("Binning_1x2")
        @vlBinning_2x1 = PORISValue.new("Binning_2x1")
        @vlBinning_2x2 = PORISValue.new("Binning_2x2")
        @mdBinningMode_All = PORISMode.new("BinningMode_All")
        @mdAcquisitionMode_Calibration = PORISMode.new("AcquisitionMode_Calibration")
        @mdVariantsMode_Normal = PORISMode.new("VariantsMode_Normal")
        @mdVariantsMode_Extended = PORISMode.new("VariantsMode_Extended")
        @mdVariantsMode_Extended_2 = PORISMode.new("VariantsMode_Extended_2")
        @mdARCGenIIIMode_Engineering = PORISMode.new("ARCGenIIIMode_Engineering")
        @mdFirmwareMode_Engineering = PORISMode.new("FirmwareMode_Engineering")
        @mdVariantsMode_Engineering = PORISMode.new("VariantsMode_Engineering")
        @mdAcquisitionMode_Engineering = PORISMode.new("AcquisitionMode_Engineering")
        @mdSubarrayFeatureMode_Engineering = PORISMode.new("SubarrayFeatureMode_Engineering")
        @mdExposureCtrlMode_Engineering = PORISMode.new("ExposureCtrlMode_Engineering")
        @mdOutputSourceMode_Engineering = PORISMode.new("OutputSourceMode_Engineering")
        @mdDimensionsMode_Engineering = PORISMode.new("DimensionsMode_Engineering")
        self.addItem(@sysARCGenIII)
        @sysARCGenIII.setIdent("ARC-0004")
        @sysARCGenIII.setDescription("")
        self.addItem(@mdARCGenIIIMode_UNKNOWN)
        @mdARCGenIIIMode_UNKNOWN.setIdent("UNKM_ARC-0004")
        @mdARCGenIIIMode_UNKNOWN.setDescription("")
        @sysARCGenIII.addMode(@mdARCGenIIIMode_UNKNOWN)
        self.addItem(@sysFirmware)
        @sysFirmware.setIdent("ARC-0007")
        @sysFirmware.setDescription("")
        @sysARCGenIII.addSubsystem(@sysFirmware)
        self.addItem(@mdFirmwareMode_UNKNOWN)
        @mdFirmwareMode_UNKNOWN.setIdent("UNKM_ARC-0007")
        @mdFirmwareMode_UNKNOWN.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_UNKNOWN)
        self.addItem(@sysVariants)
        @sysVariants.setIdent("ARC-0097")
        @sysVariants.setDescription("")
        @sysFirmware.addSubsystem(@sysVariants)
        self.addItem(@mdVariantsMode_UNKNOWN)
        @mdVariantsMode_UNKNOWN.setIdent("UNKM_ARC-0097")
        @mdVariantsMode_UNKNOWN.setDescription("")
        @sysVariants.addMode(@mdVariantsMode_UNKNOWN)
        self.addItem(@sysAcquisition)
        @sysAcquisition.setIdent("ARC-0076")
        @sysAcquisition.setDescription("")
        @sysVariants.addSubsystem(@sysAcquisition)
        self.addItem(@mdAcquisitionMode_UNKNOWN)
        @mdAcquisitionMode_UNKNOWN.setIdent("UNKM_ARC-0076")
        @mdAcquisitionMode_UNKNOWN.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_UNKNOWN)
        self.addItem(@prShuffleLines)
        @prShuffleLines.setIdent("ARC-0080")
        @prShuffleLines.setDescription("")
        @sysAcquisition.addParam(@prShuffleLines)
        self.addItem(@vlShuffleLines_UNKNOWN)
        @vlShuffleLines_UNKNOWN.setIdent("UNK_ARC-0080")
        @vlShuffleLines_UNKNOWN.setDescription("Unknown value for ShuffleLines")
        @prShuffleLines.addValue(@vlShuffleLines_UNKNOWN)
        self.addItem(@mdShuffleLinesMode_UNKNOWN)
        @mdShuffleLinesMode_UNKNOWN.setIdent("UNKM_ARC-0080")
        @mdShuffleLinesMode_UNKNOWN.setDescription("Unknown mode for ShuffleLines")
        @prShuffleLines.addMode(@mdShuffleLinesMode_UNKNOWN)
        @mdShuffleLinesMode_UNKNOWN.addValue(@vlShuffleLines_UNKNOWN)
        @mdAcquisitionMode_UNKNOWN.addSubMode(@mdShuffleLinesMode_UNKNOWN)
        self.addItem(@prShiftNumber)
        @prShiftNumber.setIdent("ARC-0083")
        @prShiftNumber.setDescription("")
        @sysAcquisition.addParam(@prShiftNumber)
        self.addItem(@vlShiftNumber_UNKNOWN)
        @vlShiftNumber_UNKNOWN.setIdent("UNK_ARC-0083")
        @vlShiftNumber_UNKNOWN.setDescription("Unknown value for ShiftNumber")
        @prShiftNumber.addValue(@vlShiftNumber_UNKNOWN)
        self.addItem(@mdShiftNumberMode_UNKNOWN)
        @mdShiftNumberMode_UNKNOWN.setIdent("UNKM_ARC-0083")
        @mdShiftNumberMode_UNKNOWN.setDescription("Unknown mode for ShiftNumber")
        @prShiftNumber.addMode(@mdShiftNumberMode_UNKNOWN)
        @mdShiftNumberMode_UNKNOWN.addValue(@vlShiftNumber_UNKNOWN)
        @mdAcquisitionMode_UNKNOWN.addSubMode(@mdShiftNumberMode_UNKNOWN)
        self.addItem(@sysSubarrayFeature)
        @sysSubarrayFeature.setIdent("ARC-0013")
        @sysSubarrayFeature.setDescription("")
        @sysAcquisition.addSubsystem(@sysSubarrayFeature)
        self.addItem(@mdSubarrayFeatureMode_UNKNOWN)
        @mdSubarrayFeatureMode_UNKNOWN.setIdent("UNKM_ARC-0013")
        @mdSubarrayFeatureMode_UNKNOWN.setDescription("")
        @sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_UNKNOWN)
        self.addItem(@prCols)
        @prCols.setIdent("ARC-0044")
        @prCols.setDescription("")
        @sysSubarrayFeature.addParam(@prCols)
        self.addItem(@vlCols_UNKNOWN)
        @vlCols_UNKNOWN.setIdent("UNK_ARC-0044")
        @vlCols_UNKNOWN.setDescription("Unknown value for Cols")
        @prCols.addValue(@vlCols_UNKNOWN)
        self.addItem(@mdColsMode_UNKNOWN)
        @mdColsMode_UNKNOWN.setIdent("UNKM_ARC-0044")
        @mdColsMode_UNKNOWN.setDescription("Unknown mode for Cols")
        @prCols.addMode(@mdColsMode_UNKNOWN)
        @mdColsMode_UNKNOWN.addValue(@vlCols_UNKNOWN)
        @mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdColsMode_UNKNOWN)
        self.addItem(@proffsetRow)
        @proffsetRow.setIdent("ARC-0045")
        @proffsetRow.setDescription("")
        @sysSubarrayFeature.addParam(@proffsetRow)
        self.addItem(@vloffsetRow_UNKNOWN)
        @vloffsetRow_UNKNOWN.setIdent("UNK_ARC-0045")
        @vloffsetRow_UNKNOWN.setDescription("Unknown value for offsetRow")
        @proffsetRow.addValue(@vloffsetRow_UNKNOWN)
        self.addItem(@mdoffsetRowMode_UNKNOWN)
        @mdoffsetRowMode_UNKNOWN.setIdent("UNKM_ARC-0045")
        @mdoffsetRowMode_UNKNOWN.setDescription("Unknown mode for offsetRow")
        @proffsetRow.addMode(@mdoffsetRowMode_UNKNOWN)
        @mdoffsetRowMode_UNKNOWN.addValue(@vloffsetRow_UNKNOWN)
        @mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdoffsetRowMode_UNKNOWN)
        self.addItem(@prRows)
        @prRows.setIdent("ARC-0043")
        @prRows.setDescription("")
        @sysSubarrayFeature.addParam(@prRows)
        self.addItem(@vlRows_UNKNOWN)
        @vlRows_UNKNOWN.setIdent("UNK_ARC-0043")
        @vlRows_UNKNOWN.setDescription("Unknown value for Rows")
        @prRows.addValue(@vlRows_UNKNOWN)
        self.addItem(@mdRowsMode_UNKNOWN)
        @mdRowsMode_UNKNOWN.setIdent("UNKM_ARC-0043")
        @mdRowsMode_UNKNOWN.setDescription("Unknown mode for Rows")
        @prRows.addMode(@mdRowsMode_UNKNOWN)
        @mdRowsMode_UNKNOWN.addValue(@vlRows_UNKNOWN)
        @mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdRowsMode_UNKNOWN)
        self.addItem(@proffsetCol)
        @proffsetCol.setIdent("ARC-0046")
        @proffsetCol.setDescription("")
        @sysSubarrayFeature.addParam(@proffsetCol)
        self.addItem(@vloffsetCol_UNKNOWN)
        @vloffsetCol_UNKNOWN.setIdent("UNK_ARC-0046")
        @vloffsetCol_UNKNOWN.setDescription("Unknown value for offsetCol")
        @proffsetCol.addValue(@vloffsetCol_UNKNOWN)
        self.addItem(@mdoffsetColMode_UNKNOWN)
        @mdoffsetColMode_UNKNOWN.setIdent("UNKM_ARC-0046")
        @mdoffsetColMode_UNKNOWN.setDescription("Unknown mode for offsetCol")
        @proffsetCol.addMode(@mdoffsetColMode_UNKNOWN)
        @mdoffsetColMode_UNKNOWN.addValue(@vloffsetCol_UNKNOWN)
        @mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdoffsetColMode_UNKNOWN)
        self.addItem(@sysExposureCtrl)
        @sysExposureCtrl.setIdent("ARC-0103")
        @sysExposureCtrl.setDescription("")
        @sysAcquisition.addSubsystem(@sysExposureCtrl)
        self.addItem(@mdExposureCtrlMode_UNKNOWN)
        @mdExposureCtrlMode_UNKNOWN.setIdent("UNKM_ARC-0103")
        @mdExposureCtrlMode_UNKNOWN.setDescription("")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_UNKNOWN)
        self.addItem(@sysOpenShutter)
        @sysOpenShutter.setIdent("ARC-0009")
        @sysOpenShutter.setDescription("")
        @sysExposureCtrl.addSubsystem(@sysOpenShutter)
        self.addItem(@mdOpenShutterMode_UNKNOWN)
        @mdOpenShutterMode_UNKNOWN.setIdent("UNKM_ARC-0009")
        @mdOpenShutterMode_UNKNOWN.setDescription("")
        @sysOpenShutter.addMode(@mdOpenShutterMode_UNKNOWN)
        self.addItem(@prExpTime)
        @prExpTime.setIdent("ARC-0010")
        @prExpTime.setDescription("")
        @sysExposureCtrl.addParam(@prExpTime)
        self.addItem(@vlExpTime_UNKNOWN)
        @vlExpTime_UNKNOWN.setIdent("UNK_ARC-0010")
        @vlExpTime_UNKNOWN.setDescription("Unknown value for ExpTime")
        @prExpTime.addValue(@vlExpTime_UNKNOWN)
        self.addItem(@mdExpTimeMode_UNKNOWN)
        @mdExpTimeMode_UNKNOWN.setIdent("UNKM_ARC-0010")
        @mdExpTimeMode_UNKNOWN.setDescription("Unknown mode for ExpTime")
        @prExpTime.addMode(@mdExpTimeMode_UNKNOWN)
        @mdExpTimeMode_UNKNOWN.addValue(@vlExpTime_UNKNOWN)
        @mdExposureCtrlMode_UNKNOWN.addSubMode(@mdExpTimeMode_UNKNOWN)
        self.addItem(@sysPixelSpeed)
        @sysPixelSpeed.setIdent("ARC-0093")
        @sysPixelSpeed.setDescription("")
        @sysExposureCtrl.addSubsystem(@sysPixelSpeed)
        self.addItem(@mdPixelSpeedMode_UNKNOWN)
        @mdPixelSpeedMode_UNKNOWN.setIdent("UNKM_ARC-0093")
        @mdPixelSpeedMode_UNKNOWN.setDescription("")
        @sysPixelSpeed.addMode(@mdPixelSpeedMode_UNKNOWN)
        self.addItem(@prnumOfFrames)
        @prnumOfFrames.setIdent("ARC-0001")
        @prnumOfFrames.setDescription("")
        @sysExposureCtrl.addParam(@prnumOfFrames)
        self.addItem(@vlnumOfFrames_UNKNOWN)
        @vlnumOfFrames_UNKNOWN.setIdent("UNK_ARC-0001")
        @vlnumOfFrames_UNKNOWN.setDescription("Unknown value for numOfFrames")
        @prnumOfFrames.addValue(@vlnumOfFrames_UNKNOWN)
        self.addItem(@mdnumOfFramesMode_UNKNOWN)
        @mdnumOfFramesMode_UNKNOWN.setIdent("UNKM_ARC-0001")
        @mdnumOfFramesMode_UNKNOWN.setDescription("Unknown mode for numOfFrames")
        @prnumOfFrames.addMode(@mdnumOfFramesMode_UNKNOWN)
        @mdnumOfFramesMode_UNKNOWN.addValue(@vlnumOfFrames_UNKNOWN)
        @mdExposureCtrlMode_UNKNOWN.addSubMode(@mdnumOfFramesMode_UNKNOWN)
        self.addItem(@prCalibGain)
        @prCalibGain.setIdent("ARC-0130")
        @prCalibGain.setDescription("")
        @sysExposureCtrl.addParam(@prCalibGain)
        self.addItem(@vlCalibGain_UNKNOWN)
        @vlCalibGain_UNKNOWN.setIdent("UNK_ARC-0130")
        @vlCalibGain_UNKNOWN.setDescription("Unknown value for CalibGain")
        @prCalibGain.addValue(@vlCalibGain_UNKNOWN)
        self.addItem(@mdCalibGainMode_UNKNOWN)
        @mdCalibGainMode_UNKNOWN.setIdent("UNKM_ARC-0130")
        @mdCalibGainMode_UNKNOWN.setDescription("Unknown mode for CalibGain")
        @prCalibGain.addMode(@mdCalibGainMode_UNKNOWN)
        @mdCalibGainMode_UNKNOWN.addValue(@vlCalibGain_UNKNOWN)
        @mdExposureCtrlMode_UNKNOWN.addSubMode(@mdCalibGainMode_UNKNOWN)
        self.addItem(@sysOutputSource)
        @sysOutputSource.setIdent("ARC-0086")
        @sysOutputSource.setDescription("")
        @sysAcquisition.addSubsystem(@sysOutputSource)
        self.addItem(@mdOutputSourceMode_UNKNOWN)
        @mdOutputSourceMode_UNKNOWN.setIdent("UNKM_ARC-0086")
        @mdOutputSourceMode_UNKNOWN.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_UNKNOWN)
        self.addItem(@sysRecomposition)
        @sysRecomposition.setIdent("ARC-0020")
        @sysRecomposition.setDescription("")
        @sysOutputSource.addSubsystem(@sysRecomposition)
        self.addItem(@mdRecompositionMode_UNKNOWN)
        @mdRecompositionMode_UNKNOWN.setIdent("UNKM_ARC-0020")
        @mdRecompositionMode_UNKNOWN.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_UNKNOWN)
        self.addItem(@sysDimensions)
        @sysDimensions.setIdent("ARC-0099")
        @sysDimensions.setDescription("")
        @sysAcquisition.addSubsystem(@sysDimensions)
        self.addItem(@mdDimensionsMode_UNKNOWN)
        @mdDimensionsMode_UNKNOWN.setIdent("UNKM_ARC-0099")
        @mdDimensionsMode_UNKNOWN.setDescription("")
        @sysDimensions.addMode(@mdDimensionsMode_UNKNOWN)
        self.addItem(@pruiRows)
        @pruiRows.setIdent("ARC-0005")
        @pruiRows.setDescription("")
        @sysDimensions.addParam(@pruiRows)
        self.addItem(@vluiRows_UNKNOWN)
        @vluiRows_UNKNOWN.setIdent("UNK_ARC-0005")
        @vluiRows_UNKNOWN.setDescription("Unknown value for uiRows")
        @pruiRows.addValue(@vluiRows_UNKNOWN)
        self.addItem(@mduiRowsMode_UNKNOWN)
        @mduiRowsMode_UNKNOWN.setIdent("UNKM_ARC-0005")
        @mduiRowsMode_UNKNOWN.setDescription("Unknown mode for uiRows")
        @pruiRows.addMode(@mduiRowsMode_UNKNOWN)
        @mduiRowsMode_UNKNOWN.addValue(@vluiRows_UNKNOWN)
        @mdDimensionsMode_UNKNOWN.addSubMode(@mduiRowsMode_UNKNOWN)
        self.addItem(@pruiCols)
        @pruiCols.setIdent("ARC-0006")
        @pruiCols.setDescription("")
        @sysDimensions.addParam(@pruiCols)
        self.addItem(@vluiCols_UNKNOWN)
        @vluiCols_UNKNOWN.setIdent("UNK_ARC-0006")
        @vluiCols_UNKNOWN.setDescription("Unknown value for uiCols")
        @pruiCols.addValue(@vluiCols_UNKNOWN)
        self.addItem(@mduiColsMode_UNKNOWN)
        @mduiColsMode_UNKNOWN.setIdent("UNKM_ARC-0006")
        @mduiColsMode_UNKNOWN.setDescription("Unknown mode for uiCols")
        @pruiCols.addMode(@mduiColsMode_UNKNOWN)
        @mduiColsMode_UNKNOWN.addValue(@vluiCols_UNKNOWN)
        @mdDimensionsMode_UNKNOWN.addSubMode(@mduiColsMode_UNKNOWN)
        self.addItem(@prBinning)
        @prBinning.setIdent("ARC-0008")
        @prBinning.setDescription("")
        @sysAcquisition.addParam(@prBinning)
        self.addItem(@vlBinning_UNKNOWN)
        @vlBinning_UNKNOWN.setIdent("UNK_ARC-0008")
        @vlBinning_UNKNOWN.setDescription("Unknown value for Binning")
        @prBinning.addValue(@vlBinning_UNKNOWN)
        self.addItem(@mdBinningMode_UNKNOWN)
        @mdBinningMode_UNKNOWN.setIdent("UNKM_ARC-0008")
        @mdBinningMode_UNKNOWN.setDescription("Unknown mode for Binning")
        @prBinning.addMode(@mdBinningMode_UNKNOWN)
        @mdBinningMode_UNKNOWN.addValue(@vlBinning_UNKNOWN)
        @mdAcquisitionMode_UNKNOWN.addSubMode(@mdBinningMode_UNKNOWN)
        self.addItem(@mdARCGenIIIMode_Real)
        @mdARCGenIIIMode_Real.setIdent("ARC-0018")
        @mdARCGenIIIMode_Real.setDescription("")
        @sysARCGenIII.addMode(@mdARCGenIIIMode_Real)
        self.addItem(@mdARCGenIIIMode_Emulated)
        @mdARCGenIIIMode_Emulated.setIdent("ARC-0110")
        @mdARCGenIIIMode_Emulated.setDescription("")
        @sysARCGenIII.addMode(@mdARCGenIIIMode_Emulated)
        self.addItem(@mdFirmwareMode_tim)
        @mdFirmwareMode_tim.setIdent("ARC-0021")
        @mdFirmwareMode_tim.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_tim)
        self.addItem(@mdFirmwareMode_osiris2)
        @mdFirmwareMode_osiris2.setIdent("ARC-0062")
        @mdFirmwareMode_osiris2.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_osiris2)
        self.addItem(@mdFirmwareMode_osiris3)
        @mdFirmwareMode_osiris3.setIdent("ARC-0073")
        @mdFirmwareMode_osiris3.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_osiris3)
        self.addItem(@mdFirmwareMode_osiris4)
        @mdFirmwareMode_osiris4.setIdent("ARC-0074")
        @mdFirmwareMode_osiris4.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_osiris4)
        self.addItem(@mdFirmwareMode_osiris5)
        @mdFirmwareMode_osiris5.setIdent("ARC-0075")
        @mdFirmwareMode_osiris5.setDescription("")
        @sysFirmware.addMode(@mdFirmwareMode_osiris5)
        self.addItem(@mdAcquisitionMode_Normal)
        @mdAcquisitionMode_Normal.setIdent("ARC-0077")
        @mdAcquisitionMode_Normal.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_Normal)
        self.addItem(@mdAcquisitionMode_FrameTransfer)
        @mdAcquisitionMode_FrameTransfer.setIdent("ARC-0078")
        @mdAcquisitionMode_FrameTransfer.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_FrameTransfer)
        self.addItem(@mdAcquisitionMode_Shuffling)
        @mdAcquisitionMode_Shuffling.setIdent("ARC-0079")
        @mdAcquisitionMode_Shuffling.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_Shuffling)
        self.addItem(@vlShuffleLines_Full_Range)
        @vlShuffleLines_Full_Range.setIdent("ARC-0081")
        @vlShuffleLines_Full_Range.setDescription("")
        @prShuffleLines.addValue(@vlShuffleLines_Full_Range)
        self.addItem(@mdShuffleLinesMode_Normal)
        @mdShuffleLinesMode_Normal.setIdent("ARC-0082")
        @mdShuffleLinesMode_Normal.setDescription("")
        @prShuffleLines.addMode(@mdShuffleLinesMode_Normal)
        self.addItem(@vlShiftNumber_Full_Range)
        @vlShiftNumber_Full_Range.setIdent("ARC-0084")
        @vlShiftNumber_Full_Range.setDescription("")
        @prShiftNumber.addValue(@vlShiftNumber_Full_Range)
        self.addItem(@mdShiftNumberMode_Normal)
        @mdShiftNumberMode_Normal.setIdent("ARC-0085")
        @mdShiftNumberMode_Normal.setDescription("")
        @prShiftNumber.addMode(@mdShiftNumberMode_Normal)
        self.addItem(@mdSubarrayFeatureMode_Off)
        @mdSubarrayFeatureMode_Off.setIdent("ARC-0041")
        @mdSubarrayFeatureMode_Off.setDescription("")
        @sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_Off)
        self.addItem(@mdSubarrayFeatureMode_On)
        @mdSubarrayFeatureMode_On.setIdent("ARC-0042")
        @mdSubarrayFeatureMode_On.setDescription("")
        @sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_On)
        self.addItem(@mdColsMode_Normal)
        @mdColsMode_Normal.setIdent("ARC-0066")
        @mdColsMode_Normal.setDescription("")
        @prCols.addMode(@mdColsMode_Normal)
        self.addItem(@vlCols_Full_Range)
        @vlCols_Full_Range.setIdent("ARC-0065")
        @vlCols_Full_Range.setDescription("")
        @prCols.addValue(@vlCols_Full_Range)
        self.addItem(@mdoffsetRowMode_Normal)
        @mdoffsetRowMode_Normal.setIdent("ARC-0068")
        @mdoffsetRowMode_Normal.setDescription("")
        @proffsetRow.addMode(@mdoffsetRowMode_Normal)
        self.addItem(@vloffsetRow_Full_Range)
        @vloffsetRow_Full_Range.setIdent("ARC-0067")
        @vloffsetRow_Full_Range.setDescription("")
        @proffsetRow.addValue(@vloffsetRow_Full_Range)
        self.addItem(@mdRowsMode_Normal)
        @mdRowsMode_Normal.setIdent("ARC-0064")
        @mdRowsMode_Normal.setDescription("")
        @prRows.addMode(@mdRowsMode_Normal)
        self.addItem(@vlRows_Full_Range)
        @vlRows_Full_Range.setIdent("ARC-0063")
        @vlRows_Full_Range.setDescription("")
        @prRows.addValue(@vlRows_Full_Range)
        self.addItem(@mdoffsetColMode_Normal)
        @mdoffsetColMode_Normal.setIdent("ARC-0070")
        @mdoffsetColMode_Normal.setDescription("")
        @proffsetCol.addMode(@mdoffsetColMode_Normal)
        self.addItem(@vloffsetCol_Full_Range)
        @vloffsetCol_Full_Range.setIdent("ARC-0069")
        @vloffsetCol_Full_Range.setDescription("")
        @proffsetCol.addValue(@vloffsetCol_Full_Range)
        self.addItem(@mdOpenShutterMode_On)
        @mdOpenShutterMode_On.setIdent("ARC-0033")
        @mdOpenShutterMode_On.setDescription("")
        @sysOpenShutter.addMode(@mdOpenShutterMode_On)
        self.addItem(@mdOpenShutterMode_Off)
        @mdOpenShutterMode_Off.setIdent("ARC-0034")
        @mdOpenShutterMode_Off.setDescription("")
        @sysOpenShutter.addMode(@mdOpenShutterMode_Off)
        self.addItem(@vlExpTime_Full_Range)
        @vlExpTime_Full_Range.setIdent("ARC-0035")
        @vlExpTime_Full_Range.setDescription("")
        @prExpTime.addValue(@vlExpTime_Full_Range)
        self.addItem(@mdExpTimeMode_Normal)
        @mdExpTimeMode_Normal.setIdent("ARC-0036")
        @mdExpTimeMode_Normal.setDescription("")
        @prExpTime.addMode(@mdExpTimeMode_Normal)
        self.addItem(@mdExpTimeMode_FT)
        @mdExpTimeMode_FT.setIdent("ARC-0119")
        @mdExpTimeMode_FT.setDescription("")
        @prExpTime.addMode(@mdExpTimeMode_FT)
        self.addItem(@vlExpTime_FT_Range)
        @vlExpTime_FT_Range.setIdent("ARC-0120")
        @vlExpTime_FT_Range.setDescription("")
        @prExpTime.addValue(@vlExpTime_FT_Range)
        self.addItem(@mdPixelSpeedMode_SLW)
        @mdPixelSpeedMode_SLW.setIdent("ARC-0094")
        @mdPixelSpeedMode_SLW.setDescription("")
        @sysPixelSpeed.addMode(@mdPixelSpeedMode_SLW)
        self.addItem(@mdPixelSpeedMode_MED)
        @mdPixelSpeedMode_MED.setIdent("ARC-0095")
        @mdPixelSpeedMode_MED.setDescription("")
        @sysPixelSpeed.addMode(@mdPixelSpeedMode_MED)
        self.addItem(@mdPixelSpeedMode_FST)
        @mdPixelSpeedMode_FST.setIdent("ARC-0096")
        @mdPixelSpeedMode_FST.setDescription("")
        @sysPixelSpeed.addMode(@mdPixelSpeedMode_FST)
        self.addItem(@mdExposureCtrlMode_Normal)
        @mdExposureCtrlMode_Normal.setIdent("ARC-0104")
        @mdExposureCtrlMode_Normal.setDescription("")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_Normal)
        self.addItem(@mdExposureCtrlMode_FT)
        @mdExposureCtrlMode_FT.setIdent("ARC-0114")
        @mdExposureCtrlMode_FT.setDescription("")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_FT)
        self.addItem(@mdnumOfFramesMode_Multiple)
        @mdnumOfFramesMode_Multiple.setIdent("ARC-0072")
        @mdnumOfFramesMode_Multiple.setDescription("")
        @prnumOfFrames.addMode(@mdnumOfFramesMode_Multiple)
        self.addItem(@vlnumOfFrames_Multiple_Range)
        @vlnumOfFrames_Multiple_Range.setIdent("ARC-0071")
        @vlnumOfFrames_Multiple_Range.setDescription("")
        @prnumOfFrames.addValue(@vlnumOfFrames_Multiple_Range)
        self.addItem(@mdnumOfFramesMode_Single)
        @mdnumOfFramesMode_Single.setIdent("ARC-0037")
        @mdnumOfFramesMode_Single.setDescription("")
        @prnumOfFrames.addMode(@mdnumOfFramesMode_Single)
        self.addItem(@vlnumOfFrames_1)
        @vlnumOfFrames_1.setIdent("ARC-0131")
        @vlnumOfFrames_1.setDescription("")
        @prnumOfFrames.addValue(@vlnumOfFrames_1)
        self.addItem(@vlCalibGain_Normal_Range)
        @vlCalibGain_Normal_Range.setIdent("ARC-0124")
        @vlCalibGain_Normal_Range.setDescription("")
        @prCalibGain.addValue(@vlCalibGain_Normal_Range)
        self.addItem(@mdCalibGainMode_Normal)
        @mdCalibGainMode_Normal.setIdent("ARC-0125")
        @mdCalibGainMode_Normal.setDescription("")
        @prCalibGain.addMode(@mdCalibGainMode_Normal)
        self.addItem(@mdExposureCtrlMode_NoShutter)
        @mdExposureCtrlMode_NoShutter.setIdent("ARC-0134")
        @mdExposureCtrlMode_NoShutter.setDescription("")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_NoShutter)
        self.addItem(@mdExposureCtrlMode_Calibration)
        @mdExposureCtrlMode_Calibration.setIdent("ARC-0136")
        @mdExposureCtrlMode_Calibration.setDescription("")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_Calibration)
        self.addItem(@mdOutputSourceMode_0x0)
        @mdOutputSourceMode_0x0.setIdent("ARC-0087")
        @mdOutputSourceMode_0x0.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_0x0)
        self.addItem(@mdOutputSourceMode_0x1)
        @mdOutputSourceMode_0x1.setIdent("ARC-0088")
        @mdOutputSourceMode_0x1.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_0x1)
        self.addItem(@mdOutputSourceMode_0x2)
        @mdOutputSourceMode_0x2.setIdent("ARC-0089")
        @mdOutputSourceMode_0x2.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_0x2)
        self.addItem(@mdOutputSourceMode_0x3)
        @mdOutputSourceMode_0x3.setIdent("ARC-0090")
        @mdOutputSourceMode_0x3.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_0x3)
        self.addItem(@mdOutputSourceMode_ALL)
        @mdOutputSourceMode_ALL.setIdent("ARC-0091")
        @mdOutputSourceMode_ALL.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_ALL)
        self.addItem(@mdOutputSourceMode_TWO)
        @mdOutputSourceMode_TWO.setIdent("ARC-0092")
        @mdOutputSourceMode_TWO.setDescription("")
        @sysOutputSource.addMode(@mdOutputSourceMode_TWO)
        self.addItem(@mdRecompositionMode_None)
        @mdRecompositionMode_None.setIdent("ARC-0055")
        @mdRecompositionMode_None.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_None)
        self.addItem(@mdRecompositionMode_Parallel)
        @mdRecompositionMode_Parallel.setIdent("ARC-0056")
        @mdRecompositionMode_Parallel.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_Parallel)
        self.addItem(@mdRecompositionMode_Serial)
        @mdRecompositionMode_Serial.setIdent("ARC-0057")
        @mdRecompositionMode_Serial.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_Serial)
        self.addItem(@mdRecompositionMode_QuadCCD)
        @mdRecompositionMode_QuadCCD.setIdent("ARC-0058")
        @mdRecompositionMode_QuadCCD.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_QuadCCD)
        self.addItem(@mdRecompositionMode_QuadIR)
        @mdRecompositionMode_QuadIR.setIdent("ARC-0059")
        @mdRecompositionMode_QuadIR.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_QuadIR)
        self.addItem(@mdRecompositionMode_CDSQuad)
        @mdRecompositionMode_CDSQuad.setIdent("ARC-0060")
        @mdRecompositionMode_CDSQuad.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_CDSQuad)
        self.addItem(@mdRecompositionMode_HawaiiRG)
        @mdRecompositionMode_HawaiiRG.setIdent("ARC-0061")
        @mdRecompositionMode_HawaiiRG.setDescription("")
        @sysRecomposition.addMode(@mdRecompositionMode_HawaiiRG)
        self.addItem(@mdAcquisitionMode_NormalWindow)
        @mdAcquisitionMode_NormalWindow.setIdent("ARC-0126")
        @mdAcquisitionMode_NormalWindow.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_NormalWindow)
        self.addItem(@vluiRows_Full_Range)
        @vluiRows_Full_Range.setIdent("ARC-0022")
        @vluiRows_Full_Range.setDescription("")
        @pruiRows.addValue(@vluiRows_Full_Range)
        self.addItem(@mduiRowsMode_Normal)
        @mduiRowsMode_Normal.setIdent("ARC-0023")
        @mduiRowsMode_Normal.setDescription("")
        @pruiRows.addMode(@mduiRowsMode_Normal)
        self.addItem(@vluiRows_FTRange)
        @vluiRows_FTRange.setIdent("ARC-0127")
        @vluiRows_FTRange.setDescription("")
        @pruiRows.addValue(@vluiRows_FTRange)
        self.addItem(@mduiRowsMode_Half)
        @mduiRowsMode_Half.setIdent("ARC-0128")
        @mduiRowsMode_Half.setDescription("")
        @pruiRows.addMode(@mduiRowsMode_Half)
        self.addItem(@vluiCols_Full_Range)
        @vluiCols_Full_Range.setIdent("ARC-0024")
        @vluiCols_Full_Range.setDescription("")
        @pruiCols.addValue(@vluiCols_Full_Range)
        self.addItem(@mduiColsMode_Normal)
        @mduiColsMode_Normal.setIdent("ARC-0025")
        @mduiColsMode_Normal.setDescription("")
        @pruiCols.addMode(@mduiColsMode_Normal)
        self.addItem(@mdDimensionsMode_Normal)
        @mdDimensionsMode_Normal.setIdent("ARC-0100")
        @mdDimensionsMode_Normal.setDescription("")
        @sysDimensions.addMode(@mdDimensionsMode_Normal)
        self.addItem(@mdDimensionsMode_FT)
        @mdDimensionsMode_FT.setIdent("ARC-0129")
        @mdDimensionsMode_FT.setDescription("")
        @sysDimensions.addMode(@mdDimensionsMode_FT)
        self.addItem(@vlBinning_1x1)
        @vlBinning_1x1.setIdent("ARC-0026")
        @vlBinning_1x1.setDescription("")
        @prBinning.addValue(@vlBinning_1x1)
        self.addItem(@vlBinning_1x2)
        @vlBinning_1x2.setIdent("ARC-0027")
        @vlBinning_1x2.setDescription("")
        @prBinning.addValue(@vlBinning_1x2)
        self.addItem(@vlBinning_2x1)
        @vlBinning_2x1.setIdent("ARC-0028")
        @vlBinning_2x1.setDescription("")
        @prBinning.addValue(@vlBinning_2x1)
        self.addItem(@vlBinning_2x2)
        @vlBinning_2x2.setIdent("ARC-0029")
        @vlBinning_2x2.setDescription("")
        @prBinning.addValue(@vlBinning_2x2)
        self.addItem(@mdBinningMode_All)
        @mdBinningMode_All.setIdent("ARC-0031")
        @mdBinningMode_All.setDescription("")
        @prBinning.addMode(@mdBinningMode_All)
        self.addItem(@mdAcquisitionMode_Calibration)
        @mdAcquisitionMode_Calibration.setIdent("ARC-0137")
        @mdAcquisitionMode_Calibration.setDescription("")
        @sysAcquisition.addMode(@mdAcquisitionMode_Calibration)
        self.addItem(@mdVariantsMode_Normal)
        @mdVariantsMode_Normal.setIdent("ARC-0098")
        @mdVariantsMode_Normal.setDescription("")
        @sysVariants.addMode(@mdVariantsMode_Normal)
        self.addItem(@mdVariantsMode_Extended)
        @mdVariantsMode_Extended.setIdent("ARC-0105")
        @mdVariantsMode_Extended.setDescription("")
        @sysVariants.addMode(@mdVariantsMode_Extended)
        self.addItem(@mdVariantsMode_Extended_2)
        @mdVariantsMode_Extended_2.setIdent("ARC-0138")
        @mdVariantsMode_Extended_2.setDescription("")
        @sysVariants.addMode(@mdVariantsMode_Extended_2)
        self.addItem(@mdARCGenIIIMode_Engineering)
        @mdARCGenIIIMode_Engineering.setIdent("ENG-14")
        @mdARCGenIIIMode_Engineering.setDescription("ARCGenIII engineering mode")
        @sysARCGenIII.addMode(@mdARCGenIIIMode_Engineering)
        self.addItem(@mdFirmwareMode_Engineering)
        @mdFirmwareMode_Engineering.setIdent("ENG-15")
        @mdFirmwareMode_Engineering.setDescription("Firmware engineering mode")
        @sysFirmware.addMode(@mdFirmwareMode_Engineering)
        self.addItem(@mdVariantsMode_Engineering)
        @mdVariantsMode_Engineering.setIdent("ENG-16")
        @mdVariantsMode_Engineering.setDescription("Variants engineering mode")
        @sysVariants.addMode(@mdVariantsMode_Engineering)
        self.addItem(@mdAcquisitionMode_Engineering)
        @mdAcquisitionMode_Engineering.setIdent("ENG-17")
        @mdAcquisitionMode_Engineering.setDescription("Acquisition engineering mode")
        @sysAcquisition.addMode(@mdAcquisitionMode_Engineering)
        self.addItem(@mdSubarrayFeatureMode_Engineering)
        @mdSubarrayFeatureMode_Engineering.setIdent("ENG-18")
        @mdSubarrayFeatureMode_Engineering.setDescription("SubarrayFeature engineering mode")
        @sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_Engineering)
        self.addItem(@mdExposureCtrlMode_Engineering)
        @mdExposureCtrlMode_Engineering.setIdent("ENG-19")
        @mdExposureCtrlMode_Engineering.setDescription("ExposureCtrl engineering mode")
        @sysExposureCtrl.addMode(@mdExposureCtrlMode_Engineering)
        self.addItem(@mdOutputSourceMode_Engineering)
        @mdOutputSourceMode_Engineering.setIdent("ENG-22")
        @mdOutputSourceMode_Engineering.setDescription("OutputSource engineering mode")
        @sysOutputSource.addMode(@mdOutputSourceMode_Engineering)
        self.addItem(@mdDimensionsMode_Engineering)
        @mdDimensionsMode_Engineering.setIdent("ENG-24")
        @mdDimensionsMode_Engineering.setDescription("Dimensions engineering mode")
        @sysDimensions.addMode(@mdDimensionsMode_Engineering)
        # Marcamos FirmwareMode_tim como elegible para ARCGenIIIMode_Real
        @mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_tim)
        # Marcamos FirmwareMode_osiris2 como elegible para ARCGenIIIMode_Real
        @mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris2)
        # Marcamos FirmwareMode_osiris3 como elegible para ARCGenIIIMode_Real
        @mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris3)
        # Marcamos FirmwareMode_osiris4 como elegible para ARCGenIIIMode_Real
        @mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris4)
        # Marcamos FirmwareMode_osiris5 como elegible para ARCGenIIIMode_Real
        @mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris5)
        # Marcamos FirmwareMode_tim como elegible para ARCGenIIIMode_Emulated
        @mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_tim)
        # Marcamos FirmwareMode_osiris2 como elegible para ARCGenIIIMode_Emulated
        @mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris2)
        # Marcamos FirmwareMode_osiris3 como elegible para ARCGenIIIMode_Emulated
        @mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris3)
        # Marcamos FirmwareMode_osiris4 como elegible para ARCGenIIIMode_Emulated
        @mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris4)
        # Marcamos FirmwareMode_osiris5 como elegible para ARCGenIIIMode_Emulated
        @mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris5)
        # Marcamos FirmwareMode_tim como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_tim)
        # Marcamos FirmwareMode_osiris2 como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris2)
        # Marcamos FirmwareMode_osiris3 como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris3)
        # Marcamos FirmwareMode_osiris4 como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris4)
        # Marcamos FirmwareMode_osiris5 como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris5)
        # Marcamos FirmwareMode_Engineering como elegible para ARCGenIIIMode_Engineering
        @mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_Engineering)
        # Marcamos VariantsMode_Normal como elegible para FirmwareMode_tim
        @mdFirmwareMode_tim.addSubMode(@mdVariantsMode_Normal)
        # Marcamos VariantsMode_Extended como elegible para FirmwareMode_osiris2
        @mdFirmwareMode_osiris2.addSubMode(@mdVariantsMode_Extended)
        # Marcamos VariantsMode_Extended_2 como elegible para FirmwareMode_osiris3
        @mdFirmwareMode_osiris3.addSubMode(@mdVariantsMode_Extended_2)
        # Marcamos VariantsMode_Extended_2 como elegible para FirmwareMode_osiris4
        @mdFirmwareMode_osiris4.addSubMode(@mdVariantsMode_Extended_2)
        # Marcamos VariantsMode_Extended_2 como elegible para FirmwareMode_osiris5
        @mdFirmwareMode_osiris5.addSubMode(@mdVariantsMode_Extended_2)
        # Marcamos VariantsMode_Normal como elegible para FirmwareMode_Engineering
        @mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Normal)
        # Marcamos VariantsMode_Extended como elegible para FirmwareMode_Engineering
        @mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Extended)
        # Marcamos VariantsMode_Extended_2 como elegible para FirmwareMode_Engineering
        @mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Extended_2)
        # Marcamos VariantsMode_Engineering como elegible para FirmwareMode_Engineering
        @mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Engineering)
        # Marcamos AcquisitionMode_Normal como elegible para VariantsMode_Normal
        @mdVariantsMode_Normal.addSubMode(@mdAcquisitionMode_Normal)
        # Marcamos AcquisitionMode_NormalWindow como elegible para VariantsMode_Normal
        @mdVariantsMode_Normal.addSubMode(@mdAcquisitionMode_NormalWindow)
        # Marcamos AcquisitionMode_Shuffling como elegible para VariantsMode_Extended
        @mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_Shuffling)
        # Marcamos AcquisitionMode_FrameTransfer como elegible para VariantsMode_Extended
        @mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_FrameTransfer)
        # Marcamos AcquisitionMode_Normal como elegible para VariantsMode_Extended
        @mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_Normal)
        # Marcamos AcquisitionMode_NormalWindow como elegible para VariantsMode_Extended
        @mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_NormalWindow)
        # Marcamos AcquisitionMode_Shuffling como elegible para VariantsMode_Extended_2
        @mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Shuffling)
        # Marcamos AcquisitionMode_FrameTransfer como elegible para VariantsMode_Extended_2
        @mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_FrameTransfer)
        # Marcamos AcquisitionMode_Normal como elegible para VariantsMode_Extended_2
        @mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Normal)
        # Marcamos AcquisitionMode_NormalWindow como elegible para VariantsMode_Extended_2
        @mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_NormalWindow)
        # Marcamos AcquisitionMode_Calibration como elegible para VariantsMode_Extended_2
        @mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Calibration)
        # Marcamos AcquisitionMode_Normal como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Normal)
        # Marcamos AcquisitionMode_FrameTransfer como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_FrameTransfer)
        # Marcamos AcquisitionMode_Shuffling como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Shuffling)
        # Marcamos AcquisitionMode_NormalWindow como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_NormalWindow)
        # Marcamos AcquisitionMode_Calibration como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Calibration)
        # Marcamos AcquisitionMode_Engineering como elegible para VariantsMode_Engineering
        @mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Engineering)
        # Marcamos ShuffleLinesMode_Normal como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdShuffleLinesMode_Normal)
        # Marcamos ShuffleLinesMode_Normal como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdShuffleLinesMode_Normal)
        # Marcamos ShuffleLines_Full_Range como elegible para ShuffleLinesMode_Normal
        @mdShuffleLinesMode_Normal.addValue(@vlShuffleLines_Full_Range)
        # Marcamos ShiftNumberMode_Normal como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdShiftNumberMode_Normal)
        # Marcamos ShiftNumberMode_Normal como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdShiftNumberMode_Normal)
        # Marcamos ShiftNumber_Full_Range como elegible para ShiftNumberMode_Normal
        @mdShiftNumberMode_Normal.addValue(@vlShiftNumber_Full_Range)
        # Marcamos SubarrayFeatureMode_Off como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdSubarrayFeatureMode_Off)
        # Marcamos SubarrayFeatureMode_On como elegible para AcquisitionMode_NormalWindow
        @mdAcquisitionMode_NormalWindow.addSubMode(@mdSubarrayFeatureMode_On)
        # Marcamos SubarrayFeatureMode_Off como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdSubarrayFeatureMode_Off)
        # Marcamos SubarrayFeatureMode_Off como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_Off)
        # Marcamos SubarrayFeatureMode_On como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_On)
        # Marcamos SubarrayFeatureMode_Engineering como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_Engineering)
        # Marcamos ColsMode_Normal como elegible para SubarrayFeatureMode_On
        @mdSubarrayFeatureMode_On.addSubMode(@mdColsMode_Normal)
        # Marcamos ColsMode_Normal como elegible para SubarrayFeatureMode_Engineering
        @mdSubarrayFeatureMode_Engineering.addSubMode(@mdColsMode_Normal)
        # Marcamos Cols_Full_Range como elegible para ColsMode_Normal
        @mdColsMode_Normal.addValue(@vlCols_Full_Range)
        # Marcamos offsetRowMode_Normal como elegible para SubarrayFeatureMode_On
        @mdSubarrayFeatureMode_On.addSubMode(@mdoffsetRowMode_Normal)
        # Marcamos offsetRowMode_Normal como elegible para SubarrayFeatureMode_Engineering
        @mdSubarrayFeatureMode_Engineering.addSubMode(@mdoffsetRowMode_Normal)
        # Marcamos offsetRow_Full_Range como elegible para offsetRowMode_Normal
        @mdoffsetRowMode_Normal.addValue(@vloffsetRow_Full_Range)
        # Marcamos RowsMode_Normal como elegible para SubarrayFeatureMode_On
        @mdSubarrayFeatureMode_On.addSubMode(@mdRowsMode_Normal)
        # Marcamos RowsMode_Normal como elegible para SubarrayFeatureMode_Engineering
        @mdSubarrayFeatureMode_Engineering.addSubMode(@mdRowsMode_Normal)
        # Marcamos Rows_Full_Range como elegible para RowsMode_Normal
        @mdRowsMode_Normal.addValue(@vlRows_Full_Range)
        # Marcamos offsetColMode_Normal como elegible para SubarrayFeatureMode_On
        @mdSubarrayFeatureMode_On.addSubMode(@mdoffsetColMode_Normal)
        # Marcamos offsetColMode_Normal como elegible para SubarrayFeatureMode_Engineering
        @mdSubarrayFeatureMode_Engineering.addSubMode(@mdoffsetColMode_Normal)
        # Marcamos offsetCol_Full_Range como elegible para offsetColMode_Normal
        @mdoffsetColMode_Normal.addValue(@vloffsetCol_Full_Range)
        # Marcamos ExposureCtrlMode_Normal como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdExposureCtrlMode_Normal)
        # Marcamos ExposureCtrlMode_FT como elegible para AcquisitionMode_FrameTransfer
        @mdAcquisitionMode_FrameTransfer.addSubMode(@mdExposureCtrlMode_FT)
        # Marcamos ExposureCtrlMode_NoShutter como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdExposureCtrlMode_NoShutter)
        # Marcamos ExposureCtrlMode_Normal como elegible para AcquisitionMode_NormalWindow
        @mdAcquisitionMode_NormalWindow.addSubMode(@mdExposureCtrlMode_Normal)
        # Marcamos ExposureCtrlMode_Calibration como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdExposureCtrlMode_Calibration)
        # Marcamos ExposureCtrlMode_Normal como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Normal)
        # Marcamos ExposureCtrlMode_FT como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_FT)
        # Marcamos ExposureCtrlMode_NoShutter como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_NoShutter)
        # Marcamos ExposureCtrlMode_Calibration como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Calibration)
        # Marcamos ExposureCtrlMode_Engineering como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Engineering)
        # Marcamos OpenShutterMode_Off como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdOpenShutterMode_Off)
        # Marcamos OpenShutterMode_On como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdOpenShutterMode_On)
        # Marcamos OpenShutterMode_Off como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdOpenShutterMode_Off)
        # Marcamos OpenShutterMode_Off como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdOpenShutterMode_Off)
        # Marcamos OpenShutterMode_Off como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdOpenShutterMode_Off)
        # Marcamos OpenShutterMode_On como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdOpenShutterMode_On)
        # Marcamos OpenShutterMode_On como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdOpenShutterMode_On)
        # Marcamos OpenShutterMode_Off como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdOpenShutterMode_Off)
        # Marcamos ExpTimeMode_Normal como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdExpTimeMode_Normal)
        # Marcamos ExpTimeMode_FT como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdExpTimeMode_FT)
        # Marcamos ExpTimeMode_Normal como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdExpTimeMode_Normal)
        # Marcamos ExpTimeMode_Normal como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdExpTimeMode_Normal)
        # Marcamos ExpTimeMode_Normal como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdExpTimeMode_Normal)
        # Marcamos ExpTimeMode_FT como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdExpTimeMode_FT)
        # Marcamos ExpTime_Full_Range como elegible para ExpTimeMode_Normal
        @mdExpTimeMode_Normal.addValue(@vlExpTime_Full_Range)
        # Marcamos ExpTime_FT_Range como elegible para ExpTimeMode_FT
        @mdExpTimeMode_FT.addValue(@vlExpTime_FT_Range)
        # Marcamos PixelSpeedMode_FST como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_FST)
        # Marcamos PixelSpeedMode_MED como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_MED)
        # Marcamos PixelSpeedMode_SLW como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_SLW)
        # Marcamos PixelSpeedMode_FST como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_FST)
        # Marcamos PixelSpeedMode_MED como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_MED)
        # Marcamos PixelSpeedMode_SLW como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_SLW)
        # Marcamos PixelSpeedMode_FST como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_FST)
        # Marcamos PixelSpeedMode_MED como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_MED)
        # Marcamos PixelSpeedMode_SLW como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_SLW)
        # Marcamos PixelSpeedMode_FST como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_FST)
        # Marcamos PixelSpeedMode_MED como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_MED)
        # Marcamos PixelSpeedMode_SLW como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_SLW)
        # Marcamos PixelSpeedMode_SLW como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_SLW)
        # Marcamos PixelSpeedMode_MED como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_MED)
        # Marcamos PixelSpeedMode_FST como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_FST)
        # Marcamos numOfFramesMode_Single como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdnumOfFramesMode_Single)
        # Marcamos numOfFramesMode_Multiple como elegible para ExposureCtrlMode_Normal
        @mdExposureCtrlMode_Normal.addSubMode(@mdnumOfFramesMode_Multiple)
        # Marcamos numOfFramesMode_Single como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdnumOfFramesMode_Single)
        # Marcamos numOfFramesMode_Multiple como elegible para ExposureCtrlMode_FT
        @mdExposureCtrlMode_FT.addSubMode(@mdnumOfFramesMode_Multiple)
        # Marcamos numOfFramesMode_Single como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdnumOfFramesMode_Single)
        # Marcamos numOfFramesMode_Multiple como elegible para ExposureCtrlMode_NoShutter
        @mdExposureCtrlMode_NoShutter.addSubMode(@mdnumOfFramesMode_Multiple)
        # Marcamos numOfFramesMode_Single como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdnumOfFramesMode_Single)
        # Marcamos numOfFramesMode_Multiple como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdnumOfFramesMode_Multiple)
        # Marcamos numOfFramesMode_Multiple como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdnumOfFramesMode_Multiple)
        # Marcamos numOfFramesMode_Single como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdnumOfFramesMode_Single)
        # Marcamos numOfFrames_Multiple_Range como elegible para numOfFramesMode_Multiple
        @mdnumOfFramesMode_Multiple.addValue(@vlnumOfFrames_Multiple_Range)
        # Marcamos numOfFrames_1 como elegible para numOfFramesMode_Single
        @mdnumOfFramesMode_Single.addValue(@vlnumOfFrames_1)
        # Marcamos CalibGainMode_Normal como elegible para ExposureCtrlMode_Calibration
        @mdExposureCtrlMode_Calibration.addSubMode(@mdCalibGainMode_Normal)
        # Marcamos CalibGainMode_Normal como elegible para ExposureCtrlMode_Engineering
        @mdExposureCtrlMode_Engineering.addSubMode(@mdCalibGainMode_Normal)
        # Marcamos CalibGain_Normal_Range como elegible para CalibGainMode_Normal
        @mdCalibGainMode_Normal.addValue(@vlCalibGain_Normal_Range)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x1 como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x1)
        # Marcamos OutputSourceMode_0x2 como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x2)
        # Marcamos OutputSourceMode_0x3 como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x3)
        # Marcamos OutputSourceMode_TWO como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_TWO)
        # Marcamos OutputSourceMode_ALL como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_ALL)
        # Marcamos OutputSourceMode_TWO como elegible para AcquisitionMode_FrameTransfer
        @mdAcquisitionMode_FrameTransfer.addSubMode(@mdOutputSourceMode_TWO)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_FrameTransfer
        @mdAcquisitionMode_FrameTransfer.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x1 como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x1)
        # Marcamos OutputSourceMode_0x2 como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x2)
        # Marcamos OutputSourceMode_0x3 como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x3)
        # Marcamos OutputSourceMode_TWO como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_TWO)
        # Marcamos OutputSourceMode_ALL como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_ALL)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_NormalWindow
        @mdAcquisitionMode_NormalWindow.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x1 como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x1)
        # Marcamos OutputSourceMode_0x2 como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x2)
        # Marcamos OutputSourceMode_0x3 como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x3)
        # Marcamos OutputSourceMode_TWO como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_TWO)
        # Marcamos OutputSourceMode_ALL como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_ALL)
        # Marcamos OutputSourceMode_0x0 como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x0)
        # Marcamos OutputSourceMode_0x1 como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x1)
        # Marcamos OutputSourceMode_0x2 como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x2)
        # Marcamos OutputSourceMode_0x3 como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x3)
        # Marcamos OutputSourceMode_ALL como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_ALL)
        # Marcamos OutputSourceMode_TWO como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_TWO)
        # Marcamos OutputSourceMode_Engineering como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_Engineering)
        # Marcamos RecompositionMode_None como elegible para OutputSourceMode_0x0
        @mdOutputSourceMode_0x0.addSubMode(@mdRecompositionMode_None)
        # Marcamos RecompositionMode_None como elegible para OutputSourceMode_0x1
        @mdOutputSourceMode_0x1.addSubMode(@mdRecompositionMode_None)
        # Marcamos RecompositionMode_None como elegible para OutputSourceMode_0x2
        @mdOutputSourceMode_0x2.addSubMode(@mdRecompositionMode_None)
        # Marcamos RecompositionMode_None como elegible para OutputSourceMode_0x3
        @mdOutputSourceMode_0x3.addSubMode(@mdRecompositionMode_None)
        # Marcamos RecompositionMode_QuadCCD como elegible para OutputSourceMode_ALL
        @mdOutputSourceMode_ALL.addSubMode(@mdRecompositionMode_QuadCCD)
        # Marcamos RecompositionMode_Serial como elegible para OutputSourceMode_TWO
        @mdOutputSourceMode_TWO.addSubMode(@mdRecompositionMode_Serial)
        # Marcamos RecompositionMode_None como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_None)
        # Marcamos RecompositionMode_Parallel como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_Parallel)
        # Marcamos RecompositionMode_Serial como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_Serial)
        # Marcamos RecompositionMode_QuadCCD como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_QuadCCD)
        # Marcamos RecompositionMode_QuadIR como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_QuadIR)
        # Marcamos RecompositionMode_CDSQuad como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_CDSQuad)
        # Marcamos RecompositionMode_HawaiiRG como elegible para OutputSourceMode_Engineering
        @mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_HawaiiRG)
        # Marcamos DimensionsMode_Normal como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdDimensionsMode_Normal)
        # Marcamos DimensionsMode_FT como elegible para AcquisitionMode_FrameTransfer
        @mdAcquisitionMode_FrameTransfer.addSubMode(@mdDimensionsMode_FT)
        # Marcamos DimensionsMode_Normal como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdDimensionsMode_Normal)
        # Marcamos DimensionsMode_Normal como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdDimensionsMode_Normal)
        # Marcamos DimensionsMode_Normal como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_Normal)
        # Marcamos DimensionsMode_FT como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_FT)
        # Marcamos DimensionsMode_Engineering como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_Engineering)
        # Marcamos uiRowsMode_Normal como elegible para DimensionsMode_Normal
        @mdDimensionsMode_Normal.addSubMode(@mduiRowsMode_Normal)
        # Marcamos uiRowsMode_Half como elegible para DimensionsMode_FT
        @mdDimensionsMode_FT.addSubMode(@mduiRowsMode_Half)
        # Marcamos uiRowsMode_Normal como elegible para DimensionsMode_Engineering
        @mdDimensionsMode_Engineering.addSubMode(@mduiRowsMode_Normal)
        # Marcamos uiRowsMode_Half como elegible para DimensionsMode_Engineering
        @mdDimensionsMode_Engineering.addSubMode(@mduiRowsMode_Half)
        # Marcamos uiRows_Full_Range como elegible para uiRowsMode_Normal
        @mduiRowsMode_Normal.addValue(@vluiRows_Full_Range)
        # Marcamos uiRows_FTRange como elegible para uiRowsMode_Half
        @mduiRowsMode_Half.addValue(@vluiRows_FTRange)
        # Marcamos uiColsMode_Normal como elegible para DimensionsMode_Normal
        @mdDimensionsMode_Normal.addSubMode(@mduiColsMode_Normal)
        # Marcamos uiColsMode_Normal como elegible para DimensionsMode_FT
        @mdDimensionsMode_FT.addSubMode(@mduiColsMode_Normal)
        # Marcamos uiColsMode_Normal como elegible para DimensionsMode_Engineering
        @mdDimensionsMode_Engineering.addSubMode(@mduiColsMode_Normal)
        # Marcamos uiCols_Full_Range como elegible para uiColsMode_Normal
        @mduiColsMode_Normal.addValue(@vluiCols_Full_Range)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_Normal
        @mdAcquisitionMode_Normal.addSubMode(@mdBinningMode_All)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_FrameTransfer
        @mdAcquisitionMode_FrameTransfer.addSubMode(@mdBinningMode_All)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_Shuffling
        @mdAcquisitionMode_Shuffling.addSubMode(@mdBinningMode_All)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_NormalWindow
        @mdAcquisitionMode_NormalWindow.addSubMode(@mdBinningMode_All)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_Calibration
        @mdAcquisitionMode_Calibration.addSubMode(@mdBinningMode_All)
        # Marcamos BinningMode_All como elegible para AcquisitionMode_Engineering
        @mdAcquisitionMode_Engineering.addSubMode(@mdBinningMode_All)
        # Marcamos Binning_1x1 como elegible para BinningMode_All
        @mdBinningMode_All.addValue(@vlBinning_1x1)
        # Marcamos Binning_1x2 como elegible para BinningMode_All
        @mdBinningMode_All.addValue(@vlBinning_1x2)
        # Marcamos Binning_2x1 como elegible para BinningMode_All
        @mdBinningMode_All.addValue(@vlBinning_2x1)
        # Marcamos Binning_2x2 como elegible para BinningMode_All
        @mdBinningMode_All.addValue(@vlBinning_2x2)
end

    #----------------------------------------------------------------------
    #  Specific methods
    #----------------------------------------------------------------------

    ## ARCGenIIIMode 
    def get_ARCGenIIIMode
        @sysARCGenIII.getSelectedMode
	end

    def set_ARCGenIIIMode(mode)
        @sysARCGenIII.selectMode(mode)
	end

    ## FirmwareMode 
    def get_FirmwareMode
        @sysFirmware.getSelectedMode
	end

    def set_FirmwareMode(mode)
        @sysFirmware.selectMode(mode)
	end

    ## VariantsMode 
    def get_VariantsMode
        @sysVariants.getSelectedMode
	end

    def set_VariantsMode(mode)
        @sysVariants.selectMode(mode)
	end

    ## AcquisitionMode 
    def get_AcquisitionMode
        @sysAcquisition.getSelectedMode
	end

    def set_AcquisitionMode(mode)
        @sysAcquisition.selectMode(mode)
	end

    ## prParam ShuffleLines 

    # ShuffleLines
    def get_ShuffleLinesNode
        @prShuffleLines
	end

    def get_ShuffleLines
        @prShuffleLines.getSelectedValue
	end

    def set_ShuffleLines(value)
        @prShuffleLines.setValue(value)
	end

    ## ShuffleLinesMode 
    def get_ShuffleLinesMode
        @prShuffleLines.getSelectedMode
	end

    def set_ShuffleLinesMode(mode)
        @prShuffleLines.selectMode(mode)
	end

    ## prParam Acquisition 

    # ShuffleLinesDouble  
    def get_ShuffleLinesDouble
        v = @prShuffleLines.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ShuffleLinesDouble(data)
        @prShuffleLines.getSelectedValuew.setData(data)
	end

    ## prParam ShiftNumber 

    # ShiftNumber
    def get_ShiftNumberNode
        @prShiftNumber
	end

    def get_ShiftNumber
        @prShiftNumber.getSelectedValue
	end

    def set_ShiftNumber(value)
        @prShiftNumber.setValue(value)
	end

    ## ShiftNumberMode 
    def get_ShiftNumberMode
        @prShiftNumber.getSelectedMode
	end

    def set_ShiftNumberMode(mode)
        @prShiftNumber.selectMode(mode)
	end

    ## prParam Acquisition 

    # ShiftNumberDouble  
    def get_ShiftNumberDouble
        v = @prShiftNumber.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ShiftNumberDouble(data)
        @prShiftNumber.getSelectedValuew.setData(data)
	end

    ## SubarrayFeatureMode 
    def get_SubarrayFeatureMode
        @sysSubarrayFeature.getSelectedMode
	end

    def set_SubarrayFeatureMode(mode)
        @sysSubarrayFeature.selectMode(mode)
	end

    ## prParam Cols 

    # Cols
    def get_ColsNode
        @prCols
	end

    def get_Cols
        @prCols.getSelectedValue
	end

    def set_Cols(value)
        @prCols.setValue(value)
	end

    ## ColsMode 
    def get_ColsMode
        @prCols.getSelectedMode
	end

    def set_ColsMode(mode)
        @prCols.selectMode(mode)
	end

    ## prParam SubarrayFeature 

    # ColsDouble  
    def get_ColsDouble
        v = @prCols.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ColsDouble(data)
        @prCols.getSelectedValuew.setData(data)
	end

    ## prParam offsetRow 

    # offsetRow
    def get_offsetRowNode
        @proffsetRow
	end

    def get_offsetRow
        @proffsetRow.getSelectedValue
	end

    def set_offsetRow(value)
        @proffsetRow.setValue(value)
	end

    ## offsetRowMode 
    def get_offsetRowMode
        @proffsetRow.getSelectedMode
	end

    def set_offsetRowMode(mode)
        @proffsetRow.selectMode(mode)
	end

    ## prParam SubarrayFeature 

    # offsetRowDouble  
    def get_offsetRowDouble
        v = @proffsetRow.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_offsetRowDouble(data)
        @proffsetRow.getSelectedValuew.setData(data)
	end

    ## prParam Rows 

    # Rows
    def get_RowsNode
        @prRows
	end

    def get_Rows
        @prRows.getSelectedValue
	end

    def set_Rows(value)
        @prRows.setValue(value)
	end

    ## RowsMode 
    def get_RowsMode
        @prRows.getSelectedMode
	end

    def set_RowsMode(mode)
        @prRows.selectMode(mode)
	end

    ## prParam SubarrayFeature 

    # RowsDouble  
    def get_RowsDouble
        v = @prRows.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_RowsDouble(data)
        @prRows.getSelectedValuew.setData(data)
	end

    ## prParam offsetCol 

    # offsetCol
    def get_offsetColNode
        @proffsetCol
	end

    def get_offsetCol
        @proffsetCol.getSelectedValue
	end

    def set_offsetCol(value)
        @proffsetCol.setValue(value)
	end

    ## offsetColMode 
    def get_offsetColMode
        @proffsetCol.getSelectedMode
	end

    def set_offsetColMode(mode)
        @proffsetCol.selectMode(mode)
	end

    ## prParam SubarrayFeature 

    # offsetColDouble  
    def get_offsetColDouble
        v = @proffsetCol.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_offsetColDouble(data)
        @proffsetCol.getSelectedValuew.setData(data)
	end

    ## ExposureCtrlMode 
    def get_ExposureCtrlMode
        @sysExposureCtrl.getSelectedMode
	end

    def set_ExposureCtrlMode(mode)
        @sysExposureCtrl.selectMode(mode)
	end

    ## OpenShutterMode 
    def get_OpenShutterMode
        @sysOpenShutter.getSelectedMode
	end

    def set_OpenShutterMode(mode)
        @sysOpenShutter.selectMode(mode)
	end

    ## prParam ExpTime 

    # ExpTime
    def get_ExpTimeNode
        @prExpTime
	end

    def get_ExpTime
        @prExpTime.getSelectedValue
	end

    def set_ExpTime(value)
        @prExpTime.setValue(value)
	end

    ## ExpTimeMode 
    def get_ExpTimeMode
        @prExpTime.getSelectedMode
	end

    def set_ExpTimeMode(mode)
        @prExpTime.selectMode(mode)
	end

    ## prParam ExposureCtrl 

    # ExpTimeDouble  
    def get_ExpTimeDouble
        v = @prExpTime.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ExpTimeDouble(data)
        @prExpTime.getSelectedValuew.setData(data)
	end
    ## prParam ExposureCtrl 

    # ExpTimeDouble  
    def get_ExpTimeDouble
        v = @prExpTime.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ExpTimeDouble(data)
        @prExpTime.getSelectedValuew.setData(data)
	end

    ## PixelSpeedMode 
    def get_PixelSpeedMode
        @sysPixelSpeed.getSelectedMode
	end

    def set_PixelSpeedMode(mode)
        @sysPixelSpeed.selectMode(mode)
	end

    ## prParam numOfFrames 

    # numOfFrames
    def get_numOfFramesNode
        @prnumOfFrames
	end

    def get_numOfFrames
        @prnumOfFrames.getSelectedValue
	end

    def set_numOfFrames(value)
        @prnumOfFrames.setValue(value)
	end

    ## numOfFramesMode 
    def get_numOfFramesMode
        @prnumOfFrames.getSelectedMode
	end

    def set_numOfFramesMode(mode)
        @prnumOfFrames.selectMode(mode)
	end

    ## prParam ExposureCtrl 

    # numOfFramesDouble  
    def get_numOfFramesDouble
        v = @prnumOfFrames.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_numOfFramesDouble(data)
        @prnumOfFrames.getSelectedValuew.setData(data)
	end

    ## prParam CalibGain 

    # CalibGain
    def get_CalibGainNode
        @prCalibGain
	end

    def get_CalibGain
        @prCalibGain.getSelectedValue
	end

    def set_CalibGain(value)
        @prCalibGain.setValue(value)
	end

    ## CalibGainMode 
    def get_CalibGainMode
        @prCalibGain.getSelectedMode
	end

    def set_CalibGainMode(mode)
        @prCalibGain.selectMode(mode)
	end

    ## prParam ExposureCtrl 

    # CalibGainDouble  
    def get_CalibGainDouble
        v = @prCalibGain.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_CalibGainDouble(data)
        @prCalibGain.getSelectedValuew.setData(data)
	end

    ## OutputSourceMode 
    def get_OutputSourceMode
        @sysOutputSource.getSelectedMode
	end

    def set_OutputSourceMode(mode)
        @sysOutputSource.selectMode(mode)
	end

    ## RecompositionMode 
    def get_RecompositionMode
        @sysRecomposition.getSelectedMode
	end

    def set_RecompositionMode(mode)
        @sysRecomposition.selectMode(mode)
	end

    ## DimensionsMode 
    def get_DimensionsMode
        @sysDimensions.getSelectedMode
	end

    def set_DimensionsMode(mode)
        @sysDimensions.selectMode(mode)
	end

    ## prParam uiRows 

    # uiRows
    def get_uiRowsNode
        @pruiRows
	end

    def get_uiRows
        @pruiRows.getSelectedValue
	end

    def set_uiRows(value)
        @pruiRows.setValue(value)
	end

    ## uiRowsMode 
    def get_uiRowsMode
        @pruiRows.getSelectedMode
	end

    def set_uiRowsMode(mode)
        @pruiRows.selectMode(mode)
	end

    ## prParam Dimensions 

    # uiRowsDouble  
    def get_uiRowsDouble
        v = @pruiRows.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_uiRowsDouble(data)
        @pruiRows.getSelectedValuew.setData(data)
	end
    ## prParam Dimensions 

    # uiRowsDouble  
    def get_uiRowsDouble
        v = @pruiRows.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_uiRowsDouble(data)
        @pruiRows.getSelectedValuew.setData(data)
	end

    ## prParam uiCols 

    # uiCols
    def get_uiColsNode
        @pruiCols
	end

    def get_uiCols
        @pruiCols.getSelectedValue
	end

    def set_uiCols(value)
        @pruiCols.setValue(value)
	end

    ## uiColsMode 
    def get_uiColsMode
        @pruiCols.getSelectedMode
	end

    def set_uiColsMode(mode)
        @pruiCols.selectMode(mode)
	end

    ## prParam Dimensions 

    # uiColsDouble  
    def get_uiColsDouble
        v = @pruiCols.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_uiColsDouble(data)
        @pruiCols.getSelectedValuew.setData(data)
	end

    ## prParam Binning 

    # Binning
    def get_BinningNode
        @prBinning
	end

    def get_Binning
        @prBinning.getSelectedValue
	end

    def set_Binning(value)
        @prBinning.setValue(value)
	end

    ## BinningMode 
    def get_BinningMode
        @prBinning.getSelectedMode
	end

    def set_BinningMode(mode)
        @prBinning.selectMode(mode)
	end


    ## Action trigger ARCGenIII_expose ##
    def execARCGenIII_expose(value)
        # Override this
        true
	end

    ## Action trigger ARCGenIII_init_expose ##
    def execARCGenIII_init_expose(value)
        # Override this
        true
	end

    ## Action trigger ARCGenIII_cfg_init_expose ##
    def execARCGenIII_cfg_init_expose(value)
        # Override this
        true
	end

    ## Action trigger ARCGenIII_abort ##
    def execARCGenIII_abort(value)
        # Override this
        true
	end
end
