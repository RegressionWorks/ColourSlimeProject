extends Node2D

var collect_spawn = load("res://collectible.tscn")
var scene_instance
var counter
var bullet_power

signal orb_fired(col)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	counter =0
	bullet_power=200
	


func _on_player_shoot_orb(dir,col):
	counter= counter+1
	scene_instance = collect_spawn.instance()
	scene_instance.set_position($player.position + 15*$player.scale*dir)
	scene_instance.set_name(str("shot_Collectible",counter))
	add_child(scene_instance)
	scene_instance.apply_central_impulse(dir*bullet_power)
	if col == 0:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(float(1),0,0,0.25)
	elif col == 1:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(0,float(1),0,0.25)
	else:
		get_node(str("shot_Collectible",counter,"/Polygon2D")).color = Color(0,0,float(1),0.25)
