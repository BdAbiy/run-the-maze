extends MeshInstance3D

var timer = Timer.new()
var cpupar = CPUParticles3D.new()
var countes
var lastpos:Vector3
var ontime = true
func start():
	add_child(timer)
	print("ngaa 1 ready ")
	if ontime :
		timer.connect("timeout",Callable(self,"shaketree"))
		ontime = false
	timer.wait_time = 0.2
	
	timer.start()
	
	
func shaketree():
	if countes != 13 :
		if transform.origin != lastpos:
			transform.origin += Vector3(randf_range(-1,1),0,randf_range(-1,1))
		timer.start()
		countes+=1
	else:
		
		scale = scale/ 8
		visible = false 
		pass
