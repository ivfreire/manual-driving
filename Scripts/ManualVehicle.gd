extends RigidBody3D

var rpm = 1000
var gear = 0
var traction = 15000
var angle = PI / 6

func _ready():
	pass

func _physics_process(delta):
	var is_x_button_pressed = Input.is_action_pressed("ui_accept")
	
	angle = - Input.get_joy_axis(0, 0) * PI / 6
	
	$Wheels/FrontLeft.rotation.y = angle
	$Wheels/FrontRight.rotation.y = angle
	
	var clutch_level = Input.get_joy_axis(0, 4)
	
	var _traction = traction * (1 - clutch_level)
	if is_x_button_pressed: _traction = - 1.2 * _traction
	
	var force = global_transform.basis.z * _traction * cos(angle) * cos(angle)
	force += global_transform.basis.x * _traction * sin(angle) * cos(angle)
	
	print(angle, force)
	
	var torque = self.global_transform.basis.y * 1.4 * _traction * cos(angle) * sin(angle)
	
	self.apply_central_force(-force)
	self.apply_torque(torque)
