extends KinematicBody
onready var camera = $Pivot/Camera

var gravity = -30
export (int) var max_speed = 12
var mouse_sensitivity = 0.002  # radians/pixel

var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func get_input():
	var input_dir = Vector3()
	# desired move in camera direction
	if Input.is_action_pressed("player_forwards"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("player_backwards"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("player_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("player_right"):
		input_dir += global_transform.basis.x
		
	if Input.is_action_pressed("player_up"):
		input_dir += -global_transform.basis.y
	if Input.is_action_pressed("player_down"):
		input_dir += global_transform.basis.y
		
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("PrimaryMouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	#get_input()
	
	#velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity.y = desired_velocity.y
	velocity = move_and_slide(velocity)

