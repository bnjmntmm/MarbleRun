extends XROrigin3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var debug_window = $XRCamera3D/DebugWindow
@onready var marble = $"../Marble"
@onready var viewport_2_din_3d = $Left/Viewport2Din3D
@onready var label_3d = $XRCamera3D/Label3D
@onready var left_controller = $Left
@onready var right_controller = $Right

@onready var zylinder = $"../Zylinder"
@onready var finish_area = $"../Tracks/finish_area"
@onready var start_area = $"../Tracks/StartArea"
signal spawn_marble


@onready var right_hand = $Right/RightHand

var grib_left = false
var grib_right = false
var trigger_left = false
var trigger_right = false
var allGrabbed = false
var init_controller_pos : Vector3

## MARBLE TRACKS INIT
var straightBlock = ResourceLoader.load("res://scenes/pickable_straight_normal.tscn")
var curveLargeBlock = ResourceLoader.load("res://scenes/pickable_curve_large.tscn")
var selectionCircle

var origin_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	#VIEWPORT SELECTION CIRCLE
	selectionCircle = viewport_2_din_3d.get_scene_instance().get_child(0).get_child(1)
	origin_pos = marble.global_position
	random_start_stop_position()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#label_3d.text = str(selectionCircle.get_current_selection())
	get_joystick_input(XRHelpers.get_xr_controller(self))
	var is_colliding = _process_on_physical_movement(delta)
	if !is_colliding:
		_process_rotation_on_input(delta)
		_process_movement_on_input(delta)
	#change_world_pos()

func _process_on_physical_movement(delta):
	#current velocity
	var current_velocity = $CharacterBody3D.velocity
	
	#where player body currently is
	var org_player_body: Vector3 = $CharacterBody3D.global_transform.origin
	#Determine where our player body should be
	var player_body_location: Vector3 = $XRCamera3D.transform * $XRCamera3D/Neck.transform.origin
	player_body_location.y = 0.0
	player_body_location = global_transform * player_body_location

 # Attempt to move our character
	$CharacterBody3D.velocity = (player_body_location - org_player_body) / delta
	$CharacterBody3D.move_and_slide()
	
	#Set back to our current value
	$CharacterBody3D.velocity = current_velocity
	
	#Check if we managed to move all the way, ignoring heigh change
	var movement_left = player_body_location - $CharacterBody3D.global_transform.origin
	movement_left.y = 0.0
	if (movement_left).length() > 0.01:
		#todo
		return true
	else:
		return false

func _get_rotational_input() -> float:
	return 0.0
func _copy_player_rotation_to_character_body():
	var camera_forward:  Vector3 = -$XRCamera3D.global_transform.basis.z
	var body_forward: Vector3 = Vector3(camera_forward.x, 0.0,camera_forward.z)
	$CharacterBody3D.global_transform.basis = Basis.looking_at(body_forward, Vector3.UP)
	
func _process_rotation_on_input(delta):
	var t1 := Transform3D()
	var t2 := Transform3D()
	var rot := Transform3D()
	
	#we are going to rotate the origin around the player
	var player_position = $CharacterBody3D.global_transform.origin  - global_transform.origin
	t1.origin = -player_position
	t2.origin = player_position
	rot = rot.rotated(Vector3(0.0, 1.0, 0.0), _get_rotational_input() * delta)
	global_transform = (global_transform * t2 * rot * t1).orthonormalized()
	# Now ensure our player body is facing the correct way as well
	_copy_player_rotation_to_character_body()


func _get_movement_input() -> Vector2:
	return Vector2()
func _process_movement_on_input(delta):
	var org_player_body: Vector3 = $CharacterBody3D.global_transform.origin
	
	#apply grav
	$CharacterBody3D.velocity.y -= gravity * delta
	# add our movement
	var input: Vector2 = _get_movement_input()
	var movement: Vector3 = ($CharacterBody3D.global_transform.basis * Vector3(input.x, 0, input.y))
	$CharacterBody3D.velocity.x = movement.x
	$CharacterBody3D.velocity.z = movement.z
	
	# Attempt to move our player
	$CharacterBody3D.move_and_slide()
	# And now apply the actual movement to our origin
	global_transform.origin += $CharacterBody3D.global_transform.origin - org_player_body


#func print_vr(text:String):
#	debug_window.text=str(text)
func _on_left_button_pressed(name):
	#label_3d.text = name
	#print_vr(name)
	if name=="ax_button":
		viewport_2_din_3d.visible = !viewport_2_din_3d.visible
	if name=="by_button":
		get_tree().reload_current_scene()
	if name=="grip_click":
		grib_left = true
	if name=="trigger_click":
		trigger_left = true
		

func _on_left_button_released(name):
	if name=="grip_click":
		grib_left = false
	if name=="trigger_click":
		trigger_left = false



func _on_right_button_pressed(name):
	#label_3d.text = name
	if name=="ax_button":
		if selectionCircle.get_current_selection() == 1:
			var block = straightBlock.instantiate()
			get_parent().add_child(block,true)
			block.global_position=right_hand.global_position
			#block.freeze=true
		if selectionCircle.get_current_selection() == 2:
			var block = curveLargeBlock.instantiate()
			get_parent().add_child(block,true)
			block.global_position=right_hand.global_position
			#block.freeze=true
	if name=="by_button":
		spawn_marble.emit()
			
			
	if name=="grip_click":
		grib_right = true
	if name=="trigger_click":
		trigger_right = true

func _on_right_button_released(name):
	if name=="grip_click":
		grib_right = false
	if name=="trigger_click":
		trigger_right = false
			

func get_joystick_input(_controller):
	var dz_input_action = left_controller.get_vector2("primary")
	selectionCircle.get_controller_values(dz_input_action)
	
	
	#label_3d.text = str()
		
		
		
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

func spawn_track(spawningTrack):
	var newBlock = spawningTrack.instantiante()
	get_parent().add_child(newBlock,true)
	newBlock.global_position = right_hand.global_position
	newBlock.freeze = true

func random_start_stop_position():
	var init_pos = zylinder.global_position + Vector3(0,0.5,0)
	var startPos : Vector3 = init_pos + Vector3(randi_range(-1,1), randf_range(0,0.3), randi_range(-1,1))
	var endPos : Vector3 = init_pos + Vector3(randi_range(-1,1), randf_range(-1,0), randi_range(-1,1))
	
	while startPos.distance_to(endPos) < 1.5:
		startPos= init_pos + Vector3(randi_range(-1,1), randf_range(0,0.3), randi_range(-1,1))
		endPos = init_pos +Vector3(randi_range(-1,1), randf_range(-1,0 ), randi_range(-1,1))
		
		

	start_area.global_position = startPos
	finish_area.global_position = endPos
	
	start_area.look_at(endPos,Vector3(0,1,0),true)
	#start_area.global_rotation = Vector3(0,start_area.global_rotation.y,0)
	finish_area.look_at(startPos,Vector3(0,1,0),true)
	
	finish_area.rotation = Vector3(0,finish_area.rotation.y,0)
	start_area.rotation = Vector3(0,start_area.rotation.y,0)
	#finish_area.global_rotation = Vector3(0,finish_area.global_rotation.y,0)
	
	start_area.visible = true
	finish_area.visible = true

