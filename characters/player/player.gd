extends RigidBody2D
class_name Player
export var FLAP_FORCE = -200
var started = false
var alive = true

signal die_signal

func _ready():
	set_bounce(0)
	pass # Replace with function body.


func _physics_process(_delta):
	if Input.is_action_just_pressed("FLAP"):
		if !started:
			start()
		flap()

func start():
	if started:return
	started = true
	gravity_scale = 5

func flap():
	if !alive:return
	linear_velocity.y = FLAP_FORCE
	$sound.play()

func die():
	if !alive:return
	alive = false
	emit_signal("die_signal")
	$AnimationPlayer.play("die")
	sleeping=true
	$dieSound.play()
	
	
