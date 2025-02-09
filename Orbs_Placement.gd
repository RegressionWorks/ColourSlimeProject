extends Node2D

var collectible = load("res://collectible.tscn")
export (int) var total_red = 0
export (int) var red_found = 0

export (int) var total_green = 0
export (int) var green_found = 0

export (int) var total_blue = 0
export (int) var blue_found = 0

func _ready():
	##Spawning Red Orbs
	var pos_curve = $Red.get_curve()
	total_red = pos_curve.get_point_count()
	for i in range(0, total_red):
		var Collect_instance = collectible.instance()
		Collect_instance.set_name(str("spawned_red_orb",i))
		add_child(Collect_instance)
		Collect_instance.position = pos_curve.get_point_position(i)
		get_node(str("spawned_red_orb",i,"/Polygon2D")).color = Color(float(1),0,0,0.25)
	##Spawning Green Orbs
	pos_curve = $Green.get_curve()
	total_red = pos_curve.get_point_count()
	for i in range(0, total_red):
		var Collect_instance = collectible.instance()
		Collect_instance.set_name(str("spawned_green_orb",i))
		add_child(Collect_instance)
		Collect_instance.position = pos_curve.get_point_position(i)
		get_node(str("spawned_green_orb",i,"/Polygon2D")).color = Color(0,float(1),0,0.25)
	
	##Spawning Blue Orbs
	pos_curve = $Blue.get_curve()
	total_red = pos_curve.get_point_count()
	for i in range(0, total_red):
		var Collect_instance = collectible.instance()
		Collect_instance.set_name(str("spawned_blue_orb",i))
		add_child(Collect_instance)
		Collect_instance.position = pos_curve.get_point_position(i)
		get_node(str("spawned_blue_orb",i,"/Polygon2D")).color = Color(0,0,float(1),0.25)