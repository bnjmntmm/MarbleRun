extends Node3D

var xr_interface: XRInterface
var xrInterface:XRInterface
@onready var label_3d = $Label3D

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	xrInterface = XRServer.get_interface(0)
	#label_3d.text=str(xr_interface.supports_play_area_mode(XRInterface.XR_PLAY_AREA_STAGE))
	
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")
		#label_3d.text = str(xr_interface.get_play_area_mode())
		label_3d.text=str(xrInterface.supports_play_area_mode(XRInterface.XR_PLAY_AREA_STAGE))
		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		enable_passthrough()
	else:
		print("OpenXR not initialized, please check if your headset is connected")

func enable_passthrough() -> bool:
	var xr_interface: XRInterface = XRServer.primary_interface
	if xr_interface and xr_interface.is_passthrough_supported():
		if !xr_interface.start_passthrough():
			return false
	else:
		var modes = xr_interface.get_supported_environment_blend_modes()
		if xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
			xr_interface.set_environment_blend_mode(xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND)
		else:
			return false
	get_viewport().transparent_bg = true
	
	return true
