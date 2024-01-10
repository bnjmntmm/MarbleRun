extends Node3D

@onready var confetti_alt = $ConfettiAlt

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
signal marble_in_fin

func _on_area_3d_body_entered(body):
	print(body.name)
	if body != self:
		if body.name == "Marble":
			GameManager.end_time = Time.get_unix_time_from_system()
			GameManager.calculateScore()
			confetti_alt.play_confetti()
			marble_in_fin.emit()
