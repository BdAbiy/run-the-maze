extends CharacterBody3D
const GRAVITY = -2
var on_ground = false
var hh = "ffh"
var camrot = InputEventMouseMotion.new()
var camera :Camera3D
var raycast :RayCast3D
var currenttree:MeshInstance3D
var objects : Array
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera = get_node("Camera3D")
	raycast = $Camera3D/RayCast3D
	$Area3D.connect("area_entered", Callable(self, "arrent"))
	$Area3D.connect("area_exited", Callable(self, "arrext"))
func _process(delta):
	if raycast.get_collider() != null and raycast.get_collider().get_parent().name.begins_with("Tree") and raycast.get_collider().get_parent().visible:
		if Input.is_action_just_pressed("action"):
			get_parent().shaketree("trees/"+raycast.get_collider().get_parent().name)
	
func _physics_process(delta):
	
	velocity = Vector3(0,0,0)
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		if  Input.is_action_pressed("up"):
			velocity -= transform.basis.z
		if  Input.is_action_pressed("down"):
			velocity += transform.basis.z
		if  Input.is_action_pressed("right"):
			velocity += transform.basis.x
		if  Input.is_action_pressed("left"):
			velocity -= transform.basis.x
	if not is_on_floor():
		velocity.y= GRAVITY
	
	set_velocity(velocity *5)
	move_and_slide()
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*0.4))
		camera.rotate_x(deg_to_rad(-event.relative.y*0.4))
		
func arrent(area:Area3D):
	if area.name == "hh":
		on_ground =true
func arrext(area:Area3D):
	if area.name == "hh":
		on_ground = false
