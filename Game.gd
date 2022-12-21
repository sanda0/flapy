extends Node2D


onready var hud = $HUD
onready var wall_spawner = $WallSpwner
onready var menu = $Menus

const SAVE_FILE_PATH = "user://savedata.save"

var score = 0 setget set_score
var best_score =0

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)
	

func _ready():
	wall_spawner.connect("wall_created",self,"on_wall_created")
	#new_game()
	load_best_score()
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_closed", self, "_on_MobileAds_rewarded_ad_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_clicked", self, "_on_MobileAds_rewarded_ad_clicked")
		


func on_wall_created(wall):
	wall.connect("score",self,"player_score")


func new_game():
	score = 0
	wall_spawner.start()


func _on_player_die_signal():
	game_over()

func game_over():
	wall_spawner.stop()
	get_tree().call_group("walls","set_physics_process",false)
	if(score > best_score):
		best_score = score
		save_best_score()
	
	menu.init_game_over_menu(score,best_score)


func _on_Menus_start_game():
	new_game()
	
func save_best_score():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH,File.WRITE)
	save_data.store_var(best_score)
	save_data.close()

func load_best_score():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH,File.READ)
		best_score = save_data.get_var()
		save_data.close()
