extends Control

@onready var GameManagerScoreLabel = $Label/GameManagerScoreLabel
@onready var name_input = $NameLabel/NameInput
@onready var save_button = $Label/SaveButton
@onready var score_label = $BoxContainer/scoreLabel
@onready var back_button = $BackButton

@onready var leaderboard = $Box/Leaderboard
@onready var box = $Box


var leaderboard_Prefab = preload("res://scenes/Staging/leaderboard_tryout.tscn")
var leaderBoardPos = Vector2(182,31)
var leaderboardScale = Vector2(0.5,0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManagerScoreLabel.text = str(GameManager.final_score)
	save_button.set_disabled(false)
	save_button.text = "SAVE SCORE TO SCOREBOARD"

func _on_button_button_up():
	if name_input.text != "":
		save_button.set_disabled(true)
		save_button.text = "Saved"
		
		#local_scores.append({"player_name": name_input.text, "score": GameManager.final_score})
		
		back_button.set_disabled(true)
		leaderboard.queue_free()
		SilentWolf.Scores.save_score(name_input.text, GameManager.final_score)
		var LBFP = leaderboard_Prefab.instantiate()
		LBFP.transform = Transform2D(0, leaderboardScale, 0, leaderBoardPos)
		box.add_child(LBFP)
		back_button.set_disabled(false)
		


func _on_back_button_button_up():
	GameManager.back_to_menu()
