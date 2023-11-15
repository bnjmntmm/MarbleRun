extends XROrigin3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var debug_window = $XRCamera3D/DebugWindow
@onready var marble = $"../Marble"
var origin_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_pos = marble.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var is_colliding = _process_on_physical_movement(delta)
	if !is_colliding:
		_process_rotation_on_input(delta)
		_process_movement_on_input(delta)

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

func print_vr(text:String):
	debug_window.text=str(text)
func _on_left_button_pressed(name):
	print_vr(name)
	if name=="ax_button":
		debug_window.visible=!debug_window.visible
	if name=="by_button":
		get_tree().reload_current_scene()
		
		
		
	
		
		
		
