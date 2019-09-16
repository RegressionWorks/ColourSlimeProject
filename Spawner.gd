extends Node2D

var collect_spawn = load("res://collectible.tscn")
var scene_instance
var counter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	counter =0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_Timer_timeout():
	counter= counter+1
	scene_instance = collect_spawn.instance()
	scene_instance.set_name(str("collectible",counter))
	add_child(scene_instance)
