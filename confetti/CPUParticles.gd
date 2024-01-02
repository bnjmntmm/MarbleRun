extends CPUParticles3D

var red_color = Color("#ffadad")
var orange_color = Color("#ffd6a5")
var yellow_color = Color("#fdffb6")
var green_color = Color("#caffbf")
var cyan_color = Color("#9bf6ff")
var blue_color = Color("#a0c4ff")
var purple_color = Color("#bdb2ff")
var pink_color = Color("#ffc6ff")

var color_list = [red_color, orange_color, yellow_color, green_color, cyan_color, blue_color, purple_color, pink_color]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#set_color(rng.randi_range(0, len(color_list))
	pass
