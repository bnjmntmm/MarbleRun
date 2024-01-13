extends XROrigin3D

@onready var AreaSetupViewport = $LeftHand/AreaSetupViewport
var cube = preload("res://scenes/cube.tscn")

@onready var selectionViewport = $LeftHand/SelectionViewport

@onready var area_init_box = $"../Play_Area_Init/Area_Init_Box"
@onready var label_3d = $"../Label3D"

## MARBLE TRACKS INIT
var straightBlock = ResourceLoader.load("res://scenes/pickable_straight_normal.tscn")
var curveLargeBlock = ResourceLoader.load("res://scenes/pickable_curve_large.tscn")
var rampBlock=ResourceLoader.load("res://scenes/pickable_ramp_normal.tscn")
var helixhalfBlock=ResourceLoader.load("res://scenes/pickable_helix_half_normal.tscn")
var helixquarterBlock=ResourceLoader.load("res://scenes/pickable_helix_quarter_normal.tscn")
var waveBlock=ResourceLoader.load("res://scenes/pickable_wave_normal.tscn")
var scurveBlock=ResourceLoader.load("res://scenes/pickbable_scurve_normal.tscn")
var selectionCircle

##  START AND FINISH TRACK
@onready var start_area = $"../Tracks/StartArea"
@onready var finish_area = $"../Tracks/finish_area"

## Hands and Controller
@onready var left_controller = $LeftHand
@onready var right_controller = $RightHand
@onready var left_hand = $LeftHand/LeftHand
@onready var right_hand = $RightHand/RightHand


#camera
@onready var xr_camera_3d = $XRCamera3D

#WORLD GRAB
var grib_left = false
var grib_right = false
var trigger_left = false
var trigger_right = false
var allGrabbed = false
var init_controller_pos : Vector3
var toggle_boost:bool=false


signal spawn_marble

# Called when the node enters the scene tree for the first time.
func _ready():#
	selectionCircle = selectionViewport.get_scene_instance().get_child(0).get_child(1)
	#random_start_stop_position()
	#GameManager.spawnBlock.connect(spawn_block)
	GameManager.complete.connect(make_start_finish_area)
	pass # Replace with function body.


func _physics_process(delta):
	get_joystick_input(XRHelpers.get_xr_controller(self))
	area_init_box.global_position = Vector3(xr_camera_3d.global_position.x, 0, xr_camera_3d.global_position.z)
	area_init_box.rotation.y = xr_camera_3d.rotation.y
	change_world_pos()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_joystick_input(_controller):
	var dz_input_action = left_controller.get_vector2("primary")
	selectionCircle.get_controller_values(dz_input_action)

func _on_left_controller_button_pressed(name):
	if name == "ax_button":
		if AreaSetupViewport.enabled:
			AreaSetupViewport.visible = !AreaSetupViewport.visible
		if area_init_box.visible == false:
			selectionViewport.visible = !selectionViewport.visible
	if name == "by_button":
		pass
	if name == "grip_click":
		grib_left = true
	if name == "trigger_click":
		trigger_left = true

func _on_left_controller_button_released(name):
	if name=="grip_click":
		grib_left = false
	if name=="trigger_click":
		trigger_left = false



func _on_right_controller_button_pressed(name):
	if selectionViewport.visible:
		if name=="ax_button":
			if selectionCircle.get_current_selection()==0:
				toggle_boost=!toggle_boost
				selectionCircle.boost_toggle=!selectionCircle.boost_toggle
			if selectionCircle.get_current_selection() == 1:
				var block = straightBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
				
			if selectionCircle.get_current_selection() == 2:
				var block = curveLargeBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
			if selectionCircle.get_current_selection() == 7:
				var block = rampBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
			if selectionCircle.get_current_selection() == 6:
				var block = helixhalfBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
			if selectionCircle.get_current_selection() == 5:
				var block = helixquarterBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
			if selectionCircle.get_current_selection() == 4:
				var block = scurveBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
			if selectionCircle.get_current_selection() == 3:
				var block = waveBlock.instantiate()
				block.is_boosted=toggle_boost
				get_parent().add_child(block,true)
				block.global_position = right_hand.global_position
	if name=="by_button":
		spawn_marble.emit()
	if name=="grib_click":
		grib_right = true
	if name=="trigger_click":
		trigger_left = true
	if name=="primary_click":
		GameManager.delete_track()


func _on_right_controller_button_released(name):
	if name=="grib_click":
		grib_right = false
	if name=="trigger_click":
		trigger_right = false

	
		
func random_start_stop_position():
	randomize()
	var startPosition = Vector3(randf_range(GameManager.playAreaMin.x,GameManager.playAreaMax.x),randf_range(1,1.5),randf_range(GameManager.playAreaMin.z, GameManager.playAreaMax.z))
	var finPosition = Vector3(randf_range(GameManager.playAreaMin.x,GameManager.playAreaMax.x),randf_range(0.1,0.9),randf_range(GameManager.playAreaMin.z, GameManager.playAreaMax.z))
		
	while(startPosition.distance_to(finPosition) < 1.0):
		startPosition = Vector3(randf_range(GameManager.playAreaMin.x,GameManager.playAreaMax.x),randf_range(1,1.5),randf_range(GameManager.playAreaMin.z, GameManager.playAreaMax.z))
		finPosition = Vector3(randf_range(GameManager.playAreaMin.x,GameManager.playAreaMax.x),randf_range(0.1,0.9),randf_range(GameManager.playAreaMin.z, GameManager.playAreaMax.z))

	start_area.global_position = startPosition
	finish_area.global_position = finPosition
	
	start_area.look_at(finPosition,Vector3(0,1,0),true)
	finish_area.look_at(startPosition,Vector3(0,1,0),true)
	
	finish_area.rotation = Vector3(0,finish_area.rotation.y,0)
	start_area.rotation = Vector3(0,start_area.rotation.y,0)

func make_start_finish_area():
	random_start_stop_position()
	start_area.visible = true
	finish_area.visible = true
	
	

func change_world_pos():
	var speed  = 2.0
	if grib_left and grib_right and trigger_left and trigger_right:
		var avg_pos = (left_controller.global_transform.origin + right_controller.global_transform.origin) / 2.0
		if not allGrabbed:
			allGrabbed = true
			init_controller_pos = avg_pos
		else:
			#Calc diff between the positions
			var delta_pos = Vector3(avg_pos.x - init_controller_pos.x, 0.0, avg_pos.z - init_controller_pos.z)
			global_transform.origin -= delta_pos
			init_controller_pos = avg_pos
	else:
		allGrabbed = false


func _on_finish_area_marble_in_fin():
	label_3d.text = str("You brought the Marble to its Finish with a Score of: " + str(GameManager.final_score))
