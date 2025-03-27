extends RigidBody3D

var rpm = 1000
var gear = 0
var traction = 50000
var angle = PI / 6

func _ready():
	pass

func _physics_process(delta):
	var is_x_button_pressed = Input.is_action_pressed("ui_accept")
	
	angle = - Input.get_joy_axis(0, 0) * PI / 2
	
	$Wheels/FrontLeft.rotation.y = angle
	$Wheels/FrontRight.rotation.y = angle
	
	var clutch_level = Input.get_joy_axis(0, 4)
	
	var force = self.global_transform.basis.z * traction * (1 - clutch_level)
	force -= force * abs(sin(angle))
	
	print(angle, force)
	
	var torque = self.global_transform.basis.y * traction * cos(angle) * sin(angle)
	
	self.apply_central_force(-force)
	self.apply_torque(torque)
