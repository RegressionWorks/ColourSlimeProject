extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_player_colourChanged(col,counto):
	if col ==0:
		$Polygon2D.color = Color(float(1),0,0,1)
		$ammo_count.add_color_override("font_outline_modulate",Color(1,0,0,1))
	elif col == 1:
		$Polygon2D.color = Color(0,float(1),0,1)
		$ammo_count.add_color_override("font_outline_modulate",Color(0,1,0,1))
	elif col == 2:
		$Polygon2D.color = Color(0,0,float(1),1)
		$ammo_count.add_color_override("font_outline_modulate",Color(0,0,1,1))
	$ammo_count.text = str(counto)