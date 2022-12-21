extends CanvasLayer



onready var score_label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_score(new_score):
	score_label.text = str(new_score)
