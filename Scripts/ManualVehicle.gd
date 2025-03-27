extends RigidBody3D

var traction = 50
var angle = PI / 6

func _ready():
	pass

func _physics_process(delta):
	var is_x_button_pressed = Input.is_action_pressed("ui_accept")
	
	if is_x_button_pressed:
		var force = self.global_transform.basis.z * traction
		force -= force * sin(angle)
		var torque = self.global_transform.basis.y * traction * cos(angle) * sin(angle)
		
		print(torque)
		
		self.apply_central_force(-force)
		self.apply_torque(torque)
