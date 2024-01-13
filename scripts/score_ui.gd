extends Control

@onready var GameManagerScoreLabel = $Label/GameManagerScoreLabel
@onready var name_input = $NameLabel/NameInput
@onready var save_button = $Label/SaveButton
@onready var score_label = $BoxContainer/scoreLabel
@onready var back_button = $BackButton

var list_index = 0
var max_scores = 10
var local_scores
var scores
const ScoreItem = preload("res://addons/silent_wolf/Scores/ScoreItem.tscn")
var ld_name ="main"
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManagerScoreLabel.text = str(GameManager.final_score)
	save_button.set_disabled(false)
	save_button.text = "SAVE SCORE TO SCOREBOARD"

func _on_button_button_up():
	if name_input.text != "":
		list_index = 0
		save_button.set_disabled(true)
		save_button.text = "Saved"
		#local_scores.append({"player_name": name_input.text, "score": GameManager.final_score})
		
		back_button.set_disabled(true)
		SilentWolf.Scores.save_score(name_input.text, GameManager.final_score)
		back_button.set_disabled(false)
		


func _on_back_button_button_up():
	GameManager.back_to_menu()
