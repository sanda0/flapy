extends CanvasLayer

signal start_game
var game_started = false

onready var start_msg = $StartMenu/TextureRect
onready var tween = $Tween
onready var score_lbl = $GameOverMenu/VBoxContainer/ScoreLbl
onready var best_lbl = $GameOverMenu/VBoxContainer/BestLbl
onready var game_over_menu = $GameOverMenu

func _input(event):
	if event.is_action_pressed("FLAP") && !game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_msg,"modulate:a",1,0,0.5)
		tween.start()
		game_started = true
		
		
func init_game_over_menu(score,best):
	score_lbl.text = "SCORE:"+str(score)
	best_lbl.text = "BEST:"+str(best)
	game_over_menu.visible = true

func _on_RestartBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
