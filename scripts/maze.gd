extends Node3D
var trees :Array
var trscales :  Array
var treehealthes : Array
var timer
func _ready():
	$AnimationPlayer.play("daynight")
	for i in get_node("trees").get_children():
		if i is MeshInstance3D:
			trees.append(i)
			trscales.append(i.scale)
			treehealthes.append(10)
	
	pass # Replace with function body.

func _process(delta):
	var time = $AnimationPlayer.current_animation_position *24 
	$Node3D.get_node("Control/Panel/Label2").text = str(int(time/100))+":00"
#hh using print for debuging and forgot to remove it h
func shaketree(tree:String):
	if has_node(tree):
		var cpupar = preload("res://cpu_particles_3d.tscn")
		var thetree = get_node(tree)
		print("you want to break :",thetree)
		var treeposition = trees.find(thetree)
		print("found position of the tree in trees Array :" ,treeposition)
		if !treehealthes[treeposition] == 0:
			print("tree health :",treehealthes[treeposition])
			if !thetree.has_node(str(cpupar.instantiate().name)):
				thetree.add_child(cpupar.instantiate())
			for i in thetree.get_children():
					if i is CPUParticles3D:
						i.emitting = true
						break
			treehealthes[treeposition] -= 1
		else :
			print("the tree s health is 0")
			treehealthes[treeposition] = 10
			thetree.scale = trscales[treeposition]/8
			thetree.visible = false
		
		
func _on_timer_timeout():
	print("regenerating trees")
	var n = 0
	for i in trees:
		if i.scale == trscales[n]:
			pass
		elif i.scale == trscales[n]/2:
			i.scale = trscales[n]
		elif i.scale == trscales[n]/4:
			i.scale = trscales[n]/2
		elif i.scale == trscales[n]/8:
			i.visible = true 
			i.scale =trscales[n]/4
		n += 1
	pass # Replace with function body.


func _on_shaketm_timeout():
	pass
