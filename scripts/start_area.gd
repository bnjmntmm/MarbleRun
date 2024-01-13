extends Node3D

var marble = ResourceLoader.load("res://scenes/marble.tscn")
@onready var area_3d = $Area3D
var marble_spawned
var spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_xr_origin_3d_spawn_marble():
	if !spawned:
		spawned = true
		marble_spawned = marble.instantiate()
		get_parent().get_parent().add_child(marble_spawned)
		marble_spawned.global_position = area_3d.global_position
		GameManager.start_time = Time.get_unix_time_from_system()
	else:
		marble_spawned.queue_free()
		spawned = false
		
	
		
