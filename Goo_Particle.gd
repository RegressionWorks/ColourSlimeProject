extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 200
const jumpSpeed = 300
var shotBoostSpeed = 200
var jumped = false
var onWall = false
var concec_jumps=0
var my_color 
var orbs_consumed
var colourSelection #0 For Red, 1 For Green, 2 For Blue
var colourSCount
var colourChunk = 0.25
var velocity = Vector2()
onready var polygon = $Polygon2D


signal orb_was_taken
signal shoot_orb(dir,col)
signal colourChanged(col,counto)
#Function for throwing a hook to one direction and pulling closer to it.
func hookDo():
    pass

func colorChanges():
	my_color = $Polygon2D.color
	colourSCount[0]  = my_color.r*4
	colourSCount[1] = my_color.g*4
	colourSCount[2] = my_color.b*4
	arrow_Colour()
	emit_signal("colourChanged",colourSelection,colourSCount[colourSelection])

func shoot():
	print(str("Orb Color: ", my_color))
	#if orbs_consumed >=1:
	if true:
		if colourSelection == 0 && my_color.r >= colourChunk :
			$Polygon2D.color = Color(my_color.r- colourChunk, my_color.g,my_color.b,my_color.a)

		elif colourSelection == 1 && my_color.g >= colourChunk:
			$Polygon2D.color = Color(my_color.r, my_color.g- colourChunk,my_color.b,my_color.a)

		elif colourSelection == 2 && my_color.b >= colourChunk:
			$Polygon2D.color = Color(my_color.r, my_color.g,my_color.b- colourChunk,my_color.a)

			 
		else:
			print("Not Enough Material")
			return
		var diriShoot = get_local_mouse_position()
		diriShoot = diriShoot.normalized()
		velocity -= diriShoot*shotBoostSpeed
		scale = scale - 0.2*Vector2(1,1)
		#orbs_consumed = orbs_consumed -1
		colorChanges()
		emit_signal("shoot_orb",diriShoot,colourSelection)

func _ready():
	my_color = $Polygon2D.color
	#orbs_consumed=0
	colourSelection=0
	colourSCount = [0,0,0]
	colorChanges()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("cycle_modes"):
		colourSelection = (colourSelection+1)%3
		colorChanges()
	elif Input.is_action_just_pressed("Red_Mode"):
		colourSelection = 0
		colorChanges()
	elif Input.is_action_just_pressed("Green_Mode"):
		colourSelection =1
		colorChanges()
	elif Input.is_action_just_pressed("Blue_Mode"):
		colourSelection =2
		colorChanges()
	elif Input.is_action_just_pressed("alt_cycle_modes"):
		colourSelection = (2 + colourSelection)%3
		colorChanges()
	$arrow.look_at(get_global_mouse_position())
	#Jumping with Space
	if Input.is_action_pressed("ui_select") && (jumped == false || onWall == true):
		velocity.y = -jumpSpeed
		jumped = true
		onWall = false
		concec_jumps = concec_jumps+1
	else:
		velocity.y += delta * GRAVITY
   #Left and Right Movement
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED 
	else:
		velocity.x = 0
    #Movement
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
	move_and_slide(velocity, Vector2(0, -1))
    
	#Checking when landing or when colliding with wall, ceilling.
	if is_on_floor():
		jumped = false
		velocity.y = 0
		concec_jumps=0
	if is_on_ceiling():
		velocity.y = delta* GRAVITY
	if is_on_wall():
		if concec_jumps < 2:
			onWall = true
		velocity.x = -velocity.x

func on_orb_taken(c):
	emit_signal("orb_was_taken")
	var modificus = 4
	#$Polygon2D.color = Color(my_color.r + c.r/modificus, my_color.g + c.g/modificus, my_color.b +c.b/modificus, my_color.a)
	$Polygon2D.color= Color(my_color.r +c.r/modificus,my_color.g +c.g/modificus, my_color.b +c.b/modificus,my_color.blend(c).a)
	scale = scale + 0.2*Vector2(1,1)*c.r + 0.2*Vector2(1,1)*c.g + 0.2*Vector2(1,1)*c.b
	#orbs_consumed= orbs_consumed+1
	colorChanges()
	print(my_color)

func arrow_Colour():
	if colourSelection ==0:
		$arrow.color = Color(float(1),0,0,1)
	elif colourSelection == 1:
		$arrow.color = Color(0,float(1),0,1)
	elif colourSelection == 2:
		$arrow.color = Color(0,0,float(1),1)


