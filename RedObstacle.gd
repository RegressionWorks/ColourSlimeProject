extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	$CollisionPolygon2D.polygon= $Polygon2D.polygon
	set_contact_monitor( true )
	set_max_contacts_reported( 5 )


func _on_collectible_breakWall(id):
	print("Success?")
	if id == self.get_name():
		$CollisionPolygon2D.disabled = true
		hide()
		queue_free()