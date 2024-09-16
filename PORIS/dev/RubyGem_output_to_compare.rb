=begin
------- Constructor code --------
=end
require_relative 'PORIS'

class ARCGenIIIPORIS < PORISDoc
	def initialize(project_id)
		super(project_id)
		@sysARCGenIII = PORISSys.new('ARCGenIII')
		self.addItem(@sysARCGenIII)
		@sysARCGenIII.setIdent('ARC-0004')
		@sysARCGenIII.setDescription('')
		@mdARCGenIIIMode_UNKNOWN = PORISMode.new('ARCGenIIIMode_UNKNOWN')
		self.addItem(@mdARCGenIIIMode_UNKNOWN)
		@mdARCGenIIIMode_UNKNOWN.setIdent('UNKM_ARC-0004')
		@mdARCGenIIIMode_UNKNOWN.setDescription('Unknown mode for ARCGenIII')
		@mdARCGenIIIMode_Real = PORISMode.new('ARCGenIIIMode_Real')
		self.addItem(@mdARCGenIIIMode_Real)
		@mdARCGenIIIMode_Real.setIdent('ARC-0018')
		@mdARCGenIIIMode_Real.setDescription('')
		@mdARCGenIIIMode_Emulated = PORISMode.new('ARCGenIIIMode_Emulated')
		self.addItem(@mdARCGenIIIMode_Emulated)
		@mdARCGenIIIMode_Emulated.setIdent('ARC-0110')
		@mdARCGenIIIMode_Emulated.setDescription('')
		@mdARCGenIIIMode_Engineering = PORISMode.new('ARCGenIIIMode_Engineering')
		self.addItem(@mdARCGenIIIMode_Engineering)
		@mdARCGenIIIMode_Engineering.setIdent('ENG-14')
		@mdARCGenIIIMode_Engineering.setDescription('ARCGenIII engineering mode')
		@sysFirmware = PORISSys.new('Firmware')
		self.addItem(@sysFirmware)
		@sysFirmware.setIdent('ARC-0007')
		@sysFirmware.setDescription('')
		@mdFirmwareMode_UNKNOWN = PORISMode.new('FirmwareMode_UNKNOWN')
		self.addItem(@mdFirmwareMode_UNKNOWN)
		@mdFirmwareMode_UNKNOWN.setIdent('UNKM_ARC-0007')
		@mdFirmwareMode_UNKNOWN.setDescription('Unknown mode for Firmware')
		@mdFirmwareMode_tim = PORISMode.new('FirmwareMode_tim')
		self.addItem(@mdFirmwareMode_tim)
		@mdFirmwareMode_tim.setIdent('ARC-0021')
		@mdFirmwareMode_tim.setDescription('')
		@mdFirmwareMode_osiris2 = PORISMode.new('FirmwareMode_osiris2')
		self.addItem(@mdFirmwareMode_osiris2)
		@mdFirmwareMode_osiris2.setIdent('ARC-0062')
		@mdFirmwareMode_osiris2.setDescription('')
		@mdFirmwareMode_osiris3 = PORISMode.new('FirmwareMode_osiris3')
		self.addItem(@mdFirmwareMode_osiris3)
		@mdFirmwareMode_osiris3.setIdent('ARC-0073')
		@mdFirmwareMode_osiris3.setDescription('')
		@mdFirmwareMode_osiris4 = PORISMode.new('FirmwareMode_osiris4')
		self.addItem(@mdFirmwareMode_osiris4)
		@mdFirmwareMode_osiris4.setIdent('ARC-0074')
		@mdFirmwareMode_osiris4.setDescription('')
		@mdFirmwareMode_osiris5 = PORISMode.new('FirmwareMode_osiris5')
		self.addItem(@mdFirmwareMode_osiris5)
		@mdFirmwareMode_osiris5.setIdent('ARC-0075')
		@mdFirmwareMode_osiris5.setDescription('')
		@mdFirmwareMode_Engineering = PORISMode.new('FirmwareMode_Engineering')
		self.addItem(@mdFirmwareMode_Engineering)
		@mdFirmwareMode_Engineering.setIdent('ENG-15')
		@mdFirmwareMode_Engineering.setDescription('Firmware engineering mode')
		@sysVariants = PORISSys.new('Variants')
		self.addItem(@sysVariants)
		@sysVariants.setIdent('ARC-0097')
		@sysVariants.setDescription('')
		@mdVariantsMode_UNKNOWN = PORISMode.new('VariantsMode_UNKNOWN')
		self.addItem(@mdVariantsMode_UNKNOWN)
		@mdVariantsMode_UNKNOWN.setIdent('UNKM_ARC-0097')
		@mdVariantsMode_UNKNOWN.setDescription('Unknown mode for Variants')
		@mdVariantsMode_Normal = PORISMode.new('VariantsMode_Normal')
		self.addItem(@mdVariantsMode_Normal)
		@mdVariantsMode_Normal.setIdent('ARC-0098')
		@mdVariantsMode_Normal.setDescription('')
		@mdVariantsMode_Extended = PORISMode.new('VariantsMode_Extended')
		self.addItem(@mdVariantsMode_Extended)
		@mdVariantsMode_Extended.setIdent('ARC-0105')
		@mdVariantsMode_Extended.setDescription('')
		@mdVariantsMode_Extended_2 = PORISMode.new('VariantsMode_Extended_2')
		self.addItem(@mdVariantsMode_Extended_2)
		@mdVariantsMode_Extended_2.setIdent('ARC-0138')
		@mdVariantsMode_Extended_2.setDescription('')
		@mdVariantsMode_Engineering = PORISMode.new('VariantsMode_Engineering')
		self.addItem(@mdVariantsMode_Engineering)
		@mdVariantsMode_Engineering.setIdent('ENG-16')
		@mdVariantsMode_Engineering.setDescription('Variants engineering mode')
		@sysAcquisition = PORISSys.new('Acquisition')
		self.addItem(@sysAcquisition)
		@sysAcquisition.setIdent('ARC-0076')
		@sysAcquisition.setDescription('')
		@mdAcquisitionMode_UNKNOWN = PORISMode.new('AcquisitionMode_UNKNOWN')
		self.addItem(@mdAcquisitionMode_UNKNOWN)
		@mdAcquisitionMode_UNKNOWN.setIdent('UNKM_ARC-0076')
		@mdAcquisitionMode_UNKNOWN.setDescription('Unknown mode for Acquisition')
		@mdAcquisitionMode_Normal = PORISMode.new('AcquisitionMode_Normal')
		self.addItem(@mdAcquisitionMode_Normal)
		@mdAcquisitionMode_Normal.setIdent('ARC-0077')
		@mdAcquisitionMode_Normal.setDescription('')
		@mdAcquisitionMode_FrameTransfer = PORISMode.new('AcquisitionMode_FrameTransfer')
		self.addItem(@mdAcquisitionMode_FrameTransfer)
		@mdAcquisitionMode_FrameTransfer.setIdent('ARC-0078')
		@mdAcquisitionMode_FrameTransfer.setDescription('')
		@mdAcquisitionMode_Shuffling = PORISMode.new('AcquisitionMode_Shuffling')
		self.addItem(@mdAcquisitionMode_Shuffling)
		@mdAcquisitionMode_Shuffling.setIdent('ARC-0079')
		@mdAcquisitionMode_Shuffling.setDescription('')
		@mdAcquisitionMode_NormalWindow = PORISMode.new('AcquisitionMode_NormalWindow')
		self.addItem(@mdAcquisitionMode_NormalWindow)
		@mdAcquisitionMode_NormalWindow.setIdent('ARC-0126')
		@mdAcquisitionMode_NormalWindow.setDescription('')
		@mdAcquisitionMode_Calibration = PORISMode.new('AcquisitionMode_Calibration')
		self.addItem(@mdAcquisitionMode_Calibration)
		@mdAcquisitionMode_Calibration.setIdent('ARC-0137')
		@mdAcquisitionMode_Calibration.setDescription('')
		@mdAcquisitionMode_Engineering = PORISMode.new('AcquisitionMode_Engineering')
		self.addItem(@mdAcquisitionMode_Engineering)
		@mdAcquisitionMode_Engineering.setIdent('ENG-17')
		@mdAcquisitionMode_Engineering.setDescription('Acquisition engineering mode')
		@prShuffleLines = PORISParam.new('ShuffleLines')
		self.addItem(@prShuffleLines)
		@prShuffleLines.setIdent('ARC-0080')
		@prShuffleLines.setDescription('')
		@mdShuffleLinesMode_UNKNOWN = PORISMode.new('ShuffleLinesMode_UNKNOWN')
		self.addItem(@mdShuffleLinesMode_UNKNOWN)
		@mdShuffleLinesMode_UNKNOWN.setIdent('UNKM_ARC-0080')
		@mdShuffleLinesMode_UNKNOWN.setDescription('Unknown mode for ShuffleLines')
		@mdShuffleLinesMode_Normal = PORISMode.new('ShuffleLinesMode_Normal')
		self.addItem(@mdShuffleLinesMode_Normal)
		@mdShuffleLinesMode_Normal.setIdent('ARC-0082')
		@mdShuffleLinesMode_Normal.setDescription('')
		@vlShuffleLines_UNKNOWN = PORISValue.new('ShuffleLines_UNKNOWN')
		self.addItem(@vlShuffleLines_UNKNOWN)
		@vlShuffleLines_UNKNOWN.setIdent('UNK_ARC-0080')
		@vlShuffleLines_UNKNOWN.setDescription('Unknown value for ShuffleLines')
		@vlShuffleLines_Full_Range = PORISValueFloat.new('ShuffleLines_Full_Range',0,200,1000)
		self.addItem(@vlShuffleLines_Full_Range)
		@vlShuffleLines_Full_Range.setIdent('ARC-0081')
		@vlShuffleLines_Full_Range.setDescription('')
		@prShiftNumber = PORISParam.new('ShiftNumber')
		self.addItem(@prShiftNumber)
		@prShiftNumber.setIdent('ARC-0083')
		@prShiftNumber.setDescription('')
		@mdShiftNumberMode_UNKNOWN = PORISMode.new('ShiftNumberMode_UNKNOWN')
		self.addItem(@mdShiftNumberMode_UNKNOWN)
		@mdShiftNumberMode_UNKNOWN.setIdent('UNKM_ARC-0083')
		@mdShiftNumberMode_UNKNOWN.setDescription('Unknown mode for ShiftNumber')
		@mdShiftNumberMode_Normal = PORISMode.new('ShiftNumberMode_Normal')
		self.addItem(@mdShiftNumberMode_Normal)
		@mdShiftNumberMode_Normal.setIdent('ARC-0085')
		@mdShiftNumberMode_Normal.setDescription('')
		@vlShiftNumber_UNKNOWN = PORISValue.new('ShiftNumber_UNKNOWN')
		self.addItem(@vlShiftNumber_UNKNOWN)
		@vlShiftNumber_UNKNOWN.setIdent('UNK_ARC-0083')
		@vlShiftNumber_UNKNOWN.setDescription('Unknown value for ShiftNumber')
		@vlShiftNumber_Full_Range = PORISValueFloat.new('ShiftNumber_Full_Range',0,5,1000)
		self.addItem(@vlShiftNumber_Full_Range)
		@vlShiftNumber_Full_Range.setIdent('ARC-0084')
		@vlShiftNumber_Full_Range.setDescription('')
		@prBinning = PORISParam.new('Binning')
		self.addItem(@prBinning)
		@prBinning.setIdent('ARC-0008')
		@prBinning.setDescription('')
		@mdBinningMode_UNKNOWN = PORISMode.new('BinningMode_UNKNOWN')
		self.addItem(@mdBinningMode_UNKNOWN)
		@mdBinningMode_UNKNOWN.setIdent('UNKM_ARC-0008')
		@mdBinningMode_UNKNOWN.setDescription('Unknown mode for Binning')
		@mdBinningMode_All = PORISMode.new('BinningMode_All')
		self.addItem(@mdBinningMode_All)
		@mdBinningMode_All.setIdent('ARC-0031')
		@mdBinningMode_All.setDescription('')
		@vlBinning_UNKNOWN = PORISValue.new('Binning_UNKNOWN')
		self.addItem(@vlBinning_UNKNOWN)
		@vlBinning_UNKNOWN.setIdent('UNK_ARC-0008')
		@vlBinning_UNKNOWN.setDescription('Unknown value for Binning')
		@vlBinning_1x1 = PORISValue.new('Binning_1x1')
		self.addItem(@vlBinning_1x1)
		@vlBinning_1x1.setIdent('ARC-0026')
		@vlBinning_1x1.setDescription('')
		@vlBinning_1x2 = PORISValue.new('Binning_1x2')
		self.addItem(@vlBinning_1x2)
		@vlBinning_1x2.setIdent('ARC-0027')
		@vlBinning_1x2.setDescription('')
		@vlBinning_2x1 = PORISValue.new('Binning_2x1')
		self.addItem(@vlBinning_2x1)
		@vlBinning_2x1.setIdent('ARC-0028')
		@vlBinning_2x1.setDescription('')
		@vlBinning_2x2 = PORISValue.new('Binning_2x2')
		self.addItem(@vlBinning_2x2)
		@vlBinning_2x2.setIdent('ARC-0029')
		@vlBinning_2x2.setDescription('')
		@sysSubarrayFeature = PORISSys.new('SubarrayFeature')
		self.addItem(@sysSubarrayFeature)
		@sysSubarrayFeature.setIdent('ARC-0013')
		@sysSubarrayFeature.setDescription('')
		@mdSubarrayFeatureMode_UNKNOWN = PORISMode.new('SubarrayFeatureMode_UNKNOWN')
		self.addItem(@mdSubarrayFeatureMode_UNKNOWN)
		@mdSubarrayFeatureMode_UNKNOWN.setIdent('UNKM_ARC-0013')
		@mdSubarrayFeatureMode_UNKNOWN.setDescription('Unknown mode for SubarrayFeature')
		@mdSubarrayFeatureMode_Off = PORISMode.new('SubarrayFeatureMode_Off')
		self.addItem(@mdSubarrayFeatureMode_Off)
		@mdSubarrayFeatureMode_Off.setIdent('ARC-0041')
		@mdSubarrayFeatureMode_Off.setDescription('')
		@mdSubarrayFeatureMode_On = PORISMode.new('SubarrayFeatureMode_On')
		self.addItem(@mdSubarrayFeatureMode_On)
		@mdSubarrayFeatureMode_On.setIdent('ARC-0042')
		@mdSubarrayFeatureMode_On.setDescription('')
		@mdSubarrayFeatureMode_Engineering = PORISMode.new('SubarrayFeatureMode_Engineering')
		self.addItem(@mdSubarrayFeatureMode_Engineering)
		@mdSubarrayFeatureMode_Engineering.setIdent('ENG-18')
		@mdSubarrayFeatureMode_Engineering.setDescription('SubarrayFeature engineering mode')
		@prCols = PORISParam.new('Cols')
		self.addItem(@prCols)
		@prCols.setIdent('ARC-0044')
		@prCols.setDescription('')
		@mdColsMode_UNKNOWN = PORISMode.new('ColsMode_UNKNOWN')
		self.addItem(@mdColsMode_UNKNOWN)
		@mdColsMode_UNKNOWN.setIdent('UNKM_ARC-0044')
		@mdColsMode_UNKNOWN.setDescription('Unknown mode for Cols')
		@mdColsMode_Normal = PORISMode.new('ColsMode_Normal')
		self.addItem(@mdColsMode_Normal)
		@mdColsMode_Normal.setIdent('ARC-0066')
		@mdColsMode_Normal.setDescription('')
		@vlCols_UNKNOWN = PORISValue.new('Cols_UNKNOWN')
		self.addItem(@vlCols_UNKNOWN)
		@vlCols_UNKNOWN.setIdent('UNK_ARC-0044')
		@vlCols_UNKNOWN.setDescription('Unknown value for Cols')
		@vlCols_Full_Range = PORISValueFloat.new('Cols_Full_Range',0,2048,4098)
		self.addItem(@vlCols_Full_Range)
		@vlCols_Full_Range.setIdent('ARC-0065')
		@vlCols_Full_Range.setDescription('')
		@proffsetRow = PORISParam.new('offsetRow')
		self.addItem(@proffsetRow)
		@proffsetRow.setIdent('ARC-0045')
		@proffsetRow.setDescription('')
		@mdoffsetRowMode_UNKNOWN = PORISMode.new('offsetRowMode_UNKNOWN')
		self.addItem(@mdoffsetRowMode_UNKNOWN)
		@mdoffsetRowMode_UNKNOWN.setIdent('UNKM_ARC-0045')
		@mdoffsetRowMode_UNKNOWN.setDescription('Unknown mode for offsetRow')
		@mdoffsetRowMode_Normal = PORISMode.new('offsetRowMode_Normal')
		self.addItem(@mdoffsetRowMode_Normal)
		@mdoffsetRowMode_Normal.setIdent('ARC-0068')
		@mdoffsetRowMode_Normal.setDescription('')
		@vloffsetRow_UNKNOWN = PORISValue.new('offsetRow_UNKNOWN')
		self.addItem(@vloffsetRow_UNKNOWN)
		@vloffsetRow_UNKNOWN.setIdent('UNK_ARC-0045')
		@vloffsetRow_UNKNOWN.setDescription('Unknown value for offsetRow')
		@vloffsetRow_Full_Range = PORISValueFloat.new('offsetRow_Full_Range',0,2048,4098)
		self.addItem(@vloffsetRow_Full_Range)
		@vloffsetRow_Full_Range.setIdent('ARC-0067')
		@vloffsetRow_Full_Range.setDescription('')
		@prRows = PORISParam.new('Rows')
		self.addItem(@prRows)
		@prRows.setIdent('ARC-0043')
		@prRows.setDescription('')
		@mdRowsMode_UNKNOWN = PORISMode.new('RowsMode_UNKNOWN')
		self.addItem(@mdRowsMode_UNKNOWN)
		@mdRowsMode_UNKNOWN.setIdent('UNKM_ARC-0043')
		@mdRowsMode_UNKNOWN.setDescription('Unknown mode for Rows')
		@mdRowsMode_Normal = PORISMode.new('RowsMode_Normal')
		self.addItem(@mdRowsMode_Normal)
		@mdRowsMode_Normal.setIdent('ARC-0064')
		@mdRowsMode_Normal.setDescription('')
		@vlRows_UNKNOWN = PORISValue.new('Rows_UNKNOWN')
		self.addItem(@vlRows_UNKNOWN)
		@vlRows_UNKNOWN.setIdent('UNK_ARC-0043')
		@vlRows_UNKNOWN.setDescription('Unknown value for Rows')
		@vlRows_Full_Range = PORISValueFloat.new('Rows_Full_Range',0,2048,4098)
		self.addItem(@vlRows_Full_Range)
		@vlRows_Full_Range.setIdent('ARC-0063')
		@vlRows_Full_Range.setDescription('')
		@proffsetCol = PORISParam.new('offsetCol')
		self.addItem(@proffsetCol)
		@proffsetCol.setIdent('ARC-0046')
		@proffsetCol.setDescription('')
		@mdoffsetColMode_UNKNOWN = PORISMode.new('offsetColMode_UNKNOWN')
		self.addItem(@mdoffsetColMode_UNKNOWN)
		@mdoffsetColMode_UNKNOWN.setIdent('UNKM_ARC-0046')
		@mdoffsetColMode_UNKNOWN.setDescription('Unknown mode for offsetCol')
		@mdoffsetColMode_Normal = PORISMode.new('offsetColMode_Normal')
		self.addItem(@mdoffsetColMode_Normal)
		@mdoffsetColMode_Normal.setIdent('ARC-0070')
		@mdoffsetColMode_Normal.setDescription('')
		@vloffsetCol_UNKNOWN = PORISValue.new('offsetCol_UNKNOWN')
		self.addItem(@vloffsetCol_UNKNOWN)
		@vloffsetCol_UNKNOWN.setIdent('UNK_ARC-0046')
		@vloffsetCol_UNKNOWN.setDescription('Unknown value for offsetCol')
		@vloffsetCol_Full_Range = PORISValueFloat.new('offsetCol_Full_Range',0,2048,4098)
		self.addItem(@vloffsetCol_Full_Range)
		@vloffsetCol_Full_Range.setIdent('ARC-0069')
		@vloffsetCol_Full_Range.setDescription('')
		@sysExposureCtrl = PORISSys.new('ExposureCtrl')
		self.addItem(@sysExposureCtrl)
		@sysExposureCtrl.setIdent('ARC-0103')
		@sysExposureCtrl.setDescription('')
		@mdExposureCtrlMode_UNKNOWN = PORISMode.new('ExposureCtrlMode_UNKNOWN')
		self.addItem(@mdExposureCtrlMode_UNKNOWN)
		@mdExposureCtrlMode_UNKNOWN.setIdent('UNKM_ARC-0103')
		@mdExposureCtrlMode_UNKNOWN.setDescription('Unknown mode for ExposureCtrl')
		@mdExposureCtrlMode_Normal = PORISMode.new('ExposureCtrlMode_Normal')
		self.addItem(@mdExposureCtrlMode_Normal)
		@mdExposureCtrlMode_Normal.setIdent('ARC-0104')
		@mdExposureCtrlMode_Normal.setDescription('')
		@mdExposureCtrlMode_FT = PORISMode.new('ExposureCtrlMode_FT')
		self.addItem(@mdExposureCtrlMode_FT)
		@mdExposureCtrlMode_FT.setIdent('ARC-0114')
		@mdExposureCtrlMode_FT.setDescription('')
		@mdExposureCtrlMode_NoShutter = PORISMode.new('ExposureCtrlMode_NoShutter')
		self.addItem(@mdExposureCtrlMode_NoShutter)
		@mdExposureCtrlMode_NoShutter.setIdent('ARC-0134')
		@mdExposureCtrlMode_NoShutter.setDescription('')
		@mdExposureCtrlMode_Calibration = PORISMode.new('ExposureCtrlMode_Calibration')
		self.addItem(@mdExposureCtrlMode_Calibration)
		@mdExposureCtrlMode_Calibration.setIdent('ARC-0136')
		@mdExposureCtrlMode_Calibration.setDescription('')
		@mdExposureCtrlMode_Engineering = PORISMode.new('ExposureCtrlMode_Engineering')
		self.addItem(@mdExposureCtrlMode_Engineering)
		@mdExposureCtrlMode_Engineering.setIdent('ENG-19')
		@mdExposureCtrlMode_Engineering.setDescription('ExposureCtrl engineering mode')
		@prExpTime = PORISParam.new('ExpTime')
		self.addItem(@prExpTime)
		@prExpTime.setIdent('ARC-0010')
		@prExpTime.setDescription('')
		@mdExpTimeMode_UNKNOWN = PORISMode.new('ExpTimeMode_UNKNOWN')
		self.addItem(@mdExpTimeMode_UNKNOWN)
		@mdExpTimeMode_UNKNOWN.setIdent('UNKM_ARC-0010')
		@mdExpTimeMode_UNKNOWN.setDescription('Unknown mode for ExpTime')
		@mdExpTimeMode_Normal = PORISMode.new('ExpTimeMode_Normal')
		self.addItem(@mdExpTimeMode_Normal)
		@mdExpTimeMode_Normal.setIdent('ARC-0036')
		@mdExpTimeMode_Normal.setDescription('')
		@mdExpTimeMode_FT = PORISMode.new('ExpTimeMode_FT')
		self.addItem(@mdExpTimeMode_FT)
		@mdExpTimeMode_FT.setIdent('ARC-0119')
		@mdExpTimeMode_FT.setDescription('')
		@vlExpTime_UNKNOWN = PORISValue.new('ExpTime_UNKNOWN')
		self.addItem(@vlExpTime_UNKNOWN)
		@vlExpTime_UNKNOWN.setIdent('UNK_ARC-0010')
		@vlExpTime_UNKNOWN.setDescription('Unknown value for ExpTime')
		@vlExpTime_Full_Range = PORISValueFloat.new('ExpTime_Full_Range',0,1,4294967.295)
		self.addItem(@vlExpTime_Full_Range)
		@vlExpTime_Full_Range.setIdent('ARC-0035')
		@vlExpTime_Full_Range.setDescription('')
		@vlExpTime_FT_Range = PORISValueFloat.new('ExpTime_FT_Range',0,0,360)
		self.addItem(@vlExpTime_FT_Range)
		@vlExpTime_FT_Range.setIdent('ARC-0120')
		@vlExpTime_FT_Range.setDescription('')
		@prnumOfFrames = PORISParam.new('numOfFrames')
		self.addItem(@prnumOfFrames)
		@prnumOfFrames.setIdent('ARC-0001')
		@prnumOfFrames.setDescription('')
		@mdnumOfFramesMode_UNKNOWN = PORISMode.new('numOfFramesMode_UNKNOWN')
		self.addItem(@mdnumOfFramesMode_UNKNOWN)
		@mdnumOfFramesMode_UNKNOWN.setIdent('UNKM_ARC-0001')
		@mdnumOfFramesMode_UNKNOWN.setDescription('Unknown mode for numOfFrames')
		@mdnumOfFramesMode_Multiple = PORISMode.new('numOfFramesMode_Multiple')
		self.addItem(@mdnumOfFramesMode_Multiple)
		@mdnumOfFramesMode_Multiple.setIdent('ARC-0072')
		@mdnumOfFramesMode_Multiple.setDescription('')
		@mdnumOfFramesMode_Single = PORISMode.new('numOfFramesMode_Single')
		self.addItem(@mdnumOfFramesMode_Single)
		@mdnumOfFramesMode_Single.setIdent('ARC-0037')
		@mdnumOfFramesMode_Single.setDescription('')
		@vlnumOfFrames_UNKNOWN = PORISValue.new('numOfFrames_UNKNOWN')
		self.addItem(@vlnumOfFrames_UNKNOWN)
		@vlnumOfFrames_UNKNOWN.setIdent('UNK_ARC-0001')
		@vlnumOfFrames_UNKNOWN.setDescription('Unknown value for numOfFrames')
		@vlnumOfFrames_Multiple_Range = PORISValueFloat.new('numOfFrames_Multiple_Range',2,10,4294967295)
		self.addItem(@vlnumOfFrames_Multiple_Range)
		@vlnumOfFrames_Multiple_Range.setIdent('ARC-0071')
		@vlnumOfFrames_Multiple_Range.setDescription('')
		@vlnumOfFrames_1 = PORISValue.new('numOfFrames_1')
		self.addItem(@vlnumOfFrames_1)
		@vlnumOfFrames_1.setIdent('ARC-0131')
		@vlnumOfFrames_1.setDescription('')
		@prCalibGain = PORISParam.new('CalibGain')
		self.addItem(@prCalibGain)
		@prCalibGain.setIdent('ARC-0130')
		@prCalibGain.setDescription('')
		@mdCalibGainMode_UNKNOWN = PORISMode.new('CalibGainMode_UNKNOWN')
		self.addItem(@mdCalibGainMode_UNKNOWN)
		@mdCalibGainMode_UNKNOWN.setIdent('UNKM_ARC-0130')
		@mdCalibGainMode_UNKNOWN.setDescription('Unknown mode for CalibGain')
		@mdCalibGainMode_Normal = PORISMode.new('CalibGainMode_Normal')
		self.addItem(@mdCalibGainMode_Normal)
		@mdCalibGainMode_Normal.setIdent('ARC-0125')
		@mdCalibGainMode_Normal.setDescription('')
		@vlCalibGain_UNKNOWN = PORISValue.new('CalibGain_UNKNOWN')
		self.addItem(@vlCalibGain_UNKNOWN)
		@vlCalibGain_UNKNOWN.setIdent('UNK_ARC-0130')
		@vlCalibGain_UNKNOWN.setDescription('Unknown value for CalibGain')
		@vlCalibGain_Normal_Range = PORISValueFloat.new('CalibGain_Normal_Range',0,2,15)
		self.addItem(@vlCalibGain_Normal_Range)
		@vlCalibGain_Normal_Range.setIdent('ARC-0124')
		@vlCalibGain_Normal_Range.setDescription('')
		@sysOpenShutter = PORISSys.new('OpenShutter')
		self.addItem(@sysOpenShutter)
		@sysOpenShutter.setIdent('ARC-0009')
		@sysOpenShutter.setDescription('')
		@mdOpenShutterMode_UNKNOWN = PORISMode.new('OpenShutterMode_UNKNOWN')
		self.addItem(@mdOpenShutterMode_UNKNOWN)
		@mdOpenShutterMode_UNKNOWN.setIdent('UNKM_ARC-0009')
		@mdOpenShutterMode_UNKNOWN.setDescription('Unknown mode for OpenShutter')
		@mdOpenShutterMode_On = PORISMode.new('OpenShutterMode_On')
		self.addItem(@mdOpenShutterMode_On)
		@mdOpenShutterMode_On.setIdent('ARC-0033')
		@mdOpenShutterMode_On.setDescription('')
		@mdOpenShutterMode_Off = PORISMode.new('OpenShutterMode_Off')
		self.addItem(@mdOpenShutterMode_Off)
		@mdOpenShutterMode_Off.setIdent('ARC-0034')
		@mdOpenShutterMode_Off.setDescription('')
		@sysPixelSpeed = PORISSys.new('PixelSpeed')
		self.addItem(@sysPixelSpeed)
		@sysPixelSpeed.setIdent('ARC-0093')
		@sysPixelSpeed.setDescription('')
		@mdPixelSpeedMode_UNKNOWN = PORISMode.new('PixelSpeedMode_UNKNOWN')
		self.addItem(@mdPixelSpeedMode_UNKNOWN)
		@mdPixelSpeedMode_UNKNOWN.setIdent('UNKM_ARC-0093')
		@mdPixelSpeedMode_UNKNOWN.setDescription('Unknown mode for PixelSpeed')
		@mdPixelSpeedMode_SLW = PORISMode.new('PixelSpeedMode_SLW')
		self.addItem(@mdPixelSpeedMode_SLW)
		@mdPixelSpeedMode_SLW.setIdent('ARC-0094')
		@mdPixelSpeedMode_SLW.setDescription('')
		@mdPixelSpeedMode_MED = PORISMode.new('PixelSpeedMode_MED')
		self.addItem(@mdPixelSpeedMode_MED)
		@mdPixelSpeedMode_MED.setIdent('ARC-0095')
		@mdPixelSpeedMode_MED.setDescription('')
		@mdPixelSpeedMode_FST = PORISMode.new('PixelSpeedMode_FST')
		self.addItem(@mdPixelSpeedMode_FST)
		@mdPixelSpeedMode_FST.setIdent('ARC-0096')
		@mdPixelSpeedMode_FST.setDescription('')
		@sysOutputSource = PORISSys.new('OutputSource')
		self.addItem(@sysOutputSource)
		@sysOutputSource.setIdent('ARC-0086')
		@sysOutputSource.setDescription('')
		@mdOutputSourceMode_UNKNOWN = PORISMode.new('OutputSourceMode_UNKNOWN')
		self.addItem(@mdOutputSourceMode_UNKNOWN)
		@mdOutputSourceMode_UNKNOWN.setIdent('UNKM_ARC-0086')
		@mdOutputSourceMode_UNKNOWN.setDescription('Unknown mode for OutputSource')
		@mdOutputSourceMode_0x0 = PORISMode.new('OutputSourceMode_0x0')
		self.addItem(@mdOutputSourceMode_0x0)
		@mdOutputSourceMode_0x0.setIdent('ARC-0087')
		@mdOutputSourceMode_0x0.setDescription('')
		@mdOutputSourceMode_0x1 = PORISMode.new('OutputSourceMode_0x1')
		self.addItem(@mdOutputSourceMode_0x1)
		@mdOutputSourceMode_0x1.setIdent('ARC-0088')
		@mdOutputSourceMode_0x1.setDescription('')
		@mdOutputSourceMode_0x2 = PORISMode.new('OutputSourceMode_0x2')
		self.addItem(@mdOutputSourceMode_0x2)
		@mdOutputSourceMode_0x2.setIdent('ARC-0089')
		@mdOutputSourceMode_0x2.setDescription('')
		@mdOutputSourceMode_0x3 = PORISMode.new('OutputSourceMode_0x3')
		self.addItem(@mdOutputSourceMode_0x3)
		@mdOutputSourceMode_0x3.setIdent('ARC-0090')
		@mdOutputSourceMode_0x3.setDescription('')
		@mdOutputSourceMode_ALL = PORISMode.new('OutputSourceMode_ALL')
		self.addItem(@mdOutputSourceMode_ALL)
		@mdOutputSourceMode_ALL.setIdent('ARC-0091')
		@mdOutputSourceMode_ALL.setDescription('')
		@mdOutputSourceMode_TWO = PORISMode.new('OutputSourceMode_TWO')
		self.addItem(@mdOutputSourceMode_TWO)
		@mdOutputSourceMode_TWO.setIdent('ARC-0092')
		@mdOutputSourceMode_TWO.setDescription('')
		@mdOutputSourceMode_Engineering = PORISMode.new('OutputSourceMode_Engineering')
		self.addItem(@mdOutputSourceMode_Engineering)
		@mdOutputSourceMode_Engineering.setIdent('ENG-22')
		@mdOutputSourceMode_Engineering.setDescription('OutputSource engineering mode')
		@sysRecomposition = PORISSys.new('Recomposition')
		self.addItem(@sysRecomposition)
		@sysRecomposition.setIdent('ARC-0020')
		@sysRecomposition.setDescription('')
		@mdRecompositionMode_UNKNOWN = PORISMode.new('RecompositionMode_UNKNOWN')
		self.addItem(@mdRecompositionMode_UNKNOWN)
		@mdRecompositionMode_UNKNOWN.setIdent('UNKM_ARC-0020')
		@mdRecompositionMode_UNKNOWN.setDescription('Unknown mode for Recomposition')
		@mdRecompositionMode_None = PORISMode.new('RecompositionMode_None')
		self.addItem(@mdRecompositionMode_None)
		@mdRecompositionMode_None.setIdent('ARC-0055')
		@mdRecompositionMode_None.setDescription('')
		@mdRecompositionMode_Parallel = PORISMode.new('RecompositionMode_Parallel')
		self.addItem(@mdRecompositionMode_Parallel)
		@mdRecompositionMode_Parallel.setIdent('ARC-0056')
		@mdRecompositionMode_Parallel.setDescription('')
		@mdRecompositionMode_Serial = PORISMode.new('RecompositionMode_Serial')
		self.addItem(@mdRecompositionMode_Serial)
		@mdRecompositionMode_Serial.setIdent('ARC-0057')
		@mdRecompositionMode_Serial.setDescription('')
		@mdRecompositionMode_QuadCCD = PORISMode.new('RecompositionMode_QuadCCD')
		self.addItem(@mdRecompositionMode_QuadCCD)
		@mdRecompositionMode_QuadCCD.setIdent('ARC-0058')
		@mdRecompositionMode_QuadCCD.setDescription('')
		@mdRecompositionMode_QuadIR = PORISMode.new('RecompositionMode_QuadIR')
		self.addItem(@mdRecompositionMode_QuadIR)
		@mdRecompositionMode_QuadIR.setIdent('ARC-0059')
		@mdRecompositionMode_QuadIR.setDescription('')
		@mdRecompositionMode_CDSQuad = PORISMode.new('RecompositionMode_CDSQuad')
		self.addItem(@mdRecompositionMode_CDSQuad)
		@mdRecompositionMode_CDSQuad.setIdent('ARC-0060')
		@mdRecompositionMode_CDSQuad.setDescription('')
		@mdRecompositionMode_HawaiiRG = PORISMode.new('RecompositionMode_HawaiiRG')
		self.addItem(@mdRecompositionMode_HawaiiRG)
		@mdRecompositionMode_HawaiiRG.setIdent('ARC-0061')
		@mdRecompositionMode_HawaiiRG.setDescription('')
		@sysDimensions = PORISSys.new('Dimensions')
		self.addItem(@sysDimensions)
		@sysDimensions.setIdent('ARC-0099')
		@sysDimensions.setDescription('')
		@mdDimensionsMode_UNKNOWN = PORISMode.new('DimensionsMode_UNKNOWN')
		self.addItem(@mdDimensionsMode_UNKNOWN)
		@mdDimensionsMode_UNKNOWN.setIdent('UNKM_ARC-0099')
		@mdDimensionsMode_UNKNOWN.setDescription('Unknown mode for Dimensions')
		@mdDimensionsMode_Normal = PORISMode.new('DimensionsMode_Normal')
		self.addItem(@mdDimensionsMode_Normal)
		@mdDimensionsMode_Normal.setIdent('ARC-0100')
		@mdDimensionsMode_Normal.setDescription('')
		@mdDimensionsMode_FT = PORISMode.new('DimensionsMode_FT')
		self.addItem(@mdDimensionsMode_FT)
		@mdDimensionsMode_FT.setIdent('ARC-0129')
		@mdDimensionsMode_FT.setDescription('')
		@mdDimensionsMode_Engineering = PORISMode.new('DimensionsMode_Engineering')
		self.addItem(@mdDimensionsMode_Engineering)
		@mdDimensionsMode_Engineering.setIdent('ENG-24')
		@mdDimensionsMode_Engineering.setDescription('Dimensions engineering mode')
		@pruiRows = PORISParam.new('uiRows')
		self.addItem(@pruiRows)
		@pruiRows.setIdent('ARC-0005')
		@pruiRows.setDescription('')
		@mduiRowsMode_UNKNOWN = PORISMode.new('uiRowsMode_UNKNOWN')
		self.addItem(@mduiRowsMode_UNKNOWN)
		@mduiRowsMode_UNKNOWN.setIdent('UNKM_ARC-0005')
		@mduiRowsMode_UNKNOWN.setDescription('Unknown mode for uiRows')
		@mduiRowsMode_Normal = PORISMode.new('uiRowsMode_Normal')
		self.addItem(@mduiRowsMode_Normal)
		@mduiRowsMode_Normal.setIdent('ARC-0023')
		@mduiRowsMode_Normal.setDescription('')
		@mduiRowsMode_Half = PORISMode.new('uiRowsMode_Half')
		self.addItem(@mduiRowsMode_Half)
		@mduiRowsMode_Half.setIdent('ARC-0128')
		@mduiRowsMode_Half.setDescription('')
		@vluiRows_UNKNOWN = PORISValue.new('uiRows_UNKNOWN')
		self.addItem(@vluiRows_UNKNOWN)
		@vluiRows_UNKNOWN.setIdent('UNK_ARC-0005')
		@vluiRows_UNKNOWN.setDescription('Unknown value for uiRows')
		@vluiRows_Full_Range = PORISValueFloat.new('uiRows_Full_Range',0,4112,4112)
		self.addItem(@vluiRows_Full_Range)
		@vluiRows_Full_Range.setIdent('ARC-0022')
		@vluiRows_Full_Range.setDescription('')
		@vluiRows_FTRange = PORISValueFloat.new('uiRows_FTRange',0,2056,2056)
		self.addItem(@vluiRows_FTRange)
		@vluiRows_FTRange.setIdent('ARC-0127')
		@vluiRows_FTRange.setDescription('')
		@pruiCols = PORISParam.new('uiCols')
		self.addItem(@pruiCols)
		@pruiCols.setIdent('ARC-0006')
		@pruiCols.setDescription('')
		@mduiColsMode_UNKNOWN = PORISMode.new('uiColsMode_UNKNOWN')
		self.addItem(@mduiColsMode_UNKNOWN)
		@mduiColsMode_UNKNOWN.setIdent('UNKM_ARC-0006')
		@mduiColsMode_UNKNOWN.setDescription('Unknown mode for uiCols')
		@mduiColsMode_Normal = PORISMode.new('uiColsMode_Normal')
		self.addItem(@mduiColsMode_Normal)
		@mduiColsMode_Normal.setIdent('ARC-0025')
		@mduiColsMode_Normal.setDescription('')
		@vluiCols_UNKNOWN = PORISValue.new('uiCols_UNKNOWN')
		self.addItem(@vluiCols_UNKNOWN)
		@vluiCols_UNKNOWN.setIdent('UNK_ARC-0006')
		@vluiCols_UNKNOWN.setDescription('Unknown value for uiCols')
		@vluiCols_Full_Range = PORISValueFloat.new('uiCols_Full_Range',0,4096,4096)
		self.addItem(@vluiCols_Full_Range)
		@vluiCols_Full_Range.setIdent('ARC-0024')
		@vluiCols_Full_Range.setDescription('')
		self.setRoot(@sysARCGenIII)
		@sysARCGenIII.addMode(@mdARCGenIIIMode_UNKNOWN)
		@mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_tim)
		@mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris2)
		@mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris3)
		@mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris4)
		@mdARCGenIIIMode_Real.addSubMode(@mdFirmwareMode_osiris5)
		@sysARCGenIII.addMode(@mdARCGenIIIMode_Real)
		@mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_tim)
		@mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris2)
		@mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris3)
		@mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris4)
		@mdARCGenIIIMode_Emulated.addSubMode(@mdFirmwareMode_osiris5)
		@sysARCGenIII.addMode(@mdARCGenIIIMode_Emulated)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_tim)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris2)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris3)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris4)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_osiris5)
		@mdARCGenIIIMode_Engineering.addSubMode(@mdFirmwareMode_Engineering)
		@sysARCGenIII.addMode(@mdARCGenIIIMode_Engineering)
		@sysFirmware.addMode(@mdFirmwareMode_UNKNOWN)
		@mdFirmwareMode_tim.addSubMode(@mdVariantsMode_Normal)
		@sysFirmware.addMode(@mdFirmwareMode_tim)
		@mdFirmwareMode_osiris2.addSubMode(@mdVariantsMode_Extended)
		@sysFirmware.addMode(@mdFirmwareMode_osiris2)
		@mdFirmwareMode_osiris3.addSubMode(@mdVariantsMode_Extended_2)
		@sysFirmware.addMode(@mdFirmwareMode_osiris3)
		@mdFirmwareMode_osiris4.addSubMode(@mdVariantsMode_Extended_2)
		@sysFirmware.addMode(@mdFirmwareMode_osiris4)
		@mdFirmwareMode_osiris5.addSubMode(@mdVariantsMode_Extended_2)
		@sysFirmware.addMode(@mdFirmwareMode_osiris5)
		@mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Normal)
		@mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Extended)
		@mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Extended_2)
		@mdFirmwareMode_Engineering.addSubMode(@mdVariantsMode_Engineering)
		@sysFirmware.addMode(@mdFirmwareMode_Engineering)
		@sysVariants.addMode(@mdVariantsMode_UNKNOWN)
		@mdVariantsMode_Normal.addSubMode(@mdAcquisitionMode_Normal)
		@mdVariantsMode_Normal.addSubMode(@mdAcquisitionMode_NormalWindow)
		@sysVariants.addMode(@mdVariantsMode_Normal)
		@mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_Shuffling)
		@mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_FrameTransfer)
		@mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_Normal)
		@mdVariantsMode_Extended.addSubMode(@mdAcquisitionMode_NormalWindow)
		@sysVariants.addMode(@mdVariantsMode_Extended)
		@mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Shuffling)
		@mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_FrameTransfer)
		@mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Normal)
		@mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_NormalWindow)
		@mdVariantsMode_Extended_2.addSubMode(@mdAcquisitionMode_Calibration)
		@sysVariants.addMode(@mdVariantsMode_Extended_2)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Normal)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_FrameTransfer)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Shuffling)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_NormalWindow)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Calibration)
		@mdVariantsMode_Engineering.addSubMode(@mdAcquisitionMode_Engineering)
		@sysVariants.addMode(@mdVariantsMode_Engineering)
		@sysAcquisition.addMode(@mdAcquisitionMode_UNKNOWN)
		@mdAcquisitionMode_Normal.addSubMode(@mdSubarrayFeatureMode_Off)
		@mdAcquisitionMode_Normal.addSubMode(@mdExposureCtrlMode_Normal)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x1)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x2)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_0x3)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_TWO)
		@mdAcquisitionMode_Normal.addSubMode(@mdOutputSourceMode_ALL)
		@mdAcquisitionMode_Normal.addSubMode(@mdDimensionsMode_Normal)
		@mdAcquisitionMode_Normal.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_Normal)
		@mdAcquisitionMode_FrameTransfer.addSubMode(@mdExposureCtrlMode_FT)
		@mdAcquisitionMode_FrameTransfer.addSubMode(@mdOutputSourceMode_TWO)
		@mdAcquisitionMode_FrameTransfer.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_FrameTransfer.addSubMode(@mdDimensionsMode_FT)
		@mdAcquisitionMode_FrameTransfer.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_FrameTransfer)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdShuffleLinesMode_Normal)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdShiftNumberMode_Normal)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdExposureCtrlMode_NoShutter)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x1)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x2)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_0x3)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_TWO)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdOutputSourceMode_ALL)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdDimensionsMode_Normal)
		@mdAcquisitionMode_Shuffling.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_Shuffling)
		@mdAcquisitionMode_NormalWindow.addSubMode(@mdSubarrayFeatureMode_On)
		@mdAcquisitionMode_NormalWindow.addSubMode(@mdExposureCtrlMode_Normal)
		@mdAcquisitionMode_NormalWindow.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_NormalWindow.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_NormalWindow)
		@mdAcquisitionMode_Calibration.addSubMode(@mdSubarrayFeatureMode_Off)
		@mdAcquisitionMode_Calibration.addSubMode(@mdExposureCtrlMode_Calibration)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x1)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x2)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_0x3)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_TWO)
		@mdAcquisitionMode_Calibration.addSubMode(@mdOutputSourceMode_ALL)
		@mdAcquisitionMode_Calibration.addSubMode(@mdDimensionsMode_Normal)
		@mdAcquisitionMode_Calibration.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_Calibration)
		@mdAcquisitionMode_Engineering.addSubMode(@mdShuffleLinesMode_Normal)
		@mdAcquisitionMode_Engineering.addSubMode(@mdShiftNumberMode_Normal)
		@mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_Off)
		@mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_On)
		@mdAcquisitionMode_Engineering.addSubMode(@mdSubarrayFeatureMode_Engineering)
		@mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Normal)
		@mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_FT)
		@mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_NoShutter)
		@mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Calibration)
		@mdAcquisitionMode_Engineering.addSubMode(@mdExposureCtrlMode_Engineering)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x0)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x1)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x2)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_0x3)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_ALL)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_TWO)
		@mdAcquisitionMode_Engineering.addSubMode(@mdOutputSourceMode_Engineering)
		@mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_Normal)
		@mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_FT)
		@mdAcquisitionMode_Engineering.addSubMode(@mdDimensionsMode_Engineering)
		@mdAcquisitionMode_Engineering.addSubMode(@mdBinningMode_All)
		@sysAcquisition.addMode(@mdAcquisitionMode_Engineering)
		@prShuffleLines.addMode(@mdShuffleLinesMode_UNKNOWN)
		@mdShuffleLinesMode_Normal.addValue(@vlShuffleLines_Full_Range)
		@prShuffleLines.addMode(@mdShuffleLinesMode_Normal)
		@prShuffleLines.addValue(@vlShuffleLines_UNKNOWN)
		@mdShuffleLinesMode_UNKNOWN.addValue(@vlShuffleLines_UNKNOWN)
		@prShuffleLines.addValue(@vlShuffleLines_Full_Range)
		@sysAcquisition.addParam(@prShuffleLines)
		@mdAcquisitionMode_UNKNOWN.addSubMode(@mdShuffleLinesMode_UNKNOWN)
		@prShiftNumber.addMode(@mdShiftNumberMode_UNKNOWN)
		@mdShiftNumberMode_Normal.addValue(@vlShiftNumber_Full_Range)
		@prShiftNumber.addMode(@mdShiftNumberMode_Normal)
		@prShiftNumber.addValue(@vlShiftNumber_UNKNOWN)
		@mdShiftNumberMode_UNKNOWN.addValue(@vlShiftNumber_UNKNOWN)
		@prShiftNumber.addValue(@vlShiftNumber_Full_Range)
		@sysAcquisition.addParam(@prShiftNumber)
		@mdAcquisitionMode_UNKNOWN.addSubMode(@mdShiftNumberMode_UNKNOWN)
		@prBinning.addMode(@mdBinningMode_UNKNOWN)
		@mdBinningMode_All.addValue(@vlBinning_1x1)
		@mdBinningMode_All.addValue(@vlBinning_1x2)
		@mdBinningMode_All.addValue(@vlBinning_2x1)
		@mdBinningMode_All.addValue(@vlBinning_2x2)
		@prBinning.addMode(@mdBinningMode_All)
		@prBinning.addValue(@vlBinning_UNKNOWN)
		@mdBinningMode_UNKNOWN.addValue(@vlBinning_UNKNOWN)
		@prBinning.addValue(@vlBinning_1x1)
		@prBinning.addValue(@vlBinning_1x2)
		@prBinning.addValue(@vlBinning_2x1)
		@prBinning.addValue(@vlBinning_2x2)
		@sysAcquisition.addParam(@prBinning)
		@mdAcquisitionMode_UNKNOWN.addSubMode(@mdBinningMode_UNKNOWN)
		@sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_UNKNOWN)
		@sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_Off)
		@mdSubarrayFeatureMode_On.addSubMode(@mdColsMode_Normal)
		@mdSubarrayFeatureMode_On.addSubMode(@mdoffsetRowMode_Normal)
		@mdSubarrayFeatureMode_On.addSubMode(@mdRowsMode_Normal)
		@mdSubarrayFeatureMode_On.addSubMode(@mdoffsetColMode_Normal)
		@sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_On)
		@mdSubarrayFeatureMode_Engineering.addSubMode(@mdColsMode_Normal)
		@mdSubarrayFeatureMode_Engineering.addSubMode(@mdoffsetRowMode_Normal)
		@mdSubarrayFeatureMode_Engineering.addSubMode(@mdRowsMode_Normal)
		@mdSubarrayFeatureMode_Engineering.addSubMode(@mdoffsetColMode_Normal)
		@sysSubarrayFeature.addMode(@mdSubarrayFeatureMode_Engineering)
		@prCols.addMode(@mdColsMode_UNKNOWN)
		@mdColsMode_Normal.addValue(@vlCols_Full_Range)
		@prCols.addMode(@mdColsMode_Normal)
		@prCols.addValue(@vlCols_UNKNOWN)
		@mdColsMode_UNKNOWN.addValue(@vlCols_UNKNOWN)
		@prCols.addValue(@vlCols_Full_Range)
		@sysSubarrayFeature.addParam(@prCols)
		@mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdColsMode_UNKNOWN)
		@proffsetRow.addMode(@mdoffsetRowMode_UNKNOWN)
		@mdoffsetRowMode_Normal.addValue(@vloffsetRow_Full_Range)
		@proffsetRow.addMode(@mdoffsetRowMode_Normal)
		@proffsetRow.addValue(@vloffsetRow_UNKNOWN)
		@mdoffsetRowMode_UNKNOWN.addValue(@vloffsetRow_UNKNOWN)
		@proffsetRow.addValue(@vloffsetRow_Full_Range)
		@sysSubarrayFeature.addParam(@proffsetRow)
		@mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdoffsetRowMode_UNKNOWN)
		@prRows.addMode(@mdRowsMode_UNKNOWN)
		@mdRowsMode_Normal.addValue(@vlRows_Full_Range)
		@prRows.addMode(@mdRowsMode_Normal)
		@prRows.addValue(@vlRows_UNKNOWN)
		@mdRowsMode_UNKNOWN.addValue(@vlRows_UNKNOWN)
		@prRows.addValue(@vlRows_Full_Range)
		@sysSubarrayFeature.addParam(@prRows)
		@mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdRowsMode_UNKNOWN)
		@proffsetCol.addMode(@mdoffsetColMode_UNKNOWN)
		@mdoffsetColMode_Normal.addValue(@vloffsetCol_Full_Range)
		@proffsetCol.addMode(@mdoffsetColMode_Normal)
		@proffsetCol.addValue(@vloffsetCol_UNKNOWN)
		@mdoffsetColMode_UNKNOWN.addValue(@vloffsetCol_UNKNOWN)
		@proffsetCol.addValue(@vloffsetCol_Full_Range)
		@sysSubarrayFeature.addParam(@proffsetCol)
		@mdSubarrayFeatureMode_UNKNOWN.addSubMode(@mdoffsetColMode_UNKNOWN)
		@sysAcquisition.addSubsystem(@sysSubarrayFeature)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_UNKNOWN)
		@mdExposureCtrlMode_Normal.addSubMode(@mdOpenShutterMode_Off)
		@mdExposureCtrlMode_Normal.addSubMode(@mdOpenShutterMode_On)
		@mdExposureCtrlMode_Normal.addSubMode(@mdExpTimeMode_Normal)
		@mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_FST)
		@mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_MED)
		@mdExposureCtrlMode_Normal.addSubMode(@mdPixelSpeedMode_SLW)
		@mdExposureCtrlMode_Normal.addSubMode(@mdnumOfFramesMode_Single)
		@mdExposureCtrlMode_Normal.addSubMode(@mdnumOfFramesMode_Multiple)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_Normal)
		@mdExposureCtrlMode_FT.addSubMode(@mdOpenShutterMode_Off)
		@mdExposureCtrlMode_FT.addSubMode(@mdExpTimeMode_FT)
		@mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_FST)
		@mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_MED)
		@mdExposureCtrlMode_FT.addSubMode(@mdPixelSpeedMode_SLW)
		@mdExposureCtrlMode_FT.addSubMode(@mdnumOfFramesMode_Single)
		@mdExposureCtrlMode_FT.addSubMode(@mdnumOfFramesMode_Multiple)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_FT)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdOpenShutterMode_Off)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdExpTimeMode_Normal)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_FST)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_MED)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdPixelSpeedMode_SLW)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdnumOfFramesMode_Single)
		@mdExposureCtrlMode_NoShutter.addSubMode(@mdnumOfFramesMode_Multiple)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_NoShutter)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdOpenShutterMode_Off)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdOpenShutterMode_On)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdExpTimeMode_Normal)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_FST)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_MED)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdPixelSpeedMode_SLW)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdnumOfFramesMode_Single)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdnumOfFramesMode_Multiple)
		@mdExposureCtrlMode_Calibration.addSubMode(@mdCalibGainMode_Normal)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_Calibration)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdOpenShutterMode_On)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdOpenShutterMode_Off)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdExpTimeMode_Normal)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdExpTimeMode_FT)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_SLW)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_MED)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdPixelSpeedMode_FST)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdnumOfFramesMode_Multiple)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdnumOfFramesMode_Single)
		@mdExposureCtrlMode_Engineering.addSubMode(@mdCalibGainMode_Normal)
		@sysExposureCtrl.addMode(@mdExposureCtrlMode_Engineering)
		@prExpTime.addMode(@mdExpTimeMode_UNKNOWN)
		@mdExpTimeMode_Normal.addValue(@vlExpTime_Full_Range)
		@prExpTime.addMode(@mdExpTimeMode_Normal)
		@mdExpTimeMode_FT.addValue(@vlExpTime_FT_Range)
		@prExpTime.addMode(@mdExpTimeMode_FT)
		@prExpTime.addValue(@vlExpTime_UNKNOWN)
		@mdExpTimeMode_UNKNOWN.addValue(@vlExpTime_UNKNOWN)
		@prExpTime.addValue(@vlExpTime_Full_Range)
		@prExpTime.addValue(@vlExpTime_FT_Range)
		@sysExposureCtrl.addParam(@prExpTime)
		@mdExposureCtrlMode_UNKNOWN.addSubMode(@mdExpTimeMode_UNKNOWN)
		@prnumOfFrames.addMode(@mdnumOfFramesMode_UNKNOWN)
		@mdnumOfFramesMode_Multiple.addValue(@vlnumOfFrames_Multiple_Range)
		@prnumOfFrames.addMode(@mdnumOfFramesMode_Multiple)
		@mdnumOfFramesMode_Single.addValue(@vlnumOfFrames_1)
		@prnumOfFrames.addMode(@mdnumOfFramesMode_Single)
		@prnumOfFrames.addValue(@vlnumOfFrames_UNKNOWN)
		@mdnumOfFramesMode_UNKNOWN.addValue(@vlnumOfFrames_UNKNOWN)
		@prnumOfFrames.addValue(@vlnumOfFrames_Multiple_Range)
		@prnumOfFrames.addValue(@vlnumOfFrames_1)
		@sysExposureCtrl.addParam(@prnumOfFrames)
		@mdExposureCtrlMode_UNKNOWN.addSubMode(@mdnumOfFramesMode_UNKNOWN)
		@prCalibGain.addMode(@mdCalibGainMode_UNKNOWN)
		@mdCalibGainMode_Normal.addValue(@vlCalibGain_Normal_Range)
		@prCalibGain.addMode(@mdCalibGainMode_Normal)
		@prCalibGain.addValue(@vlCalibGain_UNKNOWN)
		@mdCalibGainMode_UNKNOWN.addValue(@vlCalibGain_UNKNOWN)
		@prCalibGain.addValue(@vlCalibGain_Normal_Range)
		@sysExposureCtrl.addParam(@prCalibGain)
		@mdExposureCtrlMode_UNKNOWN.addSubMode(@mdCalibGainMode_UNKNOWN)
		@sysOpenShutter.addMode(@mdOpenShutterMode_UNKNOWN)
		@sysOpenShutter.addMode(@mdOpenShutterMode_On)
		@sysOpenShutter.addMode(@mdOpenShutterMode_Off)
		@sysExposureCtrl.addSubsystem(@sysOpenShutter)
		@sysPixelSpeed.addMode(@mdPixelSpeedMode_UNKNOWN)
		@sysPixelSpeed.addMode(@mdPixelSpeedMode_SLW)
		@sysPixelSpeed.addMode(@mdPixelSpeedMode_MED)
		@sysPixelSpeed.addMode(@mdPixelSpeedMode_FST)
		@sysExposureCtrl.addSubsystem(@sysPixelSpeed)
		@sysAcquisition.addSubsystem(@sysExposureCtrl)
		@sysOutputSource.addMode(@mdOutputSourceMode_UNKNOWN)
		@mdOutputSourceMode_0x0.addSubMode(@mdRecompositionMode_None)
		@sysOutputSource.addMode(@mdOutputSourceMode_0x0)
		@mdOutputSourceMode_0x1.addSubMode(@mdRecompositionMode_None)
		@sysOutputSource.addMode(@mdOutputSourceMode_0x1)
		@mdOutputSourceMode_0x2.addSubMode(@mdRecompositionMode_None)
		@sysOutputSource.addMode(@mdOutputSourceMode_0x2)
		@mdOutputSourceMode_0x3.addSubMode(@mdRecompositionMode_None)
		@sysOutputSource.addMode(@mdOutputSourceMode_0x3)
		@mdOutputSourceMode_ALL.addSubMode(@mdRecompositionMode_QuadCCD)
		@sysOutputSource.addMode(@mdOutputSourceMode_ALL)
		@mdOutputSourceMode_TWO.addSubMode(@mdRecompositionMode_Serial)
		@sysOutputSource.addMode(@mdOutputSourceMode_TWO)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_None)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_Parallel)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_Serial)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_QuadCCD)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_QuadIR)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_CDSQuad)
		@mdOutputSourceMode_Engineering.addSubMode(@mdRecompositionMode_HawaiiRG)
		@sysOutputSource.addMode(@mdOutputSourceMode_Engineering)
		@sysRecomposition.addMode(@mdRecompositionMode_UNKNOWN)
		@sysRecomposition.addMode(@mdRecompositionMode_None)
		@sysRecomposition.addMode(@mdRecompositionMode_Parallel)
		@sysRecomposition.addMode(@mdRecompositionMode_Serial)
		@sysRecomposition.addMode(@mdRecompositionMode_QuadCCD)
		@sysRecomposition.addMode(@mdRecompositionMode_QuadIR)
		@sysRecomposition.addMode(@mdRecompositionMode_CDSQuad)
		@sysRecomposition.addMode(@mdRecompositionMode_HawaiiRG)
		@sysOutputSource.addSubsystem(@sysRecomposition)
		@sysAcquisition.addSubsystem(@sysOutputSource)
		@sysDimensions.addMode(@mdDimensionsMode_UNKNOWN)
		@mdDimensionsMode_Normal.addSubMode(@mduiRowsMode_Normal)
		@mdDimensionsMode_Normal.addSubMode(@mduiColsMode_Normal)
		@sysDimensions.addMode(@mdDimensionsMode_Normal)
		@mdDimensionsMode_FT.addSubMode(@mduiRowsMode_Half)
		@mdDimensionsMode_FT.addSubMode(@mduiColsMode_Normal)
		@sysDimensions.addMode(@mdDimensionsMode_FT)
		@mdDimensionsMode_Engineering.addSubMode(@mduiRowsMode_Normal)
		@mdDimensionsMode_Engineering.addSubMode(@mduiRowsMode_Half)
		@mdDimensionsMode_Engineering.addSubMode(@mduiColsMode_Normal)
		@sysDimensions.addMode(@mdDimensionsMode_Engineering)
		@pruiRows.addMode(@mduiRowsMode_UNKNOWN)
		@mduiRowsMode_Normal.addValue(@vluiRows_Full_Range)
		@pruiRows.addMode(@mduiRowsMode_Normal)
		@mduiRowsMode_Half.addValue(@vluiRows_FTRange)
		@pruiRows.addMode(@mduiRowsMode_Half)
		@pruiRows.addValue(@vluiRows_UNKNOWN)
		@mduiRowsMode_UNKNOWN.addValue(@vluiRows_UNKNOWN)
		@pruiRows.addValue(@vluiRows_Full_Range)
		@pruiRows.addValue(@vluiRows_FTRange)
		@sysDimensions.addParam(@pruiRows)
		@mdDimensionsMode_UNKNOWN.addSubMode(@mduiRowsMode_UNKNOWN)
		@pruiCols.addMode(@mduiColsMode_UNKNOWN)
		@mduiColsMode_Normal.addValue(@vluiCols_Full_Range)
		@pruiCols.addMode(@mduiColsMode_Normal)
		@pruiCols.addValue(@vluiCols_UNKNOWN)
		@mduiColsMode_UNKNOWN.addValue(@vluiCols_UNKNOWN)
		@pruiCols.addValue(@vluiCols_Full_Range)
		@sysDimensions.addParam(@pruiCols)
		@mdDimensionsMode_UNKNOWN.addSubMode(@mduiColsMode_UNKNOWN)
		@sysAcquisition.addSubsystem(@sysDimensions)
		@sysVariants.addSubsystem(@sysAcquisition)
		@sysFirmware.addSubsystem(@sysVariants)
		@sysARCGenIII.addSubsystem(@sysFirmware)
	end
	## sysSubsystem ARCGenIII

	def get_ARCGenIIINode
		@sysARCGenIII
	end
	def get_ARCGenIIIMode
		@sysARCGenIII.getSelectedMode
	end

	def set_ARCGenIIIMode(mode)
		@sysARCGenIII.selectMode(mode)
	end

	## sysSubsystem Firmware

	def get_FirmwareNode
		@sysFirmware
	end
	def get_FirmwareMode
		@sysFirmware.getSelectedMode
	end

	def set_FirmwareMode(mode)
		@sysFirmware.selectMode(mode)
	end

	## sysSubsystem Variants

	def get_VariantsNode
		@sysVariants
	end
	def get_VariantsMode
		@sysVariants.getSelectedMode
	end

	def set_VariantsMode(mode)
		@sysVariants.selectMode(mode)
	end

	## sysSubsystem Acquisition

	def get_AcquisitionNode
		@sysAcquisition
	end
	def get_AcquisitionMode
		@sysAcquisition.getSelectedMode
	end

	def set_AcquisitionMode(mode)
		@sysAcquisition.selectMode(mode)
	end

	## prParam ShuffleLines

	def get_ShuffleLinesNode
		@prShuffleLines
	end
	def get_ShuffleLinesMode
		@prShuffleLines.getSelectedMode
	end

	def set_ShuffleLinesMode(mode)
		@prShuffleLines.selectMode(mode)
	end

	def get_ShuffleLines
		@prShuffleLines.getSelectedValue
	end

	def set_ShuffleLines(value)
		@prShuffleLines.setValue(value)
	end

	def get_ShuffleLinesDouble
		v = @prShuffleLines.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_ShuffleLinesDouble(data)
		@prShuffleLines.getSelectedValue.setData(data)
	end

	## prParam ShiftNumber

	def get_ShiftNumberNode
		@prShiftNumber
	end
	def get_ShiftNumberMode
		@prShiftNumber.getSelectedMode
	end

	def set_ShiftNumberMode(mode)
		@prShiftNumber.selectMode(mode)
	end

	def get_ShiftNumber
		@prShiftNumber.getSelectedValue
	end

	def set_ShiftNumber(value)
		@prShiftNumber.setValue(value)
	end

	def get_ShiftNumberDouble
		v = @prShiftNumber.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_ShiftNumberDouble(data)
		@prShiftNumber.getSelectedValue.setData(data)
	end

	## prParam Binning

	def get_BinningNode
		@prBinning
	end
	def get_BinningMode
		@prBinning.getSelectedMode
	end

	def set_BinningMode(mode)
		@prBinning.selectMode(mode)
	end

	def get_Binning
		@prBinning.getSelectedValue
	end

	def set_Binning(value)
		@prBinning.setValue(value)
	end

	## sysSubsystem SubarrayFeature

	def get_SubarrayFeatureNode
		@sysSubarrayFeature
	end
	def get_SubarrayFeatureMode
		@sysSubarrayFeature.getSelectedMode
	end

	def set_SubarrayFeatureMode(mode)
		@sysSubarrayFeature.selectMode(mode)
	end

	## prParam Cols

	def get_ColsNode
		@prCols
	end
	def get_ColsMode
		@prCols.getSelectedMode
	end

	def set_ColsMode(mode)
		@prCols.selectMode(mode)
	end

	def get_Cols
		@prCols.getSelectedValue
	end

	def set_Cols(value)
		@prCols.setValue(value)
	end

	def get_ColsDouble
		v = @prCols.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_ColsDouble(data)
		@prCols.getSelectedValue.setData(data)
	end

	## prParam offsetRow

	def get_offsetRowNode
		@proffsetRow
	end
	def get_offsetRowMode
		@proffsetRow.getSelectedMode
	end

	def set_offsetRowMode(mode)
		@proffsetRow.selectMode(mode)
	end

	def get_offsetRow
		@proffsetRow.getSelectedValue
	end

	def set_offsetRow(value)
		@proffsetRow.setValue(value)
	end

	def get_offsetRowDouble
		v = @proffsetRow.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_offsetRowDouble(data)
		@proffsetRow.getSelectedValue.setData(data)
	end

	## prParam Rows

	def get_RowsNode
		@prRows
	end
	def get_RowsMode
		@prRows.getSelectedMode
	end

	def set_RowsMode(mode)
		@prRows.selectMode(mode)
	end

	def get_Rows
		@prRows.getSelectedValue
	end

	def set_Rows(value)
		@prRows.setValue(value)
	end

	def get_RowsDouble
		v = @prRows.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_RowsDouble(data)
		@prRows.getSelectedValue.setData(data)
	end

	## prParam offsetCol

	def get_offsetColNode
		@proffsetCol
	end
	def get_offsetColMode
		@proffsetCol.getSelectedMode
	end

	def set_offsetColMode(mode)
		@proffsetCol.selectMode(mode)
	end

	def get_offsetCol
		@proffsetCol.getSelectedValue
	end

	def set_offsetCol(value)
		@proffsetCol.setValue(value)
	end

	def get_offsetColDouble
		v = @proffsetCol.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_offsetColDouble(data)
		@proffsetCol.getSelectedValue.setData(data)
	end

	## sysSubsystem ExposureCtrl

	def get_ExposureCtrlNode
		@sysExposureCtrl
	end
	def get_ExposureCtrlMode
		@sysExposureCtrl.getSelectedMode
	end

	def set_ExposureCtrlMode(mode)
		@sysExposureCtrl.selectMode(mode)
	end

	## prParam ExpTime

	def get_ExpTimeNode
		@prExpTime
	end
	def get_ExpTimeMode
		@prExpTime.getSelectedMode
	end

	def set_ExpTimeMode(mode)
		@prExpTime.selectMode(mode)
	end

	def get_ExpTime
		@prExpTime.getSelectedValue
	end

	def set_ExpTime(value)
		@prExpTime.setValue(value)
	end

	def get_ExpTimeDouble
		v = @prExpTime.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_ExpTimeDouble(data)
		@prExpTime.getSelectedValue.setData(data)
	end

	## prParam numOfFrames

	def get_numOfFramesNode
		@prnumOfFrames
	end
	def get_numOfFramesMode
		@prnumOfFrames.getSelectedMode
	end

	def set_numOfFramesMode(mode)
		@prnumOfFrames.selectMode(mode)
	end

	def get_numOfFrames
		@prnumOfFrames.getSelectedValue
	end

	def set_numOfFrames(value)
		@prnumOfFrames.setValue(value)
	end

	def get_numOfFramesDouble
		v = @prnumOfFrames.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_numOfFramesDouble(data)
		@prnumOfFrames.getSelectedValue.setData(data)
	end

	## prParam CalibGain

	def get_CalibGainNode
		@prCalibGain
	end
	def get_CalibGainMode
		@prCalibGain.getSelectedMode
	end

	def set_CalibGainMode(mode)
		@prCalibGain.selectMode(mode)
	end

	def get_CalibGain
		@prCalibGain.getSelectedValue
	end

	def set_CalibGain(value)
		@prCalibGain.setValue(value)
	end

	def get_CalibGainDouble
		v = @prCalibGain.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_CalibGainDouble(data)
		@prCalibGain.getSelectedValue.setData(data)
	end

	## sysSubsystem OpenShutter

	def get_OpenShutterNode
		@sysOpenShutter
	end
	def get_OpenShutterMode
		@sysOpenShutter.getSelectedMode
	end

	def set_OpenShutterMode(mode)
		@sysOpenShutter.selectMode(mode)
	end

	## sysSubsystem PixelSpeed

	def get_PixelSpeedNode
		@sysPixelSpeed
	end
	def get_PixelSpeedMode
		@sysPixelSpeed.getSelectedMode
	end

	def set_PixelSpeedMode(mode)
		@sysPixelSpeed.selectMode(mode)
	end

	## sysSubsystem OutputSource

	def get_OutputSourceNode
		@sysOutputSource
	end
	def get_OutputSourceMode
		@sysOutputSource.getSelectedMode
	end

	def set_OutputSourceMode(mode)
		@sysOutputSource.selectMode(mode)
	end

	## sysSubsystem Recomposition

	def get_RecompositionNode
		@sysRecomposition
	end
	def get_RecompositionMode
		@sysRecomposition.getSelectedMode
	end

	def set_RecompositionMode(mode)
		@sysRecomposition.selectMode(mode)
	end

	## sysSubsystem Dimensions

	def get_DimensionsNode
		@sysDimensions
	end
	def get_DimensionsMode
		@sysDimensions.getSelectedMode
	end

	def set_DimensionsMode(mode)
		@sysDimensions.selectMode(mode)
	end

	## prParam uiRows

	def get_uiRowsNode
		@pruiRows
	end
	def get_uiRowsMode
		@pruiRows.getSelectedMode
	end

	def set_uiRowsMode(mode)
		@pruiRows.selectMode(mode)
	end

	def get_uiRows
		@pruiRows.getSelectedValue
	end

	def set_uiRows(value)
		@pruiRows.setValue(value)
	end

	def get_uiRowsDouble
		v = @pruiRows.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_uiRowsDouble(data)
		@pruiRows.getSelectedValue.setData(data)
	end

	## prParam uiCols

	def get_uiColsNode
		@pruiCols
	end
	def get_uiColsMode
		@pruiCols.getSelectedMode
	end

	def set_uiColsMode(mode)
		@pruiCols.selectMode(mode)
	end

	def get_uiCols
		@pruiCols.getSelectedValue
	end

	def set_uiCols(value)
		@pruiCols.setValue(value)
	end

	def get_uiColsDouble
		v = @pruiCols.getSelectedValue
		v.class = PORISValueFloat
		v.getData
	end

	def set_uiColsDouble(data)
		@pruiCols.getSelectedValue.setData(data)
	end

	def prBinning
		@prBinning
	end

	def mdARCGenIIIMode_Real
		@mdARCGenIIIMode_Real
	end

	def vlBinning_2x1
		@vlBinning_2x1
	end

end

thismodel = ARCGenIIIPORIS.new(16)

arcgen = thismodel.getRoot
puts(arcgen.getSelectedMode.getName)
puts(thismodel.prBinning.getSelectedValue.getName)
arcgen.selectMode(thismodel.mdARCGenIIIMode_Real)
puts(arcgen.getSelectedMode.getName)
puts(thismodel.prBinning.getSelectedValue.getName)
thismodel.prBinning.setValue(thismodel.vlBinning_2x1)
puts(thismodel.prBinning.getSelectedValue.getName)
