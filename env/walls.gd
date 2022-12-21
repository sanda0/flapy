extends Node2D


const SPEED = 200
signal score

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position.x +=  -SPEED * delta
	if global_position.x <= -100:
		queue_free()
	


func _on_wall_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_wall2_body_entered(body):
	if body is Player:
		if body.has_method("die"):	
			body.die()





func _on_scoreAria_body_exited(body):
	if body is Player:
		if body.alive:
			$scoreSound.play()
			emit_signal("score")
			
